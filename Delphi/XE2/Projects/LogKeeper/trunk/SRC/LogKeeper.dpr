program LogKeeper;

uses
  Forms,
  Windows,
  LogKeeper.uMainForm in 'UI\LogKeeper.uMainForm.pas' {MainForm},
  LogKeeper.uAboutForm in 'UI\LogKeeper.uAboutForm.pas' {AboutForm},
  LogKeeper.uSendDataToMySQLServer in 'Logic\Classes\LogKeeper.uSendDataToMySQLServer.pas',
  LogKeeper.uConfigurationForm in 'UI\LogKeeper.uConfigurationForm.pas' {ConfigurationForm},
  LogKeeper.uFindGIUDForm in 'UI\LogKeeper.uFindGIUDForm.pas' {FindGUIDForm},
  LogKeeper.uTypes in 'Logic\Types\LogKeeper.uTypes.pas',
  LogKeeper.uConsts in 'Logic\Other\LogKeeper.uConsts.pas',
  LogKeeper.uRoutines in 'Logic\Other\LogKeeper.uRoutines.pas';

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
