program SharedMemoryClient;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uConfigurationForm in 'uConfigurationForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
