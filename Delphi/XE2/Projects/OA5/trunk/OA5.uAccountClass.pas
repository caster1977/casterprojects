unit OA5.uAccountClass;

interface

uses
  System.SysUtils;

type
  EAccountException=class(Exception);

  TPrivilegies=record
    Edit: boolean;
    Clear: boolean;
    Account: boolean;
    Report: boolean;
  end;

  IAccount=interface(IInterface)
    ['{1D74197E-59C0-4A84-AAA2-BFFD74A84FA3}']
    function GetLogged: boolean;
    procedure SetLogged(const Value: boolean);
    function GetFullname: string;
    function GetID: integer;
    function GetLogin: string;
    function GetPassword: string;
    function GetPhone: string;
    function GetPosition: string;
    function GetPrivilegies: TPrivilegies;
    procedure SetFullname(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetPosition(const Value: string);
    procedure SetPrivilegies(const Value: TPrivilegies);
    property Logged: boolean read GetLogged write SetLogged;
    property ID: integer read GetID write SetID;
    property Login: string read GetLogin write SetLogin;
    property Password: string read GetPassword write SetPassword;
    property Fullname: string read GetFullname write SetFullname;
    property Position: string read GetPosition write SetPosition;
    property Phone: string read GetPhone write SetPhone;
    property Privilegies: TPrivilegies read GetPrivilegies write SetPrivilegies;
  end;

  TAccount=class(TInterfacedObject, IAccount)
  strict private
    FLogged: boolean;
    FID: integer;
    FLogin: string;
    FPassword: string;
    FFullname: string;
    FPosition: string;
    FPhone: string;
    FPrivilegies: TPrivilegies;
    function GetFullname: string;
    function GetID: integer;
    function GetLogin: string;
    function GetLogged: boolean;
    function GetPassword: string;
    function GetPhone: string;
    function GetPosition: string;
    function GetPrivilegies: TPrivilegies;
    procedure SetFullname(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetLogin(const Value: string);
    procedure SetLogged(const Value: boolean);
    procedure SetPassword(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetPosition(const Value: string);
    procedure SetPrivilegies(const Value: TPrivilegies);
  public
    constructor Create;
    property Logged: boolean read GetLogged write SetLogged default False;
    property ID: integer read GetID write SetID nodefault;
    property Login: string read GetLogin write SetLogin nodefault;
    property Password: string read GetPassword write SetPassword nodefault;
    property Fullname: string read GetFullname write SetFullname nodefault;
    property Position: string read GetPosition write SetPosition nodefault;
    property Phone: string read GetPhone write SetPhone nodefault;
    property Privilegies: TPrivilegies read GetPrivilegies write SetPrivilegies nodefault;
  end;

implementation

{ TAccount }

constructor TAccount.Create;
begin
  inherited;
  FLogged:=False;
  FID:=0;
  FLogin:='';
  FPassword:='';
  FFullname:='';
  FPosition:='';
  FPhone:='';
  with FPrivilegies do
    begin
      Edit:=False;
      Clear:=False;
      Account:=False;
      Report:=False;
    end;
end;

function TAccount.GetFullname: string;
begin
  Result:=FFullname;
end;

function TAccount.GetID: integer;
begin
  Result:=FID;
end;

function TAccount.GetLogged: boolean;
begin
  Result:=FLogged;
end;

function TAccount.GetLogin: string;
begin
  Result:=FLogin;
end;

function TAccount.GetPassword: string;
begin
  Result:=FPassword;
end;

function TAccount.GetPhone: string;
begin
  Result:=FPhone;
end;

function TAccount.GetPosition: string;
begin
  Result:=FPosition;
end;

function TAccount.GetPrivilegies: TPrivilegies;
begin
  Result:=FPrivilegies;
end;

procedure TAccount.SetFullname(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FFullname<>s then
    FFullname:=s;
end;

procedure TAccount.SetID(const Value: integer);
resourcestring
  TEXT_ACCOUNT_ID_ERROR='Идентификатор учётной записи не может быть отрицательным!';
begin
  if Value<0 then
    raise EAccountException.Create(TEXT_ACCOUNT_ID_ERROR)
  else
    if FID<>Value then
      FID:=Value;
end;

procedure TAccount.SetLogged(const Value: boolean);
begin
  if FLogged<>Value then
    FLogged:=Value;
end;

procedure TAccount.SetLogin(const Value: string);
resourcestring
  TEXT_ACCOUNT_LOGIN_ERROR='Логин учётной записи не может быть пустым!';
var
  s: string;
begin
  s:=Trim(Value);
  if s='' then
    raise EAccountException.Create(TEXT_ACCOUNT_LOGIN_ERROR)
  else
    if FLogin<>s then
      FLogin:=s;
end;

procedure TAccount.SetPassword(const Value: string);
begin
  if FPassword<>Value then
    FPassword:=Value;
end;

procedure TAccount.SetPhone(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FPhone<>Value then
    FPhone:=Value;
end;

procedure TAccount.SetPosition(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FPosition<>Value then
    FPosition:=Value;
end;

procedure TAccount.SetPrivilegies(const Value: TPrivilegies);
begin
  if ((FPrivilegies.Edit<>Value.Edit)or(FPrivilegies.Clear<>Value.Clear)or(FPrivilegies.Account<>Value.Account)or(FPrivilegies.Report<>Value.Report)) then
    FPrivilegies:=Value;
end;

end.
