program OA5;

uses
  Forms,
  OA5Main in 'OA5Main.pas' {MainForm},
  OA5Login in 'OA5Login.pas' {LoginForm},
  OA5Types in 'OA5Types.pas',
  OA5Consts in 'OA5Consts.pas',
  OA5Routines in 'OA5Routines.pas',
  mysql in 'mysql.pas',
  OA5About in 'OA5About.pas' {AboutForm},
  OA5Options in 'OA5Options.pas' {OptionsForm},
  OA5Configuration in 'OA5Configuration.pas',
  MySQLConnection in 'MySQLConnection.pas',
  OA5User in 'OA5User.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := 'Test';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
