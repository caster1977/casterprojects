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

const
  DEFAULT_LOGIN = '';
  DEFAULT_FULL_NAME = '';
  DEFAULT_ADMINISTRATOR = False;
  DEFAULT_BLOCKED = False;

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
    ledFullName: TLabeledEdit;
    chkBlocked: TCheckBox;
    chkAdministrator: TCheckBox;
    btnPassword: TButton;
    actPassword: TAction;
    procedure actCancelExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actPasswordExecute(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);
    procedure actDefaultsUpdate(Sender: TObject);
    procedure actDefaultsExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);

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
    FPasswordHash: string;
    function GetPasswordHash: string;
    procedure SetPasswordHash(const AValue: string);
    property PasswordHash: string read GetPasswordHash write SetPasswordHash nodefault;

  strict private
    function GetFullName: string;
    procedure SetFullName(const AValue: string);
    property FullName: string read GetFullName write SetFullName nodefault;

  strict private
    function GetBlocked: Boolean;
    procedure SetBlocked(const AValue: Boolean);
    property Blocked: Boolean read GetBlocked write SetBlocked default DEFAULT_BLOCKED;

  strict private
    function GetAdministrator: Boolean;
    procedure SetAdministrator(const AValue: Boolean);
    property Administrator: Boolean read GetAdministrator write SetAdministrator default DEFAULT_ADMINISTRATOR;

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
  ShowUserDialog(const AOwner: TComponent; const AUser: IUser)name 'ShowUserDialogByObject', //
  ShowUserDialog(const AOwner: TComponent; const AUsers: IUsers; const AIndex: Integer)name 'ShowUserDialogByObjectList'; //

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines,
  DBUShared.uTUser,
  DBUServerManager.uTPasswordForm;

resourcestring
  RsAddUserCaption = 'Добавление пользователя';
  RsEditUserCaption = 'Редактирование данных пользователя';

  RsAOwnerIsNil = 'AOwner is nil.';
  RsAUsersIsNil = 'AUsers is nil.';

  RsWrongAIndexValue = 'Wrong AIndex value (%d).';
  RsIUserIsNil = 'IUser is nil.';
  RsCantCreateUser = 'Не удалось создать пользователя.';
  RsCantAddUserToUsers = 'Не удалось добавить пользователя в список пользователей.';

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
      if Assigned(form.User) then
      begin
        form.ActiveControl := form.ledFullName;
      end
      else
      begin
        form.ActiveControl := form.ledLogin;
      end;
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
  if PasswordHash <> DEFAULT_PASSWORD then // если пароль был изменён, значит записываем его хэш
  begin
    User.PasswordHash := PasswordHash;
  end;
  User.FullName := FullName;
  User.Blocked := Blocked;
  User.Administrator := Administrator;

  ModalResult := mrOk;
end;

procedure TUserForm.Initialize;
begin
  if Assigned(User) then
  begin
    Caption := RsEditUserCaption;
    Login := User.Login;
    PasswordHash := User.PasswordHash;
    FullName := User.FullName;
    Blocked := User.Blocked;
    Administrator := User.Administrator;
  end
  else
  begin
    Caption := RsAddUserCaption;
    Login := DEFAULT_LOGIN;
    PasswordHash := EmptyStr;
    FullName := DEFAULT_FULL_NAME;
    Blocked := DEFAULT_BLOCKED;
    Administrator := DEFAULT_ADMINISTRATOR;
  end;
end;

constructor TUserForm.Create(AOwner: TComponent);
begin
  inherited;
  Initialize;
end;

procedure TUserForm.actApplyUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  try
    if Login = EmptyStr then
    begin
      Exit;
    end;

    if not Assigned(User) then
    begin
      if PasswordHash = EmptyStr then
      begin
        Exit;
      end;
    end;

    b := True;
  finally
    (Sender as TAction).Enabled := b;
  end;
end;

procedure TUserForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TUserForm.actDefaultsExecute(Sender: TObject);
begin
  Initialize;
end;

procedure TUserForm.actDefaultsUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  try
    if not Assigned(User) then
    begin
      if Login <> DEFAULT_LOGIN then
      begin
        b := True;
      end;
      if FullName <> DEFAULT_FULL_NAME then
      begin
        b := True;
      end;
      if Administrator <> DEFAULT_ADMINISTRATOR then
      begin
        b := True;
      end;
      if Blocked <> DEFAULT_BLOCKED then
      begin
        b := True;
      end;
      if PasswordHash <> EmptyStr then
      begin
        b := True;
      end;
    end;
  finally
    (Sender as TAction).Enabled := b;
  end;
end;

procedure TUserForm.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  ledLogin.Enabled := not Assigned(User);
end;

procedure TUserForm.actPasswordExecute(Sender: TObject);
var
  pwdh: string;
begin
  pwdh := EmptyStr;
  if not ShowPasswordForm(Self, pwdh) then
  begin
    Exit;
  end;
  PasswordHash := pwdh;
//  ShowMessage('Пароль успешно изменён');
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

function TUserForm.GetPasswordHash: string;
begin
  Result := FPasswordHash;
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

procedure TUserForm.SetPasswordHash(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FPasswordHash <> s then
  begin
    FPasswordHash := s;
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
