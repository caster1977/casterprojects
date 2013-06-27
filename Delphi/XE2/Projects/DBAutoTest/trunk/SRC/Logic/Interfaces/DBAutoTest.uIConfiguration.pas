unit DBAutoTest.uIConfiguration;

interface

uses
  System.IniFiles,
  CastersPackage.uIIniFileDataStorage,
  DBAutoTest.uIRecents,
  DBAutoTest.uIConfigurationProperties;

type
  IConfiguration = interface(IIniFileDataStorage)
    ['{ADD776D2-4F6E-42D3-B5DD-8565A2910226}']
    function GetRecents: IRecents;
    property Recents: IRecents read GetRecents;

    function GetProperties: IConfigurationProperties;
    property Properties: IConfigurationProperties read GetProperties;
  end;

implementation

end.
