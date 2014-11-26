unit DBUServerManager.uTMainForm;

interface

uses
  DBUServerManager.uTConfiguration,
  Winapi.Messages,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  AboutPackage.uTAboutWindow,
  Vcl.Menus,
  Vcl.ExtCtrls,
  CastersPackage.Actions.Classes,
  Vcl.ActnList,
  System.Actions,
  Vcl.ActnMan,
  Vcl.ActnCtrls,
  Vcl.StdActns,
  System.Classes,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ImgList,
  Vcl.ToolWin,
  AboutPackage.uTGSFileVersionInfo,
  IdContext,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdTCPServer,
  IdCmdTCPServer,
  IdCommandHandlers,
  IdTCPConnection,
  IdTCPClient,
  IdCmdTCPClient,
  Web.Win.Sockets,
  CastersPackage.uTStateImage,
  Vcl.Graphics,
  CastersPackage.uTStateProgressBar,
  CastersPackage.uTStatusBarEx,
  CastersPackage.uTApplicationOnHint,
  DBUShared.uIDBUServerLogRecords,
  System.SyncObjs;

type
  TMainForm = class(TForm)
    AboutWindow: TAboutWindow;
    ilActions: TImageList;
    actmgrMain: TActionManager;
    actHelpMenuGroup: THelpMenuGroupAction;
    actFileMenuGroup: TFileMenuGroupAction;
    actHelpContents: THelpContentsAction;
    actAbout: TAction;
    actQuit: TQuitAction;
    actCreateProfile: TAction;
    actLoadProfile: TAction;
    actRecentProfiles: TAction;
    actSaveProfile: TAction;
    actSaveProfileAs: TAction;
    actConfiguration: TAction_Configuration;
    actRecentProfilesProperties: TAction;
    actProfileProperties: TAction;
    actViewMenuGroupAction: TViewMenuGroupAction;
    actStatusBar: TAction;
    actToolBar: TAction;
    TrayIcon: TTrayIcon;
    mmMain: TMainMenu;
    mniFileMenuGroup: TMenuItem;
    mniConfiguration: TMenuItem;
    N28: TMenuItem;
    mniQuit: TMenuItem;
    mniViewMenuGroupAction: TMenuItem;
    mniToolBar: TMenuItem;
    mniStatusBar: TMenuItem;
    mniHelpMenuGroup: TMenuItem;
    mniHelpContents: TMenuItem;
    N18: TMenuItem;
    mniAbout: TMenuItem;
    acttbToolBar: TActionToolBar;
    actRestore: TAction;
    pmTray: TPopupMenu;
    mniTrayRestore: TMenuItem;
    mniN1: TMenuItem;
    mniTrayAbout: TMenuItem;
    mniN3: TMenuItem;
    mniTrayQuit: TMenuItem;
    lvLog: TListView;
    gsfviMain: TGSFileVersionInfo;
    IdTCPClient: TIdTCPClient;
    actConnect: TAction;
    actDisconnect: TAction;
    actTestConnection: TAction;
    actActionMenuGroupAction: TActionMenuGroupAction;
    ilStates: TImageList;
    StatusBar: TStatusBar;
    mniActionMenuGroupAction: TMenuItem;
    mniDisconnect: TMenuItem;
    mniConnect: TMenuItem;
    ProgressBar: TStateProgressBar;
    StateImage: TStateImage;
    aplctnhnt1: TApplicationOnHint;
    mniTestConnection: TMenuItem;
    actReserveNewDBUNUmber: TAction;
    mniReserveNewDBUNUmber: TMenuItem;
    actGetSQLActionList: TAction;
    mniGetSQLActionList: TMenuItem;
    actGetSQLSubjectList: TAction;
    mniGetSQLSubjectList: TMenuItem;
    actGetLogDataByDBType: TAction;
    mniGetLogDataByDBType: TMenuItem;
    actGetDBTypeList: TAction;
    mniGetDBTypeList: TMenuItem;
    actGetDBUStateList: TAction;
    mniGetDBUStateList: TMenuItem;
    actAddDBType: TAction;
    mniAddDBType: TMenuItem;
    actGetLogData: TAction;
    mniGetLogData: TMenuItem;
    actRefresh: TAction;
    mniN4: TMenuItem;
    mniRefresh: TMenuItem;
    actActionTesting: TAction;
    mniActionTesting: TMenuItem;
    procedure actAboutExecute(Sender: TObject);
    procedure actQuitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure actRestoreExecute(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure actRestoreUpdate(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure IdTCPClientDisconnected(Sender: TObject);
    procedure IdTCPClientConnected(Sender: TObject);
    procedure actTestConnectionExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure actConnectUpdate(Sender: TObject);
    procedure actDisconnectUpdate(Sender: TObject);
    procedure actTestConnectionUpdate(Sender: TObject);
    procedure actReserveNewDBUNUmberUpdate(Sender: TObject);
    procedure actReserveNewDBUNUmberExecute(Sender: TObject);
    procedure actGetSQLActionListExecute(Sender: TObject);
    procedure actGetSQLActionListUpdate(Sender: TObject);
    procedure actGetSQLSubjectListUpdate(Sender: TObject);
    procedure actGetSQLSubjectListExecute(Sender: TObject);
    procedure actGetLogDataByDBTypeUpdate(Sender: TObject);
    procedure actGetLogDataByDBTypeExecute(Sender: TObject);
    procedure actGetDBTypeListExecute(Sender: TObject);
    procedure actGetDBTypeListUpdate(Sender: TObject);
    procedure actGetDBUStateListUpdate(Sender: TObject);
    procedure actGetDBUStateListExecute(Sender: TObject);
    procedure actAddDBTypeUpdate(Sender: TObject);
    procedure actAddDBTypeExecute(Sender: TObject);
    procedure actGetLogDataUpdate(Sender: TObject);
    procedure actGetLogDataExecute(Sender: TObject);
    procedure actRefreshUpdate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actActionTestingExecute(Sender: TObject);

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  strict private
    FWindowMessage: Cardinal;
    procedure RegisterWindowMessages;
    procedure ApplyConfiguration;
    procedure WMGetSysCommand(var AMessage: TMessage); message WM_SYSCOMMAND;

    // strict private
    // FSvcHandle: THandle;
    // procedure ServiceStart;
    // procedure ServiceStop;
    //
    // strict private
    // FLock: TCriticalSection;
    // procedure Lock;
    // procedure UnLock;
    //
  protected
    procedure WndProc(var AMessage: TMessage); override;

  public
    destructor Destroy; override;

  strict private
    FServerLog: IDBUServerLogRecords;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Winapi.WinSvc,
  System.SysUtils,
  Winapi.CommCtrl,
  Winapi.Windows,
  Vcl.Dialogs,
  IdGlobal,
  CastersPackage.uTHackControl,
  DBUServerManager.uConsts,
  DBUServerManager.Configuration.uTInterface,
  DBUServerManager.uTConfigurationForm,
  DBUShared.uConsts,
  DBUShared.uTDBUServerLogRecords,
  DBUShared.uIDBUServerLogRecord;

resourcestring
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsWarningCaption = '%s - Предупреждение';
  RsErrorCaption = '%s - Ошибка';
  RsErrorRegisterWindowMessage = 'Не удалось выполнить операцию регистрации оконного сообщения!';

type
  THackImageList = class(TImageList);

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutWindow.Show;
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
var
  form: TForm;
begin
  form := TConfigurationForm.Create(Self, Configuration);
  if not Assigned(form) then
  begin
    Exit;
  end;

  try
    if not form.ShowModal = mrOk then
    begin
      Exit;
    end;
    ApplyConfiguration;
  finally
    form.Free;
  end;
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actStatusBar.Checked;

  if StatusBar.Visible <> b then
  begin
    StatusBar.Visible := b;
  end;

  if Configuration.Section<TInterface>.EnableStatusbar <> b then
  begin
    Configuration.Section<TInterface>.EnableStatusbar := b;
  end;

  if actStatusBar.Checked then
  begin
    IdTCPClient.Connect;
  end
  else
  begin
    IdTCPClient.IOHandler.InputBuffer.Clear;
    IdTCPClient.Disconnect;
  end;
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actToolBar.Checked;

  if acttbToolBar.Visible <> b then
  begin
    acttbToolBar.Visible := b;
  end;

  if Configuration.Section<TInterface>.EnableToolbar <> b then
  begin
    Configuration.Section<TInterface>.EnableToolbar := b;
  end;
end;

procedure TMainForm.ApplyConfiguration;
var
  b: Boolean;
begin
  b := Configuration.Section<TInterface>.EnableStatusbar;
  actStatusBar.Checked := b;
  StatusBar.Visible := b;

  b := Configuration.Section<TInterface>.EnableToolbar;
  actToolBar.Checked := b;
  acttbToolBar.Visible := b;

  TrayIcon.Visible := (not Visible) or Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon;
end;

destructor TMainForm.Destroy;
begin
  if IdTCPClient.Connected then
  begin
    IdTCPClient.IOHandler.InputBuffer.Clear;
    IdTCPClient.Disconnect;
  end;

  if Assigned(Configuration) then
  begin
    Configuration.Free;
  end;

  // FLock.Free;

  inherited;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  if Configuration.Section<TInterface>.EnableQuitConfirmation then
  begin
    CanClose := MessageBox(Handle, PWideChar(RsExitConfirmationMessage),
      PWideChar(Format(RsExitConfirmationCaption, [APPLICATION_NAME])), MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDOK;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  b: Boolean;

begin
  // FLock := TCriticalSection.Create;
  gsfviMain.Filename := Application.ExeName;
  Caption := gsfviMain.InternalName;

  RegisterWindowMessages;
  ApplyConfiguration;

  if Configuration.Section<TInterface>.EnableSplashAtStart then
  begin
    AboutWindow.Show(True);
  end;

  b := Configuration.Section<TInterface>.EnableStartAtTray;
  Application.ShowMainForm := not b;
  Visible := not b;

{$IFDEF DEBUG}
  actActionTesting.Visible := True;
{$ENDIF}
end;

function TMainForm.GetConfiguration: TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create;
  end;
  Result := FConfiguration;
end;

procedure TMainForm.RegisterWindowMessages;
begin
  FWindowMessage := RegisterWindowMessage(PWideChar(APPLICATION_NAME));
  if FWindowMessage = 0 then
  begin
    MessageBox(Handle, PWideChar(RsErrorRegisterWindowMessage), PWideChar(Format(RsErrorCaption, [Application.Title])),
      MESSAGE_TYPE_ERROR);
  end;
end;

{ procedure TMainForm.ServiceStart;
  var
  Args: PChar;
  ServiceStatus: TServiceStatus;
  begin
  Lock;
  try
  try
  StartService(FSvcHandle, 0, Args);
  QueryServiceStatus(FSvcHandle, ServiceStatus);
  if ServiceStatus.dwCurrentState = SERVICE_RUNNING then
  begin
  actConnect.Execute;
  end;
  except
  on E: Exception do
  ShowMessage(E.Message);
  end;
  finally
  UnLock;
  end;
  end;

  procedure TMainForm.ServiceStop;
  var
  ServiceStatus: TServiceStatus;
  begin
  Lock;
  try
  actDisconnect.Execute;
  try
  ControlService(FSvcHandle, SERVICE_CONTROL_STOP, ServiceStatus);
  except
  on E: Exception do
  ShowMessage(E.Message);
  end;
  finally
  UnLock;
  end;
  end; }

{ procedure TMainForm.UnLock;
  begin
  FLock.Leave;
  end; }

procedure TMainForm.TrayIconClick(Sender: TObject);
begin
  if Visible then
  begin
    SetForegroundWindow(Handle);
  end;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  AboutWindow.Hide;
  TrayIcon.Visible := Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon;
  Visible := True;
  SetForegroundWindow(Handle);
  Application.Restore;
end;

procedure TMainForm.WMGetSysCommand(var AMessage: TMessage);
begin
  if AMessage.WParam = SC_MINIMIZE then
  begin
    AboutWindow.Hide;
    Visible := False;
    TrayIcon.Visible := True;
  end
  else
  begin
    inherited;
  end;
end;

procedure TMainForm.WndProc(var AMessage: TMessage);
var
  fwi: FLASHWINFO;
begin
  if AMessage.Msg = FWindowMessage then
  begin
    actRestore.Execute;

    fwi.cbSize := SizeOf(FLASHWINFO);
    fwi.HWND := Handle;
    fwi.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
    fwi.uCount := 0;
    fwi.dwTimeout := 0;
    FlashWindowEx(fwi);
  end
  else
  begin
    inherited;
  end;
end;

procedure TMainForm.actRefreshUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actReserveNewDBUNUmberExecute(Sender: TObject);
var
  db_count: SmallInt;
  new_number: SmallInt;
begin
  IdTCPClient.SendCmd('TCP_RESERVE_NEW_DBUPDATE_NUMBER');
  IdTCPClient.IOHandler.WriteLn('db_type');
  db_count := 3;
  IdTCPClient.IOHandler.Write(db_count);
  IdTCPClient.IOHandler.WriteLn('caster');
  new_number := IdTCPClient.IOHandler.ReadSmallInt;
  ShowMessage(Format('Номер: %d', [new_number]));
end;

procedure TMainForm.actReserveNewDBUNUmberUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actRestoreExecute(Sender: TObject);
begin
  AboutWindow.Hide;
  Visible := True;
  TrayIcon.Visible := Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon;
  SetForegroundWindow(Handle);
end;

procedure TMainForm.actRestoreUpdate(Sender: TObject);
begin
  actRestore.Enabled := not Visible;
end;

procedure TMainForm.IdTCPClientConnected(Sender: TObject);
begin
  // ShowMessage('Connected');
end;

procedure TMainForm.IdTCPClientDisconnected(Sender: TObject);
begin
  // ShowMessage('Disconnected');
end;

{ procedure TMainForm.Lock;
  begin
  FLock.Enter;
  end; }

procedure TMainForm.actConnectExecute(Sender: TObject);
begin
  try
    IdTCPClient.Connect;
    if IdTCPClient.Connected then
    begin
      StateImage.State := True;
      //ShowMessage(IdTCPClient.IOHandler.ReadLn);
      actRefresh.Execute;
      lvLog.Visible := True;
    end;
  except
    ShowMessage('Не удалось подключиться к серверу');
  end;
end;

procedure TMainForm.actConnectUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not IdTCPClient.Connected;
end;

procedure TMainForm.actDisconnectExecute(Sender: TObject);
begin
  lvLog.Visible := False;
  lvLog.Items.BeginUpdate;
  try
    lvLog.Clear;
    FServerLog := nil;
  finally
    lvLog.Items.EndUpdate;
  end;
  IdTCPClient.IOHandler.InputBuffer.Clear;
  IdTCPClient.Disconnect;
  StateImage.State := False;
end;

procedure TMainForm.actDisconnectUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetDBTypeListExecute(Sender: TObject);
var
  type_count: Integer;
  sl: TStringList;
  i: Integer;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_DATABASE_TYPE_ITEMS');
  type_count := IdTCPClient.IOHandler.ReadLongInt;
  sl := TStringList.Create;
  try
    for i := 0 to Pred(type_count) do
    begin
      sl.AddObject(IdTCPClient.IOHandler.ReadLn, TObject(IdTCPClient.IOHandler.ReadLongInt));
    end;
    ShowMessage(Format('Список типов БД:' + sLineBreak + sLineBreak + '%s', [sl.Text]));
  finally
    sl.Free;
  end;
end;

procedure TMainForm.actGetDBTypeListUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetLogDataByDBTypeUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetLogDataUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetSQLActionListExecute(Sender: TObject);
var
  action_count: Integer;
  sl: TStringList;
  i: Integer;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_SQL_ACTION_ITEMS');
  action_count := IdTCPClient.IOHandler.ReadLongInt;
  sl := TStringList.Create;
  try
    for i := 0 to Pred(action_count) do
    begin
      sl.Append(IdTCPClient.IOHandler.ReadLn);
    end;
    ShowMessage(Format('Список действий:' + sLineBreak + sLineBreak + '%s', [sl.Text]));
  finally
    sl.Free;
  end;
end;

procedure TMainForm.actGetSQLActionListUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetSQLSubjectListExecute(Sender: TObject);
var
  action_count: Integer;
  sl: TStringList;
  i: Integer;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_SQL_SUBJ_ITEMS');
  action_count := IdTCPClient.IOHandler.ReadLongInt;
  sl := TStringList.Create;
  try
    for i := 0 to Pred(action_count) do
    begin
      sl.Append(IdTCPClient.IOHandler.ReadLn);
    end;
    ShowMessage(Format('Список объектов:' + sLineBreak + sLineBreak + '%s', [sl.Text]));
  finally
    sl.Free;
  end;
end;

procedure TMainForm.actGetSQLSubjectListUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actTestConnectionExecute(Sender: TObject);
var
  s: string;
begin
  try
    IdTCPClient.SendCmd('TCP_CONNECTION_TEST');
    s := IdTCPClient.IOHandler.ReadLn;
    if s = 'CONNECTION_TEST_OK' then
    begin
      s := 'Тестирование подключения выполнено успешно.'
    end;
    ShowMessage(s);
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TMainForm.actTestConnectionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actActionTestingExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.actAddDBTypeExecute(Sender: TObject);
var
  //index: SmallInt;
  db_type: string;
  s: string;
begin
  IdTCPClient.SendCmd('TCP_ADD_NEW_DATABASE_TYPE');
  db_type := 'db_type';
  IdTCPClient.IOHandler.WriteLn(db_type);
  //index :=
  IdTCPClient.IOHandler.ReadSmallInt;
  s := IdTCPClient.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
  ShowMessage(s);
end;

procedure TMainForm.actAddDBTypeUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetDBUStateListExecute(Sender: TObject);
var
  sl: TStringList;
  st: TStream;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_STATES_ITEMS');
  sl := TStringList.Create;
  try
    IdTCPClient.IOHandler.ReadStrings(sl, -1, IndyTextEncoding_OSDefault);
    st := TMemoryStream.Create;
    try
      IdTCPClient.IOHandler.ReadStream(st);
      st.Position := 0;
      THackImageList(ilActions).ReadData(st);
    finally
      st.Free;
    end;
    ShowMessage(sl.Text);
  finally
    sl.Free;
  end;
end;

procedure TMainForm.actGetDBUStateListUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetLogDataByDBTypeExecute(Sender: TObject);
var
  log_count: Integer;
  sl: TStringList;
  i: Integer;
  db_type: string;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_NEW_NUMBER_LOG_GRID');
  db_type := 'db_type';
  IdTCPClient.IOHandler.WriteLn(db_type);
  log_count := IdTCPClient.IOHandler.ReadLongInt;
  sl := TStringList.Create;
  try
    for i := 0 to Pred(log_count) do
    begin
      sl.Append(IdTCPClient.IOHandler.ReadLn);
    end;
    ShowMessage(Format('Лог работы сервера:' + sLineBreak + sLineBreak + '%s', [sl.Text]));
  finally
    sl.Free;
  end;
end;

procedure TMainForm.actGetLogDataExecute(Sender: TObject);
var
  log_count: SmallInt;
  sl: TStringList;
  i: Integer;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_NEW_NUMBER_LOG');
  log_count := 20;
  IdTCPClient.IOHandler.Write(log_count);
  log_count := IdTCPClient.IOHandler.ReadSmallInt;
  sl := TStringList.Create;
  try
    for i := 0 to Pred(log_count) do
    begin
      sl.Append(IdTCPClient.IOHandler.ReadLn);
    end;
    ShowMessage(Format('Лог работы сервера:' + sLineBreak + sLineBreak + '%s', [sl.Text]));
  finally
    sl.Free;
  end;
end;

procedure TMainForm.actRefreshExecute(Sender: TObject);
var
  line_count: Integer;
  sl: TStrings;
  i: Integer;
  li: TListItem;
  rec: IDBUServerLogRecord;
begin
  IdTCPClient.SendCmd('TCP_GET_DBU_NEW_NUMBER_LOG_GRID');

  IdTCPClient.IOHandler.WriteLn;

  line_count := IdTCPClient.IOHandler.ReadLongInt;

  sl := TStringList.Create;
  try
    for i := 0 to Pred(line_count) do
    begin
      sl.Append(IdTCPClient.IOHandler.ReadLn);
    end;

    lvLog.Items.BeginUpdate;
    try
      lvLog.Clear;
      FServerLog := GetIDBUServerLogRecords(sl);
      if not Assigned(FServerLog) then
      begin
        Exit;
      end;

      for i := 0 to Pred(FServerLog.Count) do
      begin
        rec := FServerLog[i];
        if Assigned(rec) then
        begin
          li := lvLog.Items.Add;
          if Assigned(li) then
          begin
            li.Caption := FormatDateTime(DATE_TIME_FORMAT_RU, rec.DateTime);
            if Assigned(li.SubItems) then
            begin
              li.SubItems.Add(rec.DatabaseType);
              li.SubItems.Add(Format('%d', [rec.FirstNumber]));
              li.SubItems.Add(rec.Creator);
              li.SubItems.Add(Format('%d', [rec.Quantity]));
              li.Data := Pointer(rec);
            end;
          end;
        end;
      end;
    finally
      lvLog.Items.EndUpdate;
    end;
  finally
    sl.Free;
  end;
end;

end.
