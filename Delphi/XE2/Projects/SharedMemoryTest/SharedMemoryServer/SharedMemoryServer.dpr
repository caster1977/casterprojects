program SharedMemoryServer;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uConfigurationForm in 'uConfigurationForm.pas' {ConfigurationForm},
  uAboutForm in 'uAboutForm.pas' {AboutForm},
  uConfigurationClass in 'uConfigurationClass.pas',
  uRetranslatorThreadClass in 'uRetranslatorThreadClass.pas',
  uReceiverClass in 'uReceiverClass.pas',
  uSharedFileClass in 'uSharedFileClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
