unit MySQLConnection;

interface

uses
  mysql;

type
  TMySQLConnection=class
  strict private
    FConnected: boolean;
    FConnection: PMYSQL;
    FHost: string;
    FPort: integer;
    FTimeout: integer;
    FCompression: boolean;
    FLogin: string;
    FPassword: string;
    FDatabase: string;
    procedure SetConnected(const Value: boolean);
    procedure SetConnection(const Value: PMYSQL);
    procedure SetHost(const Value: string);
    procedure SetPort(const Value: integer);
    procedure SetTimeout(const Value: integer);
    procedure SetCompression(const Value: boolean);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetDatabase(const Value: string);
  public
    property Connected: boolean read FConnected write SetConnected;
    property Connection: PMYSQL read FConnection write SetConnection;
    property Host: string read FHost write SetHost;
    property Port: integer read FPort write SetPort default MYSQL_PORT;
    property Timeout: integer read FTimeout write SetTimeout default 30;
    property Compression: boolean read FCompression write SetCompression default True;
    property Login: string read FLogin write SetLogin;
    property Password: string read FPassword write SetPassword;
    property Database: string read FDatabase write SetDatabase;
    function GetLastErrorInfo: string;
  end;

implementation

uses
  SysUtils;

function TMySQLConnection.GetLastErrorInfo: string;
begin
  if mysql_errno(FConnection)<>0 then
    Result:=#10#13+#10#13+'Код ошибки: '+#10#13+IntToStr(mysql_errno(FConnection))+#10#13+#10#13+'Наименование ошибки: '+#10#13+string(mysql_error(FConnection))
  else
    Result:='';
end;

procedure TMySQLConnection.SetCompression(const Value: boolean);
begin
  FCompression:=Value;
end;

procedure TMySQLConnection.SetConnected(const Value: boolean);
begin
  FConnected:=Value;
end;

procedure TMySQLConnection.SetConnection(const Value: PMYSQL);
begin
  FConnection:=Value;
end;

procedure TMySQLConnection.SetDatabase(const Value: string);
begin
  FDatabase:=Value;
end;

procedure TMySQLConnection.SetHost(const Value: string);
begin
  FHost:=Value;
end;

procedure TMySQLConnection.SetLogin(const Value: string);
begin
  FLogin:=Value;
end;

procedure TMySQLConnection.SetPassword(const Value: string);
begin
  FPassword:=Value;
end;

procedure TMySQLConnection.SetPort(const Value: integer);
begin
  FPort:=Value;
end;

procedure TMySQLConnection.SetTimeout(const Value: integer);
begin
  FTimeout:=Value;
end;

end.
