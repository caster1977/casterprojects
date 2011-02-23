program OA3LogClient;

uses
  Forms,
  Windows,
  Main in 'Main.pas' { MainForm },
  About in 'About.pas' { AboutForm };

{$R *.res}

var
  hPreviousInstance: HWND;

begin
  Application.Initialize;
  Application.Title:='OA3 Log Client';
  Application.HelpFile:='';
  hPreviousInstance:=FindWindow('TMainForm', 'OperARM3 Log Client');
  if (hPreviousInstance>0) then
    begin
      // SetForegroundWindow(hPreviousInstance);
      Application.Terminate;
    end;
  Application.ShowMainForm:=False;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
