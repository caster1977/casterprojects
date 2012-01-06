program COMServer;

uses
  Vcl.Forms,
  uMainFoem in 'uMainFoem.pas' {MainForm},
  TestCOMServerLib_TLB in 'TestCOMServerLib_TLB.pas';

{$R *.TLB}
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
