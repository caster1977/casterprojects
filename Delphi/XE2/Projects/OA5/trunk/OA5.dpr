program OA5;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uLoginForm in 'uLoginForm.pas' {LoginForm},
  OA5.uConsts in 'OA5.uConsts.pas',
  uAboutForm in 'uAboutForm.pas' {AboutForm},
  uConfigurationForm in 'uConfigurationForm.pas' {ConfigurationForm},
  OA5.uConfigurationClass in 'OA5.uConfigurationClass.pas',
  OA5.uUserClass in 'OA5.uUserClass.pas',
  uAddMassMsrForm in 'uAddMassMsrForm.pas' {AddMassMsrForm},
  uReportForm in 'uReportForm.pas' {ReportForm},
  uSetPasswordForm in 'uSetPasswordForm.pas' {SetPasswordForm},
  uPermissionsForm in 'uPermissionsForm.pas' {PermissionsForm},
  uMultiBufferForm in 'uMultiBufferForm.pas' {MultiBufferForm},
  OA5.uTypes in 'OA5.uTypes.pas',
  OA5.uMultiBufferClass in 'OA5.uMultiBufferClass.pas',
  OA5.uMeasureDataClass in 'OA5.uMeasureDataClass.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
