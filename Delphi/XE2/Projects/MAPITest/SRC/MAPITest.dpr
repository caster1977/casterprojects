program MAPITest;

uses
  Vcl.Forms,
  MAPITest.uTMainForm in 'UI\MAPITest.uTMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
