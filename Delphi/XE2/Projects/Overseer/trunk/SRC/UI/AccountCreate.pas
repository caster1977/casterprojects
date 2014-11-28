unit AccountCreate;

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
  Mask,
  ExtCtrls,
  StdCtrls,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  Accounts,
  OverseerTypes, System.Actions;

type
  TAccountCreateForm=class(TForm)
    lblLogin: TLabel;
    edbxLogin: TEdit;
    edbxFullname: TEdit;
    lblFullname: TLabel;
    lblPosition: TLabel;
    edbxPosition: TEdit;
    lblPhone: TLabel;
    edbxPhone: TEdit;
    lblConfirmation: TLabel;
    lblPassword: TLabel;
    Bevel1: TBevel;
    mskPassword: TMaskEdit;
    mskConfirmation: TMaskEdit;
    chkbxIsAdmin: TCheckBox;
    chkbxDisable: TCheckBox;
    btnHelp: TButton;
    Bevel2: TBevel;
    btnCreate: TButton;
    btnClose: TButton;
    ActionManager1: TActionManager;
    Action_Create: TAction;
    Action_Close: TAction;
    Action_Help: TAction;
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_CreateExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Do_UpdateActions;
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_Create;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
    procedure InitProgressBar(const aMax: integer);
    procedure StepProgressBar;
  end;

var
  AccountCreateForm: TAccountCreateForm;

implementation

{$R *.dfm}

uses
  CastersPackage.uMysql,
  Main,
  OverseerRoutines,
  OverseerConsts;

procedure TAccountCreateForm.InitProgressBar(const aMax: integer);
begin
  with MainForm do
    begin
      pbMain.Position:=pbMain.Min;
      pbMain.Max:=aMax;
    end;
  Application.ProcessMessages;
end;

procedure TAccountCreateForm.StepProgressBar;
begin
  MainForm.pbMain.Position:=MainForm.pbMain.Position+MainForm.pbMain.Step;
  Application.ProcessMessages;
end;

procedure TAccountCreateForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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

procedure TAccountCreateForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TAccountCreateForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TAccountCreateForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TAccountCreateForm.FormCreate(Sender: TObject); // завершена
const
  LogGroupGUID: string='{DE0DCC91-CA35-448A-9D90-90AE67C0B19B}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  with Action_Help do
    begin
      Enabled:=Application.HelpFile<>'';
      Visible:=Enabled;
    end;
  LogThis('Действие "'+Action_Help.Caption+'" '+Routines_GetConditionalMessage(Action_Help.Visible, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.FormShow(Sender: TObject); // завершена
const
  LogGroupGUID: string='{71A39299-5B1F-4C18-A2D8-78AC9683B872}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.FieldsChange(Sender: TObject); // завершена
const
  LogGroupGUID: string='{81E6D75C-8893-47E7-8206-3BD3332A6623}';
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.Do_UpdateActions; // завершена
const
  LogGroupGUID: string='{84FB2AFA-D1F8-4A63-959E-FEB0E76EA4B3}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);

  LogThis('Отображено окно создания новой учётной записи.', LogGroupGUID, lmtInfo);
  Action_Create.Enabled:=(edbxLogin.Text<>'')and(edbxFullname.Text<>'')and(edbxPosition.Text<>'')and(edbxPhone.Text<>'')and(mskPassword.Text=mskConfirmation.Text);
  LogThis('Действие "'+Action_Create.Caption+'" '+Routines_GetConditionalMessage(Action_Create.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  btnCreate.default:=Action_Create.Enabled;
  btnClose.default:=not Action_Create.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{D7BC6460-04BE-4080-BA33-6DE796B9F504}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.Action_CreateExecute(Sender: TObject);
const
  LogGroupGUID: string='{296AF451-9F40-4B8F-8E49-21EDE305F088}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Create.Caption+'"', LogGroupGUID);
  Do_Create;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{0ADEE611-FA1C-453A-907E-E0A2F3B53B26}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.Do_Help;
const
  LogGroupGUID: string='{08674FD3-95D9-4B67-9AD6-2EA3111E3B65}';
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

procedure TAccountCreateForm.Do_Close; // завершена
const
  LogGroupGUID: string='{7C4B2989-7CC2-4CDC-B2BC-76CDA8E954FA}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Попытка создания новой учётной записи была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно создания новой учётной записи закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountCreateForm.Do_Create;
const
  LogGroupGUID: string='{709196AF-3FD0-416B-9051-F1269DD3BD52}';
var
  bError: boolean;
  sErrorMessage: string;
  ResultSet: PMYSQL_RES;
  q: string;
  i: integer;
  sLogin, sFullName, sPosition, sPhone, sPassword, sConfirmation: string;
  bIsAdmin, bDisabled: boolean;
begin
  ProcedureHeader('Процедура добавления нового пользователя', LogGroupGUID);

  // сохранение введённых в поля данных
  sLogin:=edbxLogin.Text;
  sFullName:=edbxFullname.Text;
  sPosition:=edbxPosition.Text;
  sPhone:=edbxPhone.Text;
  sPassword:=mskPassword.Text;
  sConfirmation:=mskConfirmation.Text;
  bIsAdmin:=chkbxIsAdmin.Checked;
  bDisabled:=chkbxDisable.Checked;

  // валидация пароля
  if sPassword<>sConfirmation then
    Routines_GenerateError('Значения полей пароля и подтверждения отличаются друг от друга!', sErrorMessage, bError)
  else
    LogThis('Валидация пароля и подтверждения выполнена успешно.', LogGroupGUID, lmtDebug);

  InitProgressBar(8);

  with MainForm, Configuration, OverseerServer do
    begin
      if not bError then // подключаемся к MySQL-серверу
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

      // проверка наличия пользователя с идентичным логином в таблице пользователей
      if not bError then
        begin
          LogThis('>> Выполняется операция проверки наличия учётной записи с идентичным логином...', LogGroupGUID, lmtDebug);
          if not bConnected then
            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              if mysql_ping(hConnection)<>0 then
                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
              else
                begin
                  q:='SELECT' //
                    +' * ' //
                    +'FROM' //
                    +' '+sMySQLDatabase+'._users ' //
                    +'WHERE' //
                    +' usr_login='+Routines_NormalizeStringForQuery(sLogin, True, False)+';'; //
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
                              if i>0 then
                                begin
                                  LogThis('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (0)!', LogGroupGUID, lmtError);
                                  Routines_GenerateError('Учётная запись пользователя с таким логином уже существует!', sErrorMessage, bError);
                                end
                              else
                                begin
                                  LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                  LogThis('Пользователя с идентичным логином не найдено.', LogGroupGUID, lmtDebug);
                                end;
                            end;
                          mysql_free_result(ResultSet);
                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                        end;
                    end;
                end;
            end;
          LogThis('<< Выполнение операции проверки наличия учётной записи с идентичным логином завершено.', LogGroupGUID, lmtDebug);
          StepProgressBar; // 4
        end;

      // добавление новой записи в таблицу пользователей
      if not bError then
        begin
          LogThis('>> Выполняется операция вставки записи в таблицу пользователей...', LogGroupGUID, lmtDebug);
          if not bConnected then
            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              if mysql_ping(hConnection)<>0 then
                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
              else
                begin
                  q:='INSERT INTO '+sMySQLDatabase+'._users (' //
                    +'usr_disabled, ' //
                    +'usr_login, ' //
                    +'usr_password_md5, ' //
                    +'usr_fullname, ' //
                    +'usr_position, ' //
                    +'usr_contactphone, ' //
                    +'usr_is_admin, ' //
                    +'usr_created_at, ' //
                    +'usr_created_by_user_id, ' //
                    +'usr_modified_at, ' //
                    +'usr_modified_by_user_id' //
                    +') VALUES (' //
                    +'"'+Routines_GetConditionalMessage(bDisabled, '1', '0')+'", ' //
                    +Routines_NormalizeStringForQuery(sLogin, True, False)+', ' //
                    +'md5('+Routines_NormalizeStringForQuery(sPassword, True, False)+'), ' //
                    +Routines_NormalizeStringForQuery(sFullName, True, False)+', ' //
                    +Routines_NormalizeStringForQuery(sPosition, True, False)+', ' //
                    +Routines_NormalizeStringForQuery(sPhone, True, False)+', ' //
                    +'"'+Routines_GetConditionalMessage(bIsAdmin, '1', '0')+'", ' //
                    +'NOW(), ' //
                    +CurrentUser.sID+', ' //
                    +'NOW(), ' //
                    +CurrentUser.sID //
                    +');'; //
                  LogThis(q, LogGroupGUID, lmtSQL);
                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                  else
                    begin
                      LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                      i:=mysql_affected_rows(hConnection);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                      if (i<0)or(i>1) then
                        Routines_GenerateError('Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                      else
                        LogThis('Данные пользователя добавлены в базу данных успешно.', LogGroupGUID, lmtDebug);
                    end;
                end;
            end;
          LogThis('<< Выполнение операции вставки записи в таблицу пользователей завершено.', LogGroupGUID, lmtDebug);
          StepProgressBar; // 5
        end;

      // проверяем наличие вставленной записи
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
                    +'FROM '+sMySQLDatabase+'._users ' //
                    +'WHERE' //
                    +' usr_id='+IntToStr(mysql_insert_id(hConnection))+' AND' //
                    +' usr_disabled="'+Routines_GetConditionalMessage(bDisabled, '1', '0')+'" AND' //
                    +' usr_login='+Routines_NormalizeStringForQuery(sLogin, True, False)+' AND' //
                    +' usr_password_md5=md5('+Routines_NormalizeStringForQuery(sPassword, True, False)+') AND' //
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
                                  LogThis('Добавление данных нового пользователя выполнено успешно.', LogGroupGUID, lmtInfo);
                                end;
                            end;
                          mysql_free_result(ResultSet);
                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                        end;
                    end;
                end;
            end;
          LogThis('<< Выполнение операции проверки данных пользователя завершено.', LogGroupGUID, lmtDebug);
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

  // закрытие модального окна с результатом mrOk
  if not bError then
    begin
      ModalResult:=mrOk;
      LogThis('Окно создания новой учётной записи закрыто.', LogGroupGUID, lmtInfo);
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

end.
