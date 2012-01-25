program OA5;

uses
  Forms,
  OA5.uMainForm in 'OA5.uMainForm.pas' {MainForm},
  OA5.uLoginForm in 'OA5.uLoginForm.pas' {LoginForm},
  OA5.uConsts in 'OA5.uConsts.pas',
  OA5.uAboutForm in 'OA5.uAboutForm.pas' {AboutForm},
  OA5.uConfigurationForm in 'OA5.uConfigurationForm.pas' {ConfigurationForm},
  OA5.uConfigurationClass in 'OA5.uConfigurationClass.pas',
  OA5.uUserClass in 'OA5.uUserClass.pas',
  OA5.uAddMassMsrForm in 'OA5.uAddMassMsrForm.pas' {AddMassMsrForm},
  OA5.uReportForm in 'OA5.uReportForm.pas' {ReportForm},
  OA5.uSetPasswordForm in 'OA5.uSetPasswordForm.pas' {SetPasswordForm},
  OA5.uPermissionsForm in 'OA5.uPermissionsForm.pas' {PermissionsForm},
  OA5.uMultiBufferForm in 'OA5.uMultiBufferForm.pas' {MultiBufferForm},
  OA5.uTypes in 'OA5.uTypes.pas',
  OA5.uMultiBufferClass in 'OA5.uMultiBufferClass.pas',
  OA5.uMeasureDataClass in 'OA5.uMeasureDataClass.pas',
  Vcl.Themes,
  Vcl.Styles,
  OA5.uCreateMessageForm in 'OA5.uCreateMessageForm.pas' {CreateMessageForm},
  OA5.uViewMessageForm in 'OA5.uViewMessageForm.pas' {ViewMessageForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
