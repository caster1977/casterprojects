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
    procedure ReserveNewDBUpdateNumbersCommand(ASender: TIdCommand);
    procedure GetSqlActionItemsCommand(ASender: TIdCommand);
    procedure GetSqlSubjItemsCommand(ASender: TIdCommand);
    procedure NewNumberLogCommand(ASender: TIdCommand); // не используется клиентом
    procedure GetNewNumberLogGridCommand(ASender: TIdCommand);
    procedure GetDbuDatabaseTypeItemsCommand(ASender: TIdCommand);
    procedure GetDbuStatesItemsCommand(ASender: TIdCommand);
    procedure ConnectionTestCommand(ASender: TIdCommand);
    procedure ServiceDestroy(Sender: TObject);
    procedure LoginCommand(ASender: TIdCommand);
    procedure GetUserListCommand(ASender: TIdCommand);
    procedure AddUserCommand(ASender: TIdCommand);
    procedure EditUserCommand(ASender: TIdCommand);
    procedure DeleteUserCommand(ASender: TIdCommand);
  public
    function GetServiceController: TServiceController; override;
    constructor Create(AOwner: TComponent); override;

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
    procedure CreateTCPCommand(const ACommand: string; const ACommandEvent: TIdCommandEvent);
    procedure CreateTCPCommands;
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
  DBUShared.uIDatabaseType,
  DBUShared.uTDatabaseType,
  DBUShared.uIUser,
  DBUShared.uTUser,
  System.Math,
  System.StrUtils,
  DBUShared.uConsts,
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
    ASender.Context.Connection.IOHandler.WriteLn(Format('%s:%s', [Configuration.SQLActions[i].Name, Configuration.SQLActions[i].Abbreviation]), IndyTextEncoding_OSDefault);
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
    ASender.Context.Connection.IOHandler.WriteLn(Format('%s:%s', [Configuration.SQLSubjects[i].Name, Configuration.SQLSubjects[i].Abbreviation]), IndyTextEncoding_OSDefault);
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
    ASender.Context.Connection.IOHandler.WriteLn(Configuration.DatabaseTypes[i].Name, IndyTextEncoding_OSDefault);
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
      s := Format('%d=%s:%d', [Configuration.DBUStates[i].Id, Configuration.DBUStates[i].Name, Configuration.DBUStates[i].Flags]);
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

procedure TDBUServer.ConnectionTestCommand(ASender: TIdCommand);
begin
  LogMessage('Start IdCmdTCPServerCommandHandlers1Command', EVENTLOG_INFORMATION_TYPE);
  ASender.Context.Connection.IOHandler.WriteLn('CONNECTION_TEST_OK', IndyTextEncoding_OSDefault);
  LogMessage('Stop IdCmdTCPServerCommandHandlers1Command', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.IdCmdTCPServerConnect(AContext: TIdContext);
begin
  LogMessage(Format('Клиент "%s" подключен к серверу "%s:%d"', [AContext.Connection.Socket.Binding.PeerIP, IdCmdTCPServer.Bindings[0].IP, IdCmdTCPServer.Bindings[0].Port]),
    EVENTLOG_INFORMATION_TYPE, 0, 1);
end;

procedure TDBUServer.IdCmdTCPServerDisconnect(AContext: TIdContext);
begin
  LogMessage(Format('Клиент "%s" отключен от сервера "%s:%d"', [AContext.Connection.Socket.Binding.PeerIP, IdCmdTCPServer.Bindings[0].IP, IdCmdTCPServer.Bindings[0].Port]),
    EVENTLOG_INFORMATION_TYPE, 0, 2);
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
    sckt.IP := IfThen(Configuration.Section<TConnection>.Host = CONFIGURATION_DEFAULT_HOST, Routines.GetLocalIP, Configuration.Section<TConnection>.Host);
    sckt.Port := IfThen(Configuration.Section<TConnection>.Port = CONFIGURATION_DEFAULT_PORT, CONFIGURATION_DEFAULT_PORT, Configuration.Section<TConnection>.Port);
    IdCmdTCPServer.Active := True;
    LogMessage(Format('Сервер DBU запущен на "%s:%d"', [sckt.IP, sckt.Port]), EVENTLOG_INFORMATION_TYPE);
  end;
end;

procedure TDBUServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  IdCmdTCPServer.Active := False;
  { TODO : добавить сохранение лога в файл }
  LogMessage(Format('Сервер DBU остановлен на "%s:%d"', [IdCmdTCPServer.Bindings[0].IP, IdCmdTCPServer.Bindings[0].Port]), EVENTLOG_INFORMATION_TYPE);
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

procedure TDBUServer.ReserveNewDBUpdateNumbersCommand(ASender: TIdCommand);
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
    LogMessage('Выделены новые номера для DBU.' + sLineBreak + a.ToString, EVENTLOG_INFORMATION_TYPE);
  end;
  LogMessage('Stop GetReserveNewDBUpdateNumbersCommand', EVENTLOG_INFORMATION_TYPE);
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

procedure TDBUServer.GetUserListCommand(ASender: TIdCommand);
var
  i: Integer;
begin
  LogMessage('Start GetUserListCommand', EVENTLOG_INFORMATION_TYPE);
  if not Assigned(Configuration) then
  begin
    Exit;
  end;

  if not Assigned(Configuration.Users) then
  begin
    Exit;
  end;

  ASender.Context.Connection.IOHandler.Write(Configuration.Users.Count);
  for i := 0 to Pred(Configuration.Users.Count) do
  begin
    ASender.Context.Connection.IOHandler.WriteLn(Format('%s%s%s%s%s%s%d%s%d', [Configuration.Users[i].Login, DEFAULT_USER_LIST_SEPARATOR, Configuration.Users[i].PasswordHash,
      DEFAULT_USER_LIST_SEPARATOR, Configuration.Users[i].FullName, DEFAULT_USER_LIST_SEPARATOR, Integer(Configuration.Users[i].Blocked), DEFAULT_USER_LIST_SEPARATOR,
      Integer(Configuration.Users[i].Administrator)]), IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop GetUserListCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.LoginCommand(ASender: TIdCommand);
var
  Login: string;
  pass: string;
  t: Byte;
  t1: Byte;
  i: Integer;
begin
  LogMessage('Start LoginCommand', EVENTLOG_INFORMATION_TYPE);
  Login := Trim(ASender.Context.Connection.IOHandler.ReadLn(IndyTextEncoding_OSDefault));
  pass := ASender.Context.Connection.IOHandler.ReadLn;
  t := 1;
  t1 := 0;
  { TODO : добавить код проверки валидности введённых логина и пароля на основе списка пользователей }
  { TODO : реализовать механизм редактирования списка пользователей }
  if Assigned(Configuration.Users) then
  begin
    for i := 0 to Pred(Configuration.Users.Count) do
    begin
      if Assigned(Configuration.Users[i]) then
      begin
        if (Login = Configuration.Users[i].Login) and (pass = Configuration.Users[i].PasswordHash) then
        begin
          if Configuration.Users[i].Blocked then
          begin
            t := 2;
            LogMessage(Format('Logon failed cause user "%s" is blocked', [Login]), EVENTLOG_INFORMATION_TYPE);
          end
          else
          begin
            t := 3;
            t1 := Integer(Configuration.Users[i].Administrator);
            LogMessage(Format('User "%s" logon successfully', [Login]), EVENTLOG_INFORMATION_TYPE);
          end;
          Break;
        end;
      end;
    end;
  end;
  ASender.Context.Connection.IOHandler.Write(t);
  if t = 3 then
  begin
    ASender.Context.Connection.IOHandler.Write(t1);
  end;
  LogMessage('Stop LoginCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.AddUserCommand(ASender: TIdCommand);
var
  user_login: string;
  user_password_hash: string;
  user_full_name: string;
  user_blocked: Byte;
  user_admin: Byte;
  u: IUser;
  t: Byte;
  s: string;
begin
  LogMessage('Start AddUserCommand', EVENTLOG_INFORMATION_TYPE);
  t := ERROR_UNKNOWN;
  s := EmptyStr;
  try
    try
      user_login := ASender.Context.Connection.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
      user_password_hash := ASender.Context.Connection.IOHandler.ReadLn;
      user_full_name := ASender.Context.Connection.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
      user_blocked := ASender.Context.Connection.IOHandler.ReadByte;
      user_admin := ASender.Context.Connection.IOHandler.ReadByte;

      if not Assigned(Configuration) then
      begin
        t := ERROR_CONFIGURATION_OBJECT_NOT_EXISTS;
        s := 'Объект конфигурации не существует';
        Exit;
      end;

      if not Assigned(Configuration.Users) then
      begin
        t := ERROR_USERS_OBJECT_NOT_EXISTS;
        s := 'Объект списка пользователей не существует';
        Exit;
      end;

      u := Configuration.Users.GetUserByLogin(user_login);
      if Assigned(u) then
      begin
        t := ERROR_USER_ALREADY_EXISTS;
        s := Format('Пользователь с логином "%s" уже существует.', [u.Login]);
        Exit;
      end;

      u := GetIUser;
      if not Assigned(u) then
      begin
        t := ERROR_CAN_NOT_CREATE_USER_OBJECT;
        s := 'Не удалось создать объект для нового пользователя';
        Exit;
      end;

      u.Login := user_login;
      u.PasswordHash := user_password_hash;
      u.FullName := user_full_name;
      u.Blocked := user_blocked = 1;
      u.Administrator := user_admin = 1;

      if Configuration.Users.Add(u) < 0 then
      begin
        t := ERROR_CAN_NOT_ADD_USER_OBJECT_TO_USERS;
        s := 'Не удалось добавить объект пользователя в список';
        Exit;
      end;

      t := SUCCESS_ADD_USER;
      s := Format('Пользователь с логином "%s" успешно добавлен', [u.Login]);
    except
      on E: Exception do
      begin
        s := E.Message;
      end;
    end;
  finally
    ASender.Context.Connection.IOHandler.Write(t);
    ASender.Context.Connection.IOHandler.WriteLn(s, IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop AddUserCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.EditUserCommand(ASender: TIdCommand);
var
  user_login: string;
  user_password_hash: string;
  user_full_name: string;
  user_blocked: Byte;
  user_admin: Byte;
  u: IUser;
  t: Byte;
  s: string;
begin
  LogMessage('Start EditUserCommand', EVENTLOG_INFORMATION_TYPE);
  t := ERROR_UNKNOWN;
  s := EmptyStr;
  try
    try
      user_login := ASender.Context.Connection.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
      user_password_hash := ASender.Context.Connection.IOHandler.ReadLn;
      user_full_name := ASender.Context.Connection.IOHandler.ReadLn(IndyTextEncoding_OSDefault);
      user_blocked := ASender.Context.Connection.IOHandler.ReadByte;
      user_admin := ASender.Context.Connection.IOHandler.ReadByte;

      if not Assigned(Configuration) then
      begin
        t := ERROR_CONFIGURATION_OBJECT_NOT_EXISTS;
        s := 'Объект конфигурации не существует';
        Exit;
      end;

      if not Assigned(Configuration.Users) then
      begin
        t := ERROR_USERS_OBJECT_NOT_EXISTS;
        s := 'Объект списка пользователей не существует';
        Exit;
      end;

      u := Configuration.Users.GetUserByLogin(user_login);
      if not Assigned(u) then
      begin
        t := ERROR_USER_NOT_EXISTS;
        s := Format('Пользователь с логином "%s" не существует.', [user_login]);
        Exit;
      end;

      u.PasswordHash := user_password_hash;
      u.FullName := user_full_name;
      u.Blocked := user_blocked = 1;
      u.Administrator := user_admin = 1;

      t := SUCCESS_EDIT_USER;
      s := Format('Данные пользователя с логином "%s" успешно исправлены', [u.Login]);
    except
      on E: Exception do
      begin
        s := E.Message;
      end;
    end;
  finally
    ASender.Context.Connection.IOHandler.Write(t);
    ASender.Context.Connection.IOHandler.WriteLn(s, IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop EditUserCommand', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.DeleteUserCommand(ASender: TIdCommand);
var
  user_login: string;
  t: Byte;
  s: string;
  i: Integer;
begin
  LogMessage('Start DeleteUserCommand', EVENTLOG_INFORMATION_TYPE);
  t := ERROR_UNKNOWN;
  s := EmptyStr;
  try
    try
      user_login := Trim(ASender.Context.Connection.IOHandler.ReadLn(IndyTextEncoding_OSDefault));

      if not Assigned(Configuration) then
      begin
        t := ERROR_CONFIGURATION_OBJECT_NOT_EXISTS;
        s := 'Объект конфигурации не существует';
        Exit;
      end;

      if not Assigned(Configuration.Users) then
      begin
        t := ERROR_USERS_OBJECT_NOT_EXISTS;
        s := 'Объект списка пользователей не существует';
        Exit;
      end;

      i := Configuration.Users.GetIndexByLogin(user_login);
      if i < 0 then
      begin
        t := ERROR_USER_NOT_EXISTS;
        s := Format('Пользователь с логином "%s" не существует.', [user_login]);
        Exit;
      end;

      Configuration.Users.Delete(i);

      i := Configuration.Users.GetIndexByLogin(user_login);
      if i > -1 then
      begin
        t := ERROR_USER_NOT_DELETED;
        s := Format('Не удалось удалить пользователя с логином "%s".', [user_login]);
        Exit;
      end;

      t := SUCCESS_DELETE_USER;
      s := Format('Пользователь с логином "%s" успешно удалён', [user_login]);
    except
      on E: Exception do
      begin
        s := E.Message;
      end;
    end;
  finally
    ASender.Context.Connection.IOHandler.Write(t);
    ASender.Context.Connection.IOHandler.WriteLn(s, IndyTextEncoding_OSDefault);
  end;
  LogMessage('Stop DeleteUserCommand', EVENTLOG_INFORMATION_TYPE);
end;

constructor TDBUServer.Create(AOwner: TComponent);
begin
  inherited;
  CreateTCPCommands;
end;

procedure TDBUServer.CreateTCPCommand(const ACommand: string; const ACommandEvent: TIdCommandEvent);
var
  ch: TIdCommandHandler;
begin
  ch := IdCmdTCPServer.CommandHandlers.Add;
  if not Assigned(ch) then
  begin
    LogMessage(Format('DBU Server: Error creating TCP command "%s"', [ACommand]), EVENTLOG_ERROR_TYPE);
    Exit;
  end;

  ch.Command := Trim(ACommand);
  ch.OnCommand := ACommandEvent;
  LogMessage(Format('DBU Server: Succesfull creating TCP command "%s"', [ACommand]), EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.CreateTCPCommands;
begin
  CreateTCPCommand(TCP_COMMAND_CONNECTION_TEST, ConnectionTestCommand);
  CreateTCPCommand(TCP_COMMAND_GET_DBU_DATABASE_TYPE_ITEMS, GetDbuDatabaseTypeItemsCommand);
  CreateTCPCommand(TCP_COMMAND_GET_DBU_STATES_ITEMS, GetDbuStatesItemsCommand);
  CreateTCPCommand(TCP_COMMAND_GET_DBU_SQL_ACTION_ITEMS, GetSqlActionItemsCommand);
  CreateTCPCommand(TCP_COMMAND_GET_DBU_SQL_SUBJ_ITEMS, GetSqlSubjItemsCommand);
  CreateTCPCommand(TCP_COMMAND_GET_DBU_NEW_NUMBER_LOG_GRID, GetNewNumberLogGridCommand);
  CreateTCPCommand(TCP_COMMAND_GET_DBU_NEW_NUMBER_LOG, NewNumberLogCommand);
  CreateTCPCommand(TCP_COMMAND_ADD_NEW_DATABASE_TYPE, AddNewDatabaseTypeCommand);
  CreateTCPCommand(TCP_COMMAND_RESERVE_NEW_DBUPDATE_NUMBER, ReserveNewDBUpdateNumbersCommand);
  CreateTCPCommand(TCP_COMMAND_LOGIN, LoginCommand);
  CreateTCPCommand(TCP_COMMAND_GET_USER_LIST, GetUserListCommand);
  CreateTCPCommand(TCP_COMMAND_ADD_USER, AddUserCommand);
  CreateTCPCommand(TCP_COMMAND_EDIT_USER, EditUserCommand);
  CreateTCPCommand(TCP_COMMAND_DELETE_USER, DeleteUserCommand);
end;

end.
