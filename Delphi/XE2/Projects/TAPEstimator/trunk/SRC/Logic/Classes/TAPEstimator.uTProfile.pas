unit TAPEstimator.uTProfile;

interface

uses
  TAPEstimator.uIProfile,
  TAPEstimator.uConsts,
  CastersPackage.uICustomized,
  CastersPackage.uTIniFileDataStorage,
  System.IniFiles;

type
  TProfile = class(TIniFileDataStorage, IProfile)
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
    FWinNTSecurity: Boolean;
    function GetWinNTSecurity: Boolean;
    procedure SetWinNTSecurity(const AValue: Boolean);
  strict private
    FStorePassword: Boolean;
    function GetStorePassword: Boolean;
    procedure SetStorePassword(const AValue: Boolean);
  strict protected
    procedure Initialize; override;
    procedure Loading; override;
    procedure Saving; override;
  public
    constructor Create(const AProfileFileName: string = ''); override;
    property Server: string read GetServer write SetServer nodefault;
    property Login: string read GetLogin write SetLogin nodefault;
    property Password: string read GetPassword write SetPassword nodefault;
    property Database: string read GetDatabase write SetDatabase nodefault;
    property WinNTSecurity: Boolean read GetWinNTSecurity write SetWinNTSecurity
      default PROFILE_DEFAULT_WIN_NT_SECURITY;
    property StorePassword: Boolean read GetStorePassword write SetStorePassword default PROFILE_DEFAULT_STORE_PASSWORD;
    property ADOConnectionString: string read GetADOConnectionString nodefault;
    property Modified: Boolean read GetModified nodefault;
  end;

function GetIProfile(const AProfileFileName: string = ''): IProfile;

implementation

uses
  System.Classes,
  System.SysUtils,
  TAPEstimator.uEProfile;

resourcestring
  RsProfileSaveError = 'Произошла ошибка при попытке записи настроек профиля в файл!';

function GetIProfile(const AProfileFileName: string): IProfile;
begin
  Result := TProfile.Create(AProfileFileName);
end;

constructor TProfile.Create(const AProfileFileName: string);
begin
  inherited;
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
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO, [BoolToStr(StorePassword, True)]);
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

function TProfile.GetWinNTSecurity: Boolean;
begin
  Result := FWinNTSecurity;
end;

procedure TProfile.SetDatabase(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FDB <> s then
  begin
    FDB := s;
    inherited Modified := True;
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
    inherited Modified := True;
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
    inherited Modified := True;
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
    inherited Modified := True;
  end;
end;

procedure TProfile.SetStorePassword(const AValue: Boolean);
begin
  if FStorePassword <> AValue then
  begin
    FStorePassword := AValue;
    inherited Modified := True;
  end;
end;

procedure TProfile.SetWinNTSecurity(const AValue: Boolean);
begin
  if FWinNTSecurity <> AValue then
  begin
    FWinNTSecurity := AValue;
    inherited Modified := True;
  end;
end;

procedure TProfile.Initialize;
begin
  inherited;
  Server := PROFILE_DEFAULT_SERVER;
  Login := PROFILE_DEFAULT_LOGIN;
  Password := PROFILE_DEFAULT_PASSWORD;
  Database := PROFILE_DEFAULT_DB;
  WinNTSecurity := PROFILE_DEFAULT_WIN_NT_SECURITY;
end;

procedure TProfile.Loading;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
    begin

    end;
  end;
end;

procedure TProfile.Saving;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
      try

      except
        on EIniFileException do
        begin
          raise EProfile.Create(RsProfileSaveError);
        end;
      end;
  end;
end;

initialization

begin
  RegisterClass(TProfile);
end;

end.
