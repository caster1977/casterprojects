program TAPEstimator;

uses
  Vcl.Forms,
  TAPEstimator.uTMainForm in 'SRC\UI\TAPEstimator.uTMainForm.pas' {MainForm},
  TAPEstimator.uTConfigurationForm in 'SRC\UI\TAPEstimator.uTConfigurationForm.pas' {ConfigurationForm},
  TAPEstimator.uTConfiguration in 'SRC\Logic\Classes\TAPEstimator.uTConfiguration.pas',
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
  TAPEstimator.uEProfile in 'SRC\Logic\Classes\TAPEstimator.uEProfile.pas',
  TAPEstimator.uResourceStrings in 'SRC\Logic\Other\TAPEstimator.uResourceStrings.pas',
  TAPEstimator.uIDrawable in 'SRC\Logic\Interfaces\TAPEstimator.uIDrawable.pas',
  TAPEstimator.uIGenericFigure in 'SRC\Logic\Interfaces\TAPEstimator.uIGenericFigure.pas',
  TAPEstimator.uTGenericFigure in 'SRC\Logic\Types\TAPEstimator.uTGenericFigure.pas',
  TAPEstimator.uTGenericPoint in 'SRC\Logic\Types\TAPEstimator.uTGenericPoint.pas',
  TAPEstimator.uTTAPCommandPrefixes in 'SRC\Logic\Types\TAPEstimator.uTTAPCommandPrefixes.pas',
  TAPEstimator.uTTAPNonCommandChars in 'SRC\Logic\Types\TAPEstimator.uTTAPNonCommandChars.pas',
  TAPEstimator.uTTAPStringRoutines in 'SRC\Logic\Classes\TAPEstimator.uTTAPStringRoutines.pas',
  TAPEstimator.uETAPWrongSymbol in 'SRC\Logic\Classes\TAPEstimator.uETAPWrongSymbol.pas',
  TAPEstimator.uTInterfaceSection in 'SRC\Logic\Classes\TAPEstimator.uTInterfaceSection.pas',
  TAPEstimator.uTOtherSection in 'SRC\Logic\Classes\TAPEstimator.uTOtherSection.pas',
  TAPEstimator.uEConfiguration in 'SRC\Logic\Classes\TAPEstimator.uEConfiguration.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
