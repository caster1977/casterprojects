unit OA5.uAccountClass;

interface

uses
  System.SysUtils;

type
  EAccount=class(Exception);

  TPrivilegies=class
  strict private
    FEditing: boolean;
    FClearing: boolean;
    FAccounting: boolean;
    FReporting: boolean;
    function GetAccounting: boolean;
    function GetClearing: boolean;
    function GetEditing: boolean;
    function GetReporting: boolean;
    procedure SetAccounting(const Value: boolean);
    procedure SetClearing(const Value: boolean);
    procedure SetEditing(const Value: boolean);
    procedure SetReporting(const Value: boolean);
  public
    constructor Create; virtual;
    property Editing: boolean read GetEditing write SetEditing default False;
    property Clearing: boolean read GetClearing write SetClearing default False;
    property Accounting: boolean read GetAccounting write SetAccounting default False;
    property Reporting: boolean read GetReporting write SetReporting default False;
  end;

  TAccount=class
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
    constructor Create; virtual;
    destructor Destroy; override;
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

constructor TPrivilegies.Create;
begin
  inherited;
  FAccounting:=False;
  FClearing:=False;
  FEditing:=False;
  FReporting:=False;
end;

function TPrivilegies.GetAccounting: boolean;
begin
  Result:=FAccounting;
end;

function TPrivilegies.GetClearing: boolean;
begin
  Result:=FClearing;
end;

function TPrivilegies.GetEditing: boolean;
begin
  Result:=FEditing;
end;

function TPrivilegies.GetReporting: boolean;
begin
  Result:=FReporting;
end;

procedure TPrivilegies.SetAccounting(const Value: boolean);
begin
  if FAccounting<>Value then
    FAccounting:=Value;
end;

procedure TPrivilegies.SetClearing(const Value: boolean);
begin
  if FClearing<>Value then
    FClearing:=Value;
end;

procedure TPrivilegies.SetEditing(const Value: boolean);
begin
  if FEditing<>Value then
    FEditing:=Value;
end;

procedure TPrivilegies.SetReporting(const Value: boolean);
begin
  if FReporting<>Value then
    FReporting:=Value;
end;

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
  if not Assigned(FPrivilegies) then
    FPrivilegies:=TPrivilegies.Create;
  with FPrivilegies do
    begin
      Editing:=False;
      Clearing:=False;
      Accounting:=False;
      Reporting:=False;
    end;
end;

destructor TAccount.Destroy;
begin
  FreeAndNil(FPrivilegies);
  inherited;
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
    raise EAccount.Create(TEXT_ACCOUNT_ID_ERROR)
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
    raise EAccount.Create(TEXT_ACCOUNT_LOGIN_ERROR)
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
  if ((FPrivilegies.Editing<>Value.Editing)or(FPrivilegies.Clearing<>Value.Clearing)or(FPrivilegies.Accounting<>Value.Accounting)or(FPrivilegies.Reporting<>Value.Reporting)) then
    FPrivilegies:=Value;
end;

end.
