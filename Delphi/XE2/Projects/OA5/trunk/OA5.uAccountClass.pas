unit OA5.uAccountClass;

interface

uses
  System.SysUtils;

type
  EAccount=class(Exception);

  TPrivilegies=class
  strict private
    FEdit: boolean;
    FClear: boolean;
    FAccount: boolean;
    FReport: boolean;
    function GetAccount: boolean;
    function GetClear: boolean;
    function GetEdit: boolean;
    function GetReport: boolean;
    procedure SetAccount(const Value: boolean);
    procedure SetClear(const Value: boolean);
    procedure SetEdit(const Value: boolean);
    procedure SetReport(const Value: boolean);
  public
    constructor Create; virtual;
    property Edit: boolean read GetEdit write SetEdit default False;
    property Clear: boolean read GetClear write SetClear default False;
    property Account: boolean read GetAccount write SetAccount default False;
    property Report: boolean read GetReport write SetReport default False;
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
  FAccount:=False;
  FClear:=False;
  FEdit:=False;
  FReport:=False;
end;

function TPrivilegies.GetAccount: boolean;
begin
  Result:=FAccount;
end;

function TPrivilegies.GetClear: boolean;
begin
  Result:=FClear;
end;

function TPrivilegies.GetEdit: boolean;
begin
  Result:=FEdit;
end;

function TPrivilegies.GetReport: boolean;
begin
  Result:=FReport;
end;

procedure TPrivilegies.SetAccount(const Value: boolean);
begin
  if FAccount<>Value then
    FAccount:=Value;
end;

procedure TPrivilegies.SetClear(const Value: boolean);
begin
  if FClear<>Value then
    FClear:=Value;
end;

procedure TPrivilegies.SetEdit(const Value: boolean);
begin
  if FEdit<>Value then
    FEdit:=Value;
end;

procedure TPrivilegies.SetReport(const Value: boolean);
begin
  if FReport<>Value then
    FReport:=Value;
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
      Edit:=False;
      Clear:=False;
      Account:=False;
      Report:=False;
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
  if ((FPrivilegies.Edit<>Value.Edit)or(FPrivilegies.Clear<>Value.Clear)or(FPrivilegies.Account<>Value.Account)or(FPrivilegies.Report<>Value.Report)) then
    FPrivilegies:=Value;
end;

end.
