program Project2;

uses
  Vcl.Forms,
  uTMainForm in 'uTMainForm.pas' {MainForm},
  uTCustomBSO in 'uTCustomBSO.pas',
  uIDocument in 'uIDocument.pas',
  uTCustomDocument in 'uTCustomDocument.pas',
  uTDamagedBSO in 'uTDamagedBSO.pas',
  uIArchiveBox in 'uIArchiveBox.pas',
  uTArchiveBox in 'uTArchiveBox.pas',
  uCommonRoutines in 'uCommonRoutines.pas',
  uTDocumentField in 'uTDocumentField.pas',
  uIDocumentField in 'uIDocumentField.pas',
  uTCustomDocumentClass in 'uTCustomDocumentClass.pas',
  uTShipmentBSO in 'uTShipmentBSO.pas',
  uTShipmentBSOWithAct in 'uTShipmentBSOWithAct.pas',
  uTCustomBusinessLogic in 'uTCustomBusinessLogic.pas',
  uTOnDisplayMessage in 'uTOnDisplayMessage.pas',
  uTMessageType in 'uTMessageType.pas',
  uTDocumentArchivingLogic in 'uTDocumentArchivingLogic.pas',
  uIDocumentArchivingLogic in 'uIDocumentArchivingLogic.pas',
  uIBSOArchivingLogic in 'uIBSOArchivingLogic.pas',
  uTBSOArchivingLogic in 'uTBSOArchivingLogic.pas',
  uICustomBusinessLogic in 'uICustomBusinessLogic.pas',
  uIArchiveCompany in 'uIArchiveCompany.pas',
  uTArchiveCompany in 'uTArchiveCompany.pas',
  uTArchiveCompanies in 'uTArchiveCompanies.pas',
  uIArchiveCompanies in 'uIArchiveCompanies.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
