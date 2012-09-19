unit OA5.uTMainForm;

interface

uses
  CastersPackage.uLogProvider,
  OA5.uIAccount,
  OA5.uIConfiguration,
  OA5.uIMeasureList,
  OA5.uTAccount,
  OA5.uTConfiguration,
  OA5.uTOA5LogForm,
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  Vcl.ActnList,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.ImgList,
  Vcl.Menus,
  Winapi.Windows,
  Vcl.StdCtrls;

type
  TMainForm = class(TOA5LogForm)
    MainMenu: TMainMenu;
    imState: TImage;
    ilSmall: TImageList;
    ilLarge: TImageList;
    ilStates: TImageList;
    StatusBar: TStatusBar;
    pbMain: TProgressBar;
    ActionList: TActionList;
    actQuit: TAction;
    actAbout: TAction;
    actHelp: TAction;
    actConfiguration: TAction;
    actAccounts: TAction;
    actReport: TAction;
    actLogon: TAction;
    actLogoff: TAction;
    actMultibuffer: TAction;
    actCreateMessage: TAction;
    actViewMessages: TAction;
    actViewMessage: TAction;
    actAddPhone: TAction;
    actEditPhone: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    O1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    miStatusBar: TMenuItem;
    miToolBar: TMenuItem;
    actStatusBar: TAction;
    actToolBar: TAction;
    actViewPhones: TAction;
    N21: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actQuitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actMultibufferExecute(Sender: TObject);
    procedure actCreateMessageExecute(Sender: TObject);
    procedure actViewMessageExecute(Sender: TObject);
    procedure actAddPhoneExecute(Sender: TObject);
    procedure actEditPhoneExecute(Sender: TObject);
    procedure actLogonExecute(Sender: TObject);
    procedure actLogoffExecute(Sender: TObject);
    procedure actLogonUpdate(Sender: TObject);
    procedure actLogoffUpdate(Sender: TObject);
    procedure actAccountsUpdate(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actViewPhonesExecute(Sender: TObject);
  strict private
    FMultiBuffer: IMeasureList;
    function GetMultiBuffer: IMeasureList;
    procedure ApplicationOnHint(Sender: TObject);
    procedure _About(const AButtonVisible: Boolean);
    procedure _Configuration;
    procedure _Report;
    procedure _LoadConfiguration;
    procedure _ApplyConfiguration;
    procedure _SaveConfiguration;
    procedure _Logon;
    procedure _Logoff;
    procedure _RefreshBusyState;
  protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure InitializeLog; override;
    function GetConfiguration: IConfiguration; override;
    function GetCurrentUser: IAccount; override;
  public
    property MultiBuffer: IMeasureList read GetMultiBuffer nodefault;
  end;

var
  MainForm: TMainForm;
  GlobalBusyCounter: Integer;
  GlobalConfiguration: IConfiguration;
  GlobalCurrentUser: IAccount;

implementation

{$R *.dfm}

uses
  CastersPackage.uResourceStrings,
  System.IOUtils,
  Winapi.CommCtrl,
  OA5.uTMySQLConnection,
  OA5.uTAboutForm,
  OA5.uTConfigurationForm,
  OA5.uTReportForm,
  OA5.uTMultiBufferForm,
  OA5.uIMeasure,
  OA5.uTMeasure,
  OA5.uTMeasureList,
  OA5.uTAddMassMsrForm,
  OA5.uTLoginForm,
  OA5.uTCreateMessageForm,
  OA5.uTViewMessageForm,
  OA5.uTViewMessagesForm,
  OA5.uTAddEditPhoneForm,
  CastersPackage.uRoutines,
  CastersPackage.uMysql,
  OA5.uTPhone,
  OA5.uICustomPhone,
  OA5.uTUnknownPhone,
  OA5.uTStationaryPhone,
  OA5.uTStationaryProviders,
  OA5.uTPhoneListForm,
  OA5.uTMobilePhone,
  OA5.uTMobileProviders;

type
  THackControl = class(TControl);

const
  STATUSBAR_STATE_PANEL_NUMBER: Integer = 0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: Integer = 1;
  STATUSBAR_SERVER_NAME: Integer = 2;
  STATUSBAR_HINT_PANEL_NUMBER: Integer = 3;

resourcestring
  // RsCreateMutexError = 'Не удалось создать мьютекс.';
  // RsWaitForMutexError = 'Не удалось считать состояние мьютекса.';
  // RsReleaseMutexError = 'Не удалось удалить мьютекс.';
  // RsCloseMutexHandleError = 'Не удалось закрыть идентификатор мьютекса.';
  // RsErrorCode = ' Код ошибки: %s';
  RsMainForm = 'главного окна программы';
  RsAboutFormSuffix = '"О программе..."';
  RsConfigurationFormSuffix = 'настроек программы';
  RsReportFormSuffix = 'формирования статистических отчётов по работе пользователей';
  RsMultiBufferFormSuffix = 'мультибуфера';
  RsCreateMessageFormSuffix = 'создания нового сообщения';
  RsViewMessageFormSuffix = 'просмотра полученного сообщения';
  RsViewMessagesFormSuffix = 'просмотра полученных сообщений';
  RsAddPhoneFormSuffix = 'добавления номера телефона';
  RsEditPhoneFormSuffix = 'исправления номера телефона';
  RsPhoneListFormSuffix = 'просмотра списка телефонов';
  RsLoginFormSuffix = 'ввода учётной записи';
  RsShowWindowProcedure = 'Процедура отображения окна %s';

procedure TMainForm._RefreshBusyState;
var
  b: Boolean;
begin
  b := GlobalBusyCounter = 0;
  Log.SendDebug('Установлен режим "' + Routines.GetConditionalString(b, 'Готово', 'Занято') + '".');
  ilStates.GetIcon(Integer(b), imState.Picture.Icon);
  if Configuration.EnableStatusbar then
  begin
    StatusBar.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text := Routines.GetConditionalString(GlobalBusyCounter > 0,
      'Пожалуйста, подождите...', 'Готово');
  end
  else
  begin
    StatusBar.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text := EmptyStr;
  end;
  Application.ProcessMessages;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actAbout.Caption]), '{90CC0AAB-ED7C-46FF-97FF-4431F18EBA1A}');
  _About(True);
  ProcedureFooter;
end;

procedure TMainForm._About(const AButtonVisible: Boolean);
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsAboutFormSuffix]), '{754C2801-ED59-4595-AC3E-20DBF98F6779}');
  with TAboutForm.Create(Self, AButtonVisible, Addr(GlobalBusyCounter), _RefreshBusyState, pbMain) do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
  ProcedureFooter;
end;

procedure TMainForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{D066E67D-C195-440D-94C2-6757C427DCF6}');
  Help(HelpContext, '{94165848-9C2D-4110-A47F-32337C35794E}');
  ProcedureFooter;
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actQuit.Caption]), '{5DB14721-5FC4-4B42-B0DB-4E7C323A2AA2}');
  Close;
  ProcedureFooter;
end;

procedure TMainForm.actReportExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actReport.Caption]), '{90957E86-35D1-4C1B-9C1F-4C99CE5D2B56}');
  _Report;
  ProcedureFooter;
end;

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  ProcedureHeader('Процедура включения/отключения отображения панели статуса', '{3550143C-FACD-490F-A327-4E1496CDEC5E}');
  b := actStatusBar.Checked;

  StatusBar.Visible := b;
  Configuration.EnableStatusbar := b;
  Log.SendInfo('Панель статуса ' + Routines.GetConditionalString(b, 'в', 'от') + 'ключена.');

  ProcedureFooter;
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  ProcedureHeader('Процедура включения/отключения отображения панели кнопок', '{786D709B-0201-41AE-923C-BC307AE26A6B}');
  b := actToolBar.Checked;

  // StatusBar.Visible:=b;
  Configuration.EnableToolbar := b;
  Log.SendInfo('Панель кнопок ' + Routines.GetConditionalString(b, 'в', 'от') + 'ключена.');

  ProcedureFooter;
end;

procedure TMainForm.Initialize;
var
  PanelRect: TRect;

  procedure BindProgressBarToStatusBar;
  begin
    THackControl(pbMain).SetParent(StatusBar);
    SendMessage(StatusBar.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
    pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right - PanelRect.Left, PanelRect.Bottom - PanelRect.Top - 1);
  end;

  procedure BindStateImageToStatusBar;
  begin
    THackControl(imState).SetParent(StatusBar);
    SendMessage(StatusBar.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
    imState.SetBounds(PanelRect.Left + 2, PanelRect.Top + 1, PanelRect.Right - PanelRect.Left - 4,
      PanelRect.Bottom - PanelRect.Top - 4);
  end;

begin
  _RefreshBusyState;
  Configuration.DBServer.LogProvider := Log;
  Configuration.MessageServer.LogProvider := Log;
  BindProgressBarToStatusBar; // привязка прогрессбара к позиции на строке статуса
  BindStateImageToStatusBar; // привязка иконки готовности к позиции на строке статуса
  Application.OnHint := ApplicationOnHint;
  _LoadConfiguration; // загрузка настроек из файла
  inherited;
  _ApplyConfiguration; // применение настроек к интерфейсу
end;

procedure TMainForm.InitializeLog;
begin
  inherited;
  // установка параметров протоколирования в соответствии с настройками программы
  Log.UserName := CurrentUser.Login;
  Log.AllowedTypes := Configuration.KeepLogTypes;
  Log.Enabled := Configuration.EnableLog;
end;

procedure TMainForm.Finalize;
begin
  // применение текущих настроек главного окна к конфигурации
  Configuration.MainFormLeft := Left;
  Configuration.MainFormTop := Top;
  Configuration.MainFormWidth := Width;
  Configuration.MainFormHeight := Height;
  Configuration.MainFormEnableCentered := False;
  Configuration.MainFormEnableFullScreenAtLaunch := WindowState = wsMaximized;
  // запись конфигурации
  _SaveConfiguration;
  inherited;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Initialize;
  if Configuration.EnableSplashAtStart then
  begin
    _About(False);
  end;
  if Configuration.EnableAutoLogon then
  begin
    _Logon;
  end;
end;

procedure TMainForm.ApplicationOnHint(Sender: TObject);
begin
  if Configuration.EnableStatusbar then
  begin
    StatusBar.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text := GetLongHint(Application.Hint);
  end;
end;

function TMainForm.GetConfiguration: IConfiguration;
begin
  Result := GlobalConfiguration;
end;

function TMainForm.GetCurrentUser: IAccount;
begin
  Result := GlobalCurrentUser;
end;

function TMainForm.GetMultiBuffer: IMeasureList;
begin
  if not Assigned(FMultiBuffer) then
  begin
    FMultiBuffer := GetIMeasureList;
  end;
  Result := FMultiBuffer;
end;

procedure TMainForm.actLogonUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  if Assigned(CurrentUser) then
  begin
    b := not CurrentUser.Logged;
    if actLogon.Enabled <> b then
    begin
      ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actLogon.Caption]), '{03684037-88D8-43AE-B198-A1DF544BDC40}');
      actLogon.Enabled := b;
      Log.SendDebug(GetActionUpdateLogMessage(actLogon));
      ProcedureFooter;
    end;
  end;
end;

procedure TMainForm.actLogoffUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  if Assigned(CurrentUser) then
  begin
    b := CurrentUser.Logged;
    if actLogoff.Enabled <> b then
    begin
      ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actLogoff.Caption]), '{AFDD10B3-F271-4126-A984-0607A15A0950}');
      actLogoff.Enabled := b;
      Log.SendDebug(GetActionUpdateLogMessage(actLogoff));
      ProcedureFooter;
    end;
  end;
end;

procedure TMainForm.actAccountsUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  if Assigned(CurrentUser) then
  begin
    b := CurrentUser.Logged and CurrentUser.Privilegies.Accounting;
    if actAccounts.Enabled <> b then
    begin
      ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actAccounts.Caption]), '{AFDD10B3-F271-4126-A984-0607A15A0950}');
      actAccounts.Enabled := b;
      Log.SendDebug(GetActionUpdateLogMessage(actAccounts));
      ProcedureFooter;
    end;
  end;
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actConfiguration.Caption]),
    '{024B2718-8D00-49A1-9E1E-C02CB2696CE0}');
  _Configuration;
  ProcedureFooter;
end;

procedure TMainForm._Configuration;
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsConfigurationFormSuffix]), '{886B460D-4C73-46BE-829E-E4421B7C4378}');

  with TConfigurationForm.Create(Self, Configuration.ConfigurationFormPosition, @GlobalBusyCounter, _RefreshBusyState,
    pbMain, Configuration, CurrentUser) do
  begin
    try
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
        _ApplyConfiguration;
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm._LoadConfiguration;
begin
  ProcedureHeader('Процедура чтения настроек программы из файла', '{650B9486-2600-4038-B711-3281F7252336}');
  Log.SendInfo('Производится попытка чтения настроек программы из файла...');
  try
    Screen.Cursor := crHourGlass;
    try
      Configuration.Load;
      Log.SendInfo('Чтение настроек программы из файла прошло успешно.');
    finally
      Screen.Cursor := crDefault;
    end;
  except
    GenerateError('Произошла ошибка при попытке чтения настроек программы из файла!');
    Application.HandleException(Self);
  end;
  ProcedureFooter;
end;

procedure TMainForm._SaveConfiguration;
begin
  ProcedureHeader('Процедура записи настроек программы в файл', '{2BD55804-9631-45C8-9484-42F4DDC45C29}');

  Log.SendInfo('Производится попытка записи настроек программы в файл...');
  try
    Screen.Cursor := crHourGlass;
    try
      Configuration.Save;
      Log.SendInfo('Запись настроек программы в файл прошла успешно.');
    finally
      Screen.Cursor := crDefault;
    end;
  except
    on E: EIniFileException do
    begin
      GenerateError(E.Message);
      if MessageBox(Handle, PWideChar('Вы желаете повторить попытку записи настроек программы в файл?'),
        PWideChar(Application.Title + ' - Предупреждение'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1) = IDOK then
        try
          Screen.Cursor := crHourGlass;
          try
            Configuration.Save;
            Log.SendInfo('Запись настроек программы в файл прошла успешно.');
          except
            on E: EIniFileException do
              GenerateError(E.Message);
          end;
        finally
          Screen.Cursor := crDefault;
        end;
    end;
    else
      Application.HandleException(Self);
  end;

  ProcedureFooter;
end;

procedure TMainForm._ApplyConfiguration;
begin
  ProcedureHeader('Процедура применения изменений к интерфейсу программы', '{67A9E9BC-62AC-4848-B20D-C8B5095DEB6C}');

  // установка видимости панели статуса в соответствии с настройками программы
  miStatusBar.Checked := Configuration.EnableStatusbar;
  StatusBar.Visible := Configuration.EnableStatusbar;

  // установка позиции и размеров главного окна в соответсвии с параметрами конфигурации
  WindowState := wsNormal;
  Position := poDesigned;
  Left := Configuration.MainFormLeft;
  Top := Configuration.MainFormTop;
  Width := Configuration.MainFormWidth;
  Height := Configuration.MainFormHeight;
  if Configuration.MainFormEnableFullScreenAtLaunch then
  begin
    WindowState := wsMaximized;
  end
  else
  begin
    if Configuration.MainFormEnableCentered then
    begin
      Position := poScreenCenter;
      Configuration.MainFormEnableCentered := False;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm._Report;
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsReportFormSuffix]), '{0B2728D4-5577-4D1E-9F51-3F40A61BA774}');

  with TReportForm.Create(Self, Configuration.ReportFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
    Configuration, CurrentUser) do
  begin
    try
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actMultibufferExecute(Sender: TObject);
var
  i: Integer;
  aListItem: TListItem;
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsMultiBufferFormSuffix]), '{0B2728D4-5577-4D1E-9F51-3F40A61BA774}');

  with TMultiBufferForm.Create(Self, Configuration.MultibufferFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
    Configuration, CurrentUser, MultiBuffer) do
  begin
    try
      for i := 0 to MultiBuffer.Count - 1 do
      begin
        aListItem := lvBuffer.Items.Add;
        aListItem.Caption := IntToStr(i);
        aListItem.SubItems.Add(MultiBuffer[i].Type_ + '|' + MultiBuffer[i].Name + '|' + MultiBuffer[i].Author + '|' +
          MultiBuffer[i].Producer + '|' + MultiBuffer[i].Performer + '|' + MultiBuffer[i].Organizer + '|' +
          MultiBuffer[i].TicketPrice + '|' + string(MultiBuffer[i].OtherInfoPlane));
      end;
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actViewMessageExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsViewMessageFormSuffix]), '{347244A6-22DF-44DF-873B-2B55FC5112B9}');

  with TViewMessageForm.Create(Self, Configuration.ViewMessageFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
    Configuration, CurrentUser) do
  begin
    try
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actViewPhonesExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsPhoneListFormSuffix]), '{5CFCDFBC-34DF-4A16-A725-A4B388B9EC97}');

  with TPhoneListForm.Create(Self, Configuration.PhoneListFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
    Configuration, CurrentUser) do
  begin
    try
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actCreateMessageExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsCreateMessageFormSuffix]), '{F356F5DA-5FF7-4F78-A80E-1C563B96AF6D}');

  with TCreateMessageForm.Create(Self, Configuration.CreateMessageFormPosition, @GlobalBusyCounter, _RefreshBusyState,
    pbMain, Configuration, CurrentUser) do
  begin
    try
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actAddPhoneExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsAddPhoneFormSuffix]), '{83D61BCA-0CB5-4542-9D0A-9137AE9C733C}');

  with TAddEditPhoneForm.Create(Self, Configuration.AddEditPhoneFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
    Configuration, CurrentUser) do
  begin
    try
      Caption := 'Добавление номера телефона';
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actEditPhoneExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsEditPhoneFormSuffix]), '{36EA36F5-EDE2-4A3A-A7DE-BB9790D3F50F}');

  with TAddEditPhoneForm.Create(Self, Configuration.AddEditPhoneFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
    Configuration, CurrentUser) do
  begin
    try
      Caption := 'Исправление номера телефона';
      ShowModal;
    finally
      if ModalResult = mrOk then
      begin
      end;
      Free;
    end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.actLogonExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actLogon.Caption]), '{25B404A0-78C1-47D6-AFCE-33168CAF333A}');
  _Logon;
  ProcedureFooter;
end;

procedure TMainForm.actLogoffExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actLogoff.Caption]), '{3A1F49AC-A9CF-4FC7-90AA-A6D2E5AE1619}');
  _Logoff;
  ProcedureFooter;
end;

procedure TMainForm._Logon;
// resourcestring
// TEXT_AOUTOLOGON_ERROR='Выполнить автоматический ыход не удалось - проверьте правильность сохраненных логина и пароля пользователя!';
var
  LoginForm: TLoginForm;
  bPassLoginForm: Boolean;

  (* procedure _Login;
    var
    aResultSet: PMYSQL_RES;
    iRowCount: integer;
    slRow: TStringList;
    begin
    Screen.Cursor := crHourGlass;
    try
    Configuration.MessagesServer.Connected := True;
    Configuration.RNE4Server.Connected := True;
    iRowCount := Configuration.RNE4Server.Query
    ('SELECT usr_id, usr_fullname, usr_position, usr_phone, usr_editing, usr_clearing, usr_accounting, usr_reporting FROM '
    + Configuration.RNE4Server.Database + '._usr_rne5 WHERE usr_login="' + Configuration.Login +
    '" AND usr_password_md5=md5("' + Configuration.Password + '");', aResultSet);
    if iRowCount > 1 then
    raise Exception.Create
    ('В базе данных имеется более одного аккаунта с указанными логином и паролем! Обратитесь к администратору!')
    else
    if iRowCount < 1 then
    raise Exception.Create
    ('В базе данных отсутствует аккаунт с указанными логином и паролем! Проверьте правильность ввода данных!')
    else
    begin
    slRow := Configuration.RNE4Server.FetchRow(aResultSet);
    with CurrentUser do
    begin
    ID := StrToIntDef(slRow[0], -1);
    Login := Configuration.Login;
    Password := Configuration.Password;
    Fullname := slRow[1];
    Position := slRow[2];
    Phone := slRow[3];
    with Privilegies do
    begin
    Editing := slRow[4] = '1';
    Clearing := slRow[5] = '1';
    Accounting := slRow[6] = '1';
    Reporting := slRow[7] = '1';
    end;
    if ID = -1 then
    raise Exception.Create('Неправильный идентификатор пользователя (' + IntToStr(ID) +
    ')! Обратитесь к администратору!')
    else
    Logged := True;
    end;
    end;
    Do_UpdateActions;
    finally
    FreeAndNil(slRow);
    Screen.Cursor := crDefault;
    end
    end; *)

begin
  ProcedureHeader(Format(RsShowWindowProcedure, [RsLoginFormSuffix]), '{68883F7C-57C2-4E56-B2FB-AEDCB1EB25DC}');

  bPassLoginForm := Configuration.EnableAutoLogon and Configuration.EnableStoreLogin and
    Configuration.EnableStorePassword and (Configuration.StoredLogin <> EmptyStr);

  if bPassLoginForm then
    try
      (* _Login; *)
    except
      on E: EMySQLException do
      begin
        bPassLoginForm := False;
        GenerateError(E.Message);
        ShowErrorDialog;
      end;
      // else
      // raise Exception.Create(TEXT_AOUTOLOGON_ERROR);
    end;

  if not bPassLoginForm then
  begin
    LoginForm := TLoginForm.Create(Self, Configuration.LoginFormPosition, @GlobalBusyCounter, _RefreshBusyState, pbMain,
      Configuration, CurrentUser);
    with LoginForm do
      try
        if Configuration.EnableStoreLogin then
          edbxLogin.Text := Configuration.StoredLogin;
        if Configuration.EnableStorePassword then
          mePassword.Text := Configuration.StoredPassword;
        ShowModal;
      finally
        if ModalResult = mrOk then
        begin
          if Configuration.EnableStoreLogin then
            Configuration.StoredLogin := edbxLogin.Text;
          if Configuration.EnableStorePassword then
            Configuration.StoredPassword := mePassword.Text;
          try
            (* _Login; *)
          except
            on E: Exception do
            begin
              GenerateError(E.Message);
              ShowErrorDialog;
            end;
          end;
        end;
        Free;
      end;
  end;

  ProcedureFooter;
end;

procedure TMainForm._Logoff;
begin

end;

initialization

begin
  GlobalBusyCounter := 0;
  if not Assigned(GlobalConfiguration) then
  begin
    GlobalConfiguration := GetIConfiguration;
  end;
  if not Assigned(GlobalCurrentUser) then
  begin
    GlobalCurrentUser := GetIAccount;
  end;
end;

end.
