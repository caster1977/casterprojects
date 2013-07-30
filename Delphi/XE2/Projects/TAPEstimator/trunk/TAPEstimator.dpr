program TAPEstimator;

uses
  Vcl.Forms,
  TAPEstimator.uTMainForm in 'SRC\UI\TAPEstimator.uTMainForm.pas' {MainForm},
  TAPEstimator.uTConfigurationForm in 'SRC\UI\TAPEstimator.uTConfigurationForm.pas' {ConfigurationForm},
  TAPEstimator.Configuration.uTConfiguration in 'SRC\Logic\Classes\TAPEstimator.Configuration.uTConfiguration.pas',
  TAPEstimator.uTProfileForm in 'SRC\UI\TAPEstimator.uTProfileForm.pas' {ProfileForm},
  TAPEstimator.uConsts in 'SRC\Logic\Other\TAPEstimator.uConsts.pas',
  TAPEstimator.uTRecentsPropertiesForm in 'SRC\UI\TAPEstimator.uTRecentsPropertiesForm.pas' {RecentsPropertiesForm},
  TAPEstimator.Configuration.uIRecent in 'SRC\Logic\Interfaces\TAPEstimator.Configuration.uIRecent.pas',
  TAPEstimator.Configuration.uIRecents in 'SRC\Logic\Interfaces\TAPEstimator.Configuration.uIRecents.pas',
  TAPEstimator.Configuration.uTRecent in 'SRC\Logic\Classes\TAPEstimator.Configuration.uTRecent.pas',
  TAPEstimator.Configuration.uTRecents in 'SRC\Logic\Classes\TAPEstimator.Configuration.uTRecents.pas',
  TAPEstimator.Profile.uTProfile in 'SRC\Logic\Classes\TAPEstimator.Profile.uTProfile.pas',
  TAPEstimator.Profile.uEProfile in 'SRC\Logic\Classes\TAPEstimator.Profile.uEProfile.pas',
  TAPEstimator.uResourceStrings in 'SRC\Logic\Other\TAPEstimator.uResourceStrings.pas',
  TAPEstimator.uTTAPCommandPrefixes in 'SRC\Logic\Types\TAPEstimator.uTTAPCommandPrefixes.pas',
  TAPEstimator.uTTAPNonCommandChars in 'SRC\Logic\Types\TAPEstimator.uTTAPNonCommandChars.pas',
  TAPEstimator.uTTAPStringRoutines in 'SRC\Logic\Classes\TAPEstimator.uTTAPStringRoutines.pas',
  TAPEstimator.uETAPWrongSymbol in 'SRC\Logic\Classes\TAPEstimator.uETAPWrongSymbol.pas',
  TAPEstimator.Configuration.uTInterfaceSection in 'SRC\Logic\Classes\TAPEstimator.Configuration.uTInterfaceSection.pas',
  TAPEstimator.Configuration.uTOtherSection in 'SRC\Logic\Classes\TAPEstimator.Configuration.uTOtherSection.pas',
  TAPEstimator.Configuration.uEConfiguration in 'SRC\Logic\Classes\TAPEstimator.Configuration.uEConfiguration.pas',
  TAPEstimator.uIArc in 'SRC\Logic\Research\TAPEstimator.uIArc.pas',
  TAPEstimator.uIDrawable in 'SRC\Logic\Research\TAPEstimator.uIDrawable.pas',
  TAPEstimator.uIFigure in 'SRC\Logic\Research\TAPEstimator.uIFigure.pas',
  TAPEstimator.uILineSegment in 'SRC\Logic\Research\TAPEstimator.uILineSegment.pas',
  TAPEstimator.uILocation in 'SRC\Logic\Research\TAPEstimator.uILocation.pas',
  TAPEstimator.uIPoint in 'SRC\Logic\Research\TAPEstimator.uIPoint.pas',
  TAPEstimator.uTArc in 'SRC\Logic\Research\TAPEstimator.uTArc.pas',
  TAPEstimator.uTFigure in 'SRC\Logic\Research\TAPEstimator.uTFigure.pas',
  TAPEstimator.uTLineSegment in 'SRC\Logic\Research\TAPEstimator.uTLineSegment.pas',
  TAPEstimator.uTLocation in 'SRC\Logic\Research\TAPEstimator.uTLocation.pas',
  TAPEstimator.uTPoint in 'SRC\Logic\Research\TAPEstimator.uTPoint.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
