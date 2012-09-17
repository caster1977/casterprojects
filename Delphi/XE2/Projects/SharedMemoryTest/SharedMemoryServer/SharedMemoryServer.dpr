program SharedMemoryServer;

{$R 'SharedMemoryCommon.Waves.res' '..\SharedMemoryCommon\SharedMemoryCommon.Waves.rc'}

uses
  Vcl.Forms,
  SharedMemoryServer.uMainForm in 'SharedMemoryServer.uMainForm.pas' {MainForm} ,
  SharedMemoryServer.uConfigurationForm in 'SharedMemoryServer.uConfigurationForm.pas' {ConfigurationForm} ,
  SharedMemoryServer.uAboutForm in 'SharedMemoryServer.uAboutForm.pas' {AboutForm} ,
  SharedMemoryServer.uConfigurationClass in 'SharedMemoryServer.uConfigurationClass.pas',
  SharedMemoryCommon.uChunkClass in '..\SharedMemoryCommon\SharedMemoryCommon.uChunkClass.pas',
  SharedMemoryCommon.uChunkedFileClass in '..\SharedMemoryCommon\SharedMemoryCommon.uChunkedFileClass.pas',
  SharedMemoryCommon.uCommon in '..\SharedMemoryCommon\SharedMemoryCommon.uCommon.pas',
  SharedMemoryCommon.uRetranslatorThreadClass in '..\SharedMemoryCommon\SharedMemoryCommon.uRetranslatorThreadClass.pas',
  SharedMemoryCommon.uSharedMemClass in '..\SharedMemoryCommon\SharedMemoryCommon.uSharedMemClass.pas',
  SharedMemoryCommon.uCommonConfigurationClass in '..\SharedMemoryCommon\SharedMemoryCommon.uCommonConfigurationClass.pas',
  SharedMemoryCommon.uWatchThreadClass in '..\SharedMemoryCommon\SharedMemoryCommon.uWatchThreadClass.pas',
  SharedMemoryCommon.SharedMemoryCOMLibrary_TLB in '..\SharedMemoryCommon\SharedMemoryCommon.SharedMemoryCOMLibrary_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
