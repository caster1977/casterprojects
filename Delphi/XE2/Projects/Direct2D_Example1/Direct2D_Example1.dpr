program Direct2D_Example1;

uses
  Vcl.Forms,
  Direct2D_Example1.uTMainForm in 'Direct2D_Example1.uTMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
