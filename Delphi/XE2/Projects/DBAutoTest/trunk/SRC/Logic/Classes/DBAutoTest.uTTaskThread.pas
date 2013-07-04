unit DBAutoTest.uTTaskThread;

interface

uses
  System.Classes,
  DBAutoTest.uITask;

type
  TTaskThread = class(TThread)
  strict private
    FTask: ITask;
    function GetTask: ITask;
    property Task: ITask read GetTask nodefault;
  strict private
    FSourceADOConnectionString: WideString;
    function GetSourceADOConnectionString: WideString;
    property SourceADOConnectionString: WideString read GetSourceADOConnectionString nodefault;
  strict private
    FDestinationADOConnectionString: WideString;
    function GetDestinationADOConnectionString: WideString;
    property DestinationADOConnectionString: WideString read GetDestinationADOConnectionString nodefault;
  strict private
    FSourceServerName: WideString;
    function GetSourceServerName: WideString;
    property SourceServerName: WideString read GetSourceServerName nodefault;
  strict private
    FSourceDatabaseName: WideString;
    function GetSourceDatabaseName: WideString;
    property SourceDatabaseName: WideString read GetSourceDatabaseName nodefault;
  strict private
    FThreadMessage: Cardinal;
    function RegisterThreadMessage: Boolean;
    procedure OnTerminateProc(Sender: TObject);
  protected
    procedure Execute; override;
  public
    constructor Create(const ATask: ITask;
    const ASourceADOConnectionString: WideString = '';
    const ADestinationADOConnectionString: WideString = '';
    const ASourceServerName: WideString = '';
    const ASourceDatabaseName: WideString = ''); reintroduce; virtual;
  end;

implementation

uses
  CastersPackage.uTCOMInitClass,
  System.StrUtils,
  Winapi.Windows,
  System.SysUtils,
  Data.Win.ADODB,
  Vcl.Forms,
  DBAutoTest.uConsts,
  DBAutoTest.uTTaskStatus,
  DBAutoTest.uETaskThread,
  DBAutoTest.uResourceStrings;

resourcestring
  RsITaskIsNil = 'ITask is nil.';
  RsCannotRegisterThreadMessage = 'Не удалось зарегистрировать оконное сообщение для дочернего потока.';

constructor TTaskThread.Create(const ATask: ITask;
  const ASourceADOConnectionString, ADestinationADOConnectionString, ASourceServerName, ASourceDatabaseName: WideString);
begin
  if Assigned(ATask) then
  begin
    inherited Create(True);
    Priority := tpLower;
    FreeOnTerminate := True;
    OnTerminate := OnTerminateProc;
    FTask := ATask;
    FSourceADOConnectionString := ASourceADOConnectionString;
    FDestinationADOConnectionString := ADestinationADOConnectionString;
    FSourceServerName := ASourceServerName;
    FSourceDatabaseName := ASourceDatabaseName;
  end
  else
  begin
    raise ETaskThread.Create(RsITaskIsNil);
  end;
end;

function TTaskThread.GetSourceADOConnectionString: WideString;
begin
  Result := FSourceADOConnectionString;
end;

function TTaskThread.GetSourceDatabaseName: WideString;
begin
  Result := FSourceDatabaseName;
end;

function TTaskThread.GetSourceServerName: WideString;
begin
  Result := FSourceServerName;
end;

function TTaskThread.GetDestinationADOConnectionString: WideString;
begin
  Result := FDestinationADOConnectionString;
end;

function TTaskThread.GetTask: ITask;
begin
  Result := FTask;
end;

procedure TTaskThread.OnTerminateProc(Sender: TObject);
begin
  { TODO : можно добавить код освобождения объектов или сохранения данных перед уничтожением треда }
end;

function TTaskThread.RegisterThreadMessage: Boolean;
begin
  FThreadMessage := RegisterWindowMessage(PWideChar(WM_TASK_THREAD_MESSAGE));
  Result := FThreadMessage > 0;
end;

procedure TTaskThread.Execute;
var
  query: TADOQuery;
  i: Integer;
begin
  NewCOMInitClass;
  inherited;
  if Assigned(Task) then
  begin
    Task.Status := tsExecuting;
    PostMessage(Application.MainForm.Handle, FThreadMessage, NativeUInt(Task), NativeUInt(0));
    Task.StartTime := Now;
{$IFDEF DEBUG}
    NameThreadForDebugging(AnsiString(HexDisplayPrefix + IntToHex(PInteger(Task)^, SizeOf(PInteger) * 2)));
{$ENDIF}
    if not RegisterThreadMessage then
    begin
      MessageBox(Handle, PWideChar(RsCannotRegisterThreadMessage), PWideChar(Format(RsErrorCaption, [APPLICATION_NAME])), MESSAGE_TYPE_ERROR);
      Terminate;
    end;
    i := -1;
    if Trim(Task.SQL.Text) > EmptyStr then
    begin
      query := TADOQuery.Create(Application.MainForm);
      try
        query.ConnectionString := SourceADOConnectionString;
        query.CommandTimeout := ADO_CONNECTION_DEFAULT_COMMAND_TIMEOUT;
        query.SQL.Assign(Task.SQL);
        try
          query.Open;
          if not query.Eof then
          begin
            i := query.Fields[0].AsInteger;
          end;
        finally
          query.Close;
        end;
      finally
        FreeAndNil(query);
      end;
    end;
    Synchronize(
      procedure
      begin
        { TODO : дописать }
        if i = 1 then
        begin
          Task.Status := tsComplete;
        end
        else
        begin
          Task.Status := tsError;
        end;
        Task.StopTime := Now;
        // Application.MainForm.Caption := AnsiString(HexDisplayPrefix + IntToHex(PInteger(Task)^, SizeOf(PInteger) * 2));
      end);
    PostMessage(Application.MainForm.Handle, FThreadMessage, NativeUInt(Task), NativeUInt(0));
    // сохранение результатов в базу
    if Trim(Task.SQL.Text) > EmptyStr then
    begin
      query := TADOQuery.Create(Application.MainForm);
      try
        query.ConnectionString := DestinationADOConnectionString;
        query.CommandTimeout := ADO_CONNECTION_DEFAULT_COMMAND_TIMEOUT;
        query.SQL.Text := Format('INSERT INTO TestResults ' +
          '(ServerName, DBName, GroupName, Name, Query, StartTime, FinishTime, Passed) ' +
          'VALUES (''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', %d)',
          [SourceServerName, SourceDatabaseName, Task.Group, Task.Name, StringReplace(Task.SQL.Text, Char(39), Char(39) + Char(39), [rfReplaceAll]), DateTimeToStr(Task.StartTime), DateTimeToStr(Task.StopTime), Integer(Task.Status = tsComplete)]);
        try
          query.ExecSQL;
        finally
          query.Close;
        end;
      finally
        FreeAndNil(query);
      end;
    end;
  end;
end;

end.
