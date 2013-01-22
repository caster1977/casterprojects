unit DBAutoTest.uTProfile;

interface

uses
  DBAutoTest.uIProfile,
  DBAutoTest.uITasks,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  System.Classes;

type
  TProfile = class(TInterfacedObject, IProfile, ICustomized)
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
    function GetDB: string;
    procedure SetDB(const AValue: string);
  strict private
    function GetADOConnectionString: string;
  strict private
    FTasks: ITasks;
    function GetTasks: ITasks;
  protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override;
    procedure Clear; virtual;
    property Server: string read GetServer write SetServer;
    property Login: string read GetLogin write SetLogin;
    property DB: string read GetDB write SetDB;
    property ADOConnectionString: string read GetADOConnectionString;
    property Tasks: ITasks read GetTasks;
  end;

function GetIProfile: IProfile;

implementation

uses
  System.SysUtils,
  DBAutoTest.uTTasks;

function GetIProfile: IProfile;
begin
  Result := TProfile.Create;
end;

procedure TProfile.Clear;
begin
  Initialize;
  FTasks := GetITasks;
end;

constructor TProfile.Create;
begin
  inherited;
  Initialize;
end;

destructor TProfile.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TProfile.Finalize;
begin
end;

function TProfile.GetADOConnectionString: string;
begin
  Result := Format(DEFAULT_ADO_CONNECTION_STRING, [Login, DB, Server]);
end;

function TProfile.GetDB: string;
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
  DB := DEFAULT_DB;
  FTasks := GetITasks;
end;

procedure TProfile.SetDB(const AValue: string);
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
