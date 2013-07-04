program DBAutoTest;

uses
  Vcl.Forms,
  DBAutoTest.uTMainForm in 'SRC\UI\DBAutoTest.uTMainForm.pas' {MainForm},
  DBAutoTest.uTTaskForm in 'SRC\UI\DBAutoTest.uTTaskForm.pas' {TaskForm},
  DBAutoTest.uTConfigurationForm in 'SRC\UI\DBAutoTest.uTConfigurationForm.pas' {ConfigurationForm},
  DBAutoTest.uTTask in 'SRC\Logic\Classes\DBAutoTest.uTTask.pas',
  DBAutoTest.uITask in 'SRC\Logic\Interfaces\DBAutoTest.uITask.pas',
  DBAutoTest.uITasks in 'SRC\Logic\Interfaces\DBAutoTest.uITasks.pas',
  DBAutoTest.uTTasks in 'SRC\Logic\Classes\DBAutoTest.uTTasks.pas',
  DBAutoTest.uTTaskThread in 'SRC\Logic\Classes\DBAutoTest.uTTaskThread.pas',
  DBAutoTest.uETaskThread in 'SRC\Logic\Classes\DBAutoTest.uETaskThread.pas',
  DBAutoTest.uTProfileForm in 'SRC\UI\DBAutoTest.uTProfileForm.pas' {ProfileForm},
  DBAutoTest.uConsts in 'SRC\Logic\Other\DBAutoTest.uConsts.pas',
  DBAutoTest.uETasks in 'SRC\Logic\Classes\DBAutoTest.uETasks.pas',
  DBAutoTest.uTRecentsPropertiesForm in 'SRC\UI\DBAutoTest.uTRecentsPropertiesForm.pas' {RecentsPropertiesForm},
  DBAutoTest.uIRecent in 'SRC\Logic\Interfaces\DBAutoTest.uIRecent.pas',
  DBAutoTest.uIRecents in 'SRC\Logic\Interfaces\DBAutoTest.uIRecents.pas',
  DBAutoTest.uTRecent in 'SRC\Logic\Classes\DBAutoTest.uTRecent.pas',
  DBAutoTest.uTRecents in 'SRC\Logic\Classes\DBAutoTest.uTRecents.pas',
  DBAutoTest.uTProfile in 'SRC\Logic\Classes\DBAutoTest.uTProfile.pas',
  DBAutoTest.uEProfile in 'SRC\Logic\Classes\DBAutoTest.uEProfile.pas',
  DBAutoTest.uTTaskStatus in 'SRC\Logic\Types\DBAutoTest.uTTaskStatus.pas',
  DBAutoTest.uResourceStrings in 'SRC\Logic\Other\DBAutoTest.uResourceStrings.pas',
  DBAutoTest.Configuration.uTInterface in 'SRC\Logic\Classes\DBAutoTest.Configuration.uTInterface.pas',
  DBAutoTest.uTOtherOptions in 'SRC\Logic\Classes\DBAutoTest.uTOtherOptions.pas',
  DBAutoTest.Configuration.uTReports in 'SRC\Logic\Classes\DBAutoTest.Configuration.uTReports.pas',
  DBAutoTest.uTConfiguration in 'SRC\Logic\Classes\DBAutoTest.uTConfiguration.pas',
  DBAutoTest.Profile.uTConnection in 'SRC\Logic\Classes\DBAutoTest.Profile.uTConnection.pas',
  DBAutoTest.Profile.uTTaskSaving in 'SRC\Logic\Classes\DBAutoTest.Profile.uTTaskSaving.pas',
  DBAutoTest.Configuration.uTConnection in 'SRC\Logic\Classes\DBAutoTest.Configuration.uTConnection.pas',
  DBAutoTest.uEConfiguration in 'SRC\Logic\Classes\DBAutoTest.uEConfiguration.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
