unit LoginPackage.UI.TLoginForm;

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
    chkWindowsAuthentification: TCheckBox;
    actWindowsAuthentification: TAction;
    procedure actEnterExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actEnterUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure actWindowsAuthentificationExecute(Sender: TObject);

  strict private
    function GetLogin(): string;
  public
    property Login: string read GetLogin nodefault;

  strict private
    function GetPassword(): string;
  public
    property Password: string read GetPassword nodefault;

  strict private
    function GetWindowsAuthentification(): Boolean;
  public
    property WindowsAuthentification: Boolean read GetWindowsAuthentification nodefault;

  public
    constructor Create(const aOwner: TComponent; const aLogin: string = ''; const aPassword: string = ''; const aWindowsAuthentification: Boolean = True;
      const aTitle: string = ''; const aIcon: TIcon = nil; const aShowHelpButton: Boolean = False); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils;

const
  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;

  ICON_LOGIN = 0;

resourcestring
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
    MessageBox(Handle, PWideChar(RsHelpFileNonFound), PWideChar(Format(RsWarning, [Application.Title])), MESSAGE_TYPE_ERROR);
  end;
end;

procedure TLoginForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := not Application.HelpFile.Trim().IsEmpty();
  if actHelp.Enabled <> b then
  begin
    actHelp.Enabled := b;
  end;
end;

procedure TLoginForm.actWindowsAuthentificationExecute(Sender: TObject);
var
  b: Boolean;
begin
  b := not actWindowsAuthentification.Checked;

  if lblPassword.Enabled <> b then
  begin
    lblPassword.Enabled := b;
  end;

  if medtPassword.Enabled <> b then
  begin
    medtPassword.Enabled := b;
    if not medtPassword.Enabled then
    begin
      medtPassword.Clear();
    end;
  end;
end;

constructor TLoginForm.Create(const aOwner: TComponent; const aLogin, aPassword: string; const aWindowsAuthentification: Boolean; const aTitle: string;
  const aIcon: TIcon; const aShowHelpButton: Boolean);
var
  s: string;
begin
  inherited Create(aOwner);

  actHelp.Visible := aShowHelpButton;
  actWindowsAuthentification.Checked := aWindowsAuthentification;
  lblPassword.Enabled := not aWindowsAuthentification;
  medtPassword.Enabled := not aWindowsAuthentification;

  s := aLogin.Trim();
  edtLogin.Text := s;
  if not s.IsEmpty() then
  begin
    medtPassword.Text := aPassword;
  end;

  if s.IsEmpty() then
  begin
    ActiveControl := edtLogin;
  end
  else
  begin
    if actWindowsAuthentification.Checked then
    begin
      ActiveControl := btnEnter;
    end
    else
    begin
      if aPassword.IsEmpty() then
      begin
        ActiveControl := medtPassword;
      end
      else
      begin
        ActiveControl := btnEnter;
      end;
    end;
  end;

  s := aTitle.Trim();
  if not s.IsEmpty() then
  begin
    Caption := s;
  end;

  if Assigned(aIcon) then
  begin
    if aIcon.Handle > 0 then
    begin
      Icon := aIcon;
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

function TLoginForm.GetLogin(): string;
begin
  Result := Trim(edtLogin.Text);
end;

function TLoginForm.GetPassword(): string;
begin
  Result := medtPassword.Text;
end;

function TLoginForm.GetWindowsAuthentification(): Boolean;
begin
  Result := actWindowsAuthentification.Checked;
end;

procedure TLoginForm.actEnterUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := (not Login.IsEmpty()) and ((not Password.IsEmpty()) or (actWindowsAuthentification.Checked));
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
