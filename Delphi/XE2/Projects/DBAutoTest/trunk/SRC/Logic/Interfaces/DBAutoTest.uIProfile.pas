unit DBAutoTest.uIProfile;

interface

uses
  System.Classes,
  DBAutoTest.uITasks;

type
  IProfile = interface
    ['{36CBBEE6-6950-4024-80B6-984A84C93A7A}']
    procedure Clear;
    function GetTasks: ITasks;
    property Tasks: ITasks read GetTasks;
    function GetServer: string;
    procedure SetServer(const AValue: string);
    property Server: string read GetServer write SetServer;
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    property Login: string read GetLogin write SetLogin;
    function GetDB: string;
    procedure SetDB(const AValue: string);
    property DB: string read GetDB write SetDB;
    function GetADOConnectionString: string;
    property ADOConnectionString: string read GetADOConnectionString;
  end;

implementation

end.
