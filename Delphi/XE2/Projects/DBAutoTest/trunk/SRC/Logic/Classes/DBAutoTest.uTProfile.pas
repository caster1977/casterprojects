unit DBAutoTest.uTProfile;

interface

uses
  DBAutoTest.uIProfile,
  DBAutoTest.uITasks,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  CastersPackage.uTIniFileDataStorage,
  System.IniFiles,
  System.Classes;

type
  TProfile = class(TIniFileDataStorage, IProfile, ICustomized)
  strict private
    FServer: string;
    function GetServer: string;
    procedure SetServer(const AValue: string);
  strict private
    FLogin: string;
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
  strict private
    FPassword: string;
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
  strict private
    FDB: string;
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
  strict private
    function GetADOConnectionString: string;
  strict private
    FTasks: ITasks;
    function GetTasks: ITasks;
  strict private
    FWinNTSecurity: Boolean;
    function GetWinNTSecurity: Boolean;
    procedure SetWinNTSecurity(const AValue: Boolean);
  strict private
    FStorePassword: Boolean;
    function GetStorePassword: Boolean;
    procedure SetStorePassword(const AValue: Boolean);
  protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading(const AIniFile: TCustomIniFile); override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving(const AIniFile: TCustomIniFile); override;
  public
    constructor Create(const AProfileFileName: string = ''); override;
    property Server: string read GetServer write SetServer;
    property Login: string read GetLogin write SetLogin;
    property Password: string read GetPassword write SetPassword;
    property Database: string read GetDatabase write SetDatabase;
    property WinNTSecurity: Boolean read GetWinNTSecurity write SetWinNTSecurity;
    property StorePassword: Boolean read GetStorePassword write SetStorePassword;
    property ADOConnectionString: string read GetADOConnectionString;
    property Tasks: ITasks read GetTasks;
  end;

function GetIProfile(const AProfileFileName: string = ''): IProfile;

implementation

uses
  System.SysUtils,
  DBAutoTest.uTTasks;

function GetIProfile(const AProfileFileName: string): IProfile;
begin
  Result := TProfile.Create(AProfileFileName);
end;

procedure TProfile.AfterLoad;
begin
  inherited;

end;

procedure TProfile.BeforeSave;
begin
  inherited;

end;

constructor TProfile.Create(const AProfileFileName: string);
begin
  inherited;
  Initialize;
end;

procedure TProfile.Finalize;
begin
end;

function TProfile.GetADOConnectionString: string;
begin
  Result := Format(ADO_CONNECTION_STRING_PREFIX, [Server]);

  if WinNTSecurity then
  begin
    Result := Result + ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY;
  end
  else
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_USER_ID, [Login]);
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO,
      [BoolToStr(StorePassword, True)]);
    if StorePassword then
    begin
      Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PASSWORD, [Password]);
    end;
  end;
  if Database > EmptyStr then
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_INITIAL_CATALOG, [Database]);
  end;
end;

function TProfile.GetDatabase: string;
begin
  Result := FDB;
end;

function TProfile.GetLogin: string;
begin
  Result := FLogin;
end;

function TProfile.GetPassword: string;
begin
  Result := FPassword;
end;

function TProfile.GetServer: string;
begin
  Result := FServer;
end;

function TProfile.GetStorePassword: Boolean;
begin
  Result := FStorePassword;
end;

function TProfile.GetTasks: ITasks;
begin
  if not Assigned(FTasks) then
  begin
    FTasks := GetITasks;
  end;
  Result := FTasks;
end;

function TProfile.GetWinNTSecurity: Boolean;
begin
  Result := FWinNTSecurity;
end;

procedure TProfile.Initialize;
begin
  Server := DEFAULT_SERVER;
  Login := DEFAULT_LOGIN;
  Password := DEFAULT_PASSWORD;
  Database := DEFAULT_DB;
  WinNTSecurity := DEFAULT_WIN_NT_SECURITY;
  FTasks := GetITasks;
end;

procedure TProfile.Loading(const AIniFile: TCustomIniFile);
begin
  inherited;

end;

procedure TProfile.Saving(const AIniFile: TCustomIniFile);
begin
  inherited;

end;

procedure TProfile.SetDatabase(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FDB <> s then
  begin
    FDB := s;
  end;
end;

procedure TProfile.SetLogin(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FLogin <> s then
  begin
    FLogin := s;
  end;
end;

procedure TProfile.SetPassword(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FPassword <> s then
  begin
    FPassword := s;
  end;
end;

procedure TProfile.SetServer(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FServer <> s then
  begin
    FServer := s;
  end;
end;

procedure TProfile.SetStorePassword(const AValue: Boolean);
begin
  if FStorePassword <> AValue then
  begin
    FStorePassword := AValue;
  end;
end;

procedure TProfile.SetWinNTSecurity(const AValue: Boolean);
begin
  if FWinNTSecurity <> AValue then
  begin
    FWinNTSecurity := AValue;
  end;
end;

end.
