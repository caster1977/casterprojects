unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Main;

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
    procedure FormCreate(Sender: TObject);
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

procedure TLoginForm.FormCreate(Sender: TObject);
var
  pwcGroupName: PWideChar;
begin
  GetMem(pwcGroupName, SizeOf(WideChar)*1000);
  try
    SendMessage(edbxLogin.Handle,EM_SETCUEBANNER,WPARAM(0),LPARAM(StringToWideChar('¬ведите логин', pwcGroupName, 1000)));
  finally
    FreeMem(pwcGroupName);
  end;
  GetMem(pwcGroupName, SizeOf(WideChar)*1000);
  try
    SendMessage(edbxPassword.Handle,EM_SETCUEBANNER,WPARAM(0),LPARAM(StringToWideChar('¬ведите пароль', pwcGroupName, 1000)));
  finally
    FreeMem(pwcGroupName);
  end;
end;

end.
