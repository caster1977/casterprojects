program TestGSPA;

uses
  Forms,
  Main in 'UI\Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TestGSPA';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
