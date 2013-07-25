program Direct2D_Example2;

uses
  Vcl.Forms,
  Direct2D_Example2.uTMainForm in 'Direct2D_Example2.uTMainForm.pas' {MainForm},
  uTGlowSpot in 'uTGlowSpot.pas',
  uTGlowSpotList in 'uTGlowSpotList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
