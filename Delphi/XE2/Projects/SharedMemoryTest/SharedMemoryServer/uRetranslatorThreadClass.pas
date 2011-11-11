unit uRetranslatorThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows;

type
  TRetranslatorThread=class(TThread)
  strict private
    FPause: integer;
    FMessage: cardinal;
    FWParam: WPARAM;
    FLParam: LPARAM;
  protected
    procedure Execute; override;
  public
    constructor Create(const Msg: cardinal; const wParam: WPARAM; const lParam: LPARAM; const Pause: integer);
  end;

implementation

{ TRetranslatorThread }

uses
  uCommon;

var
  Recipients: DWORD=BSM_APPLICATIONS;

constructor TRetranslatorThread.Create(const Msg: cardinal; const wParam: WPARAM; const lParam: LPARAM; const Pause: integer);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FPause:=Pause;
  FMessage:=Msg;
  FWParam:=wParam;
  FLParam:=lParam;
end;

procedure TRetranslatorThread.Execute;
begin
  while not Terminated do
    begin
      BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, FMessage, FWParam, FLParam);
      // PostMessage(HWND_BROADCAST, FMessage, FWParam, FLParam);
      Sleep(FPause);
    end;
end;

end.
