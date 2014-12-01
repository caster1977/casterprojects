unit DBUServerManager.Configuration.uTConnection;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBUServerManager.uConsts;

type

  [TSection(CONNECTION_SECTION)]
  TConnection = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_HOST)]
    property Host: string index 0 read GetStringValue write SetStringValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_PORT)]
    property Port: Integer index 1 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_TIMEOUT)]
    property Timeout: Integer index 2 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_STORE_LOGIN)]
    property EnableStoreLogin: Boolean index 3 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_STORE_PASSWORD)]
    property EnableStorePassword: Boolean index 4 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_AUTO_LOGON)]
    property EnableAutoLogon: Boolean index 5 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_LOGIN)]
    property Login: string index 6 read GetStringValue write SetStringValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_PASSWORD)]
    property Password: string index 7 read GetStringValue write SetStringValue;
  end;

implementation

end.
