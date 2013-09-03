program Project2;

uses
  Vcl.Forms,
  Unit3 in 'Unit3.pas' {Form3},
  uTCustomBSODocument in 'uTCustomBSODocument.pas',
  uICustomDocument in 'uICustomDocument.pas',
  uTCustomDocument in 'uTCustomDocument.pas',
  uTDamagedBSO in 'uTDamagedBSO.pas',
  uIArchiveBox in 'uIArchiveBox.pas',
  uTArchiveBox in 'uTArchiveBox.pas',
  uCommonRoutines in 'uCommonRoutines.pas',
  uTDocumentField in 'uTDocumentField.pas',
  uIDocumentField in 'uIDocumentField.pas',
  uTCustomDocumentClass in 'uTCustomDocumentClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;

end.
