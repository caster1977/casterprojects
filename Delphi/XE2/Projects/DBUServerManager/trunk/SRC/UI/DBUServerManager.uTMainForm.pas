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
  CastersPackage.uTStateImage,
  Vcl.Graphics,
  CastersPackage.uTStateProgressBar,
  CastersPackage.uTStatusBarEx,
  CastersPackage.uTApplicationOnHint,
  DBUShared.uIDBUServerLogRecords,
  DBUShared.uISQLActions,
  DBUShared.uISQLSubjects,
  DBUShared.uIDBUStates,
  DBUShared.uIDatabaseTypes,
  DBUShared.uIUsers,
  System.SyncObjs,
  LoginPackage.uTLoginWindow;

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
    actConfiguration: TAction_Configuration;
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
    actAddDBType: TAction;
    mniAddDBType: TMenuItem;
    actGetLogData: TAction;
    mniGetLogData: TMenuItem;
    actRefresh: TAction;
    mniN4: TMenuItem;
    mniRefresh: TMenuItem;
    actActionTesting: TAction;
    mniActionTesting: TMenuItem;
    LoginWindow: TLoginWindow;
    pgcMain: TPageControl;
    tsLogRecords: TTabSheet;
    tsUsers: TTabSheet;
    tsSQLActions: TTabSheet;
    tsSQLSubjects: TTabSheet;
    tsDatabaseTypes: TTabSheet;
    lvUsers: TListView;
    lvSQLSubjects: TListView;
    lvDatabaseTypes: TListView;
    lvSQLActions: TListView;
    actAddItem: TAction;
    actEditItem: TAction;
    actDeleteItem: TAction;
    tlbMain: TToolBar;
    btnQuit: TToolButton;
    btnSeparator1: TToolButton;
    btnConfiguration: TToolButton;
    btnConnect: TToolButton;
    btnSeparator2: TToolButton;
    btnDisconnect: TToolButton;
    btnSeparator3: TToolButton;
    btnAddItem: TToolButton;
    btnEditItem: TToolButton;
    btnDeleteItem: TToolButton;
    btnSeparator4: TToolButton;
    btnRefresh: TToolButton;
    btnSeparator5: TToolButton;
    btn5: TToolButton;
    btnSeparator6: TToolButton;
    btnAbout: TToolButton;
    pmMain: TPopupMenu;
    mniPopupAddItem: TMenuItem;
    mniPopupEditItem: TMenuItem;
    mniPopupDeleteItem: TMenuItem;
    mniPopupSeparator1: TMenuItem;
    mniPopupRefresh: TMenuItem;
    mniPopupSeparator2: TMenuItem;
    mniPopupConnect: TMenuItem;
    mniPopupDisconnect: TMenuItem;
    mniPopupSeparator3: TMenuItem;
    mniPopupHelpContents: TMenuItem;
    mniPopupSeparator4: TMenuItem;
    mniPopupQuit: TMenuItem;
    mniN2: TMenuItem;
    mniAddItem: TMenuItem;
    mniEditItem: TMenuItem;
    mniDeleteItem: TMenuItem;
    tsDBUStates: TTabSheet;
    lvDBUStates: TListView;
    ilDBUStates: TImageList;
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
    procedure actTestConnectionExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure actConnectUpdate(Sender: TObject);
    procedure actDisconnectUpdate(Sender: TObject);
    procedure actTestConnectionUpdate(Sender: TObject);
    procedure actReserveNewDBUNUmberUpdate(Sender: TObject);
    procedure actReserveNewDBUNUmberExecute(Sender: TObject);
    procedure actGetSQLActionListUpdate(Sender: TObject);
    procedure actGetSQLSubjectListUpdate(Sender: TObject);
    procedure actGetLogDataByDBTypeUpdate(Sender: TObject);
    procedure actGetDBTypeListUpdate(Sender: TObject);
    procedure actGetDBUStateListUpdate(Sender: TObject);
    procedure actAddDBTypeUpdate(Sender: TObject);
    procedure actAddDBTypeExecute(Sender: TObject);
    procedure actGetLogDataUpdate(Sender: TObject);
    procedure actGetLogDataExecute(Sender: TObject);
    procedure actRefreshUpdate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actActionTestingExecute(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure actAddItemExecute(Sender: TObject);
    procedure actAddItemUpdate(Sender: TObject);
    procedure actEditItemExecute(Sender: TObject);
    procedure actEditItemUpdate(Sender: TObject);
    procedure actDeleteItemExecute(Sender: TObject);
    procedure actDeleteItemUpdate(Sender: TObject);

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
    FSQLActions: ISQLActions;
    FSQLSubjects: ISQLSubjects;
    FDBUStates: IDBUStates;
    FDatabaseTypes: IDatabaseTypes;
    FUsers: IUsers;
    FCurrentUserIsAdmin: Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  System.StrUtils,
  Winapi.Windows,
  Vcl.Dialogs,
  IdGlobal,
  DBUShared.uConsts,
  CastersPackage.uRoutines,
  CastersPackage.uIListItemAdapter,
  CastersPackage.uTEnterStringForm,
  DBUServerManager.uConsts,
  DBUServerManager.Configuration.uTInterface,
  DBUServerManager.Configuration.uTConnection,
  DBUServerManager.uTConfigurationForm,
  DBUShared.uTDBUServerLogRecords,
  DBUShared.uTSQLActions,
  DBUShared.uTSQLSubjects,
  DBUShared.uTDBUStates,
  DBUShared.uTDatabaseTypes,
  DBUShared.uTUsers;

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
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  form := TConfigurationForm.Create(Self, Configuration, Configuration.CurrentPage);
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
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := actToolBar.Checked;

  if tlbMain.Visible <> b then
  begin
    tlbMain.Visible := b;
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
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  b := Configuration.Section<TInterface>.EnableStatusbar;
  actStatusBar.Checked := b;
  StatusBar.Visible := b;

  b := Configuration.Section<TInterface>.EnableToolbar;
  actToolBar.Checked := b;
  tlbMain.Visible := b;

  TrayIcon.Visible := (not Visible) or Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon;

  if not Configuration.Section<TConnection>.EnableStorePassword then
  begin
    Configuration.Section<TConnection>.Password := EmptyStr;
    Configuration.Section<TConnection>.EnableAutoLogon := False;
  end;

  if not Configuration.Section<TConnection>.EnableStoreLogin then
  begin
    Configuration.Section<TConnection>.Password := EmptyStr;
    Configuration.Section<TConnection>.Login := EmptyStr;
    Configuration.Section<TConnection>.EnableAutoLogon := False;
  end;

  b := (IdTCPClient.Connected) and ((IdTCPClient.Host <> Configuration.Section<TConnection>.Host) or
    (IdTCPClient.Port <> Configuration.Section<TConnection>.Port) or
    (IdTCPClient.ConnectTimeout <> Configuration.Section<TConnection>.Timeout));
  if b then
  begin
    actDisconnect.Execute;
  end;
  IdTCPClient.Host := Configuration.Section<TConnection>.Host;
  IdTCPClient.Port := Configuration.Section<TConnection>.Port;
  IdTCPClient.ConnectTimeout := Configuration.Section<TConnection>.Timeout;
  if b then
  begin
    actConnect.Execute;
  end;
  StateImage.Hint := Format('Сервер: [%s], порт: [%d]', [Configuration.Section<TConnection>.Host,
    Configuration.Section<TConnection>.Port]);
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
      PWideChar(Format(RsExitConfirmationCaption, [APPLICATION_NAME])),
      MESSAGE_TYPE_CONFIRMATION_QUESTION) = IDOK;
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

  StatusBar.Panels[ProgressBar.BindPanelIndex].Width := 0;

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

procedure TMainForm.pgcMainChange(Sender: TObject);
begin
  actRefresh.Execute;
end;

procedure TMainForm.RegisterWindowMessages;
begin
  FWindowMessage := RegisterWindowMessage(PWideChar(APPLICATION_NAME));
  if FWindowMessage = 0 then
  begin
    MessageBox(Handle, PWideChar(RsErrorRegisterWindowMessage),
      PWideChar(Format(RsErrorCaption, [Application.Title])), MESSAGE_TYPE_ERROR);
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
  (Sender as TAction).Enabled := IdTCPClient.Connected and pgcMain.Visible and
    Assigned(pgcMain.ActivePage);
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

{ procedure TMainForm.Lock;
  begin
  FLock.Enter;
  end; }

procedure TMainForm.actConnectExecute(Sender: TObject);
var
  itc: TIdTCPClient;
  t: Byte;
  t1: Byte;
begin
  LoginWindow.Login := Configuration.Section<TConnection>.Login;
  LoginWindow.Password := Configuration.Section<TConnection>.Password;

  if not Configuration.Section<TConnection>.EnableAutoLogon then
  begin
    if LoginWindow.Execute then
    begin
      Configuration.Section<TConnection>.Login :=
        IfThen(Configuration.Section<TConnection>.EnableStoreLogin, LoginWindow.Login);
      Configuration.Section<TConnection>.Password :=
        IfThen(Configuration.Section<TConnection>.EnableStorePassword, LoginWindow.Password);
    end
    else
    begin
      Exit;
    end;
  end;

  t := 0;
  t1 := 0;
  try
    try
      itc := TIdTCPClient.Create(Self);
      try
        itc.Host := IdTCPClient.Host;
        itc.Port := IdTCPClient.Port;
        itc.ConnectTimeout := IdTCPClient.ConnectTimeout;
        itc.Connect;
        try
          // ShowMessage(itc.IOHandler.ReadLn);
          itc.SendCmd('TCP_LOGIN');
          itc.IOHandler.WriteLn(LoginWindow.Login);
          itc.IOHandler.WriteLn(Routines.Hash(LoginWindow.Password));
          t := itc.IOHandler.ReadByte;
          if t = 3 then
          begin
            t1 := itc.IOHandler.ReadByte;
          end;

        finally
          itc.Disconnect;
        end;
      finally
        itc.Free;
      end;
    except
    end;
  finally
    case t of
      0:
        begin
          ShowMessage('Не удалось подключиться к серверу.' + sLineBreak +
            'Проверьте правильность настроек подключения.');
        end;
      1:
        begin
          ShowMessage('Введены неверные данные пользователя.');
          Configuration.Section<TConnection>.EnableAutoLogon := False;
        end;
      2:
        begin
          ShowMessage('Учётная запись пользователя заблокирована.');
          Configuration.Section<TConnection>.EnableAutoLogon := False;
        end;
      3:
        begin
          IdTCPClient.Connect;
          if IdTCPClient.Connected then
          begin
            StateImage.State := True;
            // ShowMessage(IdTCPClient.IOHandler.ReadLn);
            pgcMain.ActivePage := tsLogRecords;
            pgcMain.Visible := True;
            actRefresh.Execute;
            { TODO : дописать применение админских прав }
            FCurrentUserIsAdmin := t1 = 1;
            tsUsers.TabVisible := FCurrentUserIsAdmin;
            tsUsers.Visible := FCurrentUserIsAdmin;
            // ShowMessage('Пользователь является администратором');
          end;
        end;
    end;
  end;
end;

procedure TMainForm.actConnectUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not IdTCPClient.Connected;
end;

procedure TMainForm.actDeleteItemExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.actDeleteItemUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected and FCurrentUserIsAdmin;
end;

procedure TMainForm.actDisconnectExecute(Sender: TObject);
begin
  pgcMain.Visible := False;
  lvLog.Items.BeginUpdate;
  try
    lvLog.Clear;
    FServerLog := nil;
  finally
    lvLog.Items.EndUpdate;
  end;
  lvSQLActions.Items.BeginUpdate;
  try
    lvSQLActions.Clear;
    FSQLActions := nil;
  finally
    lvSQLActions.Items.EndUpdate;
  end;
  lvSQLSubjects.Items.BeginUpdate;
  try
    lvSQLSubjects.Clear;
    FSQLSubjects := nil;
  finally
    lvSQLSubjects.Items.EndUpdate;
  end;
  lvDBUStates.Items.BeginUpdate;
  try
    lvDBUStates.Clear;
    FDBUStates := nil;
  finally
    lvDBUStates.Items.EndUpdate;
  end;
  lvDatabaseTypes.Items.BeginUpdate;
  try
    lvDatabaseTypes.Clear;
    FDatabaseTypes := nil;
  finally
    lvDatabaseTypes.Items.EndUpdate;
  end;
  lvUsers.Items.BeginUpdate;
  try
    lvUsers.Clear;
    FUsers := nil;
  finally
    lvUsers.Items.EndUpdate;
  end;
  IdTCPClient.IOHandler.InputBuffer.Clear;
  IdTCPClient.Disconnect;
  StateImage.State := False;
  FCurrentUserIsAdmin := False;
end;

procedure TMainForm.actDisconnectUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actEditItemExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.actEditItemUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected and FCurrentUserIsAdmin;
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

procedure TMainForm.actGetSQLActionListUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
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

procedure TMainForm.actAddDBTypeUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actGetDBUStateListUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
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
  lv: TListView;
  lia: IListItemAdapter;
  items_count: Integer;
  st: TStream;
begin
  items_count := 0;
  if not pgcMain.Visible then
  begin
    Exit;
  end;

  if not Assigned(pgcMain.ActivePage) then
  begin
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    sl := TStringList.Create;
    try
      lv := nil;

      if pgcMain.ActivePage = tsLogRecords then
      begin
        lv := lvLog;
        IdTCPClient.SendCmd('TCP_GET_DBU_NEW_NUMBER_LOG_GRID');
        IdTCPClient.IOHandler.WriteLn;
        line_count := IdTCPClient.IOHandler.ReadLongInt;
        for i := 0 to Pred(line_count) do
        begin
          sl.Append(IdTCPClient.IOHandler.ReadLn);
        end;
        FServerLog := GetIDBUServerLogRecords(sl, ['^^']);
        if not Assigned(FServerLog) then
        begin
          Exit;
        end;
        items_count := FServerLog.Count;
      end;

      if pgcMain.ActivePage = tsSQLActions then
      begin
        lv := lvSQLActions;
        IdTCPClient.SendCmd('TCP_GET_DBU_SQL_ACTION_ITEMS');
        line_count := IdTCPClient.IOHandler.ReadLongInt;
        for i := 0 to Pred(line_count) do
        begin
          sl.Append(IdTCPClient.IOHandler.ReadLn);
        end;
        FSQLActions := GetISQLActions(sl, [':']);
        if not Assigned(FSQLActions) then
        begin
          Exit;
        end;
        items_count := FSQLActions.Count;
      end;

      if pgcMain.ActivePage = tsSQLSubjects then
      begin
        lv := lvSQLSubjects;
        IdTCPClient.SendCmd('TCP_GET_DBU_SQL_SUBJ_ITEMS');
        line_count := IdTCPClient.IOHandler.ReadLongInt;
        for i := 0 to Pred(line_count) do
        begin
          sl.Append(IdTCPClient.IOHandler.ReadLn);
        end;
        FSQLSubjects := GetISQLSubjects(sl, [':']);
        if not Assigned(FSQLSubjects) then
        begin
          Exit;
        end;
        items_count := FSQLSubjects.Count;
      end;

      if pgcMain.ActivePage = tsDBUStates then
      begin
        lv := lvDBUStates;
        IdTCPClient.SendCmd('TCP_GET_DBU_STATES_ITEMS');
        IdTCPClient.IOHandler.ReadStrings(sl, -1, IndyTextEncoding_OSDefault);

        st := TMemoryStream.Create;
        try
          IdTCPClient.IOHandler.ReadStream(st);
          st.Position := 0;
          THackImageList(ilDBUStates).ReadData(st);
        finally
          st.Free;
        end;

        FDBUStates := GetIDBUStates(sl, ilDBUStates, ['=', ':']);
        if not Assigned(FDBUStates) then
        begin
          Exit;
        end;
        items_count := FDBUStates.Count;
      end;

      if pgcMain.ActivePage = tsDatabaseTypes then
      begin
        lv := lvDatabaseTypes;
        IdTCPClient.SendCmd('TCP_GET_DBU_DATABASE_TYPE_ITEMS');
        line_count := IdTCPClient.IOHandler.ReadLongInt;
        for i := 0 to Pred(line_count) do
        begin
          sl.Append(Format('%s=%d', [IdTCPClient.IOHandler.ReadLn,
            IdTCPClient.IOHandler.ReadLongInt]));
        end;
        FDatabaseTypes := GetIDatabaseTypes(sl, ['=']);
        if not Assigned(FDatabaseTypes) then
        begin
          Exit;
        end;
        items_count := FDatabaseTypes.Count;
      end;

      if pgcMain.ActivePage = tsUsers then
      begin
        lv := lvUsers;
        IdTCPClient.SendCmd('TCP_GET_USERS');
        line_count := IdTCPClient.IOHandler.ReadLongInt;
        for i := 0 to Pred(line_count) do
        begin
          sl.Append(IdTCPClient.IOHandler.ReadLn(IndyTextEncoding_OSDefault));
        end;
        FUsers := GetIUsers(sl, [DEFAULT_USER_LIST_SEPARATOR]);
        if not Assigned(FUsers) then
        begin
          Exit;
        end;
        items_count := FUsers.Count;
      end;

      if not Assigned(lv) then
      begin
        Exit;
      end;

      lv.Items.BeginUpdate;
      try
        lv.Clear;
        if StatusBar.Visible then
        begin
          ProgressBar.Position := 0;
          ProgressBar.Max := items_count;
          StatusBar.Panels[ProgressBar.BindPanelIndex].Width := STATUSBAR_PROGRESS_PANEL_WIDTH;
          ProgressBar.Visible := True;
        end;

        for i := 0 to Pred(items_count) do
        begin
          if StatusBar.Visible then
          begin
            ProgressBar.StepIt;
            Application.ProcessMessages;
          end;

          if pgcMain.ActivePage = tsLogRecords then
          begin
            if not Supports(FServerLog[i], IListItemAdapter, lia) then
            begin
              Continue;
            end;
          end;

          if pgcMain.ActivePage = tsSQLActions then
          begin
            if not Supports(FSQLActions[i], IListItemAdapter, lia) then
            begin
              Continue;
            end;
          end;

          if pgcMain.ActivePage = tsSQLSubjects then
          begin
            if not Supports(FSQLSubjects[i], IListItemAdapter, lia) then
            begin
              Continue;
            end;
          end;

          if pgcMain.ActivePage = tsDBUStates then
          begin
            if not Supports(FDBUStates[i], IListItemAdapter, lia) then
            begin
              Continue;
            end;
          end;

          if pgcMain.ActivePage = tsDatabaseTypes then
          begin
            if not Supports(FDatabaseTypes[i], IListItemAdapter, lia) then
            begin
              Continue;
            end;
          end;

          if pgcMain.ActivePage = tsUsers then
          begin
            if not Supports(FUsers[i], IListItemAdapter, lia) then
            begin
              Continue;
            end;
          end;

          lia.AppendToListView(lv);
        end;
        if StatusBar.Visible then
        begin
          ProgressBar.Visible := False;
          StatusBar.Panels[ProgressBar.BindPanelIndex].Width := 0;
        end;
      finally
        lv.Items.EndUpdate;
      end;
    finally
      sl.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.actAddDBTypeExecute(Sender: TObject);
var
  // index: SmallInt;
  db_type: string;
  s: string;
begin
  IdTCPClient.SendCmd('TCP_ADD_NEW_DATABASE_TYPE');
  db_type := 'db_type';
  IdTCPClient.IOHandler.WriteLn(db_type);
  // index :=
  IdTCPClient.IOHandler.ReadSmallInt;
  s := IdTCPClient.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
  ShowMessage(s);
end;

procedure TMainForm.actAddItemExecute(Sender: TObject);
var
  id: Integer;
  form: TEnterStringForm;
  s: string;
begin
  if not pgcMain.Visible then
  begin
    Exit;
  end;

  if not Assigned(pgcMain.ActivePage) then
  begin
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    if pgcMain.ActivePage = tsDatabaseTypes then
    begin
      form := TEnterStringForm.Create(Self, 'Создание типа БД', 'Наименование:');
      try
        form.ShowModal;
        if form.ModalResult = mrOk then
        begin
          s := form.Value;
          IdTCPClient.SendCmd('TCP_ADD_NEW_DATABASE_TYPE');
          IdTCPClient.IOHandler.WriteLn(s);
          id := IdTCPClient.IOHandler.ReadSmallInt;
          s := IdTCPClient.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
//          ShowMessage(s);
          if id > -1 then
          begin
            actRefresh.Execute;
          end;
        end;
      finally
        form.Free;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.actAddItemUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected and FCurrentUserIsAdmin;
end;

end.
