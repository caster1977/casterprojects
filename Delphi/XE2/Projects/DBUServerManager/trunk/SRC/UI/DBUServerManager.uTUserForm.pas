unit DBUServerManager.uTUserForm;

interface

uses
  DBUShared.uIUsers,
  DBUShared.uIUser,
  CastersPackage.uICustomized,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  System.Actions,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TUserForm = class(TForm, ICustomized)
    actApply: TAction;
    actCancel: TAction;
    actDefaults: TAction_Defaults;
    actHelp: TAction_Help;
    ActionList: TActionList;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    pnlButtons: TPanel;
    ImageList: TImageList;
    grpMain: TGroupBox;
    ledLogin: TLabeledEdit;
    ledPassword: TLabeledEdit;
    ledFullName: TLabeledEdit;
    chkBlocked: TCheckBox;
    chkAdministrator: TCheckBox;
    btnNextPage: TButton;
    actGeneratePassword: TAction;
    procedure actCancelExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);

  protected
    procedure Initialize; virtual;
  strict protected
    procedure Finalize; virtual;
  protected
    constructor Create(AOwner: TComponent); override; final;
  public
    destructor Destroy; override; final;

  strict private
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    property Login: string read GetLogin write SetLogin nodefault;

  strict private
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
    property Password: string read GetPassword write SetPassword nodefault;

  strict private
    function GetPasswordHash: string;
    property PasswordHash: string read GetPasswordHash nodefault;

  strict private
    function GetFullName: string;
    procedure SetFullName(const AValue: string);
    property FullName: string read GetFullName write SetFullName nodefault;

  strict private
    function GetBlocked: Boolean;
    procedure SetBlocked(const AValue: Boolean);
    property Blocked: Boolean read GetBlocked write SetBlocked nodefault;

  strict private
    function GetAdministrator: Boolean;
    procedure SetAdministrator(const AValue: Boolean);
    property Administrator: Boolean read GetAdministrator write SetAdministrator nodefault;

  strict private
    FUser: IUser;
    function GetUser: IUser;
    procedure SetUser(const AValue: IUser);
  private
    property User: IUser read GetUser write SetUser nodefault;
  end;

function ShowUserDialog(const AOwner: TComponent; var AUser: IUser): Boolean; overload;
function ShowUserDialog(const AOwner: TComponent; const AUsers: IUsers; var AIndex: Integer): Boolean; overload;

exports //
  ShowUserDialog(const AOwner: TComponent; const AUser: IUser), //
  ShowUserDialog(const AOwner: TComponent; const AUsers: IUsers; const AIndex: Integer); //

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines,
  DBUShared.uTUser;

resourcestring
  RsAddUserCaption = 'ƒобавление пользовател€';
  RsEditUserCaption = '–едактирование данных пользовател€';

  RsAOwnerIsNil = 'AOwner is nil.';
  RsAUsersIsNil = 'AUsers is nil.';

  RsWrongAIndexValue = 'Wrong AIndex value (%d).';
  RsIUserIsNil = 'IUser is nil.';
  RsCantCreateUser = 'Ќе удалось создать пользовател€.';
  RsCantAddUserToUsers = 'Ќе удалось добавить пользовател€ в список пользователей.';

function ShowUserDialog(const AOwner: TComponent; var AUser: IUser): Boolean;
var
  form: TUserForm;
begin
  Assert(Assigned(AOwner), RsAOwnerIsNil);

  Result := False;
  try
    form := TUserForm.Create(AOwner);
    try
      form.User := AUser;
      form.Initialize;
      Result := form.ShowModal = mrOk;
      if not Result then
      begin
        Exit;
      end;
      AUser := form.User;
    finally
      form.Free;
    end;
  except
  end;
end;

function ShowUserDialog(const AOwner: TComponent; const AUsers: IUsers; var AIndex: Integer): Boolean;
var
  a: IUser;
begin
  Assert(Assigned(AUsers), RsAUsersIsNil);
  Assert(AUsers.Count > AIndex, Format(RsWrongAIndexValue, [AIndex]));

  Result := False;
  try
    if AIndex < 0 then
    begin
      a := nil;
    end
    else
    begin
      a := AUsers[AIndex];
    end;

    Result := ShowUserDialog(AOwner, a);

    if Result and (AIndex < 0) then
    begin
      AIndex := AUsers.Add(a);
      Result := AIndex >= 0;
    end;
  except
  end;
end;

procedure TUserForm.actApplyExecute(Sender: TObject);
var
  i: Integer;
begin
  if not Assigned(User) then
  begin
    User := GetIUser;
  end;

  if not Assigned(User) then
  begin
    MessageBox(Handle, PWideChar(RsCantCreateUser), PWideChar(Application.Title), MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
    Exit;
  end;

  User.Login := Login;
  User.PasswordHash := PasswordHash;
  User.FullName := FullName;
  User.Blocked := Blocked;
  User.Administrator := Administrator;

  ModalResult := mrOk;
end;

procedure TUserForm.Initialize;
begin
  Password := EmptyStr;
  if Assigned(User) then
  begin
    Caption := RsEditUserCaption;
    Login := User.Login;
    FullName := User.FullName;
    Blocked := User.Blocked;
    Administrator := User.Administrator;
  end
  else
  begin
    Caption := RsAddUserCaption;
    Login := EmptyStr;
    FullName := EmptyStr;
    Blocked := False;
    Administrator := False;
  end;
end;

constructor TUserForm.Create(AOwner: TComponent);
begin
  inherited;
  Initialize;
end;

procedure TUserForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TUserForm.Finalize;
begin
end;

destructor TUserForm.Destroy;
begin
  Finalize;
  inherited;
end;

function TUserForm.GetAdministrator: Boolean;
begin
  Result := chkAdministrator.Checked;
end;

function TUserForm.GetBlocked: Boolean;
begin
  Result := chkBlocked.Checked;
end;

function TUserForm.GetFullName: string;
begin
  Result := Trim(ledFullName.Text);
end;

function TUserForm.GetLogin: string;
begin
  Result := Trim(ledLogin.Text);
end;

function TUserForm.GetPassword: string;
begin
  Result := Trim(ledPassword.Text);
end;

function TUserForm.GetPasswordHash: string;
begin
  Result := Routines.Hash(Password);
end;

function TUserForm.GetUser: IUser;
begin
  Result := FUser;
end;

procedure TUserForm.SetAdministrator(const AValue: Boolean);
begin
  if chkAdministrator.Checked <> AValue then
  begin
    chkAdministrator.Checked := AValue;
  end;
end;

procedure TUserForm.SetBlocked(const AValue: Boolean);
begin
  if chkBlocked.Checked <> AValue then
  begin
    chkBlocked.Checked := AValue;
  end;
end;

procedure TUserForm.SetFullName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ledFullName.Text <> s then
  begin
    ledFullName.Text := s;
  end;
end;

procedure TUserForm.SetLogin(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ledLogin.Text <> s then
  begin
    ledLogin.Text := s;
  end;
end;

procedure TUserForm.SetPassword(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ledPassword.Text <> s then
  begin
    ledPassword.Text := s;
  end;
end;

procedure TUserForm.SetUser(const AValue: IUser);
begin
  if FUser <> AValue then
  begin
    FUser := AValue;
  end;
end;

end.
