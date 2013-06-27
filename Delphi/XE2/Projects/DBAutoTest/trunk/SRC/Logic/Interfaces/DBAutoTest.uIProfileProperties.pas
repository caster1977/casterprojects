unit DBAutoTest.uIProfileProperties;

interface

uses
  CastersPackage.uIIniFileDataStorage;

type
  IProfileProperties = interface
    ['{40A53184-6AD3-4AB4-B988-186B42F8E2FD}']
    function GetEnableStoreTasks: Boolean;
    procedure SetEnableStoreTasks(const AValue: Boolean);
    property EnableStoreTasks: Boolean read GetEnableStoreTasks write SetEnableStoreTasks;

    function GetEnableStoreOnlyEnabledTasks: Boolean;
    procedure SetEnableStoreOnlyEnabledTasks(const AValue: Boolean);
    property EnableStoreOnlyEnabledTasks: Boolean read GetEnableStoreOnlyEnabledTasks write SetEnableStoreOnlyEnabledTasks;

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

    function GetEnableStorePassword: Boolean;
    procedure SetEnableStorePassword(const AValue: Boolean);
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword;

    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
    property Database: string read GetDatabase write SetDatabase;
  end;

implementation

end.
