program LogKeeper;

uses
  Forms,
  Windows,
  LogKeeper.uMainForm in 'LogKeeper.uMainForm.pas' {MainForm},
  LogKeeper.uAboutForm in 'LogKeeper.uAboutForm.pas' {AboutForm},
  LogKeeper.uMysql in 'LogKeeper.uMysql.pas',
  LogKeeper.uSendDataToMySQLServer in 'LogKeeper.uSendDataToMySQLServer.pas',
  LogKeeper.uConfigurationForm in 'LogKeeper.uConfigurationForm.pas' {ConfigurationForm},
  LogKeeper.uFindGIUDForm in 'LogKeeper.uFindGIUDForm.pas' {FindGUIDForm},
  LogKeeper.uTypes in 'LogKeeper.uTypes.pas',
  LogKeeper.uConsts in 'LogKeeper.uConsts.pas',
  LogKeeper.uRoutines in 'LogKeeper.uRoutines.pas';

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
