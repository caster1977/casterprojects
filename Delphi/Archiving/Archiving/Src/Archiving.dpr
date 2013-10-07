program Archiving;

uses
  Vcl.Forms,
  uTTestLogicMainForm in 'UI\uTTestLogicMainForm.pas' {TestLogicMainForm},
  uTDamagedBSOArchivingBusinessLogic in 'Logic\Classes\uTDamagedBSOArchivingBusinessLogic.pas',
  uTDocumentArchivingBusinessLogic in 'Logic\Classes\uTDocumentArchivingBusinessLogic.pas',
  uTDocumentArchivingBusinessLogicClass in 'Logic\Classes\uTDocumentArchivingBusinessLogicClass.pas',
  uTShipmentBSOArchivingBusinessLogic in 'Logic\Classes\uTShipmentBSOArchivingBusinessLogic.pas',
  uTShipmentBSOWithActArchivingBusinessLogic in 'Logic\Classes\uTShipmentBSOWithActArchivingBusinessLogic.pas',
  uIDocumentArchivingBusinessLogic in 'Logic\Interfaces\uIDocumentArchivingBusinessLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestLogicMainForm, TestLogicMainForm);
  Application.Run;
end.
