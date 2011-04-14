program Overseer;

{$R 'waves.res' 'waves.rc'}

uses
  Forms,
  Windows,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  mysql in 'mysql.pas',
  Configuration in 'Configuration.pas' {ConfigurationForm},
  FindGIUD in 'FindGIUD.pas' {FindGUIDForm},
  Login in 'Login.pas' {LoginForm},
  Accounts in 'Accounts.pas' {AccountsForm},
  AccountCreate in 'AccountCreate.pas' {AccountCreateForm},
  AccountChangePassword in 'AccountChangePassword.pas' {AccountChangePasswordForm},
  AccountProperties in 'AccountProperties.pas' {AccountPropertiesForm},
  Comments in 'Comments.pas' {CommentsForm},
  Permissions in 'Permissions.pas' {PermissionsForm},
  Thread_Do_SIC_03 in 'Thread_Do_SIC_03.pas',
  OverseerTypes in 'OverseerTypes.pas',
  OverseerConsts in 'OverseerConsts.pas',
  Thread_Do_SIC_01 in 'Thread_Do_SIC_01.pas',
  Thread_Do_SIC_07 in 'Thread_Do_SIC_07.pas',
  Thread_Do_SIC_04 in 'Thread_Do_SIC_04.pas',
  Thread_Do_SIC_05 in 'Thread_Do_SIC_05.pas',
  Thread_Do_SIC_08 in 'Thread_Do_SIC_08.pas',
  Thread_Do_SIC_09 in 'Thread_Do_SIC_09.pas',
  Thread_Do_SIC_10 in 'Thread_Do_SIC_10.pas',
  OverseerRoutines in 'OverseerRoutines.pas',
  Thread_Do_ASKR in 'Thread_Do_ASKR.pas',
  Thread_Do_SIC_06 in 'Thread_Do_SIC_06.pas';

{$R *.res}

begin
  Application.Initialize;
  if (FindWindow('TMainForm', 'Overseer')=0) then
    begin
      // Application.MainFormOnTaskbar:=True;
      Application.Title:='Overseer';
      Application.HelpFile:='';
      Application.ShowMainForm:=False;
      Application.CreateForm(TMainForm, MainForm);
  Application.Run;
    end
  else
    Application.Terminate;

end.
