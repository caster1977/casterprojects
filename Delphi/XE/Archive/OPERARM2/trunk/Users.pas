unit Users;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls;

type
  TUsersForm= class(TForm)
    GB_UpdateUser: TGroupBox;
    CB_UsrOperator: TCheckBox;
    CB_UsrAdministrator: TCheckBox;
    LABEL_RID: TLabel;
    LABEL_Login: TLabel;
    LABEL_Pwd: TLabel;
    LABEL_RealName: TLabel;
    BUTTON_Apply: TButton;
    BUTTON_Cancel: TButton;
    BUTTON_Help: TButton;
    EDIT_UsrLogin: TEdit;
    EDIT_UsrPwd: TEdit;
    EDIT_UsrRealName: TEdit;
    EDIT_UsrRID: TEdit;
    procedure BUTTON_ApplyClick(Sender: TObject);
    procedure EDIT_UsrLoginChange(Sender: TObject);
    procedure EDIT_UsrRIDChange(Sender: TObject);
    procedure EDIT_UsrPwdChange(Sender: TObject);
    procedure EDIT_UsrRealNameChange(Sender: TObject);
  end;

var
  UsersForm: TUsersForm;

implementation

{$R *.DFM}

procedure TUsersForm.BUTTON_ApplyClick(Sender: TObject);
begin
  if EDIT_UsrLogin.Text='' then
    begin
      MessageDlg('Вы должны обязательно задать ЛОГИН пользователя!', mtWarning, [mbOk], 0);
      EDIT_UsrLogin.SetFocus;
    end
  else
    if EDIT_UsrRealName.Text='' then
      begin
        MessageDlg('Вы должны обязательно задать ИМЯ пользователя!', mtWarning, [mbOk], 0);
        EDIT_UsrRealName.SetFocus;
      end;
  if (EDIT_UsrLogin.Text<>'')and(EDIT_UsrRealName.Text<>'') then
    ModalResult:=mrOk;
end;

procedure TUsersForm.EDIT_UsrLoginChange(Sender: TObject);
begin
  if EDIT_UsrLogin.Text='' then
    EDIT_UsrLogin.Color:=clInfoBk
  else
    EDIT_UsrLogin.Color:=clWindow;
  EDIT_UsrLogin.Hint:=EDIT_UsrLogin.Text;
end;

procedure TUsersForm.EDIT_UsrRIDChange(Sender: TObject);
begin
  if EDIT_UsrRID.Text='' then
    EDIT_UsrRID.Color:=clInfoBk
  else
    EDIT_UsrRID.Color:=clWindow;
  EDIT_UsrRID.Hint:=EDIT_UsrRID.Text;
end;

procedure TUsersForm.EDIT_UsrPwdChange(Sender: TObject);
begin
  if EDIT_UsrPwd.Text='' then
    EDIT_UsrPwd.Color:=clInfoBk
  else
    EDIT_UsrPwd.Color:=clWindow;
  EDIT_UsrPwd.Hint:=EDIT_UsrPwd.Text;
end;

procedure TUsersForm.EDIT_UsrRealNameChange(Sender: TObject);
begin
  if EDIT_UsrRealName.Text='' then
    EDIT_UsrRealName.Color:=clInfoBk
  else
    EDIT_UsrRealName.Color:=clWindow;
  EDIT_UsrRealName.Hint:=EDIT_UsrRealName.Text;
end;

end.
