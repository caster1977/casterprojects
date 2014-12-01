unit LoginPackage.uTLoginForm;

interface

uses
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.Mask,
  Vcl.StdCtrls,
  System.Actions,
  Vcl.Graphics,
  Vcl.Forms;

type
  TLoginForm = class(TForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actEnter: TAction;
    actClose: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnEnter: TButton;
    btnClose: TButton;
    lblLogin: TLabel;
    edtLogin: TEdit;
    lblPassword: TLabel;
    medtPassword: TMaskEdit;
    procedure actEnterExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actEnterUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);

  strict private
    function GetLogin: string;
  public
    property Login: string read GetLogin nodefault;

  strict private
    function GetPassword: string;
  public
    property Password: string read GetPassword nodefault;
  public
    constructor Create(const AOwner: TComponent; const ALogin: string = '';
      const APassword: string = ''; const ATitle: string = ''; const AIcon: TIcon = nil;
      const AShowHelpButton: Boolean = False); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils;

const
  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;

  ICON_LOGIN = 1;

resourcestring
  RsLoginForm = 'авторизации';
  RsHelpFileNonFound = 'Извините, справочный файл к данной программе не найден.';
  RsWarning = '%s - Предупреждение';

procedure TLoginForm.actEnterExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TLoginForm.actCloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TLoginForm.actHelpExecute(Sender: TObject);
begin
  if FileExists(ExpandFileName(Application.HelpFile)) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    MessageBox(Handle, PWideChar(RsHelpFileNonFound),
      PWideChar(Format(RsWarning, [Application.Title])), MESSAGE_TYPE_ERROR);
  end;
end;

procedure TLoginForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Trim(Application.HelpFile) > EmptyStr;
  if actHelp.Enabled <> b then
  begin
    actHelp.Enabled := b;
  end;
end;

constructor TLoginForm.Create(const AOwner: TComponent; const ALogin, APassword, ATitle: string;
  const AIcon: TIcon; const AShowHelpButton: Boolean);
var
  s: string;
begin
  inherited Create(AOwner);

  actHelp.Visible := AShowHelpButton;

  s := Trim(ALogin);
  edtLogin.Text := s;
  if s > EmptyStr then
  begin
    medtPassword.Text := APassword;
  end;

  if s = EmptyStr then
  begin
    ActiveControl := edtLogin;
  end
  else
  begin
    if APassword = EmptyStr then
    begin
      ActiveControl := medtPassword;
    end
    else
    begin
      ActiveControl := btnEnter;
    end;
  end;

  s := Trim(ATitle);
  if s > EmptyStr then
  begin
    Caption := s;
  end;

  if Assigned(AIcon) then
  begin
    if AIcon.Handle > 0 then
    begin
      Icon := AIcon;
    end
    else
    begin
      ImageList.GetIcon(ICON_LOGIN, Icon);
    end;
  end
  else
  begin
    ImageList.GetIcon(ICON_LOGIN, Icon);
  end;
end;

function TLoginForm.GetLogin: string;
begin
  Result := Trim(edtLogin.Text);
end;

function TLoginForm.GetPassword: string;
begin
  Result := medtPassword.Text;
end;

procedure TLoginForm.actEnterUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Login > EmptyStr;
  if actEnter.Enabled <> b then
  begin
    actEnter.Enabled := b;
  end;
  if btnEnter.Default <> b then
  begin
    btnEnter.Default := b;
  end;
  if btnClose.Default <> (not b) then
  begin
    btnClose.Default := not b;
  end;
end;

end.
