unit uRetranslatorThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows;

type
  TRetranslatorThread=class(TThread)
  strict private
    FTimeOut: integer;
    FReadyToReadDataUserMessage: cardinal;
  protected
    procedure Execute; override;
  public
    constructor Create(const ReadyToReadDataUserMessage: cardinal; const TimeOut: integer);
  end;

implementation

{ TRetranslatorThread }

uses
  uCommon;

constructor TRetranslatorThread.Create(const ReadyToReadDataUserMessage: cardinal; const TimeOut: integer);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FTimeOut:=TimeOut;
  FReadyToReadDataUserMessage:=ReadyToReadDataUserMessage;
end;

procedure TRetranslatorThread.Execute;
begin
  while not Terminated do
    begin
      // BroadcastSystemMessage();
      PostMessage(HWND_BROADCAST, FReadyToReadDataUserMessage, 0, 0);
      Sleep(FTimeOut);
    end;
end;

end.
