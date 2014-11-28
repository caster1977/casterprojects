program TestWhriteBinaryStreamToIniFile;

uses
  Forms,
  Main in 'UI\Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
