program ArchivingTest;

uses
  Vcl.Forms,
  uTMainForm in 'uTMainForm.pas' {MainForm},
  uTCustomBSO in 'uTCustomBSO.pas',
  uIDocument in 'uIDocument.pas',
  uTDocument in 'uTDocument.pas',
  uTDamagedBSO in 'uTDamagedBSO.pas',
  uIArchiveBox in 'uIArchiveBox.pas',
  uTArchiveBox in 'uTArchiveBox.pas',
  uTDocumentClass in 'uTDocumentClass.pas',
  uTShipmentBSO in 'uTShipmentBSO.pas',
  uTShipmentBSOWithAct in 'uTShipmentBSOWithAct.pas',
  uTDocumentArchivingLogic in 'uTDocumentArchivingLogic.pas',
  uIDocumentArchivingLogic in 'uIDocumentArchivingLogic.pas',
  uIBSOArchivingLogic in 'uIBSOArchivingLogic.pas',
  uTBSOArchivingLogic in 'uTBSOArchivingLogic.pas',
  uIDocuments in 'uIDocuments.pas',
  uTDocuments in 'uTDocuments.pas',
  uTShipmentBSOList in 'uTShipmentBSOList.pas',
  uTShipmentBSOWithActList in 'uTShipmentBSOWithActList.pas',
  uTDamagedBSOList in 'uTDamagedBSOList.pas',
  uIDocumentBox in 'uIDocumentBox.pas',
  uTDocumentBox in 'uTDocumentBox.pas',
  uTDocumentListClass in 'uTDocumentListClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
