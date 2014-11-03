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
  Web.Win.Sockets, CastersPackage.uTStateImage, Vcl.Graphics,
  CastersPackage.uTStateProgressBar, CastersPackage.uTStatusBarEx;

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
    simg1: TStateImage;
    mniActionMenuGroupAction: TMenuItem;
    mniDisconnect: TMenuItem;
    mniConnect: TMenuItem;
    statpb1: TStateProgressBar;
    stsbrx1: TStatusBarEx;
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

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  strict private
    FWindowMessage: Cardinal;
    procedure RegisterWindowMessages;
    procedure ApplyConfiguration;
    procedure WMGetSysCommand(var AMessage: TMessage); message WM_SYSCOMMAND;

  protected
    procedure WndProc(var AMessage: TMessage); override;

  public
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Winapi.CommCtrl,
  Vcl.Dialogs,
  Winapi.Windows,
  CastersPackage.uTHackControl,
  DBUServerManager.uConsts,
  DBUServerManager.Configuration.uTInterface,
  DBUServerManager.uTConfigurationForm;

resourcestring
  RsExitConfirmationMessage = 'Вы действительно хотите завершить работу программы?';
  RsExitConfirmationCaption = '%s - Подтверждение выхода';
  RsWarningCaption = '%s - Предупреждение';
  RsErrorCaption = '%s - Ошибка';
  RsErrorRegisterWindowMessage = 'Не удалось выполнить операцию регистрации оконного сообщения!';

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

procedure TMainForm.actConnectExecute(Sender: TObject);
begin
  try
    IdTCPClient.Connect;
    if IdTCPClient.Connected then
    begin
      while IdTCPClient.IOHandler.InputBuffer.Size > 0 do
      begin
        ShowMessage(IdTCPClient.IOHandler.ReadLn);
      end;
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
  IdTCPClient.IOHandler.InputBuffer.Clear;
  IdTCPClient.Disconnect;
end;

procedure TMainForm.actDisconnectUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

procedure TMainForm.actTestConnectionExecute(Sender: TObject);
var
  s: string;
begin
  IdTCPClient.SendCmd('TCP_CONNECTION_TEST');
  s := IdTCPClient.IOHandler.ReadLn;
  ShowMessage(s);
end;

procedure TMainForm.actTestConnectionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := IdTCPClient.Connected;
end;

end.
