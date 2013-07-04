unit DBAutoTest.Configuration.uTConnection;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBAutoTest.uConsts;

type
  [TSection(CONNECTION_SECTION)]
  TConnection = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_SERVER)]
    property Server: string index 0 read GetStringValue write SetStringValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_WIN_NT_SECURITY)]
    property WinNTSecurity: Boolean index 1 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_LOGIN)]
    property Login: string index 2 read GetStringValue write SetStringValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_PASSWORD)]
    property Password: string index 3 read GetStringValue write SetStringValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD)]
    property EnableStorePassword: Boolean index 4 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_EMPTY_PASSWORD)]
    property EnableEmptyPassword: Boolean index 5 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_DATABASE)]
    property Database: string index 6 read GetStringValue write SetStringValue;
  end;

implementation

end.
