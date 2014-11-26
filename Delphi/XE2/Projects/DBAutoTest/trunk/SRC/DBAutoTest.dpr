program DBAutoTest;

uses
  Vcl.Forms,
  DBAutoTest.uTMainForm in 'UI\DBAutoTest.uTMainForm.pas' {MainForm},
  DBAutoTest.uTTaskForm in 'UI\DBAutoTest.uTTaskForm.pas' {TaskForm},
  DBAutoTest.uTConfigurationForm in 'UI\DBAutoTest.uTConfigurationForm.pas' {ConfigurationForm},
  DBAutoTest.uTTask in 'Logic\Classes\DBAutoTest.uTTask.pas',
  DBAutoTest.uITask in 'Logic\Interfaces\DBAutoTest.uITask.pas',
  DBAutoTest.uITasks in 'Logic\Interfaces\DBAutoTest.uITasks.pas',
  DBAutoTest.uTTasks in 'Logic\Classes\DBAutoTest.uTTasks.pas',
  DBAutoTest.uTTaskThread in 'Logic\Classes\DBAutoTest.uTTaskThread.pas',
  DBAutoTest.uETaskThread in 'Logic\Classes\DBAutoTest.uETaskThread.pas',
  DBAutoTest.uTProfileForm in 'UI\DBAutoTest.uTProfileForm.pas' {ProfileForm},
  DBAutoTest.uConsts in 'Logic\Other\DBAutoTest.uConsts.pas',
  DBAutoTest.uETasks in 'Logic\Classes\DBAutoTest.uETasks.pas',
  DBAutoTest.uTRecentsPropertiesForm in 'UI\DBAutoTest.uTRecentsPropertiesForm.pas' {RecentsPropertiesForm},
  DBAutoTest.uIRecent in 'Logic\Interfaces\DBAutoTest.uIRecent.pas',
  DBAutoTest.uIRecents in 'Logic\Interfaces\DBAutoTest.uIRecents.pas',
  DBAutoTest.uTRecent in 'Logic\Classes\DBAutoTest.uTRecent.pas',
  DBAutoTest.uTRecents in 'Logic\Classes\DBAutoTest.uTRecents.pas',
  DBAutoTest.uTProfile in 'Logic\Classes\DBAutoTest.uTProfile.pas',
  DBAutoTest.uEProfile in 'Logic\Classes\DBAutoTest.uEProfile.pas',
  DBAutoTest.uTTaskStatus in 'Logic\Types\DBAutoTest.uTTaskStatus.pas',
  DBAutoTest.uResourceStrings in 'Logic\Other\DBAutoTest.uResourceStrings.pas',
  DBAutoTest.Configuration.uTInterface in 'Logic\Classes\DBAutoTest.Configuration.uTInterface.pas',
  DBAutoTest.Configuration.uTOther in 'Logic\Classes\DBAutoTest.Configuration.uTOther.pas',
  DBAutoTest.Configuration.uTReports in 'Logic\Classes\DBAutoTest.Configuration.uTReports.pas',
  DBAutoTest.uTConfiguration in 'Logic\Classes\DBAutoTest.uTConfiguration.pas',
  DBAutoTest.Profile.uTConnection in 'Logic\Classes\DBAutoTest.Profile.uTConnection.pas',
  DBAutoTest.Profile.uTTaskSaving in 'Logic\Classes\DBAutoTest.Profile.uTTaskSaving.pas',
  DBAutoTest.Configuration.uTConnection in 'Logic\Classes\DBAutoTest.Configuration.uTConnection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
