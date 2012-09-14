unit OA5.uIMySQLConnection;

interface

uses
  System.Classes,
  CastersPackage.uMysql,
  CastersPackage.uLogProvider;

type
  IMySQLConnection = interface
    function GetActive: Boolean;
    procedure SetActive(const AValue: Boolean);
    function GetCompression: Boolean;
    procedure SetCompression(const AValue: Boolean);
    function GetDatabase: string;
    procedure SetDatabase(const AValue: string);
    function GetHost: string;
    procedure SetHost(const AValue: string);
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    function GetLogProvider: TLogProvider;
    procedure SetLogProvider(const AValue: TLogProvider);
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    function GetTimeout: Integer;
    procedure SetTimeout(const AValue: Integer);
    procedure Query(const ASQL: string); overload;
    procedure Query(const ASQL: string; out AResultSet: PMYSQL_RES); overload;
    function UpdateQuery(const ASQL: string): Int64;
    function FetchRow(const AResultSet: PMYSQL_RES): TStringList;
    function RowCount(const AResultSet: PMYSQL_RES): Cardinal;
    property Active: Boolean read GetActive write SetActive;
    property Compression: Boolean read GetCompression write SetCompression;
    property Database: string read GetDatabase write SetDatabase;
    property Host: string read GetHost write SetHost;
    property Login: string read GetLogin write SetLogin;
    property LogProvider: TLogProvider read GetLogProvider write SetLogProvider;
    property Password: string read GetPassword write SetPassword;
    property Port: Integer read GetPort write SetPort;
    property Timeout: Integer read GetTimeout write SetTimeout;
  end;

implementation

end.
