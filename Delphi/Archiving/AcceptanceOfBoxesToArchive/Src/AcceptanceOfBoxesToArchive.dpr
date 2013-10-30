program AcceptanceOfBoxesToArchive;

uses
  Vcl.Forms,
  uTAcceptanceOfBoxesToArchiveMainForm
    in 'UI\uTAcceptanceOfBoxesToArchiveMainForm.pas' {AcceptanceOfBoxesToArchiveMainForm} ,
  uIAcceptanceOfBoxesToArchiveBusinessLogic in 'Logic\Interfaces\uIAcceptanceOfBoxesToArchiveBusinessLogic.pas',
  uTAcceptanceOfBoxesToArchiveBusinessLogic in 'Logic\Classes\uTAcceptanceOfBoxesToArchiveBusinessLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAcceptanceOfBoxesToArchiveMainForm, AcceptanceOfBoxesToArchiveMainForm);
  Application.Run;

end.
