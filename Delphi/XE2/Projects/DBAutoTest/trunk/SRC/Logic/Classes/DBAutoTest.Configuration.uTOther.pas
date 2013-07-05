unit DBAutoTest.Configuration.uTOther;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBAutoTest.uConsts;

type
  [TSection(OTHER_SECTION)]
  TOther = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE)]
    property EnablePlaySoundOnComplete: Boolean index 0 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(RECENTS_DEFAULT_QUANTITY)]
    property RecentsQuantity: Integer index 1 read GetIntegerValue write SetIntegerValue;
  end;

implementation

end.
