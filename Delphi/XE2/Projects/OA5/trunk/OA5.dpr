program OA5;

uses
  Forms,
  OA5.uMainForm in 'OA5.uMainForm.pas' {MainForm},
  OA5.uLoginForm in 'OA5.uLoginForm.pas' {LoginForm},
  OA5.uConsts in 'OA5.uConsts.pas',
  OA5.uAboutForm in 'OA5.uAboutForm.pas' {AboutForm},
  OA5.uConfigurationForm in 'OA5.uConfigurationForm.pas' {ConfigurationForm},
  OA5.uTConfiguration in 'OA5.uTConfiguration.pas',
  OA5.uAccountClass in 'OA5.uAccountClass.pas',
  OA5.uAddMassMsrForm in 'OA5.uAddMassMsrForm.pas' {AddMassMsrForm},
  OA5.uReportForm in 'OA5.uReportForm.pas' {ReportForm},
  OA5.uSetPasswordForm in 'OA5.uSetPasswordForm.pas' {SetPasswordForm},
  OA5.uPermissionsForm in 'OA5.uPermissionsForm.pas' {PermissionsForm},
  OA5.uMultiBufferForm in 'OA5.uMultiBufferForm.pas' {MultiBufferForm},
  OA5.uTypes in 'OA5.uTypes.pas',
  OA5.uTMultiBuffer in 'OA5.uTMultiBuffer.pas',
  OA5.uTMeasure in 'OA5.uTMeasure.pas',
  Vcl.Themes,
  Vcl.Styles,
  OA5.uCreateMessageForm in 'OA5.uCreateMessageForm.pas' {CreateMessageForm},
  OA5.uViewMessageForm in 'OA5.uViewMessageForm.pas' {ViewMessageForm},
  OA5.uViewMessagesForm in 'OA5.uViewMessagesForm.pas' {ViewMessagesForm},
  OA5.uAddEditPhoneForm in 'OA5.uAddEditPhoneForm.pas' {AddEditPhoneForm},
  OA5.uTMySQLConnection in 'OA5.uTMySQLConnection.pas',
  OA5.uINormalized in 'OA5.uINormalized.pas',
  OA5.uIMeasure in 'OA5.uIMeasure.pas',
  OA5.uIMeasureList in 'OA5.uIMeasureList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
