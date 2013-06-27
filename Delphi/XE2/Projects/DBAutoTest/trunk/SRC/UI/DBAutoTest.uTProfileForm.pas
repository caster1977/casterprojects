unit DBAutoTest.uTProfileForm;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.StdActns,
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Mask,
  Vcl.ComCtrls,
  Vcl.ImgList,
  DBAutoTest.uConsts,
  DBAutoTest.uIProfileProperties;

type
  TProfileForm = class(TForm, IProfileProperties)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    ActionList: TActionList;
    actApply: TAction;
    actCancel: TAction;
    gbConnection: TGroupBox;
    lblServerName: TLabel;
    cmbServers: TComboBox;
    lblDatabaseName: TLabel;
    cmbDatabaseName: TComboBox;
    lblLogin: TLabel;
    lblPassword: TLabel;
    ebLogin: TEdit;
    mePassword: TMaskEdit;
    ADOConnection: TADOConnection;
    rbWinNTSecurity: TRadioButton;
    lblSecurity: TLabel;
    rbLoginAndPassword: TRadioButton;
    actRefreshDatabases: TAction;
    chkEnableEmptyPassword: TCheckBox;
    chkEnableStorePassword: TCheckBox;
    actUseWinNTSecurity: TAction;
    gbTop: TGroupBox;
    cmbPageName: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    PageControl: TPageControl;
    tsConnection: TTabSheet;
    ImageList: TImageList;
    actDefaults: TAction_Defaults;
    actPreviousPage: TAction_PreviousPage;
    actNextPage: TAction_NextPage;
    pnlTop: TPanel;
    actUseLoginAndPassword: TAction;
    actEnablePasswordSaving: TAction;
    actEnableEmptyPassword: TAction;
    btnRefreshServers: TButton;
    actRefreshServers: TAction;
    btnRefreshDatabases: TButton;
    actHelp: TAction_Help;
    tsSaving: TTabSheet;
    gbSaving: TGroupBox;
    cmbEnableStoreTasks: TCheckBox;
    cmbEnableStoreOnlyEnabledTasks: TCheckBox;
    actEnableStoreTasks: TAction;
    actEnableStoreOnlyEnabledTasks: TAction;
    procedure actUseWinNTSecurityExecute(Sender: TObject);
    procedure actUseLoginAndPasswordExecute(Sender: TObject);
    procedure actEnableEmptyPasswordExecute(Sender: TObject);
    procedure actEnablePasswordSavingExecute(Sender: TObject);
    procedure cmbServersDropDown(Sender: TObject);
    procedure cmbServersSelect(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
    procedure actRefreshServersExecute(Sender: TObject);
    procedure cmbServersChange(Sender: TObject);
    procedure cmbServersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actDefaultsExecute(Sender: TObject);
    procedure actRefreshDatabasesExecute(Sender: TObject);
    procedure ebLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mePasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actEnableStoreTasksExecute(Sender: TObject);
    procedure actEnableStoreOnlyEnabledTasksExecute(Sender: TObject);
  strict private
    FRefreshingServers: Boolean;
    FRefreshingDatabases: Boolean;
    procedure GetServerList(const aList: TStrings; var ARefreshing: Boolean);
    procedure GetDatabasesList(const aList: TStrings);
  public
    constructor Create(AOwner: TComponent; const AActivePage: Integer = PROFILE_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;

  strict private
    function GetActivePage: Integer;
    procedure SetActivePage(const AValue: Integer);
    property ActivePage: Integer read GetActivePage write SetActivePage default PROFILE_DEFAULT_ACTIVE_PAGE;

  strict private
    function GetPageCount: Integer;
    property PageCount: Integer read GetPageCount nodefault;

  strict private
    function GetEnableStoreTasks: Boolean;
    procedure SetEnableStoreTasks(const AValue: Boolean);
    property EnableStoreTasks: Boolean read GetEnableStoreTasks write SetEnableStoreTasks;

  strict private
    function GetEnableStoreOnlyEnabledTasks: Boolean;
    procedure SetEnableStoreOnlyEnabledTasks(const AValue: Boolean);
    property EnableStoreOnlyEnabledTasks: Boolean read GetEnableStoreOnlyEnabledTasks write SetEnableStoreOnlyEnabledTasks;

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
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
    property Database: string read GetDatabase write SetDatabase;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.UNetSrvList;

constructor TProfileForm.Create(AOwner: TComponent; const AActivePage: Integer);
begin
  inherited Create(AOwner);
  ActivePage := AActivePage;
  FRefreshingServers := False;
  FRefreshingDatabases := False;
end;

procedure TProfileForm.ebLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    actRefreshDatabases.Execute;
  end;
end;

procedure TProfileForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TProfileForm.actNextPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage + 1;
end;

procedure TProfileForm.actNextPageUpdate(Sender: TObject);
begin
  actNextPage.Enabled := PageCount > 1;
end;

procedure TProfileForm.actPreviousPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage - 1;
end;

procedure TProfileForm.actPreviousPageUpdate(Sender: TObject);
begin
  actPreviousPage.Enabled := PageCount > 1;
end;

function TProfileForm.GetActivePage: Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TProfileForm.GetPageCount: Integer;
begin
  Result := cmbPageName.Items.Count;
end;

function TProfileForm.GetPassword: string;
begin
end;

procedure TProfileForm.SetActivePage(const AValue: Integer);
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

procedure TProfileForm.SetDatabase(const AValue: string);
begin

end;

procedure TProfileForm.SetEnableStoreOnlyEnabledTasks(const AValue: Boolean);
begin

end;

procedure TProfileForm.SetEnableStorePassword(const AValue: Boolean);
begin

end;

procedure TProfileForm.SetEnableStoreTasks(const AValue: Boolean);
begin

end;

procedure TProfileForm.SetLogin(const AValue: string);
begin

end;

procedure TProfileForm.SetPassword(const AValue: string);
begin

end;

procedure TProfileForm.SetServer(const AValue: string);
begin

end;

procedure TProfileForm.SetWinNTSecurity(const AValue: Boolean);
begin

end;

procedure TProfileForm.cmbPageNameSelect(Sender: TObject);
begin
  ActivePage := cmbPageName.ItemIndex;
end;

procedure TProfileForm.actEnablePasswordSavingExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actEnableStoreOnlyEnabledTasksExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actEnableStoreTasksExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actDefaultsExecute(Sender: TObject);
begin
  if PageControl.ActivePage = tsConnection then
  begin
  end;
  if PageControl.ActivePage = tsSaving then
  begin
    { EnablePlaySoundOnComplete := PROFILE_DEFAULT_STORE_TASKS;
      PROFILE_DEFAULT_STORE_ONLY_ENABLED_TASKS; }
  end;
end;

procedure TProfileForm.actEnableEmptyPasswordExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actUseLoginAndPasswordExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actUseWinNTSecurityExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.cmbServersChange(Sender: TObject);
begin
  cmbDatabaseName.Items.Clear;
end;

procedure TProfileForm.cmbServersDropDown(Sender: TObject);
begin
  if cmbServers.Items.Count = 0 then
  begin
    actRefreshServers.Execute;
  end;
end;

function TProfileForm.GetServer: string;
begin

end;

procedure TProfileForm.GetServerList(const aList: TStrings; var ARefreshing: Boolean);
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

function TProfileForm.GetWinNTSecurity: Boolean;
begin
  Result := rbWinNTSecurity.Checked and rbWinNTSecurity.Enabled;
end;

procedure TProfileForm.mePasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    actRefreshDatabases.Execute;
  end;
end;

function TProfileForm.GetDatabase: string;
begin

end;

procedure TProfileForm.GetDatabasesList(const aList: TStrings);
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

function TProfileForm.GetEnableStoreOnlyEnabledTasks: Boolean;
begin
  Result := cmbEnableStoreOnlyEnabledTasks.Checked and cmbEnableStoreOnlyEnabledTasks.Enabled;
end;

function TProfileForm.GetEnableStorePassword: Boolean;
begin

end;

function TProfileForm.GetEnableStoreTasks: Boolean;
begin
  Result := cmbEnableStoreTasks.Checked and cmbEnableStoreTasks.Enabled;
end;

function TProfileForm.GetLogin: string;
begin

end;

procedure TProfileForm.actRefreshServersExecute(Sender: TObject);
begin
  GetServerList(cmbServers.Items, FRefreshingServers);
end;

procedure TProfileForm.actRefreshDatabasesExecute(Sender: TObject);
begin
  FRefreshingDatabases := True;
  actRefreshDatabases.Enabled := False;
  try
    GetDatabasesList(cmbDatabaseName.Items);
  finally
    FRefreshingDatabases := False;
  end;
end;

procedure TProfileForm.cmbServersSelect(Sender: TObject);
begin
  cmbServers.Text := cmbServers.Items[cmbServers.ItemIndex];
  cmbServers.Repaint;
  actRefreshDatabases.Execute;
end;

procedure TProfileForm.cmbServersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    actRefreshDatabases.Execute;
  end;
end;

procedure TProfileForm.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
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

  actEnableStoreOnlyEnabledTasks.Enabled := actEnableStoreTasks.Checked;
  actEnableStoreOnlyEnabledTasks.Checked := actEnableStoreOnlyEnabledTasks.Checked and actEnableStoreOnlyEnabledTasks.Enabled;
end;

end.
