program TAPEstimator;

uses
  Vcl.Forms,
  TAPEstimator.uTMainForm in 'SRC\UI\TAPEstimator.uTMainForm.pas' {MainForm},
  TAPEstimator.uTConfigurationForm in 'SRC\UI\TAPEstimator.uTConfigurationForm.pas' {ConfigurationForm},
  TAPEstimator.uTConfiguration in 'SRC\Logic\Classes\TAPEstimator.uTConfiguration.pas',
  TAPEstimator.uIConfiguration in 'SRC\Logic\Interfaces\TAPEstimator.uIConfiguration.pas',
  TAPEstimator.uETaskThread in 'SRC\Logic\Classes\TAPEstimator.uETaskThread.pas',
  TAPEstimator.uTProfileForm in 'SRC\UI\TAPEstimator.uTProfileForm.pas' {ProfileForm},
  TAPEstimator.uConsts in 'SRC\Logic\Other\TAPEstimator.uConsts.pas',
  TAPEstimator.uIProfile in 'SRC\Logic\Interfaces\TAPEstimator.uIProfile.pas',
  TAPEstimator.uIProfiles in 'SRC\Logic\Interfaces\TAPEstimator.uIProfiles.pas',
  TAPEstimator.uTRecentsPropertiesForm in 'SRC\UI\TAPEstimator.uTRecentsPropertiesForm.pas' {RecentsPropertiesForm},
  TAPEstimator.uIRecent in 'SRC\Logic\Interfaces\TAPEstimator.uIRecent.pas',
  TAPEstimator.uIRecents in 'SRC\Logic\Interfaces\TAPEstimator.uIRecents.pas',
  TAPEstimator.uTRecent in 'SRC\Logic\Classes\TAPEstimator.uTRecent.pas',
  TAPEstimator.uTRecents in 'SRC\Logic\Classes\TAPEstimator.uTRecents.pas',
  TAPEstimator.uTProfile in 'SRC\Logic\Classes\TAPEstimator.uTProfile.pas',
  TAPEstimator.uEConfiguration in 'SRC\Logic\Classes\TAPEstimator.uEConfiguration.pas',
  TAPEstimator.uEProfile in 'SRC\Logic\Classes\TAPEstimator.uEProfile.pas',
  TAPEstimator.uResourceStrings in 'SRC\Logic\Other\TAPEstimator.uResourceStrings.pas',
  TAPEstimator.Temp in 'SRC\Logic\Other\TAPEstimator.Temp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
