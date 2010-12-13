program LogKeeper;

uses
  Forms,
  Windows,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  mysql in 'mysql.pas',
  SendDataToMySQLServer in 'SendDataToMySQLServer.pas',
  Configuration in 'Configuration.pas' {ConfigurationForm},
  FindGIUD in 'FindGIUD.pas' {FindGUIDForm},
  LogKeeperTypes in 'LogKeeperTypes.pas',
  LogKeeperConsts in 'LogKeeperConsts.pas',
  LogKeeperRoutines in 'LogKeeperRoutines.pas';

{$R *.res}

begin
  Application.Initialize;
  if (FindWindow('TMainForm', 'LogKeeper')=0) then
    begin
      // Application.MainFormOnTaskbar:=True;
      Application.Title:='LogKeeper';
      Application.HelpFile:='';
      Application.CreateForm(TMainForm, MainForm);
  Application.Run;
    end
  else
    Application.Terminate;
end.
