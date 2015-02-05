unit DBUShared.uTUser;

interface

uses
  DBUShared.uIUser,
  CastersPackage.uICustomized,
  System.Classes,
  CastersPackage.uIListItemAdapter,
  Vcl.ComCtrls;

type
  TUser = class(TInterfacedObject, IUser, ICustomized, IListItemAdapter)
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override; final;

  strict private
    FLogin: string;
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
  public
    property Login: string read GetLogin write SetLogin nodefault;

  strict private
    FPasswordHash: string;
    function GetPasswordHash: string;
    procedure SetPasswordHash(const AValue: string);
  public
    property PasswordHash: string read GetPasswordHash write SetPasswordHash nodefault;

  strict private
    FFullName: string;
    function GetFullName: string;
    procedure SetFullName(const AValue: string);
  public
    property FullName: string read GetFullName write SetFullName nodefault;

  strict private
    FBlocked: Boolean;
    function GetBlocked: Boolean;
    procedure SetBlocked(const AValue: Boolean);
  public
    property Blocked: Boolean read GetBlocked write SetBlocked nodefault;

  strict private
    FAdministrator: Boolean;
    function GetAdministrator: Boolean;
    procedure SetAdministrator(const AValue: Boolean);
  public
    property Administrator: Boolean read GetAdministrator write SetAdministrator nodefault;

  public
    function ToString: string; override;
    procedure AppendToListView(const AListView: TListView); virtual;
  end;

function GetIUser: IUser; overload;
function GetIUser(const ALogin, APasswordHash, AFullName: string; const ABlocked, AAdministrator: Boolean): IUser; overload;

implementation

uses
  IdHashCRC,
  System.SysUtils,
  System.StrUtils;

resourcestring
  RsYes = 'Да';
  RsNo = 'Нет';

function GetIUser: IUser;
begin
  Result := TUser.Create;
end;

function GetIUser(const ALogin, APasswordHash, AFullName: string; const ABlocked, AAdministrator: Boolean): IUser;
begin
  Result := GetIUser;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Login := Trim(ALogin);
  Result.PasswordHash := APasswordHash;
  Result.FullName := Trim(AFullName);
  Result.Blocked := ABlocked;
  Result.Administrator := AAdministrator;
end;

procedure TUser.AppendToListView(const AListView: TListView);
var
  a: IUser;
  li: TListItem;
begin
  if not Assigned(AListView) then
  begin
    Exit;
  end;

  if not Assigned(AListView.Items) then
  begin
    Exit;
  end;

  li := AListView.Items.Add;

  if not Assigned(li) then
  begin
    Exit;
  end;

  li.Caption := Login;

  if Assigned(li.SubItems) then
  begin
    li.SubItems.Add(FullName);
    li.SubItems.Add(IfThen(Blocked, RsYes, RsNo));
    li.SubItems.Add(IfThen(Administrator, RsYes, RsNo));

    if Supports(Self, IUser, a) then
    begin
      li.Data := Pointer(a);
    end;
  end;
end;

constructor TUser.Create;
begin
  inherited;
  Initialize;
end;

destructor TUser.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TUser.Initialize;
begin
  Login := EmptyStr;
  PasswordHash := EmptyStr;
  FullName := EmptyStr;
  Blocked := False;
  Administrator := False;
end;

procedure TUser.Finalize;
begin
end;

function TUser.GetAdministrator: Boolean;
begin
  Result := FAdministrator;
end;

function TUser.GetBlocked: Boolean;
begin
  Result := FBlocked;
end;

function TUser.GetFullName: string;
begin
  Result := FFullName;
end;

function TUser.GetLogin: string;
begin
  Result := FLogin;
end;

function TUser.GetPasswordHash: string;
begin
  Result := FPasswordHash;
end;

procedure TUser.SetLogin(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FLogin <> s then
  begin
    FLogin := s;
  end;
end;

procedure TUser.SetAdministrator(const AValue: Boolean);
begin
  if FAdministrator <> AValue then
  begin
    FAdministrator := AValue;
  end;
end;

procedure TUser.SetBlocked(const AValue: Boolean);
begin
  if FBlocked <> AValue then
  begin
    FBlocked := AValue;
  end;
end;

procedure TUser.SetPasswordHash(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FPasswordHash <> s then
  begin
    FPasswordHash := s;
  end;
end;

procedure TUser.SetFullName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FFullName <> s then
  begin
    FFullName := s;
  end;
end;

function TUser.ToString: string;
begin
  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) + Format('=> Login: %s, PasswordHash: %s, FullName: %s, Blocked: %s, Administrator: %s',
    [Login, PasswordHash, FullName, BoolToStr(Blocked, True), BoolToStr(Administrator, True)]);
end;

end.
