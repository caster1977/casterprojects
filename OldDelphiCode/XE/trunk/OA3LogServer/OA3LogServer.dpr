program OA3LogServer;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  SendMsgTo in 'SendMsgTo.pas' {SendMsgToForm};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm:=False;
  Application.Title := 'OperARM3 Log Server';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
