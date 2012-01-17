unit OA5.uMySQLConnectionClass;

interface

uses
  CastersPackage.uLogProvider,
  System.SysUtils,
  System.Classes,
  CastersPackage.uMysql;

type
  EMySQLException=class(Exception);

  TMySQLConnection=class
  strict private
    FConnected: boolean;
    FConnection: PMYSQL;
    FLogProvider: TLogProvider;
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
    procedure SetLogProvider(const Value: TLogProvider);
    procedure SendDebug(Value: string);
    procedure SendError(Value: string);
    procedure SendWarning(Value: string);
    procedure SendInfo(Value: string);
    procedure SendSQL(Value: string);
    procedure RaiseEMySQLException(Value: string);
  protected
    function GetLastErrorInfo: string;
    class function PrepareStringValueForQuery(const Source: string; AddCommas, ReturnNull: boolean): string; static;
    function Query(const SQL: string): integer; overload;
    function Query(const SQL: string; var ResultSet: PMYSQL_RES): integer; overload;
    function UpdateQuery(const SQL: string): integer;
    function FetchRow(const ResultSet: PMYSQL_RES): TStringList;
    function RowCount(const ResultSet: PMYSQL_RES): cardinal;
    procedure OpenConnection;
    procedure CloseConnection;
  public
    property Connected: boolean read FConnected write SetConnected stored False;
    property Connection: PMYSQL read FConnection write SetConnection stored False;
    property LogProvider: TLogProvider read FLogProvider write SetLogProvider stored False;

    property Host: string read FHost write SetHost stored False;
    property Port: integer read FPort write SetPort default MYSQL_PORT;
    property Timeout: integer read FTimeout write SetTimeout default 30;
    property Compression: boolean read FCompression write SetCompression default True;
    property Login: string read FLogin write SetLogin stored False;
    property Password: string read FPassword write SetPassword stored False;
    property Database: string read FDatabase write SetDatabase stored False;
  end;

implementation

function TMySQLConnection.GetLastErrorInfo: string;
begin
  if Assigned(FConnection) then
    if mysql_errno(FConnection)<>0 then
      Result:=sLineBreak+sLineBreak+'Код ошибки: '+sLineBreak+IntToStr(mysql_errno(FConnection))+sLineBreak+sLineBreak+'Наименование ошибки: '+sLineBreak+string(mysql_error(FConnection))
    else
      Result:=''
  else
    raise EInvalidPointer.Create('Возникла ошибка при попытке получения указателя активного соединения!');
end;

class function TMySQLConnection.PrepareStringValueForQuery(const Source: string; AddCommas, ReturnNull: boolean): string;
var
  z: PAnsiChar;
begin
  Result:='';
  if (ReturnNull and(Trim(Source)='')) then
    Result:='NULL'
  else
    begin
      z:=GetMemory(Length(PAnsiChar(AnsiString(Source)))*2+1);
      try
        mysql_escape_string(z, PAnsiChar(AnsiString(Source)), Length(PAnsiChar(AnsiString(Source))));
        if AddCommas then
          Result:='"'+string(StrPas(z))+'"'
        else
          Result:=string(StrPas(z));
      finally
        if z<>nil then
          FreeMemory(z);
      end;
    end;
end;

procedure TMySQLConnection.RaiseEMySQLException(Value: string);
begin
  if Assigned(FLogProvider) then
    FLogProvider.SendError(Value);
  raise EMySQLException.Create(Value);
end;

procedure TMySQLConnection.SendDebug(Value: string);
begin
  if Assigned(FLogProvider) then
    FLogProvider.SendDebug(Value);
end;

procedure TMySQLConnection.SendError(Value: string);
begin
  if Assigned(FLogProvider) then
    FLogProvider.SendError(Value);
end;

procedure TMySQLConnection.SendInfo(Value: string);
begin
  if Assigned(FLogProvider) then
    FLogProvider.SendInfo(Value);
end;

procedure TMySQLConnection.SendSQL(Value: string);
begin
  if Assigned(FLogProvider) then
    FLogProvider.SendSQL(Value);
end;

procedure TMySQLConnection.SendWarning(Value: string);
begin
  if Assigned(FLogProvider) then
    FLogProvider.SendWarning(Value);
end;

procedure TMySQLConnection.SetCompression(const Value: boolean);
begin
  FCompression:=Value;
end;

procedure TMySQLConnection.SetConnected(const Value: boolean);
begin
  if FConnected<>Value then
    if Value then
      CloseConnection
    else
      OpenConnection;
end;

procedure TMySQLConnection.SetConnection(const Value: PMYSQL);
begin
  if FConnection<>Value then
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

procedure TMySQLConnection.SetLogProvider(const Value: TLogProvider);
begin
  FLogProvider:=Value;
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

function TMySQLConnection.Query(const SQL: string): integer;
begin
  Result:=-1;
  SendDebug('Операция по выполнению SQL-запроса не возвращающего результирующую выборку запущена...');
  try
    if not Connected then
      RaiseEMySQLException('Для выполнения операции необходимо подключение к серверу MySQL!')
    else
      if mysql_ping(Connection)<>0 then
        RaiseEMySQLException('Возникла ошибка при попытке проверки подключения к серверу MySQL!')
      else
        begin
          SendSQL(SQL);
          if mysql_real_query(Connection, PAnsiChar(AnsiString(SQL)), Length(SQL))<>0 then
            RaiseEMySQLException('Возникла ошибка при выполнении SQL-запроса!')
          else
            begin
              Result:=0;
              SendDebug('Операция по выполнению SQL-запроса не возвращающего результирующую выборку выполнена успешно.');
            end;
        end;
  finally
    SendDebug('Операция по выполнению SQL-запроса не возвращающего результирующую выборку завершена.');
  end;
end;

function TMySQLConnection.Query(const SQL: string; var ResultSet: PMYSQL_RES): integer;
begin
  Result:=-1;
  SendDebug('Операция по выполнению SQL-запроса запущена...');
  try
    if not Connected then
      RaiseEMySQLException('Для выполнения операции необходимо подключение к серверу MySQL!')
    else
      if mysql_ping(Connection)<>0 then
        RaiseEMySQLException('Возникла ошибка при попытке проверки подключения к серверу MySQL!')
      else
        begin
          SendSQL(SQL);
          if mysql_real_query(Connection, PAnsiChar(AnsiString(SQL)), Length(SQL))<>0 then
            RaiseEMySQLException('Возникла ошибка при выполнении SQL-запроса!')
          else
            begin
              SendDebug('SQL-запрос выполнен успешно.');
              ResultSet:=mysql_store_result(Connection);
              if ResultSet=nil then
                RaiseEMySQLException('Не удалось получить результирующую выборку по SQL-запросу!')
              else
                begin
                  SendDebug('Результирующая выборка получена успешно.');
                  Result:=mysql_num_rows(ResultSet);
                  SendDebug('Количество строк выборки равно '+IntToStr(Result)+'.');
                  if Result<0 then
                    RaiseEMySQLException('Возникла ошибка при получении количества срок результирующей выборки!')
                  else
                    SendDebug('Операция по выполнению SQL-запроса выполнена успешно.');
                end;
            end;
        end;
  finally
    SendDebug('Операция по выполнению SQL-запроса завершена.');
  end;
end;

function TMySQLConnection.FetchRow(const ResultSet: PMYSQL_RES): TStringList;
var
  ResultRow: PMYSQL_ROW;
  i, num_fields: Cardinal;
begin
  SendDebug('Операция по получению строки выборки запущена...');
  try
    Result:=TStringList.Create;
    Result.Sorted:=False;

    if Assigned(ResultSet) then
      begin
        ResultRow:=mysql_fetch_row(ResultSet);
        if not Assigned(ResultRow) then
          RaiseEMySQLException('Возникла ошибка при получении данных очередной строки выборки!')
        else
          begin
            num_fields:=mysql_num_fields(ResultSet);
            for i:=0 to num_fields-1 do
              Result.Append(string(ResultRow[i]));
            SendDebug('Данные строки выборки получены успешно.');
          end;
      end;
  finally
    SendDebug('Операция по получению строки выборки завершена.');
  end;
end;

function TMySQLConnection.RowCount(const ResultSet: PMYSQL_RES): cardinal;
begin
  if not Assigned(ResultSet) then
    raise EInvalidPointer.Create('Указатель на результат выборки равен NULL!')
  else
    Result:=mysql_num_rows(ResultSet);
end;

function TMySQLConnection.UpdateQuery(const SQL: string): integer;
begin
  Result:=-1;
  SendDebug('Операция по обновления данных таблицы базы данных ...');
  try
    if not Connected then
      RaiseEMySQLException('Для выполнения операции необходимо подключение к MySQL-серверу!')
    else
      begin
        if mysql_ping(Connection)<>0 then
          RaiseEMySQLException('Возникла ошибка при попытке проверки подключения к MySQL-серверу!')
        else
          begin
            SendSQL(SQL);
            if mysql_real_query(Connection, PAnsiChar(AnsiString(SQL)), Length(SQL))<>0 then
              RaiseEMySQLException('Возникла ошибка при выполнении SQL-запроса!')
            else
              begin
                SendDebug('SQL-запрос выполнен успешно.');
                Result:=mysql_affected_rows(Connection);
                SendDebug('Количество обновлённых строк равно '+IntToStr(Result)+'.');
                if Result<0 then
                  RaiseEMySQLException('Количество обновлённых строк ('+IntToStr(Result)+') не соответствует требуемому (>=0)!')
                else
                  SendDebug('Операция по обновлению данных таблицы базы данных выполнена успешно.');
              end;
          end;
      end;
  finally
    SendDebug('Выполнение операции обновления данных таблицы базы данных завершено.');
  end;
end;

procedure TMySQLConnection.OpenConnection;
begin
  if not Connected then
    begin
      SendDebug('Выполняется операция подключения к MySQL-серверу '+Host+':'+IntToStr(Port)+'...');
      Connection:=mysql_init(nil);
      if Connection=nil then
        RaiseEMySQLException('Возникла ошибка при инициализации объекта соединения с MySQL-сервером '+Host+':'+IntToStr(Port)+'!')
      else
        begin
          SendDebug('Инициализация объекта соединения с MySQL-сервером '+Host+':'+IntToStr(Port)+' выполнена успешно.');
          if Connection<>mysql_real_connect(Connection, PAnsiChar(AnsiString(Host)), PAnsiChar(AnsiString(Login)), PAnsiChar(AnsiString(Password)), PAnsiChar(AnsiString(Database)), Port, nil, integer(Compression)*CLIENT_COMPRESS) then
            RaiseEMySQLException('Возникла ошибка при при попытке подключения к MySQL-серверу '+Host+':'+IntToStr(Port)+'!')
          else
            begin
              FConnected:=True;
              SendDebug('Подключение к MySQL-серверу '+Host+':'+IntToStr(Port)+' выполнено успешно.');
            end;
        end;
      SendDebug('Выполнение операции подключения к MySQL-серверу '+Host+':'+IntToStr(Port)+' завершено.');
    end;
end;

procedure TMySQLConnection.CloseConnection;
begin
  if Connected then
    begin
      SendDebug('Выполняется операция отключения от MySQL-сервера '+Host+':'+IntToStr(Port)+'...');
      if Assigned(Connection) then
        begin
          mysql_close(Connection);
          Connection:=nil;
        end;
      FConnected:=False;
      SendInfo('Отключение от MySQL-сервера '+Host+':'+IntToStr(Port)+' выполнено успешно.');
      SendDebug('Выполнение операции отключения от MySQL-сервера '+Host+':'+IntToStr(Port)+' завершено.');
    end;
end;

end.
