program TestLogic;

uses
  Vcl.Forms,
  uTTestLogicMainForm in 'uTTestLogicMainForm.pas' {TestLogicMainForm},
  uCommonRoutines in 'uCommonRoutines.pas',
  uIArchiveCompanies in 'uIArchiveCompanies.pas',
  uIArchiveCompany in 'uIArchiveCompany.pas',
  uILoadableItem in 'uILoadableItem.pas',
  uILoadableList in 'uILoadableList.pas',
  uTArchiveCompanies in 'uTArchiveCompanies.pas',
  uTArchiveCompany in 'uTArchiveCompany.pas',
  uTLoadableItem in 'uTLoadableItem.pas',
  uTLoadableItemClass in 'uTLoadableItemClass.pas',
  uTLoadableList in 'uTLoadableList.pas',
  uTLoadableListClass in 'uTLoadableListClass.pas',
  uIArchiveBoxType in 'uIArchiveBoxType.pas',
  uIArchiveBoxTypes in 'uIArchiveBoxTypes.pas',
  uTArchiveBoxTypes in 'uTArchiveBoxTypes.pas',
  uTArchiveBoxType in 'uTArchiveBoxType.pas',
  uTMessageType in 'uTMessageType.pas',
  uTOnDisplayMessage in 'uTOnDisplayMessage.pas',
  uIShowableField in 'uIShowableField.pas',
  uTShowableField in 'uTShowableField.pas',
  uICustomBusinessLogic in 'uICustomBusinessLogic.pas',
  uTCustomBusinessLogic in 'uTCustomBusinessLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestLogicMainForm, TestLogicMainForm);
  Application.Run;
end.
