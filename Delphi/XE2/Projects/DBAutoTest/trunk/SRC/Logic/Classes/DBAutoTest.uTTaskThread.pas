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
    procedure OnTerminateProc(Sender: TObject);
  protected
    procedure Execute; override;
  public
    constructor Create(const ATask: ITask); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils,
  DBAutoTest.uETaskThread;

resourcestring
  RsITaskIsNil = 'ITask is nil.';

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

  Synchronize(UpdateCaption);

  and UpdateCaption could look like,

  procedure TSignalThread.UpdateCaption;
  begin
  Form1.Caption := 'Updated in a thread';
  end;

  or

  Synchronize(
  procedure
  begin
  Form1.Caption := 'Updated in thread via an anonymous method'
  end
  )
  );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}constructor TTaskThread.Create(const ATask: ITask);
begin
  if Assigned(ATask) then
  begin
    inherited Create(True);
    Priority := tpLower;
    FreeOnTerminate := False;
    OnTerminate := OnTerminateProc;
    FTask := ATask;
  end
  else
  begin
    raise ETaskThread.Create(RsITaskIsNil);
  end;
end;

function TTaskThread.GetTask: ITask;
begin
  Result := FTask;
end;

procedure TTaskThread.Execute;
begin
  inherited;
{$IFDEF DEBUG}
  if Assigned(Task) then
  begin
    NameThreadForDebugging(AnsiString(HexDisplayPrefix + IntToHex(PInteger(Task)^,
      SizeOf(PInteger) * 2)));
  end;
{$ENDIF}
  { Place thread code here }
end;

procedure TTaskThread.OnTerminateProc(Sender: TObject);
begin
  { TODO : можно добавить код освобождени€ объектов или сохранени€ данных перед уничтожением треда }
end;

end.
