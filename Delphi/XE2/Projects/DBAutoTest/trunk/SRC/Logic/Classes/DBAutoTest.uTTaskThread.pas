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
    FADOConnectionString: WideString;
    function GetADOConnectionString: WideString;
    property ADOConnectionString: WideString read GetADOConnectionString nodefault;
  strict private
    FThreadMessage: Cardinal;
    function RegisterThreadMessage: Boolean;
    procedure OnTerminateProc(Sender: TObject);
  protected
    procedure Execute; override;
  public
    constructor Create(const ATask: ITask; const AADOConnectionString: WideString = ''); reintroduce; virtual;
  end;

implementation

uses
  CastersPackage.uTCOMInitClass,
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

constructor TTaskThread.Create(const ATask: ITask; const AADOConnectionString: WideString);
begin
  if Assigned(ATask) then
  begin
    inherited Create(True);
    Priority := tpLower;
    FreeOnTerminate := True;
    OnTerminate := OnTerminateProc;
    FTask := ATask;
    FADOConnectionString := AADOConnectionString;
  end
  else
  begin
    raise ETaskThread.Create(RsITaskIsNil);
  end;
end;

function TTaskThread.GetADOConnectionString: WideString;
begin
  Result := FADOConnectionString;
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
        query.ConnectionString := ADOConnectionString;
        query.CommandTimeout := ADO_CONNECTION_DEFAULT_COMMAND_TIMEOUT;
        query.SQL.Assign(Task.SQL);
        try
          query.Open;
          if not Eof then
          begin
            i := query.FieldValues['Result'];
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
        if i = 0 then
        begin
          Task.Status := tsComplete;
        end
        else
        begin
          Task.Status := tsError;
        end;
        // Application.MainForm.Caption := AnsiString(HexDisplayPrefix + IntToHex(PInteger(Task)^, SizeOf(PInteger) * 2));
      end);
    PostMessage(Application.MainForm.Handle, FThreadMessage, NativeUInt(Task), NativeUInt(0));
  end;
end;

end.
