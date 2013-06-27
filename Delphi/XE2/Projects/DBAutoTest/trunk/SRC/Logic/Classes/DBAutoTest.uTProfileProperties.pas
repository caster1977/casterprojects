unit DBAutoTest.uTProfileProperties;

interface

uses
  DBAutoTest.uConsts,
  CastersPackage.uTCustomProperties,
  DBAutoTest.uIProfileProperties;

type
  TProfileProperties = class(TCustomProperties, IProfileProperties)
  strict protected
    procedure Initialize; override;
  public
    property Modified: Boolean read GetModified nodefault;

  strict private
    FEnableStoreTasks: Boolean;
    function GetEnableStoreTasks: Boolean;
    procedure SetEnableStoreTasks(const AValue: Boolean);
  public
    property EnableStoreTasks: Boolean read GetEnableStoreTasks write SetEnableStoreTasks;

  strict private
    FEnableStoreOnlyEnabledTasks: Boolean;
    function GetEnableStoreOnlyEnabledTasks: Boolean;
    procedure SetEnableStoreOnlyEnabledTasks(const AValue: Boolean);
  public
    property EnableStoreOnlyEnabledTasks: Boolean read GetEnableStoreOnlyEnabledTasks write SetEnableStoreOnlyEnabledTasks;

  strict private
    FServer: string;
    function GetServer: string;
    procedure SetServer(const AValue: string);
  public
    property Server: string read GetServer write SetServer nodefault;

  strict private
    FWinNTSecurity: Boolean;
    function GetWinNTSecurity: Boolean;
    procedure SetWinNTSecurity(const AValue: Boolean);
  public
    property WinNTSecurity: Boolean read GetWinNTSecurity write SetWinNTSecurity default PROFILE_DEFAULT_WIN_NT_SECURITY;

  strict private
    FLogin: string;
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
  public
    property Login: string read GetLogin write SetLogin nodefault;

  strict private
    FPassword: string;
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
  public
    property Password: string read GetPassword write SetPassword nodefault;

  strict private
    FEnableStorePassword: Boolean;
    function GetEnableStorePassword: Boolean;
    procedure SetEnableStorePassword(const AValue: Boolean);
  public
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword default PROFILE_DEFAULT_ENABLE_STORE_PASSWORD;

  strict private
    FDatabese: string;
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
  public
    property Database: string read GetDatabase write SetDatabase nodefault;
  end;

function GetIProfileProperties: IProfileProperties;

implementation

uses
  System.SysUtils;

function GetIProfileProperties: IProfileProperties;
begin
  Result := TProfileProperties.Create;
end;

function TProfileProperties.GetDatabase: string;
begin
  Result := FDatabese;
end;

function TProfileProperties.GetEnableStoreOnlyEnabledTasks: Boolean;
begin
  Result := FEnableStoreOnlyEnabledTasks;
end;

function TProfileProperties.GetEnableStoreTasks: Boolean;
begin
  Result := FEnableStoreTasks;
end;

function TProfileProperties.GetLogin: string;
begin
  Result := FLogin;
end;

function TProfileProperties.GetPassword: string;
begin
  Result := FPassword;
end;

function TProfileProperties.GetServer: string;
begin
  Result := FServer;
end;

function TProfileProperties.GetEnableStorePassword: Boolean;
begin
  Result := FEnableStorePassword;
end;

function TProfileProperties.GetWinNTSecurity: Boolean;
begin
  Result := FWinNTSecurity;
end;

procedure TProfileProperties.SetDatabase(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FDatabese <> s then
  begin
    FDatabese := s;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetEnableStoreOnlyEnabledTasks(const AValue: Boolean);
begin
  if FEnableStoreOnlyEnabledTasks <> AValue then
  begin
    FEnableStoreOnlyEnabledTasks := AValue;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetEnableStoreTasks(const AValue: Boolean);
begin
  if FEnableStoreTasks <> AValue then
  begin
    FEnableStoreTasks := AValue;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetLogin(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FLogin <> s then
  begin
    FLogin := s;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetPassword(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FPassword <> s then
  begin
    FPassword := s;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetServer(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FServer <> s then
  begin
    FServer := s;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetEnableStorePassword(const AValue: Boolean);
begin
  if FEnableStorePassword <> AValue then
  begin
    FEnableStorePassword := AValue;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.SetWinNTSecurity(const AValue: Boolean);
begin
  if FWinNTSecurity <> AValue then
  begin
    FWinNTSecurity := AValue;
    inherited Modified := True;
  end;
end;

procedure TProfileProperties.Initialize;
begin
  Server := PROFILE_DEFAULT_SERVER;
  Login := PROFILE_DEFAULT_LOGIN;
  Password := PROFILE_DEFAULT_PASSWORD;
  Database := PROFILE_DEFAULT_DB;
  WinNTSecurity := PROFILE_DEFAULT_WIN_NT_SECURITY;
  EnableStorePassword := PROFILE_DEFAULT_ENABLE_STORE_PASSWORD;
  EnableStoreTasks := PROFILE_DEFAULT_ENABLE_STORE_TASKS;
  EnableStoreOnlyEnabledTasks := PROFILE_DEFAULT_ENABLE_STORE_ONLY_ENABLED_TASKS;
  inherited;
end;

end.
