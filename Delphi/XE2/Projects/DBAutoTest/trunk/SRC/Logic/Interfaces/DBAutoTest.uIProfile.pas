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

    function GetEnableStoreTasks: Boolean;
    procedure SetEnableStoreTasks(const AValue: Boolean);
    property EnableStoreTasks: Boolean read GetEnableStoreTasks write SetEnableStoreTasks;

    function GetEnableStoreOnlyEnabledTasks: Boolean;
    procedure SetEnableStoreOnlyEnabledTasks(const AValue: Boolean);
    property EnableStoreOnlyEnabledTasks: Boolean read GetEnableStoreOnlyEnabledTasks write SetEnableStoreOnlyEnabledTasks;

    function GetADOConnectionString: string;
    property ADOConnectionString: string read GetADOConnectionString;

    function GetServer: string;
    procedure SetServer(const AValue: string);
    property Server: string read GetServer write SetServer;

    function GetWinNTSecurity: Boolean;
    procedure SetWinNTSecurity(const AValue: Boolean);
    property WinNTSecurity: Boolean read GetWinNTSecurity write SetWinNTSecurity;

    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    property Login: string read GetLogin write SetLogin;

    function GetPassword: string;
    procedure SetPassword(const AValue: string);
    property Password: string read GetPassword write SetPassword;

    function GetStorePassword: Boolean;
    procedure SetStorePassword(const AValue: Boolean);
    property StorePassword: Boolean read GetStorePassword write SetStorePassword;

    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
    property Database: string read GetDatabase write SetDatabase;
  end;

implementation

end.
