program Comtest;

uses
  Forms,
  Unit1 in 'UNIT1.PAS' {Form1},
  ComPort in 'ComPort.pas',
  ComBin in 'ComBin.pas';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
