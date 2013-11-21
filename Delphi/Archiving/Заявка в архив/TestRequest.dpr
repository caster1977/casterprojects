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
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {Form7},
  Unit8 in 'Unit8.pas' {Form8},
  Unit9 in 'Unit9.pas' {Form9},
  Unit10 in 'Unit10.pas' {Form10},
  Unit11 in 'Unit11.pas' {Form11},
  Unit12 in 'Unit12.pas' {Form12},
  Unit14 in 'Unit14.pas' {Form14},
  Unit15 in 'Unit15.pas' {Form15},
  Unit16 in 'Unit16.pas' {Form16},
  uTArchiveFrame in 'uTArchiveFrame.pas' {ArchiveFrame: TFrame},
  Unit19 in 'Unit19.pas' {Form19},
  uIPeriodFilter in 'uIPeriodFilter.pas',
  uTCommonPeriodFilter in 'uTCommonPeriodFilter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm19, Form19);
  Application.Run;
end.
