program SharedMemoryClient;

{$R 'SharedMemoryCommon.Waves.res' '..\SharedMemoryCommon\SharedMemoryCommon.Waves.rc'}

uses
  Vcl.Forms,
  SharedMemoryClient.uMainForm in 'SharedMemoryClient.uMainForm.pas' {MainForm} ,
  SharedMemoryClient.uConfigurationForm in 'SharedMemoryClient.uConfigurationForm.pas' {ConfigurationForm} ,
  SharedMemoryClient.uAboutForm in 'SharedMemoryClient.uAboutForm.pas' {AboutForm} ,
  SharedMemoryClient.uConfigurationClass in 'SharedMemoryClient.uConfigurationClass.pas',
  SharedMemoryCommon.uChunkClass in '..\SharedMemoryCommon\SharedMemoryCommon.uChunkClass.pas',
  SharedMemoryCommon.uChunkedFileClass in '..\SharedMemoryCommon\SharedMemoryCommon.uChunkedFileClass.pas',
  SharedMemoryCommon.uCommon in '..\SharedMemoryCommon\SharedMemoryCommon.uCommon.pas',
  SharedMemoryCommon.uSharedMemClass in '..\SharedMemoryCommon\SharedMemoryCommon.uSharedMemClass.pas',
  SharedMemoryCommon.uWatchThreadClass in '..\SharedMemoryCommon\SharedMemoryCommon.uWatchThreadClass.pas',
  SharedMemoryCommon.uCommonConfigurationClass in '..\SharedMemoryCommon\SharedMemoryCommon.uCommonConfigurationClass.pas',
  SharedMemoryCommon.SharedMemoryCOMLibrary_TLB in '..\SharedMemoryCommon\SharedMemoryCommon.SharedMemoryCOMLibrary_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
