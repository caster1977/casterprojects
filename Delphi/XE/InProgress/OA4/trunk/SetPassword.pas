unit SetPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask;

type
  TSetPasswordForm = class(TForm)
    Panel1: TPanel;
    edbxPassword: TEdit;
    edbxConfirmation: TMaskEdit;
    lblPassword: TLabel;
    lblConfirmation: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    imgKey: TImage;
    chkbxShowPassword: TCheckBox;
    procedure chkbxShowPasswordClick(Sender: TObject);
    procedure chkbxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetPasswordForm: TSetPasswordForm;

implementation

{$R *.dfm}

procedure TSetPasswordForm.chkbxChange(Sender: TObject);
begin
  btnOk.Enabled:=edbxPassword.Text=edbxConfirmation.Text;
end;

procedure TSetPasswordForm.chkbxShowPasswordClick(Sender: TObject);
begin
  if chkbxShowPassword.Checked then
    begin
      edbxPassword.PasswordChar:=#0;
      edbxConfirmation.PasswordChar:=#0;
    end
  else
    begin
      edbxPassword.PasswordChar:='*';
      edbxConfirmation.PasswordChar:='*';
    end;
end;

end.
