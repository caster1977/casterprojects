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
  TAPEstimator.uICoordinate in 'SRC\Logic\Interfaces\TAPEstimator.uICoordinate.pas',
  TAPEstimator.uTAbstractCoordinate in 'SRC\Logic\Types\TAPEstimator.uTAbstractCoordinate.pas',
  TAPEstimator.uIIntegerCoordinate in 'SRC\Logic\Interfaces\TAPEstimator.uIIntegerCoordinate.pas',
  TAPEstimator.uIInt64Coordinate in 'SRC\Logic\Interfaces\TAPEstimator.uIInt64Coordinate.pas',
  TAPEstimator.uTIntegerFunction in 'SRC\Logic\Types\TAPEstimator.uTIntegerFunction.pas',
  TAPEstimator.uTIntegerCoordinate in 'SRC\Logic\Types\TAPEstimator.uTIntegerCoordinate.pas',
  TAPEstimator.uTInt64Function in 'SRC\Logic\Types\TAPEstimator.uTInt64Function.pas',
  TAPEstimator.uTInt64Coordinate in 'SRC\Logic\Types\TAPEstimator.uTInt64Coordinate.pas',
  TAPEstimator.uICoordinateConverter in 'SRC\Logic\Interfaces\TAPEstimator.uICoordinateConverter.pas',
  TAPEstimator.Temp in 'SRC\Logic\Other\TAPEstimator.Temp.pas',
  TAPEstimator.uTTableRotation in 'SRC\Logic\Types\TAPEstimator.uTTableRotation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
