program SharedMemoryCOM;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  SharedMemoryCOMLibrary_TLB in 'SharedMemoryCOMLibrary_TLB.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
