unit OA5.uTAccount;

interface

uses
  OA5.uIAccount,
  System.SysUtils,
  System.Classes,
  OA5.uIPrivilegies,
  OA5.uTPrivilegies,
  CastersPackage.uICustomized;

type
  EAccount = class(Exception);

  TAccount = class(TInterfacedPersistent, IAccount, ICustomized)
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
    procedure SetFullname(const AValue: string);
    function GetID: Integer;
    procedure SetID(const AValue: Integer);
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    function GetLogged: Boolean;
    procedure SetLogged(const AValue: Boolean);
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
    function GetPhone: string;
    procedure SetPhone(const AValue: string);
    function GetPosition: string;
    procedure SetPosition(const AValue: string);
    function GetPrivilegies: IPrivilegies;
    procedure SetPrivilegies(const AValue: IPrivilegies);
  protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Equals(Obj: TObject): Boolean; override;
    procedure Assign(Source: TPersistent); override;
    property Logged: Boolean read GetLogged write SetLogged default False;
    property ID: Integer read GetID write SetID nodefault;
    property Login: string read GetLogin write SetLogin nodefault;
    property Password: string read GetPassword write SetPassword nodefault;
    property Fullname: string read GetFullname write SetFullname nodefault;
    property Position: string read GetPosition write SetPosition nodefault;
    property Phone: string read GetPhone write SetPhone nodefault;
    property Privilegies: IPrivilegies read GetPrivilegies write SetPrivilegies nodefault;
  end;

  TAccountClass = class of TAccount;

function GetIAccount: IAccount;

implementation

uses
  CastersPackage.uRoutines;

resourcestring
  TEXT_ACCOUNT_ID_ERROR = 'Идентификатор учётной записи не может быть отрицательным!';
  TEXT_ACCOUNT_LOGIN_ERROR = 'Логин учётной записи не может быть пустым!';

function GetIAccount: IAccount;
begin
  Result := TAccount.Create;
end;

procedure TAccount.Assign(Source: TPersistent);
var
  o: TAccount;
begin
  if Source is TAccount then
  begin
    o := Source as TAccount;
    Logged := o.Logged;
    ID := o.ID;
    Login := o.Login;
    Password := o.Password;
    Fullname := o.Fullname;
    Position := o.Position;
    Phone := o.Phone;
    Privilegies := o.Privilegies;
  end
  else
  begin
    inherited;
  end;
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
  Initialize;
end;

destructor TAccount.Destroy;
begin
  Finalize;
  inherited;
end;

function TAccount.Equals(Obj: TObject): Boolean;
var
  o: TAccount;
begin
  Result := False;
  if Obj is TAccount then
  begin
    o := Obj as TAccount;
    Result := (Logged = o.Logged) and (ID = o.ID) and (Login = o.Login) and (Password = o.Password)
      and (Fullname = o.Fullname) and (Position = o.Position) and (Phone = o.Phone) and
      ((Privilegies as TPrivilegies).Equals(o.Privilegies as TPrivilegies));
  end
  else
  begin
    inherited;
  end;
end;

procedure TAccount.Finalize;
begin
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
  if not Assigned(FPrivilegies) then
  begin
    FPrivilegies := GetIPrivilegies;
  end;
  Result := FPrivilegies;
end;

procedure TAccount.Initialize;
begin
end;

procedure TAccount.SetFullname(const AValue: string);
begin
  Routines.SetField(AValue, FFullname);
end;

procedure TAccount.SetID(const AValue: Integer);
begin
  if AValue < 0 then
  begin
    raise EAccount.Create(TEXT_ACCOUNT_ID_ERROR);
  end
  else
  begin
    Routines.SetField(AValue, FID);
  end;
end;

procedure TAccount.SetLogged(const AValue: Boolean);
begin
  Routines.SetField(AValue, FLogged);
end;

procedure TAccount.SetLogin(const AValue: string);
begin
  if Trim(AValue) = EmptyStr then
  begin
    raise EAccount.Create(TEXT_ACCOUNT_LOGIN_ERROR);
  end
  else
  begin
    Routines.SetField(AValue, FLogin);
  end;
end;

procedure TAccount.SetPassword(const AValue: string);
begin
  Routines.SetField(AValue, FPassword);
end;

procedure TAccount.SetPhone(const AValue: string);
begin
  Routines.SetField(AValue, FPhone);
end;

procedure TAccount.SetPosition(const AValue: string);
begin
  Routines.SetField(AValue, FPosition);
end;

procedure TAccount.SetPrivilegies(const AValue: IPrivilegies);
begin
  FPrivilegies := nil;
  if Assigned(AValue) then
  begin
    if not(AValue as TPrivilegies).Equals((FPrivilegies as TPrivilegies)) then
    begin
      (FPrivilegies as TPrivilegies).Assign((AValue as TPrivilegies));
    end;
  end;
end;

end.
