unit DBUServerManager.uTConfigurationForm;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  DBUServerManager.uConsts,
  DBUServerManager.uTConfiguration,
  Vcl.Samples.Spin,
  Vcl.ImgList,
  Vcl.StdActns;

type
  TConfigurationForm = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    actDefaults: TAction_Defaults;
    actHelp: TAction_Help;
    ActionList: TActionList;
    actNextPage: TAction_NextPage;
    actPreviousPage: TAction_PreviousPage;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    chkEnablePlaySoundOnComplete: TCheckBox;
    chkEnableQuitConfirmation: TCheckBox;
    chkEnableSplashAtStart: TCheckBox;
    chkEnableStatusbar: TCheckBox;
    chkEnableToolbar: TCheckBox;
    cmbPageName: TComboBox;
    gbInterface: TGroupBox;
    gbOther: TGroupBox;
    gbTop: TGroupBox;
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    chkEnableStoreMainFormSizesAndPosition: TCheckBox;
    Action_Help1: TAction_Help;
    ImageList: TImageList;
    chkEnableAlwaysShowTrayIcon: TCheckBox;
    chkEnableStartAtTray: TCheckBox;
    tsConnection: TTabSheet;
    grpConnection: TGroupBox;
    cbbHost: TComboBox;
    lblHost: TLabel;
    lblPort: TLabel;
    sePort: TSpinEdit;
    seTimeout: TSpinEdit;
    lblTimeout: TLabel;
    chkEnableStoreLogin: TCheckBox;
    chkEnableStorePassword: TCheckBox;
    chkEnableAutoLogon: TCheckBox;
    bvlConnection: TBevel;
    actClearHosts: TAction;
    btnClearHosts: TButton;
    procedure actCancelExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actDefaultsExecute(Sender: TObject);
    procedure actDefaultsUpdate(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);
    procedure actClearHostsExecute(Sender: TObject);
    procedure actClearHostsUpdate(Sender: TObject);

  strict private
    function GetActivePage: Integer;
    procedure SetActivePage(const AValue: Integer);
    property ActivePage: Integer read GetActivePage write SetActivePage
      default CONFIGURATION_DEFAULT_ACTIVE_PAGE;

  strict private
    function GetPageCount: Integer;
    property PageCount: Integer read GetPageCount nodefault;

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  public
    constructor Create(AOwner: TComponent; const AConfiguration: TConfiguration;
      const AActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;

  strict private
    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation
      write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;

  strict private
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart
      default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;

  strict private
    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar
      default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;

  strict private
    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar
      default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;

  strict private
    function GetEnableStoreMainFormSizesAndPosition: Boolean;
    procedure SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
    property EnableStoreMainFormSizesAndPosition: Boolean
      read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition
      default CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;

  strict private
    function GetEnableAlwaysShowTrayIcon: Boolean;
    procedure SetEnableAlwaysShowTrayIcon(const AValue: Boolean);
    property EnableAlwaysShowTrayIcon: Boolean read GetEnableAlwaysShowTrayIcon
      write SetEnableAlwaysShowTrayIcon default CONFIGURATION_DEFAULT_ENABLE_ALWAYS_SHOW_TRAY_ICON;

  strict private
    function GetEnableStartAtTray: Boolean;
    procedure SetEnableStartAtTray(const AValue: Boolean);
    property EnableStartAtTray: Boolean read GetEnableStartAtTray write SetEnableStartAtTray
      default CONFIGURATION_DEFAULT_ENABLE_START_AT_TRAY;

  strict private
    function GetHost: string;
    procedure SetHost(const AValue: string);
    property Host: string read GetHost write SetHost nodefault;

  strict private
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    property Port: Integer read GetPort write SetPort default CONFIGURATION_DEFAULT_PORT;

  strict private
    function GetTimeout: Integer;
    procedure SetTimeout(const AValue: Integer);
    property Timeout: Integer read GetTimeout write SetTimeout
      default CONFIGURATION_DEFAULT_TIMEOUT;

  strict private
    function GetEnableStoreLogin: Boolean;
    procedure SetEnableStoreLogin(const AValue: Boolean);
    property EnableStoreLogin: Boolean read GetEnableStoreLogin write SetEnableStoreLogin
      default CONFIGURATION_DEFAULT_ENABLE_STORE_LOGIN;

  strict private
    function GetEnableStorePassword: Boolean;
    procedure SetEnableStorePassword(const AValue: Boolean);
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword
      default CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD;

  strict private
    function GetEnableAutoLogon: Boolean;
    procedure SetEnableAutoLogon(const AValue: Boolean);
    property EnableAutoLogon: Boolean read GetEnableAutoLogon write SetEnableAutoLogon
      default CONFIGURATION_DEFAULT_ENABLE_AUTO_LOGON;
  end;

implementation

uses
  CastersPackage.uRoutines,
  System.UITypes,
  DBUServerManager.Configuration.uTInterface,
  DBUServerManager.Configuration.uTConnection;

resourcestring
  RsAConfigurationIsNil = 'AConfiguration is nil.';

{$R *.dfm}

constructor TConfigurationForm.Create(AOwner: TComponent; const AConfiguration: TConfiguration;
  const AActivePage: Integer);

  procedure ApplyConfiguration;
  begin
    if Assigned(Configuration) then
    begin
      cbbHost.Items.Assign(Configuration.Hosts);
      EnableQuitConfirmation := Configuration.Section<TInterface>.EnableQuitConfirmation;
      EnableSplashAtStart := Configuration.Section<TInterface>.EnableSplashAtStart;
      EnableStatusbar := Configuration.Section<TInterface>.EnableStatusbar;
      EnableToolbar := Configuration.Section<TInterface>.EnableToolbar;
      EnableStoreMainFormSizesAndPosition :=
        Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition;
      EnableAlwaysShowTrayIcon := Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon;
      EnableStartAtTray := Configuration.Section<TInterface>.EnableStartAtTray;
      Host := Configuration.Section<TConnection>.Host;
      Port := Configuration.Section<TConnection>.Port;
      Timeout := Configuration.Section<TConnection>.Timeout;
      EnableStoreLogin := Configuration.Section<TConnection>.EnableStoreLogin;
      EnableStorePassword := Configuration.Section<TConnection>.EnableStorePassword;
      EnableAutoLogon := Configuration.Section<TConnection>.EnableAutoLogon;
    end;
  end;

begin
  Assert(Assigned(AConfiguration), RsAConfigurationIsNil);
  inherited Create(AOwner);
  ActivePage := AActivePage;
  FConfiguration := AConfiguration;
  ApplyConfiguration;
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
begin
  if PageControl.ActivePage = tsInterface then
  begin
    EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
    EnableStoreMainFormSizesAndPosition :=
      CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;
    EnableAlwaysShowTrayIcon := CONFIGURATION_DEFAULT_ENABLE_ALWAYS_SHOW_TRAY_ICON;
    EnableStartAtTray := CONFIGURATION_DEFAULT_ENABLE_START_AT_TRAY;
  end;
  if PageControl.ActivePage = tsConnection then
  begin
    Host := CONFIGURATION_DEFAULT_HOST;
    Port := CONFIGURATION_DEFAULT_PORT;
    Timeout := CONFIGURATION_DEFAULT_TIMEOUT;
    EnableStoreLogin := CONFIGURATION_DEFAULT_ENABLE_STORE_LOGIN;
    EnableStorePassword := CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD;
    EnableAutoLogon := CONFIGURATION_DEFAULT_ENABLE_AUTO_LOGON;
  end;
end;

procedure TConfigurationForm.actDefaultsUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if PageControl.ActivePage = tsInterface then
  begin
    b := not((EnableQuitConfirmation = CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION) and
      (EnableSplashAtStart = CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START) and
      (EnableStatusbar = CONFIGURATION_DEFAULT_ENABLE_STATUSBAR) and
      (EnableToolbar = CONFIGURATION_DEFAULT_ENABLE_TOOLBAR) and
      (EnableStoreMainFormSizesAndPosition =
      CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION) and
      (EnableAlwaysShowTrayIcon = CONFIGURATION_DEFAULT_ENABLE_ALWAYS_SHOW_TRAY_ICON) and
      (EnableStartAtTray = CONFIGURATION_DEFAULT_ENABLE_START_AT_TRAY));
  end;
  if PageControl.ActivePage = tsConnection then
  begin
    b := not((Host = CONFIGURATION_DEFAULT_HOST) and (Port = CONFIGURATION_DEFAULT_PORT) and
      (Timeout = CONFIGURATION_DEFAULT_TIMEOUT) and
      (EnableStoreLogin = CONFIGURATION_DEFAULT_ENABLE_STORE_LOGIN) and
      (EnableStorePassword = CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD) and
      (EnableAutoLogon = CONFIGURATION_DEFAULT_ENABLE_AUTO_LOGON));
  end;
  actDefaults.Enabled := b;
end;

procedure TConfigurationForm.actApplyExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(Configuration) then
  begin
    Configuration.Section<TInterface>.EnableQuitConfirmation := EnableQuitConfirmation;
    Configuration.Section<TInterface>.EnableSplashAtStart := EnableSplashAtStart;
    Configuration.Section<TInterface>.EnableStatusbar := EnableStatusbar;
    Configuration.Section<TInterface>.EnableToolbar := EnableToolbar;
    Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition :=
      EnableStoreMainFormSizesAndPosition;
    Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon := EnableAlwaysShowTrayIcon;
    Configuration.Section<TInterface>.EnableStartAtTray := EnableStartAtTray;
    Configuration.Section<TConnection>.Host := Host;
    Configuration.Section<TConnection>.Port := Port;
    Configuration.Section<TConnection>.Timeout := Timeout;
    Configuration.Section<TConnection>.EnableStoreLogin := EnableStoreLogin;
    Configuration.Section<TConnection>.EnableStorePassword := EnableStorePassword;
    Configuration.Section<TConnection>.EnableAutoLogon := EnableAutoLogon;
    Configuration.CurrentPage := ActivePage;

    if Host > EmptyStr then
    begin
      i := Configuration.Hosts.IndexOf(Host);
      if i > -1 then
      begin
        Configuration.Hosts.Delete(i);
      end;
      Configuration.Hosts.Insert(0, Host);
    end;
  end;
  ModalResult := mrOk;
end;

procedure TConfigurationForm.actApplyUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Configuration) then
  begin
    b := not((Configuration.Section<TInterface>.EnableQuitConfirmation = EnableQuitConfirmation) and
      (Configuration.Section<TInterface>.EnableSplashAtStart = EnableSplashAtStart) and
      (Configuration.Section<TInterface>.EnableStatusbar = EnableStatusbar) and
      (Configuration.Section<TInterface>.EnableToolbar = EnableToolbar) and
      (Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition =
      EnableStoreMainFormSizesAndPosition) and
      (Configuration.Section<TInterface>.EnableAlwaysShowTrayIcon = EnableAlwaysShowTrayIcon) and
      (Configuration.Section<TInterface>.EnableStartAtTray = EnableStartAtTray) and

      (Configuration.Section<TConnection>.Host = Host) and
      (Configuration.Section<TConnection>.Port = Port) and
      (Configuration.Section<TConnection>.Timeout = Timeout) and

      (Configuration.Section<TConnection>.EnableStoreLogin = EnableStoreLogin) and
      (Configuration.Section<TConnection>.EnableStorePassword = EnableStorePassword) and
      (Configuration.Section<TConnection>.EnableAutoLogon = EnableAutoLogon));
  end;
  actApply.Enabled := b;
  btnApply.Default := b;
  btnCancel.Default := not b;
end;

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TConfigurationForm.GetActivePage: Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TConfigurationForm.GetConfiguration: TConfiguration;
begin
  Result := FConfiguration;
end;

function TConfigurationForm.GetEnableAlwaysShowTrayIcon: Boolean;
begin
  Result := chkEnableAlwaysShowTrayIcon.Checked and chkEnableAlwaysShowTrayIcon.Enabled;
end;

function TConfigurationForm.GetEnableAutoLogon: Boolean;
begin
  Result := chkEnableAutoLogon.Checked and chkEnableAutoLogon.Enabled;
end;

function TConfigurationForm.GetEnableQuitConfirmation: Boolean;
begin
  Result := chkEnableQuitConfirmation.Enabled and chkEnableQuitConfirmation.Checked;
end;

function TConfigurationForm.GetEnableSplashAtStart: Boolean;
begin
  Result := chkEnableSplashAtStart.Enabled and chkEnableSplashAtStart.Checked;
end;

function TConfigurationForm.GetEnableStartAtTray: Boolean;
begin
  Result := chkEnableStartAtTray.Enabled and chkEnableStartAtTray.Checked;
end;

function TConfigurationForm.GetEnableStatusbar: Boolean;
begin
  Result := chkEnableStatusbar.Enabled and chkEnableStatusbar.Checked;
end;

function TConfigurationForm.GetEnableStoreLogin: Boolean;
begin
  Result := chkEnableStoreLogin.Enabled and chkEnableStoreLogin.Checked;
end;

function TConfigurationForm.GetEnableStoreMainFormSizesAndPosition: Boolean;
begin
  Result := chkEnableStoreMainFormSizesAndPosition.Enabled and
    chkEnableStoreMainFormSizesAndPosition.Checked;
end;

function TConfigurationForm.GetEnableToolbar: Boolean;
begin
  Result := chkEnableToolbar.Enabled and chkEnableToolbar.Checked;
end;

function TConfigurationForm.GetPageCount: Integer;
begin
  Result := cmbPageName.Items.Count;
end;

function TConfigurationForm.GetPort: Integer;
begin
  Result := sePort.Value;
end;

function TConfigurationForm.GetTimeout: Integer;
begin
  Result := seTimeout.Value;
end;

procedure TConfigurationForm.SetActivePage(const AValue: Integer);
var
  i: Integer;
begin
  i := AValue;
  if i < 0 then
  begin
    i := PageCount - 1;
  end;
  if i > PageCount - 1 then
  begin
    i := 0;
  end;
  if cmbPageName.ItemIndex <> i then
  begin
    cmbPageName.ItemIndex := i;
  end;

  for i := 0 to PageControl.PageCount - 1 do
  begin
    if PageControl.Pages[i].Caption = cmbPageName.Items[cmbPageName.ItemIndex] then
    begin
      if PageControl.ActivePageIndex <> i then
      begin
        PageControl.ActivePageIndex := i;
      end;
      Break;
    end;
  end;
end;

procedure TConfigurationForm.SetEnableAlwaysShowTrayIcon(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableAlwaysShowTrayIcon, AValue);
end;

procedure TConfigurationForm.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableQuitConfirmation, AValue);
end;

procedure TConfigurationForm.SetEnableSplashAtStart(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableSplashAtStart, AValue);
end;

procedure TConfigurationForm.SetEnableStartAtTray(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStartAtTray, AValue);
end;

procedure TConfigurationForm.SetEnableStatusbar(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStatusbar, AValue);
end;

procedure TConfigurationForm.SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStoreMainFormSizesAndPosition, AValue);
end;

procedure TConfigurationForm.SetEnableToolbar(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableToolbar, AValue);
end;

procedure TConfigurationForm.actPreviousPageUpdate(Sender: TObject);
begin
  actPreviousPage.Enabled := PageCount > 1;
end;

procedure TConfigurationForm.actNextPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage + 1;
end;

procedure TConfigurationForm.actNextPageUpdate(Sender: TObject);
begin
  actNextPage.Enabled := PageCount > 1;
end;

procedure TConfigurationForm.actPreviousPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage - 1;
end;

procedure TConfigurationForm.cmbPageNameSelect(Sender: TObject);
begin
  ActivePage := cmbPageName.ItemIndex;
end;

function TConfigurationForm.GetEnableStorePassword: Boolean;
begin
  Result := chkEnableStorePassword.Checked and chkEnableStorePassword.Enabled;
end;

procedure TConfigurationForm.SetEnableStorePassword(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStorePassword, AValue);
end;

procedure TConfigurationForm.SetEnableAutoLogon(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableAutoLogon, AValue);
end;

procedure TConfigurationForm.SetEnableStoreLogin(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStoreLogin, AValue);
end;

procedure TConfigurationForm.SetPort(const AValue: Integer);
begin
  if sePort.Value <> AValue then
  begin
    sePort.Value := AValue;
  end;
end;

procedure TConfigurationForm.SetTimeout(const AValue: Integer);
begin
  if seTimeout.Value <> AValue then
  begin
    seTimeout.Value := AValue;
  end;
end;

function TConfigurationForm.GetHost: string;
begin
  Result := Trim(cbbHost.Text);
end;

procedure TConfigurationForm.SetHost(const AValue: string);
var
  s: string;
  i: Integer;
begin
  s := Trim(AValue);

  if s > EmptyStr then
  begin
    i := cbbHost.Items.IndexOf(s);
    if i < 0 then
    begin
      i := 0;
      cbbHost.Items.Insert(i, s);
    end;

    cbbHost.ItemIndex := i;
  end
  else
  begin
    cbbHost.Text := s;
  end;
end;

procedure TConfigurationForm.actClearHostsExecute(Sender: TObject);
var
  s: string;
  i: Integer;
begin
  s := Trim(cbbHost.Text);
  cbbHost.Items.BeginUpdate;
  try
    for i := Pred(cbbHost.Items.Count) downto 0 do
    begin
      if cbbHost.Items[i] = s then
      begin
        Continue;
      end;
      cbbHost.Items.Delete(i);
    end;
  finally
    cbbHost.Items.EndUpdate;
  end;

  if Assigned(Configuration) then
  begin
    for i := Pred(Configuration.Hosts.Count) downto 0 do
    begin
      if Configuration.Hosts[i] = s then
      begin
        Continue;
      end;
      Configuration.Hosts.Delete(i);
    end;
  end;
end;

procedure TConfigurationForm.actClearHostsUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := cbbHost.Items.Count > 1;
end;

end.
