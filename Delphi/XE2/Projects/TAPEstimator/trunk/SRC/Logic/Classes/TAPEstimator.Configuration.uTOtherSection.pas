unit TAPEstimator.Configuration.uTOtherSection;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  TAPEstimator.uConsts;

type

  [TSection(CONFIGURATION_OTHER_SECTION)]
  TOtherSection = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE)]
    property EnablePlaySoundOnComplete: Boolean index 0 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_RECENTS_QUANTITY)]
    property RecentsQuantity: Integer index 1 read GetIntegerValue write SetIntegerValue;
  end;

implementation

end.
