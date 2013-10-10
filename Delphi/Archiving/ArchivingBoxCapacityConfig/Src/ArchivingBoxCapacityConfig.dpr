program ArchivingBoxCapacityConfig;

uses
  Vcl.Forms,
  uTArchivingBoxCapacityConfigMainForm
    in 'UI\uTArchivingBoxCapacityConfigMainForm.pas' {ArchivingBoxCapacityConfigMainForm} ,
  uTArchivingBoxCapacityConfigBusinessLogic in 'Logic\Classes\uTArchivingBoxCapacityConfigBusinessLogic.pas',
  uIArchivingBoxCapacityConfigBusinessLogic in 'Logic\Interfaces\uIArchivingBoxCapacityConfigBusinessLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TArchivingBoxCapacityConfigMainForm, ArchivingBoxCapacityConfigMainForm);
  Application.Run;

end.
