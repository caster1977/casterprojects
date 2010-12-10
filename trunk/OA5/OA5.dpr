program OA5;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Login in 'Login.pas' {LoginForm},
  OA5Types in 'OA5Types.pas',
  OA5Consts in 'OA5Consts.pas',
  OA5Routines in 'OA5Routines.pas',
  mysql in 'mysql.pas',
  About in 'About.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
