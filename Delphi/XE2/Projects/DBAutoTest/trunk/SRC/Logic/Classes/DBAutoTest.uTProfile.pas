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
    FDB: string;
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
  strict private
    function GetADOConnectionString: string;
  strict private
    FTasks: ITasks;
    function GetTasks: ITasks;
  protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading(const AIniFile: TCustomIniFile); override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving(const AIniFile: TCustomIniFile); override;
  public
//    constructor Create(const AProfileFileName: string = ''); override; final;
    property Server: string read GetServer write SetServer;
    property Login: string read GetLogin write SetLogin;
    property Database: string read GetDatabase write SetDatabase;
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

//constructor TProfile.Create(const AProfileFileName: string);
//begin
//  inherited;
//  Initialize;
//end;

procedure TProfile.Finalize;
begin
end;

function TProfile.GetADOConnectionString: string;
begin
  Result := Format(DEFAULT_ADO_CONNECTION_STRING, [Login, Database, Server]);
end;

function TProfile.GetDatabase: string;
begin
  Result := FDB;
end;

function TProfile.GetLogin: string;
begin
  Result := FLogin;
end;

function TProfile.GetServer: string;
begin
  Result := FServer;
end;

function TProfile.GetTasks: ITasks;
begin
  if not Assigned(FTasks) then
  begin
    FTasks := GetITasks;
  end;
  Result := FTasks;
end;

procedure TProfile.Initialize;
begin
  Server := DEFAULT_SERVER;
  Login := DEFAULT_LOGIN;
  Database := DEFAULT_DB;
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

end.
