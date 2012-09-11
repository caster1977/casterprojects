unit OA5.uTMainForm;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.Forms,
  OA5.uTAccount,
  OA5.uTConfiguration,
  System.IniFiles,
  OA5.uIMeasureList,
  System.Classes,
  Vcl.ActnList,
  CastersPackage.uLogProvider,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  CastersPackage.uTLogForm;

type
  TMainForm = class(TLogForm)
    MainMenu: TMainMenu;
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
    actQuit: TAction;
    actAbout: TAction;
    actHelp: TAction;
    actConfiguration: TAction;
    actAccounts: TAction;
    actReport: TAction;
    actLogon: TAction;
    actLogout: TAction;
    actMultibuffer: TAction;
    actCreateMessage: TAction;
    actViewMessages: TAction;
    actViewMessage: TAction;
    actAddPhone: TAction;
    actEditPhone: TAction;
    ilSmall: TImageList;
    ilLarge: TImageList;
    ilStates: TImageList;
    StatusBar: TStatusBar;
    pbMain: TProgressBar;
    imState: TImage;
    ActionList: TActionList;
    procedure actQuitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actReportExecute(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure actMultibufferExecute(Sender: TObject);
    procedure actCreateMessageExecute(Sender: TObject);
    procedure actViewMessageExecute(Sender: TObject);
    procedure miToolBarClick(Sender: TObject);
    procedure actAddPhoneExecute(Sender: TObject);
    procedure actEditPhoneExecute(Sender: TObject);
    procedure actLogonExecute(Sender: TObject);
    procedure actLogoutExecute(Sender: TObject);
  strict private
    FMultiBuffer: IMeasureList;
    bFirstRun: Boolean;
    function GetMultiBuffer: IMeasureList;
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreShowModal(const aWindowName: string; var aOldBusyState: Integer);
    procedure PostShowModal(const aWindowName: string; var aOldBusyState: Integer);
    procedure PreFooter(const aHandle: HWND; const aError: Boolean; const aErrorMessage: string);
    procedure ApplicationOnHint(Sender: TObject);

    procedure Do_UpdateActions;
    procedure Do_About(const aButtonVisible: Boolean);
    procedure Do_Help;
    procedure Do_Configuration;
    procedure Do_Report;
    procedure Do_LoadConfiguration;
    procedure Do_ApplyConfiguration;
    procedure Do_SaveConfiguration;
    procedure Do_Logon;
    procedure Do_Logout;
  public
    Configuration: TConfiguration;
    CurrentUser: TAccount;
    iBusyCounter: Integer;
    procedure Inc_BusyState;
    procedure Dec_BusyState;
    procedure Refresh_BusyState;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
    property MultiBuffer: IMeasureList read GetMultiBuffer nodefault;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  CommCtrl,
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
  CastersPackage.uMysql;

type
  THackControl = class(TControl);

const
  ICON_BUSY = 0;
  ICON_READY = 1;

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
  RsAboutFormSuffix = '"О программе..."';
  RsConfigurationFormSuffix = 'настроек программы';
  RsReportFormSuffix = 'формирования статистических отчётов по работе пользователей';
  RsMultiBufferFormSuffix = 'мультибуфера';
  RsCreateMessageFormSuffix = 'создания нового сообщения';
  RsViewMessageFormSuffix = 'просмотра полученного сообщения';
  RsViewMessagesFormSuffix = 'просмотра полученных сообщений';
  RsAddPhoneFormSuffix = 'добавления номера телефона';
  RsEditPhoneFormSuffix = 'исправления номера телефона';
  RsLoginFormSuffix = 'ввода учётной записи';

procedure TMainForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; var aOldBusyState: Integer);
begin
  Log.SendDebug('Производится попытка отображения модального окна ' + aWindowName + '.');
  with MainForm do
  begin
    aOldBusyState := iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
    iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
    Refresh_BusyState; // обновление состояния индикатора
  end;
end;

procedure TMainForm.PostShowModal(const aWindowName: string; var aOldBusyState: Integer);
begin
  with MainForm do
  begin
    iBusyCounter := aOldBusyState; // возвращение старого значения счётчика
    Refresh_BusyState; // обновление состояния индикатора
  end;
  Log.SendDebug('Окно ' + aWindowName + ' скрыто.');
end;

procedure TMainForm.PreFooter(const aHandle: HWND; const aError: Boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position := MainForm.pbMain.Min;
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
var
  iOldBusyCounter: Integer;
begin
  Log.SendError(aErrorMessage);

  iOldBusyCounter := iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState; // обновление состояния индикатора

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(MainForm.Caption + ' - Ошибка!'),
    MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter := iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState; // обновление состояния индикатора
  Application.ProcessMessages;
end;

procedure TMainForm.Refresh_BusyState;
begin
  Log.SendDebug('Установлен режим "' + Routines.GetConditionalString(iBusyCounter > 0, 'Занято', 'Готово') + '".');
  with MainForm do
  begin
    if iBusyCounter > 0 then
      ilStates.GetIcon(ICON_BUSY, imState.Picture.Icon)
    else
      ilStates.GetIcon(ICON_READY, imState.Picture.Icon);
    if Configuration.ShowStatusbar then
      StatusBar.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text := Routines.GetConditionalString(iBusyCounter > 0,
        'Пожалуйста, подождите...', 'Готово');
  end;
  Application.ProcessMessages;
end;

procedure TMainForm.Inc_BusyState;
begin
  with MainForm do
  begin
    iBusyCounter := iBusyCounter + 1;
    if iBusyCounter < 0 then
      iBusyCounter := 0;
    Refresh_BusyState;
  end;
end;

procedure TMainForm.miStatusBarClick(Sender: TObject);
begin
  ProcedureHeader('Процедура включения/отключения отображения панели статуса',
    '{3550143C-FACD-490F-A327-4E1496CDEC5E}');

  StatusBar.Visible := miStatusBar.Checked;
  Configuration.ShowStatusbar := StatusBar.Visible;
  Log.SendInfo('Панель статуса ' + Routines.GetConditionalString(StatusBar.Visible, 'в', 'от') + 'ключена.');

  ProcedureFooter;
end;

procedure TMainForm.miToolBarClick(Sender: TObject);
begin
  ProcedureHeader('Процедура включения/отключения отображения панели кнопок', '{786D709B-0201-41AE-923C-BC307AE26A6B}');

  // StatusBar1.Visible:=miStatusbar.Checked;
  // Configuration.ShowToolbar:=StatusBar1.Visible;
  // Log.SendInfo('Панель кнопок '+Routines.GetConditionalString(StatusBar1.Visible, 'в', 'от')+'ключена.');

  ProcedureFooter;
end;

procedure TMainForm.Dec_BusyState;
begin
  with MainForm do
  begin
    iBusyCounter := iBusyCounter - 1;
    if iBusyCounter < 0 then
      iBusyCounter := 0;
    Refresh_BusyState;
  end;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actAbout.Caption + '"', '{90CC0AAB-ED7C-46FF-97FF-4431F18EBA1A}');
  Do_About(True);
  ProcedureFooter;
end;

procedure TMainForm.Do_About(const aButtonVisible: Boolean);
var
  AboutForm: TAboutForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsAboutFormSuffix, '{754C2801-ED59-4595-AC3E-20DBF98F6779}');

  AboutForm := TAboutForm.Create(Self, aButtonVisible, Addr(MainForm.iBusyCounter), MainForm.Inc_BusyState,
    MainForm.Dec_BusyState, MainForm.Refresh_BusyState, pbMain);
  with AboutForm do
    try
      PreShowModal(RsAboutFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsAboutFormSuffix, iBusy);
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actHelp.Caption + '"', '{D066E67D-C195-440D-94C2-6757C427DCF6}');
  Do_Help;
  ProcedureFooter;
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actQuit.Caption + '"', '{5DB14721-5FC4-4B42-B0DB-4E7C323A2AA2}');
  Close;
  ProcedureFooter;
end;

procedure TMainForm.actReportExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actReport.Caption + '"',
    '{90957E86-35D1-4C1B-9C1F-4C99CE5D2B56}');
  Do_Report;
  ProcedureFooter;
end;

procedure TMainForm.Do_Help;
var
  bError: Boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура открытия справочного файла программы', '{457E450C-4870-4B17-9594-EB7F91B4578E}');
  bError := False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Configuration);
  FreeAndNil(CurrentUser);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  PanelRect: TRect;

  procedure BindMainProgressBarToStatusBar;
  begin
    THackControl(pbMain).SetParent(StatusBar);
    SendMessage(StatusBar.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
    pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right - PanelRect.Left,
      PanelRect.Bottom - PanelRect.Top - 1);
  end;

  procedure BindStateImageToStatusBar;
  begin
    THackControl(imState).SetParent(StatusBar);
    SendMessage(StatusBar.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
    imState.SetBounds(PanelRect.Left + 2, PanelRect.Top + 1, PanelRect.Right - PanelRect.Left - 4,
      PanelRect.Bottom - PanelRect.Top - 4);
  end;

begin
  // переменная правдива с момента запуска программы до момента отображения главного окна
  bFirstRun := True;
  CurrentUser := TAccount.Create; // создание и инициализщация объекта текущего пользователя
  Configuration := TConfiguration.Create; // создание и инициализщация объекта конфигурации
  (* Configuration.RNE4Server.LogProvider := MainForm.Log;
    Configuration.MessagesServer.LogProvider := MainForm.Log; *)
  BindMainProgressBarToStatusBar; // привязка прогрессбара к позиции на строке статуса
  BindStateImageToStatusBar; // привязка иконки готовности к позиции на строке статуса
  Application.OnHint := ApplicationOnHint;
  (* Do_LoadConfiguration; // загрузка настроек из файла *)
  Do_ApplyConfiguration; // применение настроек к интерфейсу

  { TODO : добавить отображение окна "о программе" }

  Do_UpdateActions;
end;

procedure TMainForm.ApplicationOnHint(Sender: TObject);
begin
  if Configuration.ShowStatusbar then
    StatusBar.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text := GetLongHint(Application.Hint);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{9FD296B5-1A3D-4E90-85CA-492271D2B6A9}');

  if bFirstRun then
  begin
    iBusyCounter := 0;
    bFirstRun := False;
    if Configuration.ShowSplashAtStart then
      Do_About(False);
    // if Configuration.AutoLogon then
    // Do_Logon;
  end;
  Refresh_BusyState;

  ProcedureFooter;
end;

function TMainForm.GetMultiBuffer: IMeasureList;
begin
  if not Assigned(FMultiBuffer) then
  begin
    FMultiBuffer := TMeasureList.Create;
  end;
  Result := FMultiBuffer;
end;

procedure TMainForm.Do_UpdateActions;
var
  b: Boolean;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{03351462-40CF-47ED-AE96-3F9E0D9EA148}');

  b := CurrentUser.Logged;

  actLogon.Enabled := not b;
  // actLogon.Visible:=not b;
  Log.SendDebug('Действие "' + actLogon.Caption + '" ' + Routines.GetConditionalString(actLogon.Enabled, 'включено',
    'отключено') + '.');
  actLogout.Enabled := b;
  // actLogout.Visible:=b;
  Log.SendDebug('Действие "' + actLogout.Caption + '" ' + Routines.GetConditionalString(actLogout.Enabled, 'включено',
    'отключено') + '.');
  b := b and CurrentUser.Privilegies.Accounting;
  actAccounts.Enabled := b;
  // actAccounts.Visible:=b;

  Application.ProcessMessages;

  ProcedureFooter;
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actConfiguration.Caption + '"',
    '{024B2718-8D00-49A1-9E1E-C02CB2696CE0}');
  Do_Configuration;
  ProcedureFooter;
end;

procedure TMainForm.Do_Configuration;
var
  ConfigurationForm: TConfigurationForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsConfigurationFormSuffix, '{886B460D-4C73-46BE-829E-E4421B7C4378}');

  ConfigurationForm := TConfigurationForm.Create(Self, Configuration.ConfigurationFormPosition);
  with ConfigurationForm do
    try
      PreShowModal(RsConfigurationFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsConfigurationFormSuffix, iBusy);
      if ModalResult = mrOk then
        Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ProcedureHeader('Процедура-обработчик события закрытия окна', '{A430AB2D-F069-4FFF-A5CA-883D7B3E1985}');

  // применение текущих настроек главного окна к конфигурации
  Configuration.MainFormLeft := Left;
  Configuration.MainFormTop := Top;
  Configuration.MainFormWidth := Width;
  Configuration.MainFormHeight := Height;
  Configuration.MainFormPositionByCenter := False;
  Configuration.FullScreenAtLaunch := WindowState = wsMaximized;

  // запись конфигурации
  Do_SaveConfiguration;

  Configuration.RNE4Server.Connected := False;
  Configuration.MessagesServer.Connected := False;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TMainForm.Do_LoadConfiguration;
var
  bError: Boolean;
  sErrorMessage: string;
begin
  if not bFirstRun then
  begin
    ProcedureHeader('Процедура чтения настроек программы из файла', '{650B9486-2600-4038-B711-3281F7252336}');
    bError := False;
    Log.SendInfo('Производится попытка чтения настроек программы из файла...');
  end;
  try
    Screen.Cursor := crHourGlass;
    try
      Configuration.Load;
      if not bFirstRun then
        Log.SendInfo('Чтение настроек программы из файла прошло успешно.');
    finally
      Screen.Cursor := crDefault;
    end;
  except
    if not bFirstRun then
      Routines.GenerateError('Произошла ошибка при попытке чтения настроек программы из файла!', sErrorMessage, bError);
    Application.HandleException(Self);
  end;
  if not bFirstRun then
  begin
    PreFooter(Handle, bError, sErrorMessage);
    ProcedureFooter;
  end;
end;

procedure TMainForm.Do_SaveConfiguration;
var
  bError: Boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура записи настроек программы в файл', '{2BD55804-9631-45C8-9484-42F4DDC45C29}');
  bError := False;

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
      Routines.GenerateError(E.Message, sErrorMessage, bError);
      if MessageBox(Handle, PWideChar('Вы желаете повторить попытку записи настроек программы в файл?'),
        PWideChar(MainForm.Caption + ' - Предупреждение'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1) = IDOK then
        try
          Screen.Cursor := crHourGlass;
          try
            Configuration.Save;
            Log.SendInfo('Запись настроек программы в файл прошла успешно.');
          except
            on E: EIniFileException do
              Routines.GenerateError(E.Message, sErrorMessage, bError);
          end;
        finally
          Screen.Cursor := crDefault;
        end;
    end;
    else
      Application.HandleException(Self);
  end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TMainForm.Do_ApplyConfiguration;
begin
  ProcedureHeader('Процедура применения изменений к интерфейсу программы', '{67A9E9BC-62AC-4848-B20D-C8B5095DEB6C}');

  // установка параметров протоколирования в соответствии с настройками программы
  Log.UserName := CurrentUser.Login;
  Log.AllowedTypes := Configuration.KeepLogTypes;
  Log.Enabled := Configuration.EnableLog;

  // установка видимости панели статуса в соответствии с настройками программы
  miStatusBar.Checked := Configuration.ShowStatusbar;
  StatusBar.Visible := Configuration.ShowStatusbar;

  // установка позиции и размеров главного окна в соответсвии с параметрами конфигурации
  WindowState := wsNormal;
  Position := poDesigned;
  Left := Configuration.MainFormLeft;
  Top := Configuration.MainFormTop;
  Width := Configuration.MainFormWidth;
  Height := Configuration.MainFormHeight;
  if Configuration.FullScreenAtLaunch then
    WindowState := wsMaximized
  else
    if Configuration.MainFormPositionByCenter then
    begin
      Position := poScreenCenter;
      Configuration.MainFormPositionByCenter := False;
    end;

  ProcedureFooter;
end;

procedure TMainForm.Do_Report;
var
  ReportForm: TReportForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsReportFormSuffix, '{0B2728D4-5577-4D1E-9F51-3F40A61BA774}');

  ReportForm := TReportForm.Create(Self, Configuration.ReportFormPosition);
  with ReportForm do
    try
      PreShowModal(RsReportFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsReportFormSuffix, iBusy);
      { TODO : дописать! }
      // if ModalResult=mrOk then
      // Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actMultibufferExecute(Sender: TObject);
var
  MultiBufferForm: TMultiBufferForm;
  iBusy: Integer;
  i: Integer;
  aListItem: TListItem;
begin
  ProcedureHeader('Процедура отображения окна ' + RsMultiBufferFormSuffix, '{0B2728D4-5577-4D1E-9F51-3F40A61BA774}');

  MultiBufferForm := TMultiBufferForm.Create(Self, Configuration.MultibufferFormPosition);
  with MultiBufferForm do
    try
      for i := 0 to MultiBuffer.Count - 1 do
      begin
        aListItem := lvBuffer.Items.Add;
        aListItem.Caption := IntToStr(i);
        aListItem.SubItems.Add(MultiBuffer[i].Type_ + '|' + MultiBuffer[i].Name + '|' + MultiBuffer[i].Author + '|' +
          MultiBuffer[i].Producer + '|' + MultiBuffer[i].Performer + '|' + MultiBuffer[i].Organizer + '|' +
          MultiBuffer[i].TicketPrice + '|' + string(MultiBuffer[i].OtherInfoPlane));
      end;
      PreShowModal(RsMultiBufferFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsMultiBufferFormSuffix, iBusy);
      { TODO : дописать! }
      // if ModalResult=mrOk then
      // Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actViewMessageExecute(Sender: TObject);
var
  ViewMessageForm: TViewMessageForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsViewMessageFormSuffix, '{347244A6-22DF-44DF-873B-2B55FC5112B9}');

  ViewMessageForm := TViewMessageForm.Create(Self, Configuration.ViewMessageFormPosition);
  with ViewMessageForm do
    try
      PreShowModal(RsViewMessageFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsViewMessageFormSuffix, iBusy);
      { TODO : дописать! }
      // if ModalResult=mrOk then
      // Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actCreateMessageExecute(Sender: TObject);
var
  CreateMessageForm: TCreateMessageForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsCreateMessageFormSuffix, '{F356F5DA-5FF7-4F78-A80E-1C563B96AF6D}');

  CreateMessageForm := TCreateMessageForm.Create(Self, Configuration.CreateMessageFormPosition);
  with CreateMessageForm do
    try
      PreShowModal(RsCreateMessageFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsCreateMessageFormSuffix, iBusy);
      { TODO : дописать! }
      // if ModalResult=mrOk then
      // Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actAddPhoneExecute(Sender: TObject);
var
  AddPhoneForm: TAddEditPhoneForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsAddPhoneFormSuffix, '{83D61BCA-0CB5-4542-9D0A-9137AE9C733C}');

  AddPhoneForm := TAddEditPhoneForm.Create(Self, Configuration.AddEditPhoneFormPosition);
  with AddPhoneForm do
    try
      Caption := 'Добавление номера телефона';
      PreShowModal(RsAddPhoneFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsAddPhoneFormSuffix, iBusy);
      { TODO : дописать! }
      // if ModalResult=mrOk then
      // Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actEditPhoneExecute(Sender: TObject);
var
  EditPhoneForm: TAddEditPhoneForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + RsEditPhoneFormSuffix, '{36EA36F5-EDE2-4A3A-A7DE-BB9790D3F50F}');

  EditPhoneForm := TAddEditPhoneForm.Create(Self, Configuration.AddEditPhoneFormPosition);
  with EditPhoneForm do
    try
      Caption := 'Исправление номера телефона';
      PreShowModal(RsEditPhoneFormSuffix, iBusy);
      ShowModal;
    finally
      PostShowModal(RsEditPhoneFormSuffix, iBusy);
      { TODO : дописать! }
      // if ModalResult=mrOk then
      // Do_ApplyConfiguration;
      Free;
    end;

  ProcedureFooter;
end;

procedure TMainForm.actLogonExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actLogon.Caption + '"', '{25B404A0-78C1-47D6-AFCE-33168CAF333A}');
  Do_Logon;
  ProcedureFooter;
end;

procedure TMainForm.actLogoutExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actLogout.Caption + '"',
    '{3A1F49AC-A9CF-4FC7-90AA-A6D2E5AE1619}');
  Do_Logout;
  ProcedureFooter;
end;

procedure TMainForm.Do_Logon;
// resourcestring
// TEXT_AOUTOLOGON_ERROR='Выполнить автоматический ыход не удалось - проверьте правильность сохраненных логина и пароля пользователя!';
var
  LoginForm: TLoginForm;
  iBusy: Integer;
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
  ProcedureHeader('Процедура отображения окна ' + RsLoginFormSuffix, '{68883F7C-57C2-4E56-B2FB-AEDCB1EB25DC}');

  bPassLoginForm := Configuration.AutoLogon and Configuration.StoreLogin and Configuration.StorePassword and
    (Configuration.Login <> '');

  if bPassLoginForm then
    try
      (* _Login; *)
    except
      on E: EMySQLException do
      begin
        MainForm.ShowErrorBox(MainForm.Handle, E.Message);
        bPassLoginForm := False;
      end;
      // else
      // raise Exception.Create(TEXT_AOUTOLOGON_ERROR);
    end;

  if not bPassLoginForm then
  begin
    LoginForm := TLoginForm.Create(Self, Configuration.LoginFormPosition);
    with LoginForm do
      try
        if Configuration.StoreLogin then
          edbxLogin.Text := Configuration.Login;
        if Configuration.StorePassword then
          mePassword.Text := Configuration.Password;
        PreShowModal(RsLoginFormSuffix, iBusy);
        ShowModal;
      finally
        PostShowModal(RsLoginFormSuffix, iBusy);
        if ModalResult = mrOk then
        begin
          if Configuration.StoreLogin then
            Configuration.Login := edbxLogin.Text;
          if Configuration.StorePassword then
            Configuration.Password := mePassword.Text;
          try
            (* _Login; *)
          except
            on E: Exception do
              MainForm.ShowErrorBox(MainForm.Handle, E.Message);
          end;
        end;
        Free;
      end;
  end;

  ProcedureFooter;
end;

procedure TMainForm.Do_Logout;
begin

end;

end.
