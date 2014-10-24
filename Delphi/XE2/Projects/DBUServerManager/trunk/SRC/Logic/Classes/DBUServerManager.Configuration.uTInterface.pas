unit DBUServerManager.Configuration.uTInterface;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBUServerManager.uConsts;

type
  [TSection(INTERFACE_SECTION)]
  TInterface = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION)]
    property EnableQuitConfirmation: Boolean index 0 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START)]
    property EnableSplashAtStart: Boolean index 1 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_STATUSBAR)]
    property EnableStatusbar: Boolean index 2 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_TOOLBAR)]
    property EnableToolbar: Boolean index 3 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION)]
    property EnableStoreMainFormSizesAndPosition: Boolean index 4 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_ALWAYS_SHOW_TRAY_ICON)]
    property EnableAlwaysShowTrayIcon: Boolean index 5 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_START_AT_TRAY)]
    property EnableStartAtTray: Boolean index 6 read GetBooleanValue write SetBooleanValue;
  end;

implementation

end.
