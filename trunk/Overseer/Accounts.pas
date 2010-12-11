unit Accounts;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ImgList,
  Menus,
  OverseerTypes;

const
  ICON_DEFAULTCOLUMN=9;
  ICON_USER_DISABLED=0;
  ICON_USER_ENABLED=1;
  ICON_RIGHTS=10;

type
  TAccountsForm=class(TForm)
    ActionManager1: TActionManager;
    Action_Delete: TAction;
    Action_Properties: TAction;
    Action_Create: TAction;
    Action_Refresh: TAction;
    Action_ChangePassword: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnProperties: TButton;
    btnCreate: TButton;
    btnRefresh: TButton;
    btnDelete: TButton;
    lvAccounts: TListView;
    ImageList1: TImageList;
    btnClose: TButton;
    Action_Close: TAction;
    Action_Rename: TAction;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    miProperties: TMenuItem;
    miCreate: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Action_Help: TAction;
    N1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Action_Permissions: TAction;
    N3: TMenuItem;
    btnPermissions: TButton;
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvAccountsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Action_DeleteExecute(Sender: TObject);
    procedure Action_PropertiesExecute(Sender: TObject);
    procedure Action_CreateExecute(Sender: TObject);
    procedure Action_RefreshExecute(Sender: TObject);
    procedure Action_ChangePasswordExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure lvAccountsColumnClick(Sender: TObject; Column: TListColumn);
    procedure Action_RenameExecute(Sender: TObject);
    procedure lvAccountsEdited(Sender: TObject; Item: TListItem; var S: string);
    procedure lvAccountsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvAccountsDblClick(Sender: TObject);
    procedure Action_PermissionsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    iSortByColumn: integer;
    procedure Update_Actions;
    procedure Update_PopupMenu;
    procedure Do_Create;
    procedure Do_Delete;
    procedure Do_Rename;
    procedure Do_ChangePassword;
    procedure Do_Help;
    procedure Do_Refresh;
    procedure Do_Properties;
    procedure Do_Close;
    procedure Do_Rights;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
    procedure PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure InitProgressBar(const aMax: integer);
    procedure StepProgressBar;
  end;

var
  AccountsForm: TAccountsForm;

implementation

{$R *.dfm}

uses
  AccountCreate,
  AccountChangePassword,
  AccountProperties,
  Permissions,
  mysql,
  Main,
  OverseerRoutines,
  OverseerConsts;

procedure TAccountsForm.InitProgressBar(const aMax: integer);
begin
  with MainForm do
    begin
      pbMain.Position:=pbMain.Min;
      pbMain.Max:=aMax;
    end;
  Application.ProcessMessages;
end;

procedure TAccountsForm.StepProgressBar;
begin
  MainForm.pbMain.Position:=MainForm.pbMain.Position+MainForm.pbMain.Step;
  Application.ProcessMessages;
end;

procedure TAccountsForm.PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  LogThis('Производится попытка отображения модального окна '+aWindowName+'.', aLogGroupGUID, lmtDebug);
  with MainForm do
    begin
      aOldBusyState:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
    end;
end;

procedure TAccountsForm.PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  with MainForm do
    begin
      iBusyCounter:=aOldBusyState; // возвращение старого значения счётчика
      Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
    end;
  LogThis('Окно '+aWindowName+' скрыто.', aLogGroupGUID, lmtDebug);
end;

procedure TAccountsForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TAccountsForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TAccountsForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TAccountsForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TAccountsForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{9A353B49-8736-49C0-8036-F4331FF4F26B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_CreateExecute(Sender: TObject);
const
  LogGroupGUID: string='{B655948D-ECFC-47EE-8F1E-E824D229220A}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Create.Caption+'"', LogGroupGUID);
  Do_Create;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_DeleteExecute(Sender: TObject);
const
  LogGroupGUID: string='{E019A56B-5734-43B2-9038-53E8B2277E15}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Delete.Caption+'"', LogGroupGUID);
  Do_Delete;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_RefreshExecute(Sender: TObject);
const
  LogGroupGUID: string='{467D3F48-B695-47FC-A460-217442F08081}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Refresh.Caption+'"', LogGroupGUID);
  Do_Refresh;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Close;
const
  LogGroupGUID: string='{7A88CEEA-2D0C-428A-A79E-765297D9797F}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Окно управления учётными записями закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{2F4CF48C-8C25-4508-81E5-3C770D9E0615}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  iSortByColumn:=0;
  lvAccounts.Selected:=nil;
  with Action_Help do
    begin
      Enabled:=Application.HelpFile<>'';
      Visible:=Enabled;
    end;
  LogThis('Действие "'+Action_Help.Caption+'" '+Routines_GetConditionalMessage(Action_Help.Visible, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  Do_Refresh;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{730BCBA2-B980-4F6F-9589-7FE56FBA9803}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

  LogThis('Отображено окно управления учётными записями.', LogGroupGUID, lmtInfo);
  Update_Actions;
  Update_PopupMenu;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.lvAccountsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
const
  LogGroupGUID: string='{809B8976-65F6-40FB-8DD5-3A3ECE98530D}';
begin
  ProcedureHeader('Процедура-обработчик события выделения элемента списка учётных записей', LogGroupGUID);

  Update_Actions;
  Update_PopupMenu;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.lvAccountsColumnClick(Sender: TObject; Column: TListColumn);
const
  LogGroupGUID: string='{04794D19-8982-4ED6-B78F-D383A68B7A01}';
var
  i: integer;
begin
  if Column.ImageIndex<>ICON_DEFAULTCOLUMN then
    for i:=0 to lvAccounts.Columns.Count-1 do
      if lvAccounts.Columns[i].index=Column.index then
        begin
          lvAccounts.Columns[i].ImageIndex:=ICON_DEFAULTCOLUMN;
          iSortByColumn:=Column.index;
          Do_Refresh;
        end
      else
        lvAccounts.Columns[i].ImageIndex:=-1;
  LogThis('Активирована сортировка данных в окне усправления учётными записями по столбцу "'+Column.Caption+'".', LogGroupGUID, lmtInfo);
end;

procedure TAccountsForm.Update_Actions;
const
  LogGroupGUID: string='{077681C0-6E88-4172-9027-290DD90C0C89}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);

  Action_Create.Enabled:=not(lvAccounts.Selected<>nil);
  Action_Delete.Enabled:=lvAccounts.Selected<>nil;
  Action_Properties.Enabled:=lvAccounts.Selected<>nil;
  Action_Permissions.Enabled:=lvAccounts.Selected<>nil;
  Action_ChangePassword.Enabled:=lvAccounts.Selected<>nil;
  Action_Rename.Enabled:=lvAccounts.Selected<>nil;
  LogThis('Действие "'+Action_Create.Caption+'" '+Routines_GetConditionalMessage(Action_Create.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  LogThis('Действие "'+Action_Delete.Caption+'" '+Routines_GetConditionalMessage(Action_Delete.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  LogThis('Действие "'+Action_Properties.Caption+'" '+Routines_GetConditionalMessage(Action_Properties.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  LogThis('Действие "'+Action_Permissions.Caption+'" '+Routines_GetConditionalMessage(Action_Permissions.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  LogThis('Действие "'+Action_ChangePassword.Caption+'" '+Routines_GetConditionalMessage(Action_ChangePassword.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  LogThis('Действие "'+Action_Rename.Caption+'" '+Routines_GetConditionalMessage(Action_Rename.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  miCreate.default:=not(lvAccounts.Selected<>nil);
  miProperties.default:=lvAccounts.Selected<>nil;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Update_PopupMenu;
const
  LogGroupGUID: string='{A9BE265B-A451-4E6A-919A-BFE2875F3FB2}';
var
  i: integer;
begin
  ProcedureHeader('Процедура обновления состояния элементов локального меню', LogGroupGUID);
  for i:=0 to PopupMenu1.Items.Count-1 do
    PopupMenu1.Items[i].Visible:=PopupMenu1.Items[i].Enabled;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Refresh;
const
  LogGroupGUID: string='{D4D18164-EB99-4B2E-A858-3FDE549218B8}';
var
  bError: boolean;
  sErrorMessage: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  i: integer;
  j: integer;
  sSelectedID: string;
  ListItem: TListItem;
begin
  ProcedureHeader('Процедура обновления списка пользователей', LogGroupGUID);
  bError:=False;
  sSelectedID:='';

  InitProgressBar(6);

  // запомиание id выделенного элемента и
  if not bError then
    if lvAccounts.Selected<>nil then
      if lvAccounts.Selected.SubItems.Count>=5 then
        sSelectedID:=lvAccounts.Selected.SubItems[4];

  with MainForm, Configuration, OverseerServer do
    begin
      // подключаемся к MySQL-серверу, на котором находится таблица пользователей
      if not bError then
        begin
          MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
          StepProgressBar; // 1
        end;

      // проверяем наличие таблицы пользователей в базе данных
      if not bError then
        begin
          MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
          StepProgressBar; // 2
        end;

      // блокирование таблицы
      if not bError then
        begin
          MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._users READ');
          StepProgressBar; // 3
        end;

      // получение данных пользователей и заполнение списка
      if not bError then
        begin
          LogThis('>> Выполняется операция получения данных пользователей и заполнение списка...', LogGroupGUID, lmtDebug);
          if not bConnected then
            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              if mysql_ping(hConnection)<>0 then
                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
              else
                begin
                  q:='SELECT' //
                    +' usr_login AS f0,' //
                    +' usr_fullname AS f1,' //
                    +' usr_position AS f2,' //
                    +' usr_contactphone AS f3,' //
                    +' IF(usr_is_admin="1","Администраторы","Пользователи") AS f4,' //
                    +' usr_id AS f5,' //
                    +' usr_disabled ' //
                    +'FROM' //
                    +' '+sMySQLDatabase+'._users ' //
                    +'ORDER BY' //
                    +' f'+IntToStr(iSortByColumn)+';'; //
                  LogThis(q, LogGroupGUID, lmtSQL);
                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                  else
                    begin
                      LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                      ResultSet:=mysql_store_result(hConnection);
                      if ResultSet=nil then
                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                      else
                        begin
                          LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                          i:=mysql_num_rows(ResultSet);
                          LogThis('Количество строк выборки равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                          if i<0 then
                            Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                          else
                            begin
                              MainForm.pbMain.Max:=i;
                              lvAccounts.Items.BeginUpdate;
                              lvAccounts.Clear;
                              for j:=0 to i-1 do
                                if bError then
                                  Break
                                else
                                  begin
                                    LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', LogGroupGUID, lmtDebug);
                                    ResultRow:=mysql_fetch_row(ResultSet);
                                    if ResultRow=nil then
                                      Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                    else
                                      begin
                                        ListItem:=lvAccounts.Items.Add;
                                        ListItem.Caption:=string(ResultRow[0]);
                                        with ListItem.SubItems do
                                          begin
                                            Add(string(ResultRow[1]));
                                            Add(string(ResultRow[2]));
                                            Add(string(ResultRow[3]));
                                            Add(string(ResultRow[4]));
                                            Add(string(ResultRow[5]));
                                          end;
                                        if string(ResultRow[6])='1' then
                                          ListItem.ImageIndex:=ICON_USER_DISABLED
                                        else
                                          if string(ResultRow[6])='0' then
                                            ListItem.ImageIndex:=ICON_USER_ENABLED
                                          else
                                            ListItem.ImageIndex:=-1;
                                        LogThis('Данные пользователя получены успешно.', LogGroupGUID, lmtDebug);
                                      end;
                                    StepProgressBar;
                                  end;
                              lvAccounts.Items.EndUpdate;
                            end;
                          mysql_free_result(ResultSet);
                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                        end;
                    end;
                end;
            end;
          LogThis('<< Выполнение операции получения данных пользователей и заполнение списка завершено.', LogGroupGUID, lmtDebug);
          StepProgressBar; // 4
        end;

      // установка веделения на ранее выделенный элемент списка
      if not bError then
        if sSelectedID<>'' then
          begin
            for i:=0 to lvAccounts.Items.Count-1 do
              if lvAccounts.Items[i]<>nil then
                if lvAccounts.Items[i].SubItems.Count>=5 then
                  if lvAccounts.Items[i].SubItems[4]=sSelectedID then
                    lvAccounts.Selected:=lvAccounts.Items[i];
          end
        else
          lvAccounts.Selected:=nil;

      // разблокирование таблиц
      if not bError then
        begin
          MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
          StepProgressBar; // 5
        end;

      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
      MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
      StepProgressBar; // 6
    end; // of with MainForm, Configuration, OverseerServer do

  if not bError then
    LogThis('Обновление списка учётных записей выполнено успешно.', LogGroupGUID, lmtInfo);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Delete;
const
  LogGroupGUID: string='{A7CFE21A-8236-483E-9445-498F59E03428}';
var
  bError: boolean;
  sErrorMessage: string;
  q: string;
  i: integer;
  sSelectedID: string;
begin
  ProcedureHeader('Процедура удаления выделенного пользователя', LogGroupGUID);
  bError:=False;
  sSelectedID:='';

  InitProgressBar(8);

  if lvAccounts.Selected=nil then
    Routines_GenerateError('Выполнить удаление выделенного пользователя невозможно, так как не был выделен ни один пользователь из списка!', sErrorMessage, bError)
  else
    if not(MessageBox(Handle, PWideChar('Вы подтверждаете удаление пользователя с логином "'+lvAccounts.Selected.Caption+'"?'), PWideChar('OVERSEER - Подтверждение удаления'), MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES) then
      LogThis('Удаление пользователя не было подтверждено пользователем!', LogGroupGUID, lmtInfo)
    else
      begin
        // получение id выделенного элемента
        if lvAccounts.Selected<>nil then
          if lvAccounts.Selected.SubItems.Count>=5 then
            sSelectedID:=lvAccounts.Selected.SubItems[4];
        StepProgressBar; // 1

        // валидация полученного ID
        if StrToIntDef(sSelectedID, -1)<0 then
          Routines_GenerateError('Получен некорректный ID пользователя (ID="'+sSelectedID+'")!', sErrorMessage, bError)
        else
          begin
            LogThis('Валидация ID удаляемого пользователя выполнена успешно (ID="'+sSelectedID+'").', LogGroupGUID, lmtDebug);
            StepProgressBar; // 2
          end;

        with MainForm, Configuration, OverseerServer do
          begin
            // подключаемся к MySQL-серверу, на котором находится таблица пользователей
            if not bError then
              begin
                MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 3
              end;

            // проверяем наличие таблицы пользователей в базе данных
            if not bError then
              begin
                MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
                StepProgressBar; // 4
              end;

            // блокирование таблицы
            if not bError then
              begin
                MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._users WRITE');
                StepProgressBar; // 5
              end;

            // удаление записи из таблицы
            if not bError then
              begin
                LogThis('>> Выполняется операция удаления записи из таблицы пользователей...', LogGroupGUID, lmtDebug);
                if not bConnected then
                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                else
                  begin
                    if mysql_ping(hConnection)<>0 then
                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                    else
                      begin
                        q:='DELETE ' //
                          +'FROM' //
                          +' '+sMySQLDatabase+'._users ' //
                          +'WHERE' //
                          +' usr_id='+sSelectedID+';'; //
                        LogThis(q, LogGroupGUID, lmtSQL);
                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                        else
                          begin
                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                            i:=mysql_affected_rows(hConnection);
                            LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                            if i<>1 then
                              Routines_GenerateError('Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                            else
                              begin
                                LogThis('Удаление записи из таблицы пользователей выполнено успешно.', LogGroupGUID, lmtInfo);
                                lvAccounts.Selected:=nil;
                              end;
                          end;
                      end;
                  end;
                LogThis('<< Выполнение операции удаления записи из таблицы пользователей.', LogGroupGUID, lmtDebug);
                StepProgressBar; // 6
              end;

            // разблокирование таблиц
            if not bError then
              begin
                MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 7
              end;

            // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
            MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
            StepProgressBar; // 8
          end; // of with MainForm, Configuration, OverseerServer do

        // обновление списка
        Do_Refresh;
      end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Rename;
const
  LogGroupGUID: string='{B0EFA605-F039-4022-A7C1-B9E8C0B41ED2}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура включения режима редактирования имени пользователя', LogGroupGUID);
  bError:=False;

  if lvAccounts.Selected=nil then
    Routines_GenerateError('Выполнить включения режима редактирования имени пользователя невозможно, так как не был выделен ни один пользователь из списка!', sErrorMessage, bError)
  else
    begin
      lvAccounts.Selected.EditCaption;
      LogThis('Режим редактирования имени пользователя включён.', LogGroupGUID, lmtInfo);
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_RenameExecute(Sender: TObject);
const
  LogGroupGUID: string='{EE250687-DE25-42B1-A833-6CDB22329045}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Rename.Caption+'"', LogGroupGUID);
  Do_Rename;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_PermissionsExecute(Sender: TObject);
const
  LogGroupGUID: string='{A8E2BC84-2114-49FD-AA2D-A9B8E61F5A41}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Permissions.Caption+'"', LogGroupGUID);
  Do_Rights;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_ChangePasswordExecute(Sender: TObject);
const
  LogGroupGUID: string='{965EDA65-63ED-456B-87F7-08565A8FBD99}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChangePassword.Caption+'"', LogGroupGUID);
  Do_ChangePassword;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_ChangePassword;
const
  LogGroupGUID: string='{8FE2C727-2869-47E3-A8B8-57D49BA6C8E5}';
  sModalWinName: string='смены пароля пользователя';
var
  bError: boolean;
  sSelectedID, sSelectedLogin: string;
  sErrorMessage: string;
  sPassword, sConfirmation: string;
  ResultSet: PMYSQL_RES;
  q: string;
  i: integer;
  AccountChangePasswordForm: TAccountChangePasswordForm;
  mr: TModalResult;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);
  bError:=False;
  sSelectedLogin:='';
  sSelectedID:='';
  mr:=mrNone;

  // получение логина и id выделенного пользователя
  if lvAccounts.Selected=nil then
    Routines_GenerateError('Выполнить смену пароля выделенной учётной записи невозможно, так как не была выделенн ни одна учётная запись из списка!', sErrorMessage, bError)
  else
    if lvAccounts.Selected.SubItems.Count>=5 then
      begin
        sSelectedID:=lvAccounts.Selected.SubItems[4];
        sSelectedLogin:=lvAccounts.Selected.Caption;
      end;

  // валидация полученного ID
  if not bError then
    if StrToIntDef(sSelectedID, -1)<0 then
      Routines_GenerateError('Получен некорректный ID пользователя (ID="'+sSelectedID+'")!', sErrorMessage, bError)
    else
      LogThis('Валидация ID пользователя выполнена успешно (ID="'+sSelectedID+'").', LogGroupGUID, lmtDebug);

  // получение нового пароля и подтверждения
  if not bError then
    begin
      AccountChangePasswordForm:=TAccountChangePasswordForm.Create(Self);
      with AccountChangePasswordForm do
        try
          AccountChangePasswordForm.Caption:=AccountChangePasswordForm.Caption+' '+sSelectedLogin;
          PreShowModal(sModalWinName, LogGroupGUID, iBusy);
          ShowModal;
        finally
          PostShowModal(sModalWinName, LogGroupGUID, iBusy);
          mr:=ModalResult;
          sPassword:=mskPassword.Text;
          sConfirmation:=mskConfirmation.Text;
          Free;
        end;
    end;

  if not bError then
    if mr<>mrOk then
      LogThis('Ввод нового пароля для учётной записи был отменён.', LogGroupGUID, lmtInfo)
    else
      begin
        InitProgressBar(8);

        // валидация пароля
        if not bError then
          if sPassword<>sConfirmation then
            Routines_GenerateError('Значения полей пароля и подтверждения отличаются друг от друга!', sErrorMessage, bError)
          else
            begin
              LogThis('Валидация пароля выполнена успешно.', LogGroupGUID, lmtDebug);
              StepProgressBar; // 1
            end;

        with MainForm, Configuration, OverseerServer, CurrentUser do
          begin
            // подключаемся к MySQL-серверу, на котором находится таблица пользователей
            if not bError then
              begin
                MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 2
              end;

            // проверяем наличие таблицы пользователей в базе данных
            if not bError then
              begin
                MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
                StepProgressBar; // 3
              end;

            // блокирование таблицы
            if not bError then
              begin
                MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._users WRITE');
                StepProgressBar; // 4
              end;

            // исправление записи таблицы
            if not bError then
              begin
                LogThis('>> Выполняется операция изменения записи таблицы пользователей...', LogGroupGUID, lmtDebug);
                if not bConnected then
                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                else
                  begin
                    if mysql_ping(hConnection)<>0 then
                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                    else
                      begin
                        q:='UPDATE' //
                          +' '+sMySQLDatabase+'._users ' //
                          +'SET' //
                          +' usr_password_md5=md5('+Routines_NormalizeStringForQuery(sPassword, True, False)+'),' //
                          +' usr_modified_at=NOW(),' //
                          +' usr_modified_by_user_id='+sID+' ' //
                          +'WHERE' //
                          +' usr_id='+sSelectedID+';'; //
                        LogThis(q, LogGroupGUID, lmtSQL);
                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                        else
                          begin
                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                            i:=mysql_affected_rows(hConnection);
                            LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                            if (i<0)or(i>1) then
                              Routines_GenerateError('Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError);
                          end;
                      end;
                  end;
                LogThis('<< Выполнение операции изменения записи таблицы пользователей завершено.', LogGroupGUID, lmtDebug);
                StepProgressBar; // 5
              end;

            // проверяем текущий пароль пользователя
            if not bError then
              begin
                LogThis('>> Выполняется операция проверки пароля пользователя...', LogGroupGUID, lmtDebug);
                if not bConnected then
                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                else
                  begin
                    if mysql_ping(hConnection)<>0 then
                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                    else
                      begin
                        q:='SELECT' //
                          +' usr_password_md5 ' //
                          +'FROM' //
                          +' '+sMySQLDatabase+'._users ' //
                          +'WHERE' //
                          +' usr_id='+sSelectedID+' AND' //
                          +' usr_password_md5=md5('+Routines_NormalizeStringForQuery(sPassword, True, False)+');'; //
                        LogThis(q, LogGroupGUID, lmtSQL);
                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                        else
                          begin
                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                            ResultSet:=mysql_store_result(hConnection);
                            if ResultSet=nil then
                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                            else
                              begin
                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                i:=mysql_num_rows(ResultSet);
                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                                if i<0 then
                                  Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                else
                                  begin
                                    if i<>1 then
                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                        LogThis('Изменение пароля учётной записи выполнено успешно.', LogGroupGUID, lmtInfo);
                                      end;
                                  end;
                                mysql_free_result(ResultSet);
                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                              end;
                          end;
                      end;
                  end;
                LogThis('<< Выполнение операции проверки проверки пароля пользователя завершено.', LogGroupGUID, lmtDebug);
                StepProgressBar; // 6
              end;

            // разблокирование таблиц
            if not bError then
              begin
                MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 7
              end;
            // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
            MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
            StepProgressBar; // 8
          end; // of with MainForm, Configuration, OverseerServer, CurrentUser do
      end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.lvAccountsDblClick(Sender: TObject);
const
  LogGroupGUID: string='{96C320B5-EB54-4FF6-8498-524955AF8E28}';
begin
  ProcedureHeader('Процедура-обработчик двойного щелчка в области списка пользователей', LogGroupGUID);

  if lvAccounts.Selected<>nil then
    Action_Properties.Execute
  else
    Action_Create.Execute;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Help;
const
  LogGroupGUID: string='{5DB37D10-27F4-4F7C-80A6-BCDB781F1238}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Create;
const
  LogGroupGUID: string='{F829742F-EE25-4F75-98C6-F4A442D44F79}';
  sModalWinName: string='добавления нового пользователя';
var
  mr: TModalResult;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);

  with TAccountCreateForm.Create(Self) do
    try
      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      mr:=ModalResult;
      Free;
    end;
  if mr=mrOk then
    begin
      Do_Refresh;
      Do_Create; // повторное открытие окна
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{FB7B9093-F329-4003-94FD-A2DBE8589BC7}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Action_PropertiesExecute(Sender: TObject);
const
  LogGroupGUID: string='{66768658-72DB-47E2-8DDF-860DE6A1FF82}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Properties.Caption+'"', LogGroupGUID);
  Do_Properties;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.lvAccountsEdited(Sender: TObject; Item: TListItem; var S: string);
const
  LogGroupGUID: string='{79501F7B-358C-4B22-99AC-2EB5D8597836}';
var
  ResultSet: PMYSQL_RES;
  q: string;
  i: integer;
  bError: boolean;
  sErrorMessage: string;
  sSelectedID: string;
begin
  ProcedureHeader('Процедура переименования выделенного пользователя', LogGroupGUID);
  sSelectedID:='';
  bError:=False;

  InitProgressBar(8);

  // получение id выделенного элемента
  if not bError then
    if lvAccounts.Selected<>nil then
      if lvAccounts.Selected.SubItems.Count>=5 then
        sSelectedID:=lvAccounts.Selected.SubItems[4];

  // валидация полученного ID
  if not bError then
    if StrToIntDef(sSelectedID, -1)<0 then
      Routines_GenerateError('Получен некорректный ID пользователя (ID="'+sSelectedID+'")!', sErrorMessage, bError)
    else
      begin
        LogThis('Валидация ID выбранного пользователя выполнена успешно (ID="'+sSelectedID+'").', LogGroupGUID, lmtDebug);
        StepProgressBar; // 1
      end;

  with MainForm, Configuration, OverseerServer, CurrentUser do
    begin
      // подключаемся к MySQL-серверу, на котором находится таблица пользователей
      if not bError then
        begin
          MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
          StepProgressBar; // 2
        end;

      // проверяем наличие таблицы пользователей в базе данных
      if not bError then
        begin
          MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
          StepProgressBar; // 3
        end;

      // блокирование таблицы
      if not bError then
        begin
          MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._users WRITE');
          StepProgressBar; // 4
        end;

      // исправление записи таблицы
      if not bError then
        begin
          LogThis('>> Выполняется операция изменения записи таблицы пользователей...', LogGroupGUID, lmtDebug);
          if not bConnected then
            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              if mysql_ping(hConnection)<>0 then
                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
              else
                begin
                  q:='UPDATE' //
                    +' '+sMySQLDatabase+'._users ' //
                    +'SET' //
                    +' usr_login='+Routines_NormalizeStringForQuery(S, True, False)+',' //
                    +' usr_modified_at=NOW(),' //
                    +' usr_modified_by_user_id='+sID+' ' //
                    +'WHERE' //
                    +' usr_id='+sSelectedID+';'; //
                  LogThis(q, LogGroupGUID, lmtSQL);
                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                  else
                    begin
                      LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                      i:=mysql_affected_rows(hConnection);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                      if (i<0)or(i>1) then
                        Routines_GenerateError('Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError);
                    end;
                end;
            end;
          LogThis('<< Выполнение операции изменения записи таблицы пользователей завершено.', LogGroupGUID, lmtDebug);
          StepProgressBar; // 5
        end;

      // проверяем текущий пароль пользователя
      if not bError then
        begin
          LogThis('>> Выполняется операция проверки имени пользователя...', LogGroupGUID, lmtDebug);
          if not bConnected then
            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              if mysql_ping(hConnection)<>0 then
                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
              else
                begin
                  q:='SELECT' //
                    +' usr_login ' //
                    +'FROM' //
                    +' '+sMySQLDatabase+'._users ' //
                    +'WHERE' //
                    +' usr_id='+sSelectedID+' AND' //
                    +' usr_login='+Routines_NormalizeStringForQuery(S, True, False)+';'; //
                  LogThis(q, LogGroupGUID, lmtSQL);
                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                  else
                    begin
                      LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                      ResultSet:=mysql_store_result(hConnection);
                      if ResultSet=nil then
                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                      else
                        begin
                          LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                          i:=mysql_num_rows(ResultSet);
                          LogThis('Количество строк выборки равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                          if i<0 then
                            Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                          else
                            begin
                              if i<>1 then
                                Routines_GenerateError('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                              else
                                begin
                                  LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                  LogThis('Изменение имени пользователя выполнено успешно.', LogGroupGUID, lmtInfo);
                                end;
                            end;
                          mysql_free_result(ResultSet);
                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено успешно.', LogGroupGUID, lmtDebug);
                        end;
                    end;
                end;
            end;
          LogThis('<< Выполнение операции проверки имени пользователя завершено.', LogGroupGUID, lmtDebug);
          StepProgressBar; // 6
        end;

      // разблокирование таблиц
      if not bError then
        begin
          MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
          StepProgressBar; // 7
        end;
      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
      MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
      StepProgressBar; // 8
    end; // of with MainForm, Configuration, OverseerServer, CurrentUser do

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.lvAccountsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  LogGroupGUID: string='{021861A8-88D0-4C2E-96A9-6325EC0E8E71}';
begin
  ProcedureHeader('Процедура-обработчик события отжатия кнопки клавиатуры', LogGroupGUID);
  if Key=VK_F2 then
    if lvAccounts.Selected<>nil then
      Do_Rename;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Properties;
const
  LogGroupGUID: string='{5021AD01-AF04-4ED5-9E07-8BE60543838F}';
  sModalWinName: string='свойств учётной записи';
var
  AccountPropertiesForm: TAccountPropertiesForm;
  sLogin, sFullname, sPosition, sPhone: string;
  bIsAdmin, bDisabled: boolean;
  bError: boolean;
  sErrorMessage: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  i: integer;
  sSelectedID: string;
  mr: TModalResult;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);
  sSelectedID:='';
  bError:=False;
  bIsAdmin:=False;
  bDisabled:=False;
  mr:=mrCancel;

  InitProgressBar(7);

  // получение id выделенного элемента
  if not bError then
    if lvAccounts.Selected<>nil then
      if lvAccounts.Selected.SubItems.Count>=5 then
        sSelectedID:=lvAccounts.Selected.SubItems[4];

  // валидация полученного ID
  if not bError then
    if StrToIntDef(sSelectedID, -1)<0 then
      Routines_GenerateError('Получен некорректный ID пользователя (ID="'+sSelectedID+'")!', sErrorMessage, bError)
    else
      begin
        LogThis('Валидация ID выбранного пользователя выполнена успешно (ID="'+sSelectedID+'").', LogGroupGUID, lmtDebug);
        StepProgressBar; // 1
      end;

  LogThis('>> Выполняется операция получения данных выделенной учётной записи...', LogGroupGUID, lmtDebug);

  with MainForm, Configuration, OverseerServer do
    begin
      // подключаемся к MySQL-серверу, на котором находится таблица пользователей
      if not bError then
        begin
          MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
          StepProgressBar; // 2
        end;

      // проверяем наличие таблицы пользователей в базе данных
      if not bError then
        begin
          MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
          StepProgressBar; // 3
        end;

      // блокирование таблицы
      if not bError then
        begin
          MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._users READ');
          StepProgressBar; // 4
        end;

      // получение данных учётной записи из таблицы пользователей
      if not bError then
        begin
          LogThis('>> Выполняется операция получения данных учётной записи...', LogGroupGUID, lmtDebug);
          if not bConnected then
            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              if mysql_ping(hConnection)<>0 then
                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
              else
                begin
                  q:='SELECT' //
                    +' usr_login,' //
                    +' usr_fullname,' //
                    +' usr_position,' //
                    +' usr_contactphone,' //
                    +' usr_is_admin,' //
                    +' usr_disabled ' //
                    +'FROM' //
                    +' '+sMySQLDatabase+'._users ' //
                    +'WHERE' //
                    +' usr_id='+sSelectedID+';'; //
                  LogThis(q, LogGroupGUID, lmtSQL);
                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                  else
                    begin
                      LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                      ResultSet:=mysql_store_result(hConnection);
                      if ResultSet=nil then
                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                      else
                        begin
                          LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                          i:=mysql_num_rows(ResultSet);
                          LogThis('Количество строк выборки равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                          if i<0 then
                            Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                          else
                            begin
                              if i<>1 then
                                Routines_GenerateError('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                              else
                                begin
                                  LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                  ResultRow:=mysql_fetch_row(ResultSet);
                                  if ResultRow=nil then
                                    Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                  else
                                    begin
                                      sLogin:=string(ResultRow[0]);
                                      sFullname:=string(ResultRow[1]);
                                      sPosition:=string(ResultRow[2]);
                                      sPhone:=string(ResultRow[3]);
                                      bIsAdmin:=string(ResultRow[4])='1';
                                      bDisabled:=string(ResultRow[5])='1';
                                      LogThis('Получение данных учётной записи выполнено успешно.', LogGroupGUID, lmtInfo);
                                    end;
                                end;
                            end;
                          mysql_free_result(ResultSet);
                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                        end;
                    end;
                end;
            end;
          LogThis('<< Выполнение операции получения данных учётной записи завершено.', LogGroupGUID, lmtDebug);
          StepProgressBar; // 5
        end;

      // разблокирование таблиц
      if not bError then
        begin
          MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
          StepProgressBar; // 6
        end;
      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
      MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
      StepProgressBar; // 7
    end; // of with MainForm, Configuration, OverseerServer do

  LogThis('<< Выполнение операции получения данных выделенной учётной записи завершено.', LogGroupGUID, lmtDebug);

  InitProgressBar(7);

  // вывод окна ввода
  if not bError then
    begin
      LogThis('>> Выполняется операция вывода окна свойств выделенной учётной записи...', LogGroupGUID, lmtDebug);
      AccountPropertiesForm:=TAccountPropertiesForm.Create(Self);
      with AccountPropertiesForm do
        try
          Caption:=Caption+' '+sLogin;
          edbxFullname.Text:=sFullname;
          edbxPosition.Text:=sPosition;
          edbxPhone.Text:=sPhone;
          chkbxIsAdmin.Checked:=bIsAdmin;
          chkbxDisable.Checked:=bDisabled;
          PreShowModal(sModalWinName, LogGroupGUID, iBusy);
          ShowModal;
        finally
          PostShowModal(sModalWinName, LogGroupGUID, iBusy);
          mr:=ModalResult;
          sFullname:=edbxFullname.Text;
          sPosition:=edbxPosition.Text;
          sPhone:=edbxPhone.Text;
          bIsAdmin:=chkbxIsAdmin.Checked;
          bDisabled:=chkbxDisable.Checked;
          Free;
        end;
      LogThis('<< Выполнение операции вывода окна свойств выделенной учётной записи завершено.', LogGroupGUID, lmtDebug);
    end;

  // реакция на введённые данные и сохранение данных в таблице БД
  if not bError then
    if mr=mrOk then
      begin
        LogThis('>> Выполняется операция изменения данных выделенной учётной записи...', LogGroupGUID, lmtDebug);

        with MainForm, Configuration, OverseerServer, CurrentUser do
          begin
            // подключаемся к MySQL-серверу, на котором находится таблица пользователей
            if not bError then
              begin
                MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 1
              end;

            // проверяем наличие таблицы пользователей в базе данных
            if not bError then
              begin
                MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
                StepProgressBar; // 2
              end;

            // блокирование таблицы
            if not bError then
              begin
                MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._users WRITE');
                StepProgressBar; // 3
              end;

            // исправление записи таблицы
            if not bError then
              begin
                LogThis('>> Выполняется операция изменения записи таблицы пользователей...', LogGroupGUID, lmtDebug);
                if not bConnected then
                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                else
                  begin
                    if mysql_ping(hConnection)<>0 then
                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                    else
                      begin
                        q:='UPDATE' //
                          +' '+sMySQLDatabase+'._users ' //
                          +'SET' //
                          +' usr_disabled="'+Routines_GetConditionalMessage(bDisabled, '1', '0')+'",' //
                          +' usr_fullname='+Routines_NormalizeStringForQuery(sFullName, True, False)+',' //
                          +' usr_position='+Routines_NormalizeStringForQuery(sPosition, True, False)+',' //
                          +' usr_contactphone='+Routines_NormalizeStringForQuery(sPhone, True, False)+',' //
                          +' usr_is_admin="'+Routines_GetConditionalMessage(bIsAdmin, '1', '0')+'",' //
                          +' usr_modified_at=NOW(),' //
                          +' usr_modified_by_user_id='+sID+' ' //
                          +'WHERE' //
                          +' usr_id='+sSelectedID+';'; //
                        LogThis(q, LogGroupGUID, lmtSQL);
                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                        else
                          begin
                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                            i:=mysql_affected_rows(hConnection);
                            LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                            if (i<0)or(i>1) then
                              Routines_GenerateError('Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError);
                          end;
                      end;
                  end;
                LogThis('<< Выполнение операции изменения записи таблицы пользователей завершено.', LogGroupGUID, lmtDebug);
                StepProgressBar; // 4
              end;

            // проверяем текущий пароль пользователя
            if not bError then
              begin
                LogThis('>> Выполняется операция проверки данных пользователя...', LogGroupGUID, lmtDebug);
                if not bConnected then
                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                else
                  begin
                    if mysql_ping(hConnection)<>0 then
                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                    else
                      begin
                        q:='SELECT' //
                          +' usr_id ' //
                          +'FROM' //
                          +' '+sMySQLDatabase+'._users ' //
                          +'WHERE' //
                          +' usr_id='+sSelectedID+' AND' //
                          +' usr_disabled="'+Routines_GetConditionalMessage(bDisabled, '1', '0')+'" AND' //
                          +' usr_fullname='+Routines_NormalizeStringForQuery(sFullName, True, False)+' AND' //
                          +' usr_position='+Routines_NormalizeStringForQuery(sPosition, True, False)+' AND' //
                          +' usr_contactphone='+Routines_NormalizeStringForQuery(sPhone, True, False)+' AND' //
                          +' usr_is_admin="'+Routines_GetConditionalMessage(bIsAdmin, '1', '0')+'";'; //
                        LogThis(q, LogGroupGUID, lmtSQL);
                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                        else
                          begin
                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                            ResultSet:=mysql_store_result(hConnection);
                            if ResultSet=nil then
                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                            else
                              begin
                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                i:=mysql_num_rows(ResultSet);
                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                                if i<0 then
                                  Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                else
                                  begin
                                    if i<>1 then
                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                        LogThis('Изменение данных пользователя выполнено успешно.', LogGroupGUID, lmtInfo);
                                      end;
                                  end;
                                mysql_free_result(ResultSet);
                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                              end;
                          end;
                      end;
                  end;
                LogThis('<< Выполнение операции проверки данных пользователя завершено.', LogGroupGUID, lmtDebug);
                StepProgressBar; // 5
              end;

            // разблокирование таблиц
            if not bError then
              begin
                MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 6
              end;

            // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
            MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
            StepProgressBar; // 7

            LogThis('<< Выполнение операции изменения данных выделенной учётной записи завершено.', LogGroupGUID, lmtDebug);

            if not bError then
              Do_Refresh;

            // вывод предупреждения о необходимости перелогирования
            if not bError then
              if sSelectedID=MainForm.CurrentUser.sID then
                begin
                  LogThis('>> Производится операция вывода сообщения о необходимости завершения сеанса работы текущего пользователя программы для вступления в силу внесённых изменений...', LogGroupGUID, lmtDebug);
                  MessageBox(Handle, PWideChar('Было произведено изменение данных текущей учётной записи! Изменения вступят в силу только после завершения сеанса работы данного пользователя программы!'), PWideChar('OVERSEER - Внимание!'),
                    MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  LogThis('<< Выполнение операции вывода сообщения о необходимости завершения сеанса работы текущего пользователя программы для вступления в силу внесённых изменений завершено.', LogGroupGUID, lmtDebug);
                end;
          end; // of with MainForm, Configuration, OverseerServer, CurrentUser do
      end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountsForm.Do_Rights;
const
  LogGroupGUID: string='{8187A79A-DDB8-45F2-B36E-01F18D2F4CFA}';
  sModalWinName: string='изменения прав пользователя';
var
  bError: boolean;
  sErrorMessage: string;
  sSelectedID: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  iRoutineCounter, iRowQuantity, iRowCounter: integer;
  slActions: TStringList;
  slSourcePermissions, slResultPermissions: TStringList;
  PermissionsForm: TPermissionsForm;
  mr: TModalResult;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);
  bError:=False;

  InitProgressBar(12);

  // получение id выделенного элемента
  if lvAccounts.Selected<>nil then
    if lvAccounts.Selected.SubItems.Count>=5 then
      sSelectedID:=lvAccounts.Selected.SubItems[4];

  // валидация полученного ID
  if StrToIntDef(sSelectedID, -1)<0 then
    Routines_GenerateError('Получен некорректный ID пользователя (ID="'+sSelectedID+'")!', sErrorMessage, bError)
  else
    begin
      LogThis('Валидация ID выбранного пользователя выполнена успешно (ID="'+sSelectedID+'").', LogGroupGUID, lmtDebug);
      StepProgressBar; // 1
    end;

  if not bError then
    begin
      // формируем полный список прав
      slActions:=TStringList.Create;
      try
        // формирование списка уже разрешённых прав
        slSourcePermissions:=TStringList.Create;
        try
          // формирование списка вновь выставленных прав
          slResultPermissions:=TStringList.Create;
          try
            LogThis('>> Выполняется операция получения прав доступа выделенной учётной записи...', LogGroupGUID, lmtDebug);

            with MainForm, Configuration, OverseerServer do
              begin
                // подключаемся к MySQL-серверу, на котором находится таблицы данных
                MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 2

                if not bError then
                  begin
                    // проверяем наличие таблицы действий в базе данных
                    MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_actions');
                    StepProgressBar; // 3

                    if not bError then
                      begin
                        // блокирование таблицы
                        MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._actions READ');
                        StepProgressBar; // 4

                        // получение данных таблицы действий
                        if not bError then
                          begin
                            LogThis('>> Выполняется операция получения полного списка действий...', LogGroupGUID, lmtDebug);
                            if not bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                else
                                  begin
                                    q:='SELECT' //
                                      +' act_name ' //
                                      +'FROM' //
                                      +' '+sMySQLDatabase+'._actions ' //
                                      +'ORDER BY' //
                                      +' act_name;'; //
                                    LogThis(q, LogGroupGUID, lmtSQL);
                                    if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                        ResultSet:=mysql_store_result(hConnection);
                                        if ResultSet=nil then
                                          Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                            iRowQuantity:=mysql_num_rows(ResultSet);
                                            LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                            if iRowQuantity<0 then
                                              Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                  if bError then
                                                    Break
                                                  else
                                                    begin
                                                      LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                      ResultRow:=mysql_fetch_row(ResultSet);
                                                      if ResultRow=nil then
                                                        Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(OverseerServer),
                                                          sErrorMessage, bError)
                                                      else
                                                        begin
                                                          slActions.Add(string(ResultRow[0]));
                                                          LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                        end;
                                                    end;
                                              end;
                                            mysql_free_result(ResultSet);
                                            LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено успешно.', LogGroupGUID, lmtDebug);
                                          end;
                                      end;
                                  end;
                              end;
                            LogThis('<< Выполнение операции получения полного списка действий завершено.', LogGroupGUID, lmtDebug);
                            StepProgressBar; // 5

                            // разблокирование таблиц
                            if not bError then
                              begin
                                MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                                StepProgressBar; // 6

                                if not bError then
                                  begin
                                    // проверяем наличие таблицы пользователей в базе данных
                                    MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_users');
                                    StepProgressBar; // 7

                                    if not bError then
                                      begin
                                        // проверяем наличие таблицы прав пользователей в базе данных
                                        MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_permissions');
                                        StepProgressBar; // 8

                                        if not bError then
                                          begin
                                            // блокирование таблиц
                                            MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._actions READ, _users READ, _permissions READ');
                                            StepProgressBar; // 9

                                            // получение данных из таблиц
                                            if not bError then
                                              begin
                                                LogThis('>> Выполняется операция получения списка доступных пользователю действий...', LogGroupGUID, lmtDebug);
                                                if not bConnected then
                                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if mysql_ping(hConnection)<>0 then
                                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                    else
                                                      begin
                                                        q:='SELECT' //
                                                          +' act_name ' //
                                                          +'FROM' //
                                                          +' '+sMySQLDatabase+'._permissions ' //
                                                          +'LEFT JOIN' //
                                                          +' '+sMySQLDatabase+'._actions ' //
                                                          +'ON' //
                                                          +' act_id=prm_action_id ' //
                                                          +'LEFT JOIN' //
                                                          +' '+sMySQLDatabase+'._users ' //
                                                          +'ON' //
                                                          +' usr_id=prm_user_id ' //
                                                          +'WHERE' //
                                                          +' prm_permit="1" AND' //
                                                          +' usr_id='+sSelectedID+';'; //
                                                        LogThis(q, LogGroupGUID, lmtSQL);
                                                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                                            ResultSet:=mysql_store_result(hConnection);
                                                            if ResultSet=nil then
                                                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                                iRowQuantity:=mysql_num_rows(ResultSet);
                                                                LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                                if iRowQuantity<0 then
                                                                  Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                else
                                                                  begin
                                                                    LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                                    for iRowCounter:=0 to iRowQuantity-1 do
                                                                      if bError then
                                                                        Break
                                                                      else
                                                                        begin
                                                                          LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                                          ResultRow:=mysql_fetch_row(ResultSet);
                                                                          if ResultRow=nil then
                                                                            Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                              Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              slSourcePermissions.Add(string(ResultRow[0]));
                                                                              LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                                            end;
                                                                        end;
                                                                  end;
                                                                mysql_free_result(ResultSet);
                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                                              end;
                                                          end;
                                                      end;
                                                  end;
                                                LogThis('<< Выполнение операции получения списка доступных пользователю действий завершено.', LogGroupGUID, lmtDebug);
                                                StepProgressBar; // 10

                                                // разблокирование таблиц
                                                if not bError then
                                                  begin
                                                    MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                                                    StepProgressBar; // 11
                                                  end;
                                              end;
                                          end;
                                      end;
                                  end;
                              end;
                          end;
                      end;
                  end;

                // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                StepProgressBar; // 12
              end; // of with MainForm, Configuration, OverseerServer do

            LogThis('<< Выполнение операции получения получения прав доступа выделенной учётной записи завершено.', LogGroupGUID, lmtDebug);

            InitProgressBar(14);

            if not bError then
              begin
                PermissionsForm:=TPermissionsForm.Create(Self);
                ImageList1.GetIcon(ICON_RIGHTS, PermissionsForm.Icon);
                with PermissionsForm do
                  try
                    clbActions.Items.AddStrings(slActions);
                    for iRowCounter:=0 to slSourcePermissions.Count-1 do
                      begin
                        iRoutineCounter:=clbActions.Items.IndexOf(slSourcePermissions[iRowCounter]);
                        if iRoutineCounter>-1 then
                          clbActions.Checked[iRoutineCounter]:=True; // пометка тех действий, на которые есть права использования у выбранного пользователя
                      end;
                    PreShowModal(sModalWinName, LogGroupGUID, iBusy);
                    ShowModal;
                  finally
                    PostShowModal(sModalWinName, LogGroupGUID, iBusy);
                    mr:=ModalResult;
                    if mr=mrOk then
                      for iRoutineCounter:=0 to clbActions.Count-1 do
                        if clbActions.Checked[iRoutineCounter] then
                          slResultPermissions.Add(clbActions.Items[iRoutineCounter]);
                    Free;
                  end;

                if mr=mrOk then
                  begin
                    LogThis('>> Выполняется операция записи прав доступа выделенной учётной записи...', LogGroupGUID, lmtDebug);

                    with MainForm, Configuration, OverseerServer, CurrentUser do
                      begin
                        // подключаемся к MySQL-серверу, на котором находится таблицы данных
                        MySQL_OpenConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 1

                        if not bError then
                          begin
                            // проверяем наличие таблицы прав пользователей в базе данных
                            MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_permissions');
                            StepProgressBar; // 2

                            if not bError then
                              begin
                                // блокирование таблицы
                                MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._permissions WRITE');
                                StepProgressBar; // 3

                                if not bError then
                                  begin
                                    // запрет всех действий для пользователя
                                    LogThis('>> Выполняется операция удаления записей из таблицы...', LogGroupGUID, lmtDebug);
                                    if not bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                        else
                                          begin
                                            q:='DELETE ' //
                                              +'FROM' //
                                              +' '+sMySQLDatabase+'._permissions ' //
                                              +'WHERE' //
                                              +' prm_user_id='+sSelectedID+';'; //
                                            LogThis(q, LogGroupGUID, lmtSQL);
                                            if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                                iRowQuantity:=mysql_affected_rows(hConnection);
                                                LogThis('Количество обработанных строк равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                if iRowQuantity<0 then
                                                  Routines_GenerateError('Количество обработанных строк ('+IntToStr(iRowQuantity)+') не соответствует требуемому (>=0)!', sErrorMessage, bError)
                                                else
                                                  LogThis('Удаление данных выполнено успешно.', LogGroupGUID, lmtDebug);
                                              end;
                                          end;
                                      end;
                                    LogThis('<< Выполнение операции удаления записей из таблицы завершено.', LogGroupGUID, lmtDebug);
                                    StepProgressBar; // 4

                                    // разблокирование таблиц
                                    if not bError then
                                      begin
                                        MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                                        StepProgressBar; // 5

                                        // преобразование строк нового списка прав в строки с номерами в списке действий
                                        if not bError then
                                          begin
                                            if slResultPermissions.Count>0 then
                                              begin
                                                // проверяем наличие таблицы действий в базе данных
                                                MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_actions');
                                                StepProgressBar; // 6

                                                if not bError then
                                                  begin
                                                    // блокирование таблицы
                                                    MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._actions READ');
                                                    StepProgressBar; // 7

                                                    if not bError then
                                                      begin
                                                        LogThis('>> Выполняется операция получения списка номеров разрешённых действий...', LogGroupGUID, lmtDebug);
                                                        if not bConnected then
                                                          Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            if mysql_ping(hConnection)<>0 then
                                                              Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                q:='SELECT' //
                                                                  +' act_id ' //
                                                                  +'FROM' //
                                                                  +' '+sMySQLDatabase+'._actions ' //
                                                                  +'WHERE ' //
                                                                  +' act_name IN('; //
                                                                for iRoutineCounter:=0 to slResultPermissions.Count-1 do
                                                                  begin
                                                                    q:=q+'"'+slResultPermissions[iRoutineCounter]+'"';
                                                                    if iRoutineCounter<slResultPermissions.Count-1 then
                                                                      q:=q+', ';
                                                                  end;
                                                                q:=q+') ' //
                                                                  +'ORDER BY' //
                                                                  +' act_id;'; //

                                                                slResultPermissions.Clear; // так как больше список ненужен - повторно используем его для сохранения номеров вновь разрешённых действий

                                                                LogThis(q, LogGroupGUID, lmtSQL);
                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                  Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                else
                                                                  begin
                                                                    LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                                                    ResultSet:=mysql_store_result(hConnection);
                                                                    if ResultSet=nil then
                                                                      Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                    else
                                                                      begin
                                                                        LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                                        iRowQuantity:=mysql_num_rows(ResultSet);
                                                                        LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                                        if iRowQuantity<0 then
                                                                          Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                        else
                                                                          begin
                                                                            LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                                            for iRowCounter:=0 to iRowQuantity-1 do
                                                                              if bError then
                                                                                Break
                                                                              else
                                                                                begin
                                                                                LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                slResultPermissions.Add(string(ResultRow[0]));
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                                                end;
                                                                                end;
                                                                          end;
                                                                        mysql_free_result(ResultSet);
                                                                        LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                                                      end;
                                                                  end;
                                                              end;
                                                          end;
                                                        LogThis('<< Выполнение операции получения списка номеров разрешённых действий завершено.', LogGroupGUID, lmtDebug);
                                                        StepProgressBar; // 8

                                                        if not bError then
                                                          begin
                                                            // разблокирование таблиц
                                                            MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                                                            StepProgressBar; // 9

                                                            if not bError then
                                                              begin
                                                                if slResultPermissions.Count>0 then
                                                                  begin
                                                                    // проверяем наличие таблицы прав пользователей в базе данных
                                                                    MySQL_CheckTableExistance(LogGroupGUID, OverseerServer, sMySQLDatabase, bError, sErrorMessage, '_permissions');
                                                                    StepProgressBar; // 10

                                                                    // блокирование таблицы
                                                                    if not bError then
                                                                      begin
                                                                        MySQL_LockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage, sMySQLDatabase+'._permissions WRITE');
                                                                        StepProgressBar; // 11

                                                                        if not bError then
                                                                          begin
                                                                            for iRoutineCounter:=0 to slResultPermissions.Count-1 do
                                                                              if bError then
                                                                                Break
                                                                              else
                                                                                begin
                                                                                q:='INSERT ' //
                                                                                +'INTO' //
                                                                                +' '+MainForm.Configuration.OverseerServer.sMySQLDatabase+'._permissions (' //
                                                                                +'prm_user_id, ' //
                                                                                +'prm_action_id, ' //
                                                                                +'prm_permit, ' //
                                                                                +'prm_modified_at, ' //
                                                                                +'prm_modified_by_user_id' //
                                                                                +') VALUES (' //
                                                                                +sSelectedID+', ' //
                                                                                +slResultPermissions[iRoutineCounter]+', ' //
                                                                                +'"1", ' //
                                                                                +'NOW(), ' //
                                                                                +sID+');'; //
                                                                                iRowCounter:=MySQL_InsertRecords(LogGroupGUID, OverseerServer, bError, sErrorMessage, q);
                                                                                if iRowCounter<>1 then
                                                                                Routines_GenerateError('Количество обработанных строк ('+IntToStr(iRowCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError);
                                                                                end;
                                                                            StepProgressBar; // 12

                                                                            if not bError then
                                                                              begin
                                                                                // разблокирование таблиц
                                                                                MySQL_UnlockTables(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                                                                                StepProgressBar; // 13
                                                                              end;
                                                                          end;
                                                                      end;
                                                                  end;
                                                              end;
                                                          end;
                                                      end;
                                                  end;
                                              end;
                                          end;
                                      end;
                                  end;
                              end;
                          end;

                        // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                        MySQL_CloseConnection(LogGroupGUID, OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 14
                      end; // of with MainForm, Configuration, OverseerServer, CurrentUser do

                    LogThis('<< Выполнение операции записи прав доступа выделенной учётной записи завершено.', LogGroupGUID, lmtDebug);
                  end;
              end;

          finally
            slResultPermissions.Free;
          end;
        finally
          slSourcePermissions.Free;
        end;
      finally
        slActions.Free;
      end;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

end.
