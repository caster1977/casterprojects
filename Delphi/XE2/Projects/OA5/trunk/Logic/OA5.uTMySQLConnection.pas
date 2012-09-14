unit OA5.uTMySQLConnection;

interface

uses
  OA5.uIMySQLConnection,
  System.SysUtils,
  System.Classes,
  CastersPackage.uLogProvider,
  CastersPackage.uICustomized,
  CastersPackage.uMysql;

type
  EMySQLException = class(Exception);

  TMySQLConnection = class(TInterfacedObject, IMySQLConnection, ICustomized)
  strict private
    FActive: Boolean;
    FConnection: PMYSQL;
    FLogProvider: TLogProvider;
    FHost: string;
    FPort: Integer;
    FTimeout: Integer;
    FCompression: Boolean;
    FLogin: string;
    FPassword: string;
    FDatabase: string;
    function GetConnection: PMYSQL;
    procedure SetConnection(const AValue: PMYSQL);
    procedure SendDebug(const AValue: string);
    procedure SendInfo(const AValue: string);
    procedure SendSQL(const AValue: string);
    procedure RaiseEMySQLException(const AValue: string);
    procedure Open;
    procedure Close;
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
  protected
    property Connection: PMYSQL read GetConnection write SetConnection stored False;
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    class function PrepareStringForQuery(const ASource: string; const AAddCommas: Boolean; const AReturnNull: Boolean)
      : string; static;
    function GetLastErrorInfo: string;
    procedure Query(const ASQL: string); overload;
    procedure Query(const ASQL: string; out AResultSet: PMYSQL_RES); overload;
    function UpdateQuery(const ASQL: string): Int64;
    function FetchRow(const AResultSet: PMYSQL_RES): TStringList;
    function RowCount(const AResultSet: PMYSQL_RES): Cardinal;

    property Active: Boolean read GetActive write SetActive stored False;
    property LogProvider: TLogProvider read GetLogProvider write SetLogProvider stored False;
    property Host: string read GetHost write SetHost stored False;
    property Port: Integer read GetPort write SetPort default MYSQL_PORT;
    property Timeout: Integer read GetTimeout write SetTimeout default 30;
    property Compression: Boolean read GetCompression write SetCompression default True;
    property Login: string read GetLogin write SetLogin stored False;
    property Password: string read GetPassword write SetPassword stored False;
    property Database: string read GetDatabase write SetDatabase stored False;
  end;

function GetIMySQLConnection: IMySQLConnection;

implementation

resourcestring
  RsConnectionStarted = 'Выполняется операция подключения к MySQL-серверу "%s:%d"...';
  RsConnectionInitializationCompleteSuccessfully =
    'Инициализация объекта соединения с MySQL-сервером "%s:%d" выполнена успешно.';
  RsConnectionInitializationError = 'Возникла ошибка при инициализации объекта соединения с MySQL-сервером "%s:%d"!';
  RsConnectionCompleteSuccessfully = 'Подключение к MySQL-серверу "%s:%d" выполнено успешно.';
  RsConnectionError = 'Возникла ошибка при попытке подключения к MySQL-серверу "%s:%d"!';
  RsConnectionFinished = 'Выполнение операции подключения к MySQL-серверу "%s:%d" завершено.';
  RsDisconnectionStarted = 'Выполняется операция отключения от MySQL-сервер "%s:%d"...';
  RsDisconnectionCompleteSuccessfully = 'Отключение от MySQL-сервера "%s:%d" выполнено успешно.';
  RsDisconnectionFinished = 'Выполнение операции отключения от MySQL-сервера "%s:%d" завершено.';
  RsNULL = 'NULL';
  RsResultSetNotAssigned = 'Указатель на результат выборки равен NULL!';
  RsFetchRowStarted = 'Операция по получению строки выборки запущена...';
  RsFetchRowFinished = 'Операция по получению строки выборки завершена.';
  RsFetchRowCompleteSuccessfully = 'Данные строки выборки получены успешно.';
  RsFetchRowError = 'Возникла ошибка при получении данных очередной строки выборки!';
  RsErrorCode = 'Код ошибки: ';
  RsErrorName = 'Наименование ошибки: ';
  RsConnectionNotAssigned = 'Возникла ошибка при попытке получения указателя активного соединения!';
  RsNonResultingQueryStarted = 'Операция по выполнению SQL-запроса не возвращающего результирующую выборку запущена...';
  RsNonResultingQueryFinished = 'Операция по выполнению SQL-запроса не возвращающего результирующую выборку завершена.';
  RsConnectionDemanded = 'Для выполнения операции необходимо подключение к серверу MySQL!';
  RsConnectionVerificationError = 'Возникла ошибка при попытке проверки подключения к серверу MySQL!';
  RsQueryStarted = 'Операция по выполнению SQL-запроса запущена...';
  RsUpdateQueryStarted = 'Операция по обновлению данных таблицы базы данных ...';
  RsQueryFinished = 'Операция по выполнению SQL-запроса завершена.';
  RsUpdateQueryFinished = 'Операция по обновлению данных таблицы базы данных завершена.';
  RsSQLQueryError = 'Возникла ошибка при выполнении SQL-запроса!';
  RsNonResultingQueryCompleteSuccessfully =
    'Операция по выполнению SQL-запроса не возвращающего результирующую выборку выполнена успешно.';
  RsUpdateQueryCompleteSuccessfully = 'Операция по обновлению данных таблицы базы данных выполнена успешно.';
  RsQueryCompleteSuccessfully = 'Операция по выполнению SQL-запроса выполнена успешно.';
  RsQueryExecuted = 'SQL-запрос выполнен.';
  RsResultSetRecievedSuccessfully = 'Результирующая выборка получена успешно.';
  RsResultSetRecieveError = 'Не удалось получить результирующую выборку по SQL-запросу!';
  RsReceivedResultSetRowsCount = 'Количество строк полученной выборки: %d.';
  RsAffectedRowsCount = 'Количество обновлённых строк: %d.';
  RsAffectedRowsCountError = 'Количество обновлённых строк (%d) не соответствует требуемому (>=0)!';
  RsReceivedResultSetRowsCountError = 'Возникла ошибка при получении количества срок полученной результирующей выборки!';
  RsCommas = '"';

function GetIMySQLConnection: IMySQLConnection;
begin
  Result := TMySQLConnection.Create;
end;

function TMySQLConnection.GetActive: Boolean;
begin
  Result := FActive;
end;

function TMySQLConnection.GetCompression: Boolean;
begin
  Result := FCompression;
end;

function TMySQLConnection.GetConnection: PMYSQL;
begin
  Result := FConnection;
end;

function TMySQLConnection.GetDatabase: string;
begin
  Result := FDatabase;
end;

function TMySQLConnection.GetHost: string;
begin
  Result := FHost;
end;

function TMySQLConnection.GetLogin: string;
begin
  Result := FLogin;
end;

function TMySQLConnection.GetLogProvider: TLogProvider;
begin
  Result := FLogProvider;
end;

function TMySQLConnection.GetPassword: string;
begin
  Result := FPassword;
end;

function TMySQLConnection.GetPort: Integer;
begin
  Result := FPort;
end;

function TMySQLConnection.GetTimeout: Integer;
begin
  Result := FTimeout;
end;

procedure TMySQLConnection.Initialize;
begin
  FActive := False;
  FConnection := nil;
  FLogProvider := nil;
  FHost := EmptyStr;
  FPort := MYSQL_PORT;
  FTimeout := 30;
  FCompression := True;
  FLogin := EmptyStr;
  FPassword := EmptyStr;
  FDatabase := EmptyStr;
end;

function TMySQLConnection.GetLastErrorInfo: string;
begin
  if Assigned(FConnection) then
  begin
    Result := EmptyStr;
    if mysql_errno(FConnection) <> 0 then
    begin
      Result := sLineBreak + sLineBreak + RsErrorCode + sLineBreak + IntToStr(mysql_errno(FConnection)) + sLineBreak +
        sLineBreak + RsErrorName + sLineBreak + string(mysql_error(FConnection));
    end;
  end
  else
  begin
    raise EInvalidPointer.Create(RsConnectionNotAssigned);
  end;
end;

procedure TMySQLConnection.RaiseEMySQLException(const AValue: string);
begin
  if Assigned(FLogProvider) then
  begin
    FLogProvider.SendError(AValue + GetLastErrorInfo);
  end;
  raise EMySQLException.Create(AValue + GetLastErrorInfo);
end;

procedure TMySQLConnection.SendDebug(const AValue: string);
begin
  if Assigned(FLogProvider) then
  begin
    FLogProvider.SendDebug(AValue);
  end;
end;

procedure TMySQLConnection.SendInfo(const AValue: string);
begin
  if Assigned(FLogProvider) then
  begin
    FLogProvider.SendInfo(AValue);
  end;
end;

procedure TMySQLConnection.SendSQL(const AValue: string);
begin
  if Assigned(FLogProvider) then
  begin
    FLogProvider.SendSQL(AValue);
  end;
end;

procedure TMySQLConnection.SetCompression(const AValue: Boolean);
begin
  if FCompression <> AValue then
  begin
    FCompression := AValue;
  end;
end;

procedure TMySQLConnection.SetActive(const AValue: Boolean);
begin
  if FActive <> AValue then
  begin
    if AValue then
    begin
      Open;
    end
    else
    begin
      Close;
    end;
  end;
end;

procedure TMySQLConnection.SetConnection(const AValue: PMYSQL);
begin
  if FConnection <> AValue then
  begin
    FConnection := AValue;
  end;
end;

procedure TMySQLConnection.SetDatabase(const AValue: string);
begin
  if FDatabase <> AValue then
  begin
    FDatabase := AValue;
  end;
end;

procedure TMySQLConnection.SetHost(const AValue: string);
begin
  if FHost <> AValue then
  begin
    FHost := AValue;
  end;
end;

procedure TMySQLConnection.SetLogin(const AValue: string);
begin
  if FLogin <> AValue then
  begin
    FLogin := AValue;
  end;
end;

procedure TMySQLConnection.SetLogProvider(const AValue: TLogProvider);
begin
  if FLogProvider <> AValue then
  begin
    FLogProvider := AValue;
  end;
end;

procedure TMySQLConnection.SetPassword(const AValue: string);
begin
  if FPassword <> AValue then
  begin
    FPassword := AValue;
  end;
end;

procedure TMySQLConnection.SetPort(const AValue: Integer);
begin
  if FPort <> AValue then
  begin
    FPort := AValue;
  end;
end;

procedure TMySQLConnection.SetTimeout(const AValue: Integer);
begin
  if FTimeout <> AValue then
  begin
    FTimeout := AValue;
  end;
end;

procedure TMySQLConnection.Query(const ASQL: string);
begin
  SendDebug(RsNonResultingQueryStarted);
  try
    if Active then
    begin
      if mysql_ping(Connection) = 0 then
      begin
        SendSQL(ASQL);
        if mysql_real_query(Connection, PAnsiChar(AnsiString(ASQL)), Length(ASQL)) <> 0 then
        begin
          RaiseEMySQLException(RsSQLQueryError);
        end;
        SendDebug(RsNonResultingQueryCompleteSuccessfully);
      end
      else
      begin
        RaiseEMySQLException(RsConnectionVerificationError);
      end;
    end
    else
    begin
      RaiseEMySQLException(RsConnectionDemanded);
    end;
  finally
    SendDebug(RsNonResultingQueryFinished);
  end;
end;

procedure TMySQLConnection.Query(const ASQL: string; out AResultSet: PMYSQL_RES);
var
  rows: Int64;
begin
  SendDebug(RsQueryStarted);
  try
    if Active then
    begin
      if mysql_ping(Connection) = 0 then
      begin
        SendSQL(ASQL);
        if mysql_real_query(Connection, PAnsiChar(AnsiString(ASQL)), Length(ASQL)) = 0 then
        begin
          SendDebug(RsQueryExecuted);
          AResultSet := mysql_store_result(Connection);
          if Assigned(AResultSet) then
          begin
            SendDebug(RsResultSetRecievedSuccessfully);
            rows := mysql_num_rows(AResultSet);
            SendDebug(Format(RsReceivedResultSetRowsCount, [rows]));
            if rows < 0 then
            begin
              RaiseEMySQLException(RsReceivedResultSetRowsCountError);
            end;
            SendDebug(RsQueryCompleteSuccessfully);
          end
          else
          begin
            RaiseEMySQLException(RsResultSetRecieveError);
          end;
        end
        else
        begin
          RaiseEMySQLException(RsSQLQueryError);
        end;
      end
      else
      begin
        RaiseEMySQLException(RsConnectionVerificationError);
      end;
    end
    else
    begin
      RaiseEMySQLException(RsConnectionDemanded);
    end;
  finally
    SendDebug(RsQueryFinished);
  end;
end;

constructor TMySQLConnection.Create;
begin
  inherited;
  Initialize;
end;

destructor TMySQLConnection.Destroy;
begin
  Finalize;
  inherited;
end;

function TMySQLConnection.FetchRow(const AResultSet: PMYSQL_RES): TStringList;
var
  result_row: PMYSQL_ROW;
  i: Cardinal;
  num_fields: Cardinal;
begin
  Result := TStringList.Create;
  Result.Sorted := False;
  SendDebug(RsFetchRowStarted);
  try
    if Assigned(AResultSet) then
    begin
      result_row := mysql_fetch_row(AResultSet);
      if Assigned(result_row) then
      begin
        num_fields := mysql_num_fields(AResultSet);
        for i := 0 to num_fields - 1 do
        begin
          Result.Append(string(result_row[i]));
        end;
        SendDebug(RsFetchRowCompleteSuccessfully);
      end
      else
      begin
        RaiseEMySQLException(RsFetchRowError);
      end;
    end
    else
    begin
      raise EInvalidPointer.Create(RsResultSetNotAssigned);
    end;
  finally
    SendDebug(RsFetchRowFinished);
  end;
end;

procedure TMySQLConnection.Finalize;
begin
  Active := False;
end;

function TMySQLConnection.RowCount(const AResultSet: PMYSQL_RES): Cardinal;
begin
  if Assigned(AResultSet) then
  begin
    Result := mysql_num_rows(AResultSet);
  end
  else
  begin
    raise EInvalidPointer.Create(RsResultSetNotAssigned);
  end;
end;

function TMySQLConnection.UpdateQuery(const ASQL: string): Int64;
begin
  Result := -1;
  SendDebug(RsUpdateQueryStarted);
  try
    if Active then
    begin
      if mysql_ping(Connection) = 0 then
      begin
        SendSQL(ASQL);
        if mysql_real_query(Connection, PAnsiChar(AnsiString(ASQL)), Length(ASQL)) = 0 then
        begin
          SendDebug(RsQueryExecuted);
          Result := mysql_affected_rows(Connection);
          SendDebug(Format(RsAffectedRowsCount, [Result]));
          if Result >= 0 then
          begin
            SendDebug(RsUpdateQueryCompleteSuccessfully);
          end
          else
          begin
            RaiseEMySQLException(Format(RsAffectedRowsCountError, [Result]));
          end;
        end
        else
        begin
          RaiseEMySQLException(RsSQLQueryError);
        end;
      end
      else
      begin
        RaiseEMySQLException(RsConnectionVerificationError);
      end;
    end
    else
    begin
      RaiseEMySQLException(RsConnectionDemanded);
    end;
  finally
    SendDebug(RsUpdateQueryFinished);
  end;
end;

procedure TMySQLConnection.Open;
begin
  if not Active then
  begin
    SendDebug(Format(RsConnectionStarted, [Host, Port]));
    Connection := mysql_init(nil);
    if Assigned(Connection) then
    begin
      SendDebug(Format(RsConnectionInitializationCompleteSuccessfully, [Host, Port]));
      if Connection <> mysql_real_connect(Connection, PAnsiChar(AnsiString(Host)), PAnsiChar(AnsiString(Login)),
        PAnsiChar(AnsiString(Password)), PAnsiChar(AnsiString(Database)), Port, nil, Integer(Compression) * CLIENT_COMPRESS)
      then
      begin
        RaiseEMySQLException(Format(RsConnectionError, [Host, Port]));
      end
      else
      begin
        FActive := True;
        SendDebug(Format(RsConnectionCompleteSuccessfully, [Host, Port]));
      end;
    end
    else
    begin
      RaiseEMySQLException(Format(RsConnectionInitializationError, [Host, Port]));
    end;
    SendDebug(Format(RsConnectionFinished, [Host, Port]));
  end;
end;

procedure TMySQLConnection.Close;
begin
  if Active then
  begin
    SendDebug(Format(RsDisconnectionStarted, [Host, Port]));
    if Assigned(Connection) then
    begin
      mysql_close(Connection);
      Connection := nil;
    end;
    FActive := False;
    SendInfo(Format(RsDisconnectionCompleteSuccessfully, [Host, Port]));
    SendDebug(Format(RsDisconnectionFinished, [Host, Port]));
  end;
end;

class function TMySQLConnection.PrepareStringForQuery(const ASource: string; const AAddCommas, AReturnNull: Boolean): string;
var
  pac: PAnsiChar;
begin
  Result := EmptyStr;
  if (AReturnNull and (Trim(ASource) = EmptyStr)) then
  begin
    Result := RsNULL;
  end
  else
  begin
    pac := GetMemory(Length(PAnsiChar(AnsiString(ASource))) * 2 + 1);
    try
      mysql_escape_string(pac, PAnsiChar(AnsiString(ASource)), Length(PAnsiChar(AnsiString(ASource))));
      Result := string(StrPas(pac));
      if AAddCommas then
      begin
        Result := RsCommas + Result + RsCommas;
      end;
    finally
      FreeMemory(pac);
    end;
  end;
end;

end.
