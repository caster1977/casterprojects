unit OA5.uTSetPasswordForm;

interface

uses
  Vcl.Forms,
  CastersPackage.uTLogForm,
  Vcl.PlatformDefaultStyleActnCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls;

type
  TSetPasswordForm = class(TLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actApply: TAction;
    actClose: TAction;
    actHelp: TAction;
    lblPassword: TLabel;
    mePassword: TMaskEdit;
    lblConfirmation: TLabel;
    meConfirmation: TMaskEdit;
    chkbxShowPassword: TCheckBox;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnHelp: TButton;
    btnClose: TButton;
    procedure actHelpExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkbxShowPasswordClick(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);
  strict private
    procedure _Help;
    procedure _Apply;
    procedure _Close;
    procedure _SwitchPasswordVisibility;
  end;

implementation

{$R *.dfm}

uses
  SysUtils,
  OA5.uMainForm,
  CastersPackage.uRoutines;

const
  ICON_SETPASSWORD = 1;

procedure TSetPasswordForm._Apply;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{8C1D1934-43A0-4BD3-A063-95940EA9B73D}');

  ModalResult := mrOk;
  Log.SendInfo('Попытка изменения пароля учётной записи была подтверждена пользователем.');
  Log.SendInfo('Окно изменения пароля учётной записи закрыто.');

  ProcedureFooter;
end;

procedure TSetPasswordForm._Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{19DBBA6D-0E8E-4BBB-BF5B-D2C80E71A631}');

  ModalResult := mrClose;
  Log.SendInfo('Попытка изменения пароля учётной записи была отменена пользователем.');
  Log.SendInfo('Окно изменения пароля учётной записи закрыто.');

  ProcedureFooter;
end;

procedure TSetPasswordForm._Help;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{95536062-F76C-495C-B1F2-70E50F7A9FF0}');

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    GenerateError('Извините, справочный файл к данной программе не найден.');

  ProcedureFooter;
end;

procedure TSetPasswordForm._SwitchPasswordVisibility;
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "' + chkbxShowPassword.Caption + '"',
    '{0219B9CF-B108-49C8-A390-22AF8B17C186}');

  if chkbxShowPassword.Checked then
  begin
    mePassword.PasswordChar := #0;
    meConfirmation.PasswordChar := #0;
  end
  else
  begin
    mePassword.PasswordChar := '*';
    meConfirmation.PasswordChar := '*';
  end;

  ProcedureFooter;
end;

procedure TSetPasswordForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{43E2DB1C-46EC-46FB-BE5F-69082FF4BDB0}');

  ImageList.GetIcon(ICON_SETPASSWORD, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;

    // установка положения окна в соответсвии со значениями конфигурации программы
    if SetPasswordFormPosition.bCenter then
      Position := poScreenCenter
    else
    begin
      Position := poDesigned;
      if SetPasswordFormPosition.x < Screen.WorkAreaLeft then
        Left := Screen.WorkAreaLeft
      else
        if SetPasswordFormPosition.x > Screen.WorkAreaLeft + Screen.WorkAreaWidth then
          Left := Screen.WorkAreaLeft + Screen.WorkAreaWidth - Width
        else
          Left := SetPasswordFormPosition.x;
      if SetPasswordFormPosition.y < Screen.WorkAreaTop then
        Top := Screen.WorkAreaTop
      else
        if SetPasswordFormPosition.y > Screen.WorkAreaTop + Screen.WorkAreaHeight then
          Top := Screen.WorkAreaTop + Screen.WorkAreaHeight - Height
        else
          Top := SetPasswordFormPosition.y;
    end;
  end;

  ProcedureFooter;
end;

procedure TSetPasswordForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{109E2C60-29E7-4230-956B-848F6063FD69}');
  Log.SendInfo('Отображено окно изменения пароля учётной записи.');
  ProcedureFooter;
end;

procedure TSetPasswordForm.actApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actApply.Caption + '"', '{D6F02F10-4334-4227-9C49-E2DB8B98CA70}');
  _Apply;
  ProcedureFooter;
end;

procedure TSetPasswordForm.actApplyUpdate(Sender: TObject);
var
  b: boolean;
begin
  b := mePassword.Text = meConfirmation.Text;
  if actApply.Enabled <> b then
  begin
    ProcedureHeader('Процедура-обработчик обновления действия "' + actApply.Caption + '"',
      '{C430F728-3AC7-4605-831B-F2AE12429BDA}');
    actApply.Enabled := b;
    Log.SendDebug('Действие "' + actApply.Caption + '" ' + Routines.GetConditionalString(actApply.Enabled, 'в', 'от') +
      'ключено.');
    ProcedureFooter;
  end;
  if btnApply.Default <> b then
  begin
    btnApply.Default := b;
  end;
  if btnClose.Default <> (not b) then
  begin
    btnClose.Default := not b;
  end;
end;

procedure TSetPasswordForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actClose.Caption + '"', '{4569EB61-7A53-4A07-8D49-7D91C54D6FEF}');
  _Close;
  ProcedureFooter;
end;

procedure TSetPasswordForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actHelp.Caption + '"', '{772E549E-6DD2-4921-B2F9-5C65F20976FE}');
  _Help;
  ProcedureFooter;
end;

procedure TSetPasswordForm.actHelpUpdate(Sender: TObject);
var
  b: boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader('Процедура-обработчик обновления действия "' + actHelp.Caption + '"',
      '{B92D0FEB-6E73-42D9-A684-68918F5F11A6}');
    actHelp.Enabled := b;
    Log.SendDebug('Действие "' + actHelp.Caption + '" ' + Routines.GetConditionalString(b, 'в', 'от') + 'ключено.');
    ProcedureFooter;
  end;
end;

procedure TSetPasswordForm.chkbxShowPasswordClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxShowPassword.Caption + '"',
    '{1CA50F76-73D7-4646-8365-189442365348}');
  _SwitchPasswordVisibility;
  ProcedureFooter;
end;

end.
