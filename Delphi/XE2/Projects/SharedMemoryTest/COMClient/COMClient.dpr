program COMClient;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  TestCOMServerLib_TLB in '..\COMServer\TestCOMServerLib_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
