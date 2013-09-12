program ArchivingTest;

uses
  Vcl.Forms,
  uTMainForm in 'uTMainForm.pas' {MainForm},
  uIArchiveBox in 'uIArchiveBox.pas',
  uTArchiveBox in 'uTArchiveBox.pas',
  uTDocumentArchivingLogic in 'uTDocumentArchivingLogic.pas',
  uIDocumentArchivingLogic in 'uIDocumentArchivingLogic.pas',
  uIBSOArchivingLogic in 'uIBSOArchivingLogic.pas',
  uTBSOArchivingLogic in 'uTBSOArchivingLogic.pas',
  uIDocumentBox in 'uIDocumentBox.pas',
  uTDocumentBox in 'uTDocumentBox.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
