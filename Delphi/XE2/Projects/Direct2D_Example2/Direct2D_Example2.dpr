program Direct2D_Example2;

uses
  Vcl.Forms,
  Direct2D_Example2.uTMainForm in 'Direct2D_Example2.uTMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
