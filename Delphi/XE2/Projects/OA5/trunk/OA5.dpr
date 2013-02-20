program OA5;

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  OA5.uIAccount in 'SRC\Logic\Interfaces\OA5.uIAccount.pas',
  OA5.uIConfiguration in 'SRC\Logic\Interfaces\OA5.uIConfiguration.pas',
  OA5.uIMeasure in 'SRC\Logic\Interfaces\OA5.uIMeasure.pas',
  OA5.uIMeasureList in 'SRC\Logic\Interfaces\OA5.uIMeasureList.pas',
  OA5.uIMySQLConnection in 'SRC\Logic\Interfaces\OA5.uIMySQLConnection.pas',
  OA5.uIOA5Form in 'SRC\Logic\Interfaces\OA5.uIOA5Form.pas',
  OA5.uIPrivilegies in 'SRC\Logic\Interfaces\OA5.uIPrivilegies.pas',
  OA5.uTAboutForm in 'SRC\UI\OA5.uTAboutForm.pas' {AboutForm},
  OA5.uTAddEditPhoneForm in 'SRC\UI\OA5.uTAddEditPhoneForm.pas' {AddEditPhoneForm},
  OA5.uTAddMassMsrForm in 'SRC\UI\OA5.uTAddMassMsrForm.pas' {AddMassMsrForm},
  OA5.uTConfigurationForm in 'SRC\UI\OA5.uTConfigurationForm.pas' {ConfigurationForm},
  OA5.uTCreateMessageForm in 'SRC\UI\OA5.uTCreateMessageForm.pas' {CreateMessageForm},
  OA5.uTLoginForm in 'SRC\UI\OA5.uTLoginForm.pas' {LoginForm},
  OA5.uTMainForm in 'SRC\UI\OA5.uTMainForm.pas' {MainForm},
  OA5.uTMultiBufferForm in 'SRC\UI\OA5.uTMultiBufferForm.pas' {MultiBufferForm},
  OA5.uTPermissionsForm in 'SRC\UI\OA5.uTPermissionsForm.pas' {PermissionsForm},
  OA5.uTReportForm in 'SRC\UI\OA5.uTReportForm.pas' {ReportForm},
  OA5.uTSetPasswordForm in 'SRC\UI\OA5.uTSetPasswordForm.pas' {SetPasswordForm},
  OA5.uTViewMessageForm in 'SRC\UI\OA5.uTViewMessageForm.pas' {ViewMessageForm},
  OA5.uTViewMessagesForm in 'SRC\UI\OA5.uTViewMessagesForm.pas' {ViewMessagesForm},
  OA5.uTAccount in 'SRC\Logic\Classes\OA5.uTAccount.pas',
  OA5.uTConfiguration in 'SRC\Logic\Classes\OA5.uTConfiguration.pas',
  OA5.uTMeasure in 'SRC\Logic\Classes\OA5.uTMeasure.pas',
  OA5.uTMeasureList in 'SRC\Logic\Classes\OA5.uTMeasureList.pas',
  OA5.uTMySQLConnection in 'SRC\Logic\Classes\OA5.uTMySQLConnection.pas',
  OA5.uTPrivilegies in 'SRC\Logic\Classes\OA5.uTPrivilegies.pas',
  OA5.uDefaultConsts in 'SRC\Logic\Other\OA5.uDefaultConsts.pas',
  OA5.uTPhone in 'SRC\Logic\Classes\OA5.uTPhone.pas',
  OA5.uTPhoneTypes in 'SRC\Logic\Types\OA5.uTPhoneTypes.pas',
  OA5.uTStationaryProviders in 'SRC\Logic\Types\OA5.uTStationaryProviders.pas',
  OA5.uTMobileProviders in 'SRC\Logic\Types\OA5.uTMobileProviders.pas',
  OA5.uResourceStrings in 'SRC\Logic\Other\OA5.uResourceStrings.pas',
  OA5.uConsts in 'SRC\Logic\Other\OA5.uConsts.pas',
  OA5.uTOA5LogForm in 'SRC\Logic\Classes\OA5.uTOA5LogForm.pas' {OA5LogForm},
  OA5.uTOA5PositionedLogForm in 'SRC\Logic\Classes\OA5.uTOA5PositionedLogForm.pas' {OA5PositionedLogForm},
  OA5.uTCustomPhone in 'SRC\Logic\Classes\OA5.uTCustomPhone.pas',
  OA5.uTUnknownPhone in 'SRC\Logic\Classes\OA5.uTUnknownPhone.pas',
  OA5.uTStationaryPhone in 'SRC\Logic\Classes\OA5.uTStationaryPhone.pas',
  OA5.uTMobilePhone in 'SRC\Logic\Classes\OA5.uTMobilePhone.pas',
  OA5.uICustomPhone in 'SRC\Logic\Interfaces\OA5.uICustomPhone.pas',
  OA5.uTPhoneListForm in 'SRC\UI\OA5.uTPhoneListForm.pas' {PhoneListForm},
  OA5.uEConfiguration in 'SRC\Logic\Classes\OA5.uEConfiguration.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'OA5';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
