unit OA5User;

interface

type
  TUser=class
  strict private
    FLogged: boolean;
    FID: integer;
    FLogin: string;
    FPassword: string;
    FFullname: string;
    FPosition: string;
    FPhone: string;
    FEditor: boolean;
    FAdministrator: boolean;
    procedure SetLogged(const Value: boolean);
    procedure SetID(const Value: integer);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPhone(const Value: string);
  public
    property Logged: boolean read FLogged write SetLogged default False;
    property ID: integer read FID write SetID nodefault;
    property Login: string read FLogin write SetLogin nodefault;
    property Password: string read FPassword write SetPassword nodefault;
    property Fullname: string read FFullname write FFullname nodefault;
    property Position: string read FPosition write FPosition nodefault;
    property Phone: string read FPhone write SetPhone nodefault;
    property Editor: boolean read FEditor write FEditor default False;
    property Administrator: boolean read FAdministrator write FAdministrator default False;
    constructor Create;
  end;

implementation

uses
  SysUtils;

constructor TUser.Create;
begin
  inherited;
  FLogged:=False;
  FID:=0;
  FLogin:='';
  FPassword:='';
  FFullname:='';
  FPosition:='';
  FPhone:='';
  FEditor:=False;
  FAdministrator:=False;
end;

procedure TUser.SetID(const Value: integer);
begin
  if Value<0 then
    raise Exception.Create('Идентификатор пользователя не может быть отрицательным!')
  else
    FID:=Value;
end;

procedure TUser.SetLogged(const Value: boolean);
begin
  FLogged:=Value;
end;

procedure TUser.SetLogin(const Value: string);
begin
  if Trim(Value)='' then
    raise Exception.Create('Логин пользователя не может быть пустым!')
  else
    FLogin:=Value;
end;

procedure TUser.SetPassword(const Value: string);
begin
  FPassword:=Value;
end;

procedure TUser.SetPhone(const Value: string);
begin
  FPhone:=Value;
end;

end.
