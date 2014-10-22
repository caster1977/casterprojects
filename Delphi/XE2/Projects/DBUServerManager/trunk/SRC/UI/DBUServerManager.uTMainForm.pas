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
  Vcl.ActnCtrls, Vcl.StdActns, System.Classes,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ImgList, Vcl.ToolWin;

type
  TMainForm = class(TForm)
    statMain: TStatusBar;
    AboutWindow: TAboutWindow;
    ilActions: TImageList;
    ActionManager: TActionManager;
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
    MainMenu: TMainMenu;
    N7: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N5: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    N10: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    acttbToolBar: TActionToolBar;
    actRestore: TAction;
    pmTray: TPopupMenu;
    mniActionRestore: TMenuItem;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    mniO1: TMenuItem;
    mniN3: TMenuItem;
    mniQuit: TMenuItem;
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

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  strict private
    FWindowMessage: Cardinal;
    procedure RegisterWindowMessages;
    procedure ApplyConfiguration;
    procedure OnHint(ASender: TObject);
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
  Winapi.Windows,
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

  if statMain.Visible <> b then
  begin
    statMain.Visible := b;
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
  statMain.Visible := b;

  b := Configuration.Section<TInterface>.EnableToolbar;
  actToolBar.Checked := b;
  acttbToolBar.Visible := b;
end;

destructor TMainForm.Destroy;
begin
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
begin
  Application.OnHint := OnHint;
  RegisterWindowMessages;
  ApplyConfiguration;

  if Configuration.Section<TInterface>.EnableSplashAtStart then
  begin
    AboutWindow.Show(True);
  end;
end;

function TMainForm.GetConfiguration: TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create;
  end;
  Result := FConfiguration;
end;

procedure TMainForm.OnHint(ASender: TObject);
begin
  statMain.SimpleText := GetLongHint(Application.Hint);
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
  TrayIcon.Visible := False;
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
  TrayIcon.Visible := False;
  SetForegroundWindow(Handle);
end;

procedure TMainForm.actRestoreUpdate(Sender: TObject);
begin
  actRestore.Enabled := not Visible;
end;

end.
