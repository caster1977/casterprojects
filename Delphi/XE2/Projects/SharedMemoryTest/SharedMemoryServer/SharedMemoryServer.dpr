program SharedMemoryServer;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uConfigurationForm in 'uConfigurationForm.pas' {ConfigurationForm},
  uAboutForm in 'uAboutForm.pas' {AboutForm},
  uConfigurationClass in 'uConfigurationClass.pas',
  uRetranslatorThreadClass in 'uRetranslatorThreadClass.pas',
  uSharedMemClass in 'uSharedMemClass.pas',
  uChunkClass in 'uChunkClass.pas',
  uChunkedFileClass in 'uChunkedFileClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
