program SharedMemoryCOM;

uses
  Vcl.Forms,
  SharedMemoryCOM.uMainForm in 'SharedMemoryCOM.uMainForm.pas' {MainForm} ,
  SharedMemoryCommon.SharedMemoryCOMLibrary_TLB in '..\SharedMemoryCommon\SharedMemoryCommon.SharedMemoryCOMLibrary_TLB.pas';

{$R *.TLB}
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
