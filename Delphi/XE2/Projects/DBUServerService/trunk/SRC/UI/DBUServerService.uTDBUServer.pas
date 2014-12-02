// для тестовой записи иконок состояний в файл конфигурации использовать DEFINE FROM_IMAGE_LIST
// необходимо создать на форме компонент типа TImageList с именем ilStates и значением свойства ColorDepth = cd32bit
// а потом загрузить туда картинки из файлов *.png из каталога IMG проекта
unit DBUServerService.uTDBUServer;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.SvcMgr,
  IdContext,
  IdCustomTCPServer,
  IdCmdTCPServer,
  IdCommandHandlers,
  Vcl.ImgList,
  DBUServerService.uTConfiguration,
  DBUShared.uIDBUServerLogRecords,
  IdBaseComponent,
  IdComponent,
  IdTCPServer;

type
  TDBUServer = class(TService)
    IdCmdTCPServer: TIdCmdTCPServer;
    procedure IdCmdTCPServerConnect(AContext: TIdContext);
    procedure IdCmdTCPServerDisconnect(AContext: TIdContext);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure AddNewDatabaseTypeCommand(ASender: TIdCommand);
    procedure GetReserveNewDBUpdateNumbersCommand(ASender: TIdCommand);
    procedure GetSqlActionItemsCommand(ASender: TIdCommand);
    procedure GetSqlSubjItemsCommand(ASender: TIdCommand);
    procedure NewNumberLogCommand(ASender: TIdCommand); // не используется клиентом
    procedure GetNewNumberLogGridCommand(ASender: TIdCommand);
    procedure GetDbuDatabaseTypeItemsCommand(ASender: TIdCommand);
    procedure GetDbuStatesItemsCommand(ASender: TIdCommand);
    procedure IdCmdTCPServerCommandHandlers1Command(ASender: TIdCommand);
    procedure ServiceDestroy(Sender: TObject);
    procedure LoginCommand(ASender: TIdCommand);
  public
    function GetServiceController: TServiceController; override;

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  strict private
    FLog: IDBUServerLogRecords;
    function GetLog: IDBUServerLogRecords;
    property Log: IDBUServerLogRecords read GetLog nodefault;

  strict private
    function BuildDbuNewNumberLog(var ACount: SmallInt): string;
  end;

var
  DBUServer: TDBUServer;

implementation

{$R *.DFM}

uses
  CastersPackage.uRoutines,
  DBUServerService.uDBUServerUtils,
  DBUServerService.Configuration.uTConnection,
  DBUShared.uIDBUServerLogRecord,
  DBUShared.uTDBUServerLogRecord,
  DBUServerService.uIDatabaseType,
  DBUServerService.uTDatabaseType,
  System.Math,
  System.StrUtils,
  DBUServerService.uConsts,
  IdSocketHandle,
  IdGlobal,
  DBUShared.uTDBUServerLogRecords;

type
  THackImageList = class(TImageList);

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  DBUServer.Controller(CtrlCode);
end;

procedure TDBUServer.GetSqlActionItemsCommand(ASender: TIdCommand);
var
  i: Integer;
begin
  LogMessage('Start GetSqlActionItemsCommand', EVENTLOG_INFORMATION_TYPE);
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if not Assigned(Configuration.SQLActions) then
  begin
    Exit;
  end;

  ASender.Context.Connection.IOHandler.Write(Configuration.SQLActions.Count);
  for i := 0 to Pred(Configuration.SQLActions.Count) do
  begin
    ASender.Context.Connection.IOHandler.WriteLn(Format('%s:%s', [Configuration.SQLActions[i].Name,
      Configuration.SQLActions[i].Abbreviation]), IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop GetSqlActionItemsCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.GetSqlSubjItemsCommand(ASender: TIdCommand);
var
  i: Integer;
begin
  LogMessage('Start GetSqlSubjItemsCommand', EVENTLOG_INFORMATION_TYPE);
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if not Assigned(Configuration.SQLSubjects) then
  begin
    Exit;
  end;

  ASender.Context.Connection.IOHandler.Write(Configuration.SQLSubjects.Count);
  for i := 0 to Pred(Configuration.SQLSubjects.Count) do
  begin
    ASender.Context.Connection.IOHandler.WriteLn(Format('%s:%s', [Configuration.SQLSubjects[i].Name,
      Configuration.SQLSubjects[i].Abbreviation]), IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop GetSqlSubjItemsCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.GetDbuDatabaseTypeItemsCommand(ASender: TIdCommand);
var
  i: Integer;
begin
  LogMessage('Start GetDbuDatabaseTypeItemsCommand', EVENTLOG_INFORMATION_TYPE);
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if not Assigned(Configuration.DatabaseTypes) then
  begin
    Exit;
  end;

  ASender.Context.Connection.IOHandler.Write(Configuration.DatabaseTypes.Count);
  for i := 0 to Pred(Configuration.DatabaseTypes.Count) do
  begin
    ASender.Context.Connection.IOHandler.WriteLn(Configuration.DatabaseTypes[i].Name,
      IndyTextEncoding_OSDefault);
    ASender.Context.Connection.IOHandler.Write(Configuration.DatabaseTypes[i].Id);
  end;
  LogMessage('Stop GetDbuDatabaseTypeItemsCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.GetDbuStatesItemsCommand(ASender: TIdCommand);
var
  sl: TStrings;
  ms: TStream;
  i: Integer;
  s: string;
  ico: TIcon;
  il: TImageList;
begin
  LogMessage('Start GetDbuStatesItemsCommand', EVENTLOG_INFORMATION_TYPE);
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if not Assigned(Configuration.DBUStates) then
  begin
    Exit;
  end;

  sl := TStringList.Create;
  try
    for i := 0 to Pred(Configuration.DBUStates.Count) do
    begin
      s := Format('%d=%s:%d', [Configuration.DBUStates[i].Id, Configuration.DBUStates[i].Name,
        Configuration.DBUStates[i].Flags]);
      sl.Append(s);
    end;
    ASender.Context.Connection.IOHandler.Write(sl, True, IndyTextEncoding_OSDefault);

    ms := TMemoryStream.Create;
    try
      ms.Seek(0, soFromBeginning);
{$IFNDEF FROM_IMAGE_LIST}
      il := TImageList.Create(Self);
      try
        il.ColorDepth := cd32Bit;
        for i := 0 to Pred(Configuration.DBUStates.Count) do
        begin
          if Assigned(Configuration.DBUStates[i]) then
          begin
            ico := Configuration.DBUStates[i].Icon;
            if Assigned(ico) then
            begin
              il.AddIcon(ico);
            end;
          end;
        end;
        THackImageList(il).WriteData(ms);
      finally
        il.Free;
      end;
{$ELSE}
      THackImageList(ilStates).WriteData(ms);
{$ENDIF}
      ASender.Context.Connection.IOHandler.Write(ms, 0, True);
    finally
      ms.Free;
    end;

{$IFDEF FROM_IMAGE_LIST}
    for i := 0 to Pred(Configuration.DBUStates.Count) do
    begin
      ico := TIcon.Create;
      try
        ilStates.GetIcon(i, ico);
        Configuration.DBUStates[i].Icon := ico;
      finally
        ico.Free;
      end;
    end;
{$ENDIF}
  finally
    sl.Free;
  end;
  LogMessage('Stop GetDbuStatesItemsCommand', EVENTLOG_INFORMATION_TYPE);
end;

function TDBUServer.GetConfiguration: TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create;
  end;
  Result := FConfiguration;
end;

procedure TDBUServer.IdCmdTCPServerCommandHandlers1Command(ASender: TIdCommand);
begin
  LogMessage('Start IdCmdTCPServerCommandHandlers1Command', EVENTLOG_INFORMATION_TYPE);
  ASender.Context.Connection.IOHandler.WriteLn('CONNECTION_TEST_OK', IndyTextEncoding_OSDefault);
  LogMessage('Stop IdCmdTCPServerCommandHandlers1Command', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.IdCmdTCPServerConnect(AContext: TIdContext);
begin
  LogMessage(Format('Клиент "%s" подключен к серверу "%s:%d"',
    [AContext.Connection.Socket.Binding.PeerIP, IdCmdTCPServer.Bindings[0].IP,
    IdCmdTCPServer.Bindings[0].Port]), EVENTLOG_INFORMATION_TYPE, 0, 1);
end;

procedure TDBUServer.IdCmdTCPServerDisconnect(AContext: TIdContext);
begin
  LogMessage(Format('Клиент "%s" отключен от сервера "%s:%d"',
    [AContext.Connection.Socket.Binding.PeerIP, IdCmdTCPServer.Bindings[0].IP,
    IdCmdTCPServer.Bindings[0].Port]), EVENTLOG_INFORMATION_TYPE, 0, 2);
end;

function TDBUServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TDBUServer.ServiceBeforeUninstall(Sender: TService);
begin
  IdCmdTCPServer.Active := False;
  { TODO : добавить сохранение лога в файл }
end;

procedure TDBUServer.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  { TODO : добавить загрузку лога из файла }
  IdCmdTCPServer.Active := True;
end;

procedure TDBUServer.ServiceDestroy(Sender: TObject);
begin
  if Assigned(Configuration) then
  begin
    Configuration.Free;
  end;
  inherited;
end;

procedure TDBUServer.ServicePause(Sender: TService; var Paused: Boolean);
begin
  IdCmdTCPServer.Active := False;
  { TODO : добавить сохранение лога в файл }
end;

procedure TDBUServer.ServiceShutdown(Sender: TService);
begin
  IdCmdTCPServer.Active := False;
  { TODO : добавить сохранение лога в файл }
end;

procedure TDBUServer.ServiceStart(Sender: TService; var Started: Boolean);
var
  sckt: TIdSocketHandle;
begin
  { TODO : добавить загрузку лога из файла }
  IdCmdTCPServer.Bindings.Clear;
  sckt := IdCmdTCPServer.Bindings.Add;
  if Assigned(sckt) then
  begin
    sckt.IP := IfThen(Configuration.Section<TConnection>.Host = CONFIGURATION_DEFAULT_HOST,
      Routines.GetLocalIP, Configuration.Section<TConnection>.Host);
    sckt.Port := IfThen(Configuration.Section<TConnection>.Port = CONFIGURATION_DEFAULT_PORT,
      CONFIGURATION_DEFAULT_PORT, Configuration.Section<TConnection>.Port);
    IdCmdTCPServer.Active := True;
    LogMessage(Format('Сервер DBU запущен на "%s:%d"', [sckt.IP, sckt.Port]),
      EVENTLOG_INFORMATION_TYPE);
  end;
end;

procedure TDBUServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  IdCmdTCPServer.Active := False;
  { TODO : добавить сохранение лога в файл }
  LogMessage(Format('Сервер DBU остановлен на "%s:%d"', [IdCmdTCPServer.Bindings[0].IP,
    IdCmdTCPServer.Bindings[0].Port]), EVENTLOG_INFORMATION_TYPE);
end;

function TDBUServer.GetLog: IDBUServerLogRecords;
begin
  if not Assigned(FLog) then
  begin
    FLog := GetIDBUServerLogRecords;
  end;
  Result := FLog;
end;

function TDBUServer.BuildDbuNewNumberLog(var ACount: SmallInt): string;

  function BuildRecord(const AIndex: Integer): string;
  var
    i: Integer;
  begin
    Result := EmptyStr;

    for i := 0 to Pred(AIndex { cgListTV.ColumnCount } ) do
    begin
      Result := Result + { VarToStr(cgListTV.DataController.Values[AIndex, i]) } IntToStr(i) + #9;
    end;
  end;

var
  i: Integer;
begin
  Result := EmptyStr;
  ACount := Min(ACount, 10 { cgListTV.DataController.RecordCount } );
  for i := 0 to Pred(ACount) do
  begin
    Result := Result + BuildRecord(i) + sLineBreak;
  end;
end;

procedure TDBUServer.GetReserveNewDBUpdateNumbersCommand(ASender: TIdCommand);
var
  db_count: SmallInt;
  db_type: string;
  person_name: string;
  first_new_db_number: SmallInt;
  a: IDBUServerLogRecord;
begin
  LogMessage('Start GetReserveNewDBUpdateNumbersCommand', EVENTLOG_INFORMATION_TYPE);
  db_type := ASender.Context.Connection.IOHandler.ReadLn;
  db_count := ASender.Context.Connection.IOHandler.ReadSmallInt;
  person_name := ASender.Context.Connection.IOHandler.ReadLn;
  first_new_db_number := GetFirstFreeDbUpdateNumber(db_type, db_count);
  ASender.Context.Connection.IOHandler.Write(first_new_db_number);

  a := GetIDBUServerLogRecord(db_type, first_new_db_number, db_count, person_name);
  if Assigned(a) then
  begin
    Log.Add(a);
    LogMessage('Выделены новые номера для DBU.' + sLineBreak + a.ToString,
      EVENTLOG_INFORMATION_TYPE);
  end;
  LogMessage('Stop GetReserveNewDBUpdateNumbersCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.LoginCommand(ASender: TIdCommand);
var
  login: string;
  pass: string;
  t: Byte;
  s: string;
begin
  LogMessage('Start LoginCommand', EVENTLOG_INFORMATION_TYPE);
  login := Trim(ASender.Context.Connection.IOHandler.ReadLn);
  pass := ASender.Context.Connection.IOHandler.ReadLn;
  t := 1;
  { TODO : добавить код проверки валидности введённых логина и пароля на основе списка пользователей }
  { TODO : реализовать механизм редактирования списка пользователей }
  if (login = 'root') and (pass = '1-Future') then
  begin
    t := 2;
    LogMessage(Format('User %s Logon Successfully', [login]), EVENTLOG_INFORMATION_TYPE);
  end;
  ASender.Context.Connection.IOHandler.Write(t);
  LogMessage('Stop LoginCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.AddNewDatabaseTypeCommand(ASender: TIdCommand);
var
  si: SmallInt;
  db_type_name: string;
  s: string;
  dbt: IDatabaseType;
begin
  LogMessage('Start AddNewDatabaseTypeCommand', EVENTLOG_INFORMATION_TYPE);
  db_type_name := ASender.Context.Connection.IOHandler.ReadLn;
  db_type_name := Trim(db_type_name);
  si := -1;
  s := EmptyStr;
  try
    try
      dbt := Configuration.DatabaseTypes.GetItemByName(db_type_name);
      if not Assigned(dbt) then
      begin
        dbt := GetIDatabaseType;
        if Assigned(dbt) then
        begin
          dbt.Id := Succ(Configuration.DatabaseTypes.Count);
          dbt.Name := db_type_name;
          Configuration.DatabaseTypes.Add(dbt);
          si := dbt.Id;
          s := Format('Новый тип БД "%s" добавлен успешно (ID = %d)', [db_type_name, dbt.Id]);
        end;
      end
      else
      begin
        s := Format('Тип БД "%s" уже существует (ID = %d)', [dbt.Name, dbt.Id]);
      end;
    except
      on E: Exception do
      begin
        s := E.Message;
      end;
    end;
  finally
    ASender.Context.Connection.IOHandler.Write(si);
    ASender.Context.Connection.IOHandler.WriteLn(s, IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop AddNewDatabaseTypeCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.NewNumberLogCommand(ASender: TIdCommand); // не используется клиентом
var
  dbu_count: SmallInt;
  s: string;
begin
  { TODO : выкосить за ненадобностью всю связку? }
  LogMessage('Start NewNumberLogCommand', EVENTLOG_INFORMATION_TYPE);
  dbu_count := ASender.Context.Connection.IOHandler.ReadSmallInt;
  s := BuildDbuNewNumberLog(dbu_count);
  ASender.Context.Connection.IOHandler.Write(dbu_count);
  if dbu_count > 0 then
  begin
    ASender.Context.Connection.IOHandler.WriteLn(s, IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop NewNumberLogCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.GetNewNumberLogGridCommand(ASender: TIdCommand);
var
  db_type: string;
  sl: TStrings;
  i: Integer;
begin
  LogMessage('Start GetNewNumberLogGridCommand', EVENTLOG_INFORMATION_TYPE);
  { TODO : косяк в сиходной проге - тип БД не используется при выгрузке }
  db_type := ASender.Context.Connection.IOHandler.ReadLn;
  sl := TStringList.Create;
  try
    if Assigned(Log) then
    begin
      Log.ToStringList(sl);
    end;
    ASender.Context.Connection.IOHandler.Write(sl.Count);
    ASender.Context.Connection.IOHandler.WriteLn(sl[0], IndyTextEncoding_OSDefault);
    { TODO : зачем выгрузка данных происходит задом наперёд? Оо }
    for i := Pred(sl.Count) downto 1 do
    begin
      ASender.Context.Connection.IOHandler.WriteLn(sl[i], IndyTextEncoding_OSDefault);
    end;
  finally
    sl.Free;
  end;
  LogMessage('Stop GetNewNumberLogGridCommand', EVENTLOG_INFORMATION_TYPE);
end;

end.
