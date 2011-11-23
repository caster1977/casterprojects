unit uRetranslatorThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows,
  uCommon;

type
  TRetranslatorThreadClass=class(TThread)
  strict private
    FPause: integer;
    FMessage: cardinal;
    FWParam: WPARAM;
    FLParam: LPARAM;
  protected
    procedure Execute; override;
  public
    constructor Create(const Msg: cardinal; const wParam: WPARAM; const lParam: LPARAM; const Pause: integer=CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
  end;

implementation

var
  Recipients: DWORD=BSM_APPLICATIONS;

constructor TRetranslatorThreadClass.Create(const Msg: cardinal; const wParam: WPARAM; const lParam: LPARAM; const Pause: integer=CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FPause:=Pause;
  FMessage:=Msg;
  FWParam:=wParam;
  FLParam:=lParam;
end;

procedure TRetranslatorThreadClass.Execute;
begin
  while not Terminated do
    begin
      BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, FMessage, FWParam, FLParam); // PostMessage(HWND_BROADCAST, FMessage, FWParam, FLParam);
      Sleep(FPause);
    end;
end;

end.
