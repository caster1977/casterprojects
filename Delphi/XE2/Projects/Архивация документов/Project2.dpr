program Project2;

uses
  Vcl.Forms,
  uTMainForm in 'uTMainForm.pas' {MainForm},
  uTCustomBSO in 'uTCustomBSO.pas',
  uIDocument in 'uIDocument.pas',
  uTDocument in 'uTDocument.pas',
  uTDamagedBSO in 'uTDamagedBSO.pas',
  uIArchiveBox in 'uIArchiveBox.pas',
  uTArchiveBox in 'uTArchiveBox.pas',
  uCommonRoutines in 'uCommonRoutines.pas',
  uTDocumentField in 'uTDocumentField.pas',
  uIDocumentField in 'uIDocumentField.pas',
  uTDocumentClass in 'uTDocumentClass.pas',
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
  uIArchiveCompanies in 'uIArchiveCompanies.pas',
  uIDocuments in 'uIDocuments.pas',
  uTDocuments in 'uTDocuments.pas',
  uICustomList in 'uICustomList.pas',
  uTCustomList in 'uTCustomList.pas',
  uILoadableItem in 'uILoadableItem.pas',
  uILoadableList in 'uILoadableList.pas',
  uTLoadableList in 'uTLoadableList.pas',
  uTLoadableItemClass in 'uTLoadableItemClass.pas',
  uTLoadableItem in 'uTLoadableItem.pas',
  uTLoadableListClass in 'uTLoadableListClass.pas',
  uTShipmentBSOList in 'uTShipmentBSOList.pas',
  uTShipmentBSOWithActList in 'uTShipmentBSOWithActList.pas',
  uTDamagedBSOList in 'uTDamagedBSOList.pas',
  uIDocumentBox in 'uIDocumentBox.pas',
  uTDocumentBox in 'uTDocumentBox.pas',
  uTDocumentListClass in 'uTDocumentListClass.pas',
  uIArchiveBoxTypes in 'uIArchiveBoxTypes.pas',
  uIArchiveBoxType in 'uIArchiveBoxType.pas',
  uTArchiveBoxType in 'uTArchiveBoxType.pas',
  uTArchiveBoxTypes in 'uTArchiveBoxTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
