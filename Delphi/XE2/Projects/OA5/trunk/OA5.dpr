program OA5;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uLoginForm in 'uLoginForm.pas' {LoginForm},
  OA5Consts in 'OA5Consts.pas',
  uAboutForm in 'uAboutForm.pas' {AboutForm},
  uConfigurationForm in 'uConfigurationForm.pas' {ConfigurationForm},
  uConfigurationClass in 'uConfigurationClass.pas',
  uMySQLConnectionClass in 'uMySQLConnectionClass.pas',
  uUserClass in 'uUserClass.pas',
  uAddMassMsrForm in 'uAddMassMsrForm.pas' {AddMassMsrForm},
  uReportForm in 'uReportForm.pas' {ReportForm},
  uSetPasswordForm in 'uSetPasswordForm.pas' {SetPasswordForm},
  uPermissionsForm in 'uPermissionsForm.pas' {PermissionsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
