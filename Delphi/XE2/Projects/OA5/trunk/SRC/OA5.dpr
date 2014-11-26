program OA5;

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  OA5.uIAccount in 'Logic\Interfaces\OA5.uIAccount.pas',
  OA5.uIConfiguration in 'Logic\Interfaces\OA5.uIConfiguration.pas',
  OA5.uIMeasure in 'Logic\Interfaces\OA5.uIMeasure.pas',
  OA5.uIMeasureList in 'Logic\Interfaces\OA5.uIMeasureList.pas',
  OA5.uIMySQLConnection in 'Logic\Interfaces\OA5.uIMySQLConnection.pas',
  OA5.uIOA5Form in 'Logic\Interfaces\OA5.uIOA5Form.pas',
  OA5.uIPrivilegies in 'Logic\Interfaces\OA5.uIPrivilegies.pas',
  OA5.uTAboutForm in 'UI\OA5.uTAboutForm.pas' {AboutForm},
  OA5.uTAddEditPhoneForm in 'UI\OA5.uTAddEditPhoneForm.pas' {AddEditPhoneForm},
  OA5.uTAddMassMsrForm in 'UI\OA5.uTAddMassMsrForm.pas' {AddMassMsrForm},
  OA5.uTConfigurationForm in 'UI\OA5.uTConfigurationForm.pas' {ConfigurationForm},
  OA5.uTCreateMessageForm in 'UI\OA5.uTCreateMessageForm.pas' {CreateMessageForm},
  OA5.uTLoginForm in 'UI\OA5.uTLoginForm.pas' {LoginForm},
  OA5.uTMainForm in 'UI\OA5.uTMainForm.pas' {MainForm},
  OA5.uTMultiBufferForm in 'UI\OA5.uTMultiBufferForm.pas' {MultiBufferForm},
  OA5.uTPermissionsForm in 'UI\OA5.uTPermissionsForm.pas' {PermissionsForm},
  OA5.uTReportForm in 'UI\OA5.uTReportForm.pas' {ReportForm},
  OA5.uTSetPasswordForm in 'UI\OA5.uTSetPasswordForm.pas' {SetPasswordForm},
  OA5.uTViewMessageForm in 'UI\OA5.uTViewMessageForm.pas' {ViewMessageForm},
  OA5.uTViewMessagesForm in 'UI\OA5.uTViewMessagesForm.pas' {ViewMessagesForm},
  OA5.uTAccount in 'Logic\Classes\OA5.uTAccount.pas',
  OA5.uTConfiguration in 'Logic\Classes\OA5.uTConfiguration.pas',
  OA5.uTMeasure in 'Logic\Classes\OA5.uTMeasure.pas',
  OA5.uTMeasureList in 'Logic\Classes\OA5.uTMeasureList.pas',
  OA5.uTMySQLConnection in 'Logic\Classes\OA5.uTMySQLConnection.pas',
  OA5.uTPrivilegies in 'Logic\Classes\OA5.uTPrivilegies.pas',
  OA5.uDefaultConsts in 'Logic\Other\OA5.uDefaultConsts.pas',
  OA5.uTPhone in 'Logic\Classes\OA5.uTPhone.pas',
  OA5.uTPhoneTypes in 'Logic\Types\OA5.uTPhoneTypes.pas',
  OA5.uTStationaryProviders in 'Logic\Types\OA5.uTStationaryProviders.pas',
  OA5.uTMobileProviders in 'Logic\Types\OA5.uTMobileProviders.pas',
  OA5.uResourceStrings in 'Logic\Other\OA5.uResourceStrings.pas',
  OA5.uConsts in 'Logic\Other\OA5.uConsts.pas',
  OA5.uTOA5LogForm in 'Logic\Classes\OA5.uTOA5LogForm.pas' {OA5LogForm},
  OA5.uTOA5PositionedLogForm in 'Logic\Classes\OA5.uTOA5PositionedLogForm.pas' {OA5PositionedLogForm},
  OA5.uTCustomPhone in 'Logic\Classes\OA5.uTCustomPhone.pas',
  OA5.uTUnknownPhone in 'Logic\Classes\OA5.uTUnknownPhone.pas',
  OA5.uTStationaryPhone in 'Logic\Classes\OA5.uTStationaryPhone.pas',
  OA5.uTMobilePhone in 'Logic\Classes\OA5.uTMobilePhone.pas',
  OA5.uICustomPhone in 'Logic\Interfaces\OA5.uICustomPhone.pas',
  OA5.uTPhoneListForm in 'UI\OA5.uTPhoneListForm.pas' {PhoneListForm},
  OA5.uEConfiguration in 'Logic\Classes\OA5.uEConfiguration.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'OA5';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
