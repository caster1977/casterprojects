program SharedMemoryServer;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uConfigurationForm in 'uConfigurationForm.pas' {ConfigurationForm},
  uConfigurationClass in 'uConfigurationClass.pas',
  uRetranslatorThreadClass in 'uRetranslatorThreadClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TConfigurationForm, ConfigurationForm);
  Application.Run;
end.
