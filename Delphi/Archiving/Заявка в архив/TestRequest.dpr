program TestRequest;

uses
  Vcl.Forms,
  uTRequestForm in 'uTRequestForm.pas' {RequestForm},
  uTRequestListForm in 'uTRequestListForm.pas' {RequestListForm},
  uTArchivariusMainForm in 'uTArchivariusMainForm.pas' {ArchivariusMainForm},
  Vcl.Themes,
  Vcl.Styles,
  uTBoxAcceptanceToArchiveMainForm in 'uTBoxAcceptanceToArchiveMainForm.pas' {BoxAcceptanceToArchiveMainForm},
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {Form7},
  Unit8 in 'Unit8.pas' {Form8},
  Unit9 in 'Unit9.pas' {Form9};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
