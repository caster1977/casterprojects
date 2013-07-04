unit DBAutoTest.uTConfigurationForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  System.Actions,
  Vcl.ActnList,
  DBAutoTest.uConsts,
  DBAutoTest.uTConfiguration,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Mask;

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
    gbReport: TGroupBox;
    gbTop: TGroupBox;
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    tsReport: TTabSheet;
    tsResults: TTabSheet;
    chkEnableStoreMainFormSizesAndPosition: TCheckBox;
    chkEnableGenerateFastReportDocument: TCheckBox;
    chkEnableGenerateExcelDocument: TCheckBox;
    ADOConnection: TADOConnection;
    actRefreshServers: TAction;
    actRefreshDatabases: TAction;
    actUseWinNTSecurity: TAction;
    actUseLoginAndPassword: TAction;
    actEnablePasswordSaving: TAction;
    actEnableEmptyPassword: TAction;
    Action_Help1: TAction_Help;
    actEnableStoreTasks: TAction;
    gbConnection: TGroupBox;
    lblServerName: TLabel;
    lblDatabaseName: TLabel;
    lblLogin: TLabel;
    lblPassword: TLabel;
    lblSecurity: TLabel;
    cmbServers: TComboBox;
    cmbDatabaseName: TComboBox;
    rbWinNTSecurity: TRadioButton;
    rbLoginAndPassword: TRadioButton;
    chkEnableEmptyPassword: TCheckBox;
    chkEnableStorePassword: TCheckBox;
    ebLogin: TEdit;
    mePassword: TMaskEdit;
    btnRefreshServers: TButton;
    btnRefreshDatabases: TButton;
    ImageList: TImageList;
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
    procedure actRefreshServersExecute(Sender: TObject);
    procedure actRefreshDatabasesExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure cmbServersChange(Sender: TObject);
    procedure cmbServersDropDown(Sender: TObject);
    procedure cmbServersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbServersSelect(Sender: TObject);
    procedure actUseWinNTSecurityExecute(Sender: TObject);
    procedure actUseLoginAndPasswordExecute(Sender: TObject);
    procedure actEnableEmptyPasswordExecute(Sender: TObject);
    procedure actEnablePasswordSavingExecute(Sender: TObject);
    procedure ebLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mePasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  strict private
    function GetActivePage: Integer;
    procedure SetActivePage(const AValue: Integer);
    property ActivePage: Integer read GetActivePage write SetActivePage default CONFIGURATION_DEFAULT_ACTIVE_PAGE;

  strict private
    function GetPageCount: Integer;
    property PageCount: Integer read GetPageCount nodefault;

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  public
    constructor Create(AOwner: TComponent; const AConfiguration: TConfiguration; const AActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;

  strict private
    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;

  strict private
    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;

  strict private
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;

  strict private
    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;

  strict private
    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;

  strict private
    function GetEnableStoreMainFormSizesAndPosition: Boolean;
    procedure SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
    property EnableStoreMainFormSizesAndPosition: Boolean read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition default CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;

  strict private
    function GetEnableGenerateFastReportDocument: Boolean;
    procedure SetEnableGenerateFastReportDocument(const AValue: Boolean);
    property EnableGenerateFastReportDocument: Boolean read GetEnableGenerateFastReportDocument write SetEnableGenerateFastReportDocument default CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT;

  strict private
    function GetEnableGenerateExcelDocument: Boolean;
    procedure SetEnableGenerateExcelDocument(const AValue: Boolean);
    property EnableGenerateExcelDocument: Boolean read GetEnableGenerateExcelDocument write SetEnableGenerateExcelDocument default CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT;

  strict private
    FRefreshingServers: Boolean;
    FRefreshingDatabases: Boolean;
    procedure GetServerList(const aList: TStrings; var ARefreshing: Boolean);
    procedure GetDatabasesList(const aList: TStrings);

  strict private
    function GetServer: string;
    procedure SetServer(const AValue: string);
    property Server: string read GetServer write SetServer;

  strict private
    function GetWinNTSecurity: Boolean;
    procedure SetWinNTSecurity(const AValue: Boolean);
    property WinNTSecurity: Boolean read GetWinNTSecurity write SetWinNTSecurity;

  strict private
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    property Login: string read GetLogin write SetLogin;

  strict private
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
    property Password: string read GetPassword write SetPassword;

  strict private
    function GetEnableStorePassword: Boolean;
    procedure SetEnableStorePassword(const AValue: Boolean);
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword;

  strict private
    function GetEnableEmptyPassword: Boolean;
    procedure SetEnableEmptyPassword(const AValue: Boolean);
    property EnableEmptyPassword: Boolean read GetEnableEmptyPassword write SetEnableEmptyPassword;

  strict private
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
    property Database: string read GetDatabase write SetDatabase;
  end;

implementation

uses
  CastersPackage.uRoutines,
  CastersPackage.UNetSrvList,
  System.UITypes,
  DBAutoTest.Configuration.uTInterface,
  DBAutoTest.Configuration.uTReports,
  DBAutoTest.Configuration.uTConnection,
  DBAutoTest.uTOtherOptions;

resourcestring
  RsAConfigurationIsNil = 'AConfiguration is nil.';

{$R *.dfm}

constructor TConfigurationForm.Create(AOwner: TComponent; const AConfiguration: TConfiguration; const AActivePage: Integer);

  procedure ApplyConfiguration;
  begin
    if Assigned(Configuration) then
    begin
      EnableQuitConfirmation := Configuration.Section<TInterface>.EnableQuitConfirmation;
      EnableSplashAtStart := Configuration.Section<TInterface>.EnableSplashAtStart;
      EnableStatusbar := Configuration.Section<TInterface>.EnableStatusbar;
      EnableToolbar := Configuration.Section<TInterface>.EnableToolbar;
      EnableStoreMainFormSizesAndPosition := Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition;
      EnableGenerateFastReportDocument := Configuration.Section<TReports>.EnableGenerateFastReportDocument;
      EnableGenerateExcelDocument := Configuration.Section<TReports>.EnableGenerateExcelDocument;
      EnablePlaySoundOnComplete := Configuration.Section<TOtherOptions>.EnablePlaySoundOnComplete;
      Server := Configuration.Section<TConnection>.Server;
      WinNTSecurity := Configuration.Section<TConnection>.WinNTSecurity;
      Login := Configuration.Section<TConnection>.Login;
      Password := Configuration.Section<TConnection>.Password;
      EnableStorePassword := Configuration.Section<TConnection>.EnableStorePassword;
      EnableEmptyPassword := Configuration.Section<TConnection>.EnableEmptyPassword;
      Database := Configuration.Section<TConnection>.Database;
    end;
  end;

begin
  Assert(Assigned(AConfiguration), RsAConfigurationIsNil);
  inherited Create(AOwner);
  ActivePage := AActivePage;
  FConfiguration := AConfiguration;
  ApplyConfiguration;
end;

procedure TConfigurationForm.ebLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    actRefreshDatabases.Execute;
  end;
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
begin
  if PageControl.ActivePage = tsInterface then
  begin
    EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
    EnableStoreMainFormSizesAndPosition := CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;
  end;
  if PageControl.ActivePage = tsResults then
  begin
    Server := CONFIGURATION_DEFAULT_SERVER;
    WinNTSecurity := CONFIGURATION_DEFAULT_WIN_NT_SECURITY;
    Login := CONFIGURATION_DEFAULT_LOGIN;
    Password := CONFIGURATION_DEFAULT_PASSWORD;
    EnableStorePassword := CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD;
    EnableEmptyPassword := CONFIGURATION_DEFAULT_ENABLE_EMPTY_PASSWORD;
    Database := CONFIGURATION_DEFAULT_DATABASE;
  end;
  if PageControl.ActivePage = tsReport then
  begin
    EnableGenerateFastReportDocument := CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT;
    EnableGenerateExcelDocument := CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT;
  end;
  if PageControl.ActivePage = tsOther then
  begin
    EnablePlaySoundOnComplete := CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
  end;
end;

procedure TConfigurationForm.actDefaultsUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if PageControl.ActivePage = tsInterface then
  begin
    b := not(
    (EnableQuitConfirmation = CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION) and
    (EnableSplashAtStart = CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START) and
    (EnableStatusbar = CONFIGURATION_DEFAULT_ENABLE_STATUSBAR) and
    (EnableToolbar = CONFIGURATION_DEFAULT_ENABLE_TOOLBAR) and
    (EnableStoreMainFormSizesAndPosition = CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION));
  end;
  if PageControl.ActivePage = tsResults then
  begin
    b := not(
    (Server = CONFIGURATION_DEFAULT_SERVER) and
    (WinNTSecurity = CONFIGURATION_DEFAULT_WIN_NT_SECURITY) and
    (Login = CONFIGURATION_DEFAULT_LOGIN) and
    (Password = CONFIGURATION_DEFAULT_PASSWORD) and
    (EnableStorePassword = CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD) and
    (EnableEmptyPassword = CONFIGURATION_DEFAULT_ENABLE_EMPTY_PASSWORD) and
    (Database = CONFIGURATION_DEFAULT_DATABASE));
  end;
  if PageControl.ActivePage = tsReport then
  begin
    b := not((EnableGenerateFastReportDocument = CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT) and (EnableGenerateExcelDocument = CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT));
  end;
  if PageControl.ActivePage = tsOther then
  begin
    b := not(EnablePlaySoundOnComplete = CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE);
  end;
  actDefaults.Enabled := b;
end;

procedure TConfigurationForm.actEnableEmptyPasswordExecute(Sender: TObject);
begin
  //
end;

procedure TConfigurationForm.actEnablePasswordSavingExecute(Sender: TObject);
begin
  //
end;

procedure TConfigurationForm.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  actRefreshServers.Enabled := not FRefreshingServers;
  actRefreshDatabases.Enabled := (not FRefreshingDatabases) and ((Trim(cmbServers.Text) > EmptyStr) or (cmbServers.ItemIndex > -1));

  lblLogin.Enabled := actUseLoginAndPassword.Checked;

  ebLogin.Enabled := lblLogin.Enabled;
  if not ebLogin.Enabled then
  begin
    ebLogin.Clear;
    ebLogin.Color := clBtnFace;
  end
  else
  begin
    ebLogin.Color := clWindow;
  end;

  lblPassword.Enabled := actUseLoginAndPassword.Checked and (not actEnableEmptyPassword.Checked);
  mePassword.Enabled := lblPassword.Enabled;
  if not mePassword.Enabled then
  begin
    mePassword.Clear;
    mePassword.Color := clBtnFace;
  end
  else
  begin
    mePassword.Color := clWindow;
  end;

  actEnableEmptyPassword.Enabled := actUseLoginAndPassword.Checked;
  actEnablePasswordSaving.Enabled := actUseLoginAndPassword.Checked;

  cmbDatabaseName.Enabled := actRefreshDatabases.Enabled and (cmbDatabaseName.Items.Count > 0);
  lblDatabaseName.Enabled := actRefreshDatabases.Enabled;
end;

procedure TConfigurationForm.actApplyExecute(Sender: TObject);
begin
  if Assigned(Configuration) then
  begin
    Configuration.Section<TInterface>.EnableQuitConfirmation := EnableQuitConfirmation;
    Configuration.Section<TInterface>.EnableSplashAtStart := EnableSplashAtStart;
    Configuration.Section<TInterface>.EnableStatusbar := EnableStatusbar;
    Configuration.Section<TInterface>.EnableToolbar := EnableToolbar;
    Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition := EnableStoreMainFormSizesAndPosition;
    Configuration.Section<TReports>.EnableGenerateFastReportDocument := EnableGenerateFastReportDocument;
    Configuration.Section<TReports>.EnableGenerateExcelDocument := EnableGenerateExcelDocument;
    Configuration.Section<TConnection>.Server := Server;
    Configuration.Section<TConnection>.WinNTSecurity := WinNTSecurity;
    Configuration.Section<TConnection>.Login := Login;
    Configuration.Section<TConnection>.Password := Password;
    Configuration.Section<TConnection>.EnableStorePassword := EnableStorePassword;
    Configuration.Section<TConnection>.EnableEmptyPassword := EnableEmptyPassword;
    Configuration.Section<TConnection>.Database := Database;
    Configuration.Section<TOtherOptions>.EnablePlaySoundOnComplete := EnablePlaySoundOnComplete;
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
    b := not((Configuration.Section<TOtherOptions>.EnablePlaySoundOnComplete = EnablePlaySoundOnComplete) and (Configuration.Section<TInterface>.EnableQuitConfirmation = EnableQuitConfirmation) and
      (Configuration.Section<TInterface>.EnableSplashAtStart = EnableSplashAtStart) and (Configuration.Section<TInterface>.EnableStatusbar = EnableStatusbar) and (Configuration.Section<TInterface>.EnableToolbar = EnableToolbar)
      and (Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition = EnableStoreMainFormSizesAndPosition) and (Configuration.Section<TReports>.EnableGenerateFastReportDocument = EnableGenerateFastReportDocument) and
      (Configuration.Section<TReports>.EnableGenerateExcelDocument = EnableGenerateExcelDocument) and

      (Configuration.Section<TConnection>.Server = Server) and (Configuration.Section<TConnection>.WinNTSecurity = WinNTSecurity) and (Configuration.Section<TConnection>.Login = Login) and
      (Configuration.Section<TConnection>.Password = Password) and (Configuration.Section<TConnection>.EnableStorePassword = EnableStorePassword) and
      (Configuration.Section<TConnection>.EnableEmptyPassword = EnableEmptyPassword) and (Configuration.Section<TConnection>.Database = Database));
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

function TConfigurationForm.GetDatabase: string;
begin
  Result := EmptyStr;
  if cmbDatabaseName.ItemIndex > -1 then
  begin
    if cmbDatabaseName.Items.Count > cmbDatabaseName.ItemIndex then
    begin
      Result := cmbDatabaseName.Items[cmbDatabaseName.ItemIndex];
    end;
  end;
end;

procedure TConfigurationForm.GetDatabasesList(const aList: TStrings);
var
  q: TADOQuery;
  s: string;
begin
  aList.BeginUpdate;
  try
    aList.Clear;
    if cmbServers.ItemIndex > -1 then
    begin
      s := cmbServers.Items[cmbServers.ItemIndex];
    end
    else
    begin
      s := cmbServers.Text;
    end;
    ADOConnection.ConnectionString := Format(ADO_CONNECTION_STRING_PREFIX, [s]);
    if actUseWinNTSecurity.Checked then
    begin
      ADOConnection.ConnectionString := ADOConnection.ConnectionString + ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY;
    end
    else
    begin
      ADOConnection.ConnectionString := ADOConnection.ConnectionString + Format(ADO_CONNECTION_STRING_SUFFIX_USER_ID, [ebLogin.Text]);
      ADOConnection.ConnectionString := ADOConnection.ConnectionString + Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO, [BoolToStr(actEnablePasswordSaving.Checked, True)]);
      if actEnablePasswordSaving.Checked then
      begin
        ADOConnection.ConnectionString := ADOConnection.ConnectionString + Format(ADO_CONNECTION_STRING_SUFFIX_PASSWORD, [mePassword.Text]);
      end;
    end;

    ADOConnection.Connected := True;
    try
      q := TADOQuery.Create(Self);
      try
        q.Connection := ADOConnection;
        q.SQL.Text := 'SELECT sd.name FROM sys.databases sd WHERE  HAS_DBACCESS(sd.name) = 1 ORDER BY sd.name';
        q.Open;
        while not q.Eof do
        begin
          aList.Add(q.Fields[0].AsString);
          q.Next;
        end;
      finally
        q.Close;
        FreeAndNil(q);
      end;
    finally
      ADOConnection.Connected := False;
    end;
  finally
    aList.EndUpdate;
  end;
end;

function TConfigurationForm.GetEnableEmptyPassword: Boolean;
begin
  Result := chkEnableEmptyPassword.Checked and chkEnableEmptyPassword.Enabled;
end;

function TConfigurationForm.GetEnableGenerateExcelDocument: Boolean;
begin
  Result := chkEnableGenerateExcelDocument.Enabled and chkEnableGenerateExcelDocument.Checked;
end;

function TConfigurationForm.GetEnableGenerateFastReportDocument: Boolean;
begin
  Result := chkEnableGenerateFastReportDocument.Enabled and chkEnableGenerateFastReportDocument.Checked;
end;

function TConfigurationForm.GetEnablePlaySoundOnComplete: Boolean;
begin
  Result := chkEnablePlaySoundOnComplete.Enabled and chkEnablePlaySoundOnComplete.Checked;
end;

function TConfigurationForm.GetEnableQuitConfirmation: Boolean;
begin
  Result := chkEnableQuitConfirmation.Enabled and chkEnableQuitConfirmation.Checked;
end;

function TConfigurationForm.GetEnableSplashAtStart: Boolean;
begin
  Result := chkEnableSplashAtStart.Enabled and chkEnableSplashAtStart.Checked;
end;

function TConfigurationForm.GetEnableStatusbar: Boolean;
begin
  Result := chkEnableStatusbar.Enabled and chkEnableStatusbar.Checked;
end;

function TConfigurationForm.GetEnableStoreMainFormSizesAndPosition: Boolean;
begin
  Result := chkEnableStoreMainFormSizesAndPosition.Enabled and chkEnableStoreMainFormSizesAndPosition.Checked;
end;

function TConfigurationForm.GetEnableStorePassword: Boolean;
begin
  Result := chkEnableStorePassword.Checked and chkEnableStorePassword.Enabled;
end;

function TConfigurationForm.GetEnableToolbar: Boolean;
begin
  Result := chkEnableToolbar.Enabled and chkEnableToolbar.Checked;
end;

function TConfigurationForm.GetLogin: string;
begin
  Result := EmptyStr;
  if ebLogin.Enabled then
  begin
    Result := ebLogin.Text;
  end;
end;

function TConfigurationForm.GetPageCount: Integer;
begin
  Result := cmbPageName.Items.Count;
end;

function TConfigurationForm.GetPassword: string;
begin
  Result := EmptyStr;
  if mePassword.Enabled then
  begin
    Result := mePassword.Text;
  end;
end;

function TConfigurationForm.GetServer: string;
var
  s: string;
begin
  Result := EmptyStr;
  s := Trim(cmbServers.Text);
  if (s > EmptyStr) and (cmbDatabaseName.ItemIndex >= 0) then
  begin
    Result := s;
  end;
end;

procedure TConfigurationForm.GetServerList(const aList: TStrings; var ARefreshing: Boolean);
var
  aSrvs: IServerList;
  i: Integer;
  c: TCursor;
begin
  c := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ARefreshing := True;
  aList.BeginUpdate;
  try
    aList.Clear;
    aSrvs := MakeServerList('', '', SV_TYPE_SQLSERVER);
    for i := 0 to aSrvs.Count - 1 do
    begin
      // aList.AddObject(aSrvs[i].Svr_Name, TObject(aSrvs[i].svr_Type));
      aList.Add(aSrvs[i].Svr_Name);
    end;
  finally
    aList.EndUpdate;
    ARefreshing := False;
    Screen.Cursor := c;
  end;
end;

function TConfigurationForm.GetWinNTSecurity: Boolean;
begin
  Result := rbWinNTSecurity.Checked and rbWinNTSecurity.Enabled;
end;

procedure TConfigurationForm.mePasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    actRefreshDatabases.Execute;
  end;
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

procedure TConfigurationForm.SetDatabase(const AValue: string);
var
  i, j: Integer;
  s: string;
begin
  i := -1;
  s := Trim(AValue);
  for j := 0 to cmbDatabaseName.Items.Count - 1 do
  begin
    if cmbDatabaseName.Items[j] = s then
    begin
      i := j;
      Break;
    end;
  end;
  if cmbDatabaseName.ItemIndex <> i then
  begin
    cmbDatabaseName.ItemIndex := i;
  end;
end;

procedure TConfigurationForm.SetEnableEmptyPassword(const AValue: Boolean);
begin

end;

procedure TConfigurationForm.SetEnableGenerateExcelDocument(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableGenerateExcelDocument, AValue);
end;

procedure TConfigurationForm.SetEnableGenerateFastReportDocument(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableGenerateFastReportDocument, AValue);
end;

procedure TConfigurationForm.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnablePlaySoundOnComplete, AValue);
end;

procedure TConfigurationForm.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableQuitConfirmation, AValue);
end;

procedure TConfigurationForm.SetEnableSplashAtStart(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableSplashAtStart, AValue);
end;

procedure TConfigurationForm.SetEnableStatusbar(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStatusbar, AValue);
end;

procedure TConfigurationForm.SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStoreMainFormSizesAndPosition, AValue);
end;

procedure TConfigurationForm.SetEnableStorePassword(const AValue: Boolean);
begin

end;

procedure TConfigurationForm.SetEnableToolbar(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableToolbar, AValue);
end;

procedure TConfigurationForm.SetLogin(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ebLogin.Text <> s then
  begin
    ebLogin.Text := s;
  end;
end;

procedure TConfigurationForm.SetPassword(const AValue: string);
begin
  mePassword.Text := AValue;
end;

procedure TConfigurationForm.SetServer(const AValue: string);
var
  s: string;
  i, j: Integer;
begin
  i := -1;
  s := Trim(AValue);
  for j := 0 to cmbServers.Items.Count - 1 do
  begin
    if cmbServers.Items[j] = s then
    begin
      i := j;
      Break;
    end;
  end;
  if i = -1 then
  begin
    i := cmbServers.Items.Add(s);
  end;
  if cmbServers.ItemIndex <> i then
  begin
    cmbServers.ItemIndex := i;
  end;
  actRefreshDatabases.Execute;
end;

procedure TConfigurationForm.SetWinNTSecurity(const AValue: Boolean);
begin
  if AValue then
  begin
    if rbWinNTSecurity.Enabled and (not rbWinNTSecurity.Checked) then
    begin
      rbWinNTSecurity.Checked := True;
    end;
  end
  else
  begin
    if rbLoginAndPassword.Enabled and (not rbLoginAndPassword.Checked) then
    begin
      rbLoginAndPassword.Checked := True;
    end;
  end;
end;

procedure TConfigurationForm.actPreviousPageUpdate(Sender: TObject);
begin
  actPreviousPage.Enabled := PageCount > 1;
end;

procedure TConfigurationForm.actRefreshDatabasesExecute(Sender: TObject);
begin
  FRefreshingDatabases := True;
  actRefreshDatabases.Enabled := False;
  try
    try
      GetDatabasesList(cmbDatabaseName.Items);
    except
      on e: Exception do
      begin
        MessageDlg(e.Message, mtError, [mbOk], 0);
      end;
    end;
  finally
    FRefreshingDatabases := False;
  end;
end;

procedure TConfigurationForm.actRefreshServersExecute(Sender: TObject);
begin
  GetServerList(cmbServers.Items, FRefreshingServers);
end;

procedure TConfigurationForm.actUseLoginAndPasswordExecute(Sender: TObject);
begin
  //
end;

procedure TConfigurationForm.actUseWinNTSecurityExecute(Sender: TObject);
begin
  //
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

procedure TConfigurationForm.cmbServersChange(Sender: TObject);
begin
  cmbDatabaseName.Items.Clear;
end;

procedure TConfigurationForm.cmbServersDropDown(Sender: TObject);
begin
  // if cmbServers.Items.Count = 0 then
  begin
    actRefreshServers.Execute;
  end;
end;

procedure TConfigurationForm.cmbServersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    actRefreshDatabases.Execute;
  end;
end;

procedure TConfigurationForm.cmbServersSelect(Sender: TObject);
begin
  cmbServers.Text := cmbServers.Items[cmbServers.ItemIndex];
  cmbServers.Repaint;
  actRefreshDatabases.Execute;
end;

end.
