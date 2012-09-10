program OA5;

uses
  Forms,
  OA5.uTMainForm in 'OA5.uTMainForm.pas' {MainForm},
  OA5.uTLoginForm in 'OA5.uTLoginForm.pas' {LoginForm},
  OA5.uTAboutForm in 'OA5.uTAboutForm.pas' {AboutForm},
  OA5.uTConfigurationForm in 'OA5.uTConfigurationForm.pas' {ConfigurationForm},
  OA5.uTConfiguration in 'OA5.uTConfiguration.pas',
  OA5.uTAccount in 'OA5.uTAccount.pas',
  OA5.uTAddMassMsrForm in 'OA5.uTAddMassMsrForm.pas' {AddMassMsrForm},
  OA5.uTReportForm in 'OA5.uTReportForm.pas' {ReportForm},
  OA5.uTSetPasswordForm in 'OA5.uTSetPasswordForm.pas' {SetPasswordForm},
  OA5.uTPermissionsForm in 'OA5.uTPermissionsForm.pas' {PermissionsForm},
  OA5.uTMultiBufferForm in 'OA5.uTMultiBufferForm.pas' {MultiBufferForm},
  OA5.uTMeasure in 'OA5.uTMeasure.pas',
  Vcl.Themes,
  Vcl.Styles,
  OA5.uTCreateMessageForm in 'OA5.uTCreateMessageForm.pas' {CreateMessageForm},
  OA5.uTViewMessageForm in 'OA5.uTViewMessageForm.pas' {ViewMessageForm},
  OA5.uTViewMessagesForm in 'OA5.uTViewMessagesForm.pas' {ViewMessagesForm},
  OA5.uTAddEditPhoneForm in 'OA5.uTAddEditPhoneForm.pas' {AddEditPhoneForm},
  OA5.uTMySQLConnection in 'OA5.uTMySQLConnection.pas',
  OA5.uINormalized in 'OA5.uINormalized.pas',
  OA5.uIMeasure in 'OA5.uIMeasure.pas',
  OA5.uIMeasureList in 'OA5.uIMeasureList.pas',
  OA5.uTMeasureList in 'OA5.uTMeasureList.pas',
  CastersPackage.uTDialogPosition in '..\CastersPackage\CastersPackage.uTDialogPosition.pas',
  CastersPackage.uIPositionedDialog in '..\CastersPackage\CastersPackage.uIPositionedDialog.pas',
  CastersPackage.uTPositionedLogForm in '..\CastersPackage\CastersPackage.uTPositionedLogForm.pas' {PositionedLogForm},
  OA5.uDefaultConsts in 'OA5.uDefaultConsts.pas',
  OA5.uTPrivilegies in 'OA5.uTPrivilegies.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := 'OA5';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
