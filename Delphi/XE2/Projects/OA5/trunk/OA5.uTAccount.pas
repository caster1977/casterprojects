unit OA5.uTAccount;

interface

uses
  OA5.uIAccount,
  System.SysUtils,
  System.Classes,
  OA5.uIPrivilegies,
  OA5.uTPrivilegies;

type
  EAccount = class(Exception);

  TAccount = class(TInterfacedPersistent, IAccount)
  strict private
    FLogged: Boolean;
    FID: Integer;
    FLogin: string;
    FPassword: string;
    FFullname: string;
    FPosition: string;
    FPhone: string;
    FPrivilegies: IPrivilegies;
    function GetFullname: string;
    procedure SetFullname(const Value: string);
    function GetID: Integer;
    procedure SetID(const Value: Integer);
    function GetLogin: string;
    procedure SetLogin(const Value: string);
    function GetLogged: Boolean;
    procedure SetLogged(const Value: Boolean);
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    function GetPhone: string;
    procedure SetPhone(const Value: string);
    function GetPosition: string;
    procedure SetPosition(const Value: string);
    function GetPrivilegies: IPrivilegies;
    procedure SetPrivilegies(const AValue: IPrivilegies);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Logged: Boolean read GetLogged write SetLogged default False;
    property ID: Integer read GetID write SetID nodefault;
    property Login: string read GetLogin write SetLogin nodefault;
    property Password: string read GetPassword write SetPassword nodefault;
    property Fullname: string read GetFullname write SetFullname nodefault;
    property Position: string read GetPosition write SetPosition nodefault;
    property Phone: string read GetPhone write SetPhone nodefault;
    property Privilegies: IPrivilegies read GetPrivilegies write SetPrivilegies nodefault;
  end;

function GetIAccount: IAccount;

implementation

function GetIAccount: IAccount;
begin
  Result := TAccount.Create;
end;

constructor TAccount.Create;
begin
  inherited;
  FLogged := False;
  FID := 0;
  FLogin := EmptyStr;
  FPassword := EmptyStr;
  FFullname := EmptyStr;
  FPosition := EmptyStr;
  FPhone := EmptyStr;
  if not Assigned(FPrivilegies) then
    FPrivilegies := TPrivilegies.Create;
  with FPrivilegies do
  begin
    Editing := False;
    Clearing := False;
    Accounting := False;
    Reporting := False;
  end;
end;

destructor TAccount.Destroy;
begin
  FreeAndNil(FPrivilegies);
  inherited;
end;

function TAccount.GetFullname: string;
begin
  Result := FFullname;
end;

function TAccount.GetID: Integer;
begin
  Result := FID;
end;

function TAccount.GetLogged: Boolean;
begin
  Result := FLogged;
end;

function TAccount.GetLogin: string;
begin
  Result := FLogin;
end;

function TAccount.GetPassword: string;
begin
  Result := FPassword;
end;

function TAccount.GetPhone: string;
begin
  Result := FPhone;
end;

function TAccount.GetPosition: string;
begin
  Result := FPosition;
end;

function TAccount.GetPrivilegies: IPrivilegies;
begin
  Result := FPrivilegies;
end;

procedure TAccount.SetFullname(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if FFullname <> s then
    FFullname := s;
end;

procedure TAccount.SetID(const Value: Integer);
resourcestring
  TEXT_ACCOUNT_ID_ERROR = 'Идентификатор учётной записи не может быть отрицательным!';
begin
  if Value < 0 then
    raise EAccount.Create(TEXT_ACCOUNT_ID_ERROR)
  else
    if FID <> Value then
      FID := Value;
end;

procedure TAccount.SetLogged(const Value: Boolean);
begin
  if FLogged <> Value then
    FLogged := Value;
end;

procedure TAccount.SetLogin(const Value: string);
resourcestring
  TEXT_ACCOUNT_LOGIN_ERROR = 'Логин учётной записи не может быть пустым!';
var
  s: string;
begin
  s := Trim(Value);
  if s = EmptyStr then
    raise EAccount.Create(TEXT_ACCOUNT_LOGIN_ERROR)
  else
    if FLogin <> s then
      FLogin := s;
end;

procedure TAccount.SetPassword(const Value: string);
begin
  if FPassword <> Value then
    FPassword := Value;
end;

procedure TAccount.SetPhone(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if FPhone <> Value then
    FPhone := Value;
end;

procedure TAccount.SetPosition(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if FPosition <> Value then
    FPosition := Value;
end;

procedure TAccount.SetPrivilegies(const AValue: IPrivilegies);
begin
  if ((FPrivilegies.Editing <> AValue.Editing) or (FPrivilegies.Clearing <> AValue.Clearing) or (FPrivilegies.Accounting <> AValue.Accounting) or (FPrivilegies.Reporting <> AValue.Reporting)) then
    FPrivilegies := AValue;
end;

end.
