unit DBAutoTest.uIProfile;

interface

uses
  System.Classes,
  DBAutoTest.uIProfileProperties,
  CastersPackage.uIIniFileDataStorage,
  DBAutoTest.uITasks;

type
  IProfile = interface(IIniFileDataStorage)
    ['{36CBBEE6-6950-4024-80B6-984A84C93A7A}']
    function GetTasks: ITasks;
    property Tasks: ITasks read GetTasks;

    function GetProperties: IProfileProperties;
    property Properties: IProfileProperties read GetProperties;

    function GetADOConnectionString: string;
    property ADOConnectionString: string read GetADOConnectionString;
  end;

implementation

end.
