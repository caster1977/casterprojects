program Archiving;

uses
  Vcl.Forms,
  uTArchivingMainForm in 'UI\uTArchivingMainForm.pas' {ArchivingMainForm},
  uTDamagedBSOArchivingBusinessLogic in 'Logic\Classes\uTDamagedBSOArchivingBusinessLogic.pas',
  uTDocumentArchivingBusinessLogic in 'Logic\Classes\uTDocumentArchivingBusinessLogic.pas',
  uTDocumentArchivingBusinessLogicClass in 'Logic\Classes\uTDocumentArchivingBusinessLogicClass.pas',
  uTShipmentBSOArchivingBusinessLogic in 'Logic\Classes\uTShipmentBSOArchivingBusinessLogic.pas',
  uTShipmentBSOWithActArchivingBusinessLogic in 'Logic\Classes\uTShipmentBSOWithActArchivingBusinessLogic.pas',
  uIDocumentArchivingBusinessLogic in 'Logic\Interfaces\uIDocumentArchivingBusinessLogic.pas',
  uTEnterStringForm in 'UI\uTEnterStringForm.pas' {EnterStringForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TArchivingMainForm, ArchivingMainForm);
  Application.Run;

end.
