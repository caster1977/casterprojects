unit DBAutoTest.uIProfile;

interface

uses
  System.Classes,
  CastersPackage.uIIniFileDataStorage,
  DBAutoTest.uITasks;

type
  IProfile = interface(IIniFileDataStorage)
    ['{36CBBEE6-6950-4024-80B6-984A84C93A7A}']
    function GetTasks: ITasks;
    property Tasks: ITasks read GetTasks;
    function GetServer: string;
    procedure SetServer(const AValue: string);
    property Server: string read GetServer write SetServer;
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    property Login: string read GetLogin write SetLogin;
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
    property Database: string read GetDatabase write SetDatabase;
    function GetADOConnectionString: string;
    property ADOConnectionString: string read GetADOConnectionString;
  end;

implementation

end.
