unit Budgeting.Logic.Classes.Configuration.TOtherSection;

interface

uses
  ConfigPackage.Logic.TCustomSection,
  ConfigPackage.Logic.TDefaultValueAttribute,
  ConfigPackage.Logic.TSectionAttribute,
  Budgeting.Logic.Consts;

type

  [TSection(OTHER_SECTION)]
  TOtherSection = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE)]
    property EnablePlaySoundOnComplete: Boolean index 0 read GetBooleanValue write SetBooleanValue;
  end;

implementation

end.
