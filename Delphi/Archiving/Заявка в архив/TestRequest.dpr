program TestRequest;

uses
  Vcl.Forms,
  uTRequestForm in 'uTRequestForm.pas' {RequestForm},
  uTRequestListForm in 'uTRequestListForm.pas' {RequestListForm},
  uTArchivariusMainForm in 'uTArchivariusMainForm.pas' {ArchivariusMainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TArchivariusMainForm, ArchivariusMainForm);
  Application.Run;
end.
