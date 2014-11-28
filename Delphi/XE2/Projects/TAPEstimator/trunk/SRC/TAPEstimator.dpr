program TAPEstimator;

uses
  Vcl.Forms,
  TAPEstimator.uTMainForm in 'UI\TAPEstimator.uTMainForm.pas' {MainForm},
  TAPEstimator.uTConfigurationForm in 'UI\TAPEstimator.uTConfigurationForm.pas' {ConfigurationForm},
  TAPEstimator.Configuration.uTConfiguration in 'Logic\Classes\TAPEstimator.Configuration.uTConfiguration.pas',
  TAPEstimator.uTProfileForm in 'UI\TAPEstimator.uTProfileForm.pas' {ProfileForm},
  TAPEstimator.uConsts in 'Logic\Other\TAPEstimator.uConsts.pas',
  TAPEstimator.uTRecentsPropertiesForm in 'UI\TAPEstimator.uTRecentsPropertiesForm.pas' {RecentsPropertiesForm},
  TAPEstimator.Configuration.uIRecent in 'Logic\Interfaces\TAPEstimator.Configuration.uIRecent.pas',
  TAPEstimator.Configuration.uIRecents in 'Logic\Interfaces\TAPEstimator.Configuration.uIRecents.pas',
  TAPEstimator.Configuration.uTRecent in 'Logic\Classes\TAPEstimator.Configuration.uTRecent.pas',
  TAPEstimator.Configuration.uTRecents in 'Logic\Classes\TAPEstimator.Configuration.uTRecents.pas',
  TAPEstimator.Profile.uTProfile in 'Logic\Classes\TAPEstimator.Profile.uTProfile.pas',
  TAPEstimator.Profile.uEProfile in 'Logic\Classes\TAPEstimator.Profile.uEProfile.pas',
  TAPEstimator.uResourceStrings in 'Logic\Other\TAPEstimator.uResourceStrings.pas',
  TAPEstimator.uTTAPCommandPrefixes in 'Logic\Types\TAPEstimator.uTTAPCommandPrefixes.pas',
  TAPEstimator.uTTAPNonCommandChars in 'Logic\Types\TAPEstimator.uTTAPNonCommandChars.pas',
  TAPEstimator.uTTAPStringRoutines in 'Logic\Classes\TAPEstimator.uTTAPStringRoutines.pas',
  TAPEstimator.uETAPWrongSymbol in 'Logic\Classes\TAPEstimator.uETAPWrongSymbol.pas',
  TAPEstimator.Configuration.uTInterfaceSection in 'Logic\Classes\TAPEstimator.Configuration.uTInterfaceSection.pas',
  TAPEstimator.Configuration.uTOtherSection in 'Logic\Classes\TAPEstimator.Configuration.uTOtherSection.pas',
  TAPEstimator.Configuration.uEConfiguration in 'Logic\Classes\TAPEstimator.Configuration.uEConfiguration.pas',
  TAPEstimator.uIArc in 'Logic\Research\TAPEstimator.uIArc.pas',
  TAPEstimator.uIDrawable in 'Logic\Research\TAPEstimator.uIDrawable.pas',
  TAPEstimator.uIFigure in 'Logic\Research\TAPEstimator.uIFigure.pas',
  TAPEstimator.uILineSegment in 'Logic\Research\TAPEstimator.uILineSegment.pas',
  TAPEstimator.uILocation in 'Logic\Research\TAPEstimator.uILocation.pas',
  TAPEstimator.uIPoint in 'Logic\Research\TAPEstimator.uIPoint.pas',
  TAPEstimator.uTArc in 'Logic\Research\TAPEstimator.uTArc.pas',
  TAPEstimator.uTFigure in 'Logic\Research\TAPEstimator.uTFigure.pas',
  TAPEstimator.uTLineSegment in 'Logic\Research\TAPEstimator.uTLineSegment.pas',
  TAPEstimator.uTLocation in 'Logic\Research\TAPEstimator.uTLocation.pas',
  TAPEstimator.uTPoint in 'Logic\Research\TAPEstimator.uTPoint.pas',
  TAPEstimator.uTDirect3D9Gear in 'Logic\Research\TAPEstimator.uTDirect3D9Gear.pas',
  TAPEstimator.Configuration.uTMainFormStateSection in 'Logic\Classes\TAPEstimator.Configuration.uTMainFormStateSection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
