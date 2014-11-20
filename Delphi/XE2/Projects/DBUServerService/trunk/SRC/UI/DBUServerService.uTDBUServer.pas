unit DBUServerService.uTDBUServer;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.SvcMgr,
  Vcl.Dialogs,
  IdContext,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdTCPServer,
  IdCmdTCPServer,
  IdCommandHandlers,
  Vcl.ImgList,
  DBUServerService.uTConfiguration;

type
  TDBUServer = class(TService)
    IdCmdTCPServer: TIdCmdTCPServer;
    ilStates: TImageList;
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
    procedure NewNumberLogCommand(ASender: TIdCommand);
    procedure GetSqlActionItemsCommand(ASender: TIdCommand);
    procedure GetSqlSubjItemsCommand(ASender: TIdCommand);
    procedure GetNewNumberLogGridCommand(ASender: TIdCommand);
    procedure GetDbuDatabaseTypeItemsCommand(ASender: TIdCommand);
    procedure GetDbuStatesItemsCommand(ASender: TIdCommand);
    procedure IdCmdTCPServerCommandHandlers1Command(ASender: TIdCommand);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
  public
    function GetServiceController: TServiceController; override;
  private
    procedure AddLogRecord(const ADBType: string; const AFirstNewDBNumber, ADBCount: Integer;
      const APersonName: string);
    function BuildDbuNewNumberLog(var ACount: SmallInt): string;

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;
  strict private
    procedure ApplyConfiguration;
  end;

var
  DBUServer: TDBUServer;

implementation

{$R *.DFM}

uses
  CastersPackage.uRoutines,
  DBUServerService.uDBUServerUtils,
  System.Math,
  IdSocketHandle,
  IdGlobal;

type
  THackImageList = class(TImageList);

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  DBUServer.Controller(CtrlCode);
end;

procedure TDBUServer.AddLogRecord(const ADBType: string; const AFirstNewDBNumber, ADBCount: Integer;
  const APersonName: string);
{ var
  i: Integer; }
begin
  { cgList.BeginUpdate;
    try
    i := cgListTV.DataController.AppendRecord;
    cgListTV.DataController.Post;
    cgListTV.DataController.Values[i, cgListDateTime.Index] := Now;
    cgListTV.DataController.Values[i, cgListPerson.Index] := aPersonName;
    cgListTV.DataController.Values[i, cgListDBCount.Index] := aDBCount;
    cgListTV.DataController.Values[i, cgListFromNumber.Index] := aFirstNewDBNumber;
    cgListTV.DataController.Values[i, cgListDBType.Index] := aDBType;
    finally
    cgList.EndUpdate;
    end;
    SaveGridToFile(cgListTV, GetLogFileName); }
end;

procedure TDBUServer.AddNewDatabaseTypeCommand(ASender: TIdCommand);
var
  sl: TStrings;
  i: SmallInt;
  db_type_name: string;
  file_name: string;
  s: string;
begin
  db_type_name := ASender.Context.Connection.IOHandler.ReadLn;
  sl := TStringList.Create;
  try
    try
      file_name := GetDatabaseTypesFileName;
      if FileExists(file_name) then
      begin
        sl.LoadFromFile(file_name);
      end;

      if sl.Values[db_type_name] = EmptyStr then
      begin
        i := sl.Count + 1;
        sl.Values[db_type_name] := IntToStr(i);
        ForceDirectories(ExtractFilePath(file_name));
        sl.SaveToFile(file_name);

        if FileExists(file_name) then
        begin
          s := Format('DB type "%s = %d" added successfully', [db_type_name, i]);
        end
        else
        begin
          i := -1;
          s := Format('Can not to save Database types to file:' + sLineBreak + '"%s" at DBU-Server PC.', [file_name]);
        end;
      end
      else
      begin
        i := -1;
        s := Format('DB type "%s = %s" already exists', [db_type_name, sl.Values[db_type_name]]);
      end;

    except
      on E: Exception do
      begin
        i := -1;
        s := E.Message;
      end;
    end;
    ASender.Context.Connection.IOHandler.Write(i);
    ASender.Context.Connection.IOHandler.WriteLn(s);
  finally
    sl.Free;
  end;
end;

procedure TDBUServer.ApplyConfiguration;
begin

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

procedure TDBUServer.GetSqlActionItemsCommand(ASender: TIdCommand);
{$REGION}
{ var
  sl: TStrings;
  i: Integer;
  file_name: string;
  begin
  sl := TStringList.Create;
  try
  file_name := GetAppConfigFolder + 'SqlActionItems.lst';
  if FileExists(file_name) then
  begin
  sl.LoadFromFile(file_name);
  end;
  ASender.Context.Connection.IOHandler.Write(sl.Count);
  for i := 0 to Pred(sl.Count) do
  begin
  ASender.Context.Connection.IOHandler.WriteLn(sl[i]);
  end;
  finally
  sl.Free;
  end;
  end; }
{$ENDREGION}
var
  i: Integer;
begin
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
    ASender.Context.Connection.IOHandler.WriteLn(Configuration.SQLActions[i].ToString);
  end;
end;

procedure TDBUServer.GetSqlSubjItemsCommand(ASender: TIdCommand);
var
  sl: TStrings;
  i: Integer;
  file_name: string;
begin
  sl := TStringList.Create;
  try
    file_name := GetAppConfigFolder + 'SqlSubjItems.lst';
    if FileExists(file_name) then
    begin
      sl.LoadFromFile(file_name);
    end;
    ASender.Context.Connection.IOHandler.Write(sl.Count);
    for i := 0 to Pred(sl.Count) do
    begin
      ASender.Context.Connection.IOHandler.WriteLn(sl[i]);
    end;
  finally
    sl.Free;
  end;
end;

function TDBUServer.GetConfiguration: TConfiguration;
begin
  if not Assigned(FConfiguration) then
  begin
    FConfiguration := TConfiguration.Create;
  end;
  Result := FConfiguration;
end;

procedure TDBUServer.GetDbuDatabaseTypeItemsCommand(ASender: TIdCommand);
var
  sl: TStrings;
  i: Integer;
  file_name: string;
begin
  sl := TStringList.Create;
  try
    file_name := GetDatabaseTypesFileName;
    if FileExists(file_name) then
    begin
      sl.LoadFromFile(file_name);
    end;
    ASender.Context.Connection.IOHandler.Write(sl.Count);
    for i := 0 to Pred(sl.Count) do
    begin
      ASender.Context.Connection.IOHandler.WriteLn(sl.Names[i]);
      ASender.Context.Connection.IOHandler.Write(StrToInt(sl.ValueFromIndex[i]));
    end;
  finally
    sl.Free;
  end;
end;

procedure TDBUServer.GetDbuStatesItemsCommand(ASender: TIdCommand);
var
  sl: TStrings;
  file_name: string;
  st: TStream;
begin
  sl := TStringList.Create;
  try
    file_name := GetAppConfigFolder + 'DbuStates.lst';
    if FileExists(file_name) then
    begin
      sl.LoadFromFile(file_name);
    end;
    ASender.Context.Connection.IOHandler.Write(sl, True, IndyTextEncoding_UTF8);

    st := TMemoryStream.Create;
    try
      THackImageList(ilStates).WriteData(st);
      ASender.Context.Connection.IOHandler.Write(st, 0, True);
    finally
      st.Free;
    end;
  finally
    sl.Free;
  end;
end;

procedure TDBUServer.IdCmdTCPServerCommandHandlers1Command(ASender: TIdCommand);
begin
  ASender.Context.Connection.IOHandler.WriteLn('CONNECTION_TEST_OK');
end;

procedure TDBUServer.IdCmdTCPServerConnect(AContext: TIdContext);
begin
  LogMessage(Format('������ "%s" ���������', [AContext.Connection.Socket.Binding.PeerIP]), EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.IdCmdTCPServerDisconnect(AContext: TIdContext);
begin
  LogMessage(Format('������ "%s" ��������', [AContext.Connection.Socket.Binding.PeerIP]), EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.GetReserveNewDBUpdateNumbersCommand(ASender: TIdCommand);
var
  db_count: SmallInt;
  db_type: string;
  person_name: string;
  first_new_db_number: SmallInt;
begin
  db_type := ASender.Context.Connection.IOHandler.ReadLn;
  db_count := ASender.Context.Connection.IOHandler.ReadSmallInt;
  person_name := ASender.Context.Connection.IOHandler.ReadLn;
  first_new_db_number := GetFirstFreeDbUpdateNumber(db_type, db_count);
  ASender.Context.Connection.IOHandler.Write(first_new_db_number);
  LogMessage(Format('�������� ����� ������ ��� DBU.' + sLineBreak + ' ���: %s' + sLineBreak + ' ��������� �����: %d' +
    sLineBreak + ' ���������� �������: %d' + sLineBreak + ' ���������: %s', [db_type, first_new_db_number, db_count,
    person_name]), EVENTLOG_INFORMATION_TYPE);
  AddLogRecord(db_type, first_new_db_number, db_count, person_name);
end;

function TDBUServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TDBUServer.ServiceBeforeUninstall(Sender: TService);
begin
  IdCmdTCPServer.Active := False;
  { TODO : �������� ���������� ���� � ���� }
end;

procedure TDBUServer.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  { TODO : �������� �������� ���� �� ����� }
  IdCmdTCPServer.Active := True;
end;

procedure TDBUServer.ServiceCreate(Sender: TObject);
begin
  inherited;
  ApplyConfiguration;
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
  { TODO : �������� ���������� ���� � ���� }
end;

procedure TDBUServer.ServiceShutdown(Sender: TService);
begin
  IdCmdTCPServer.Active := False;
  { TODO : �������� ���������� ���� � ���� }
end;

procedure TDBUServer.ServiceStart(Sender: TService; var Started: Boolean);
var
  sckt: TIdSocketHandle;
begin
  { TODO : �������� �������� ���� �� ����� }
  IdCmdTCPServer.Bindings.Clear;
  sckt := IdCmdTCPServer.Bindings.Add;
  if Assigned(sckt) then
  begin
    sckt.IP := Routines.GetLocalIP;
    IdCmdTCPServer.Active := True;
    LogMessage(Format('������ DBU ������� �� "%s:%d"', [sckt.IP, sckt.Port]), EVENTLOG_INFORMATION_TYPE);
  end;
end;

procedure TDBUServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  IdCmdTCPServer.Active := False;
  { TODO : �������� ���������� ���� � ���� }
  LogMessage(Format('������ DBU ���������� �� "%s:%d"', [IdCmdTCPServer.Bindings[0].IP, IdCmdTCPServer.Bindings[0].Port]
    ), EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.GetNewNumberLogGridCommand(ASender: TIdCommand);
var
  db_type: string;
  sl: TStrings;
  i: Integer;
begin
  db_type := ASender.Context.Connection.IOHandler.ReadLn;
  sl := TStringList.Create;
  try
    sl.Text := Format('Log data for DB type = "%s"', [db_type]);
    { TODO : �������� �������� ������ �� ���������� ���� DB �� ������ ���� }
    ASender.Context.Connection.IOHandler.Write(sl.Count);
    ASender.Context.Connection.IOHandler.WriteLn(sl[0]);
    for i := Pred(sl.Count) downto 1 do
    begin
      ASender.Context.Connection.IOHandler.WriteLn(sl[i]);
    end;
  finally
    sl.Free;
  end;
end;

procedure TDBUServer.NewNumberLogCommand(ASender: TIdCommand);
var
  dbu_count: SmallInt;
  s: string;
begin
  dbu_count := ASender.Context.Connection.IOHandler.ReadSmallInt;
  s := BuildDbuNewNumberLog(dbu_count);
  ASender.Context.Connection.IOHandler.Write(dbu_count);
  if dbu_count > 0 then
  begin
    ASender.Context.Connection.IOHandler.WriteLn(s);
  end;
end;

end.
