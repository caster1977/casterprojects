program OA5;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uLoginForm in 'uLoginForm.pas' {LoginForm},
  OA5Types in 'OA5Types.pas',
  OA5Consts in 'OA5Consts.pas',
  OA5Routines in 'OA5Routines.pas',
  uAboutForm in 'uAboutForm.pas' {AboutForm},
  uConfigurationForm in 'uConfigurationForm.pas' {OptionsForm},
  uConfigurationClass in 'uConfigurationClass.pas',
  uMySQLConnectionClass in 'uMySQLConnectionClass.pas',
  uUserClass in 'uUserClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.Title := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
