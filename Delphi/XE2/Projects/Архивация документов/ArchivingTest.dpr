program ArchivingTest;

uses
  Vcl.Forms,
  uTMainForm in 'uTMainForm.pas' {MainForm},
  uTDocumentArchivingLogic in 'uTDocumentArchivingLogic.pas',
  uIDocumentArchivingLogic in 'uIDocumentArchivingLogic.pas',
  uIBSOArchivingLogic in 'uIBSOArchivingLogic.pas',
  uTBSOArchivingLogic in 'uTBSOArchivingLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
