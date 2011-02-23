unit Login;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Mask;

type
  TLoginForm= class(TForm)
    lblLogin: TLabel;
    edbxLogin: TEdit;
    lblPassword: TLabel;
    edbxPassword: TMaskEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure edbxPasswordKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edbxLoginKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edbxLoginChange(Sender: TObject);
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

procedure TLoginForm.edbxLoginChange(Sender: TObject);
begin
  btnOk.Enabled:=edbxLogin.Text<>'';
  // btnOk.Default:=edbxLogin.Text<>'';
  // btnCancel.Default:=edbxLogin.Text='';
end;

procedure TLoginForm.edbxLoginKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if edbxLogin.Text<>'' then
    if Key=VK_RETURN then
      edbxPassword.SetFocus;
end;

procedure TLoginForm.edbxPasswordKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if edbxLogin.Text<>'' then
    if Key=VK_RETURN then
      ModalResult:=mrOk;
end;

procedure TLoginForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F1 then
    edbxLogin.SetFocus;
  if Key=VK_F2 then
    edbxPassword.SetFocus;
end;

end.
