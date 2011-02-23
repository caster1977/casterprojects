unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask;

type
  TLoginForm = class(TForm)
    Panel1: TPanel;
    edbxLogin: TEdit;
    edbxPassword: TMaskEdit;
    lblLogin: TLabel;
    lblPassword: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    imgKey: TImage;
    procedure edbxLoginChange(Sender: TObject);
  private
  public
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

procedure TLoginForm.edbxLoginChange(Sender: TObject);
begin
  btnOk.Enabled:=edbxLogin.Text<>'';
  btnOk.Default:=edbxLogin.Text<>'';
  btnCancel.Default:=edbxLogin.Text='';
end;

end.
