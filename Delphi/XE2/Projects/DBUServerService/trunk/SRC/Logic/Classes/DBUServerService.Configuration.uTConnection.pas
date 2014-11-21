unit DBUServerService.Configuration.uTConnection;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBUServerService.uConsts;

type
  [TSection(CONNECTION_SECTION)]
  TConnection = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_HOST)]
    property Host: string index 0 read GetStringValue write SetStringValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_PORT)]
    property Port: Integer index 1 read GetIntegerValue write SetIntegerValue;
  end;

implementation

end.
