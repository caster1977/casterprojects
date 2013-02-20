unit Beeper.uTSignalThread;

interface

uses
  System.Classes,
  Beeper.uISignal;

type
  TSignalThread = class(TThread)
  strict private
    FSignal: ISignal;
    function GetSignal: ISignal;
    property Signal: ISignal read GetSignal nodefault;
  strict private
    procedure OnTerminateProc(Sender: TObject);
  protected
    procedure Execute; override;
  public
    constructor Create(const ASignal: ISignal); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils,
  Beeper.uESignalThread;

resourcestring
  RsISignalIsNil = 'ISignal is nil.';

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

}

constructor TSignalThread.Create(const ASignal: ISignal);
begin
  if Assigned(ASignal) then
  begin
    inherited Create(True);
    Priority := tpLower;
    FreeOnTerminate := False;
    OnTerminate := OnTerminateProc;
    FSignal := ASignal;
  end
  else
  begin
    raise ESignalThread.Create(RsISignalIsNil);
  end;
end;

procedure TSignalThread.Execute;
begin
  inherited;
{$IFDEF DEBUG}
  if Assigned(Signal) then
  begin
    NameThreadForDebugging(AnsiString(HexDisplayPrefix + IntToHex(PInteger(Signal)^,
      SizeOf(PInteger) * 2)));
  end;
{$ENDIF}
  { Place thread code here }
end;

function TSignalThread.GetSignal: ISignal;
begin
  Result := FSignal;
end;

procedure TSignalThread.OnTerminateProc(Sender: TObject);
begin
  { TODO : можно добавить код освобождени€ объектов или сохранени€ данных перед уничтожением треда }
end;

end.
