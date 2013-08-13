unit TAPEstimator.Configuration.uTMainFormStateSection;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  TAPEstimator.uConsts;

type

  [TSection(CONFIGURATION_MAINFORM_STATE_SECTION)]
  TMainFormStateSection = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_MAINFORM_STATE)]
    property State: Integer index 0 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_MAINFORM_LEFT)]
    property Left: Integer index 1 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_MAINFORM_TOP)]
    property Top: Integer index 2 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_MAINFORM_WIDTH)]
    property Width: Integer index 3 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_MAINFORM_HEIGHT)]
    property Height: Integer index 4 read GetIntegerValue write SetIntegerValue;
  end;

implementation

end.
