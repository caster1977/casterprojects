program Overseer;

{$R 'waves.res' 'Resources\waves.rc'}

uses
  Forms,
  Windows,
  Main in 'UI\Main.pas' {MainForm},
  About in 'UI\About.pas' {AboutForm},
  Configuration in 'UI\Configuration.pas' {ConfigurationForm},
  FindGIUD in 'UI\FindGIUD.pas' {FindGUIDForm},
  Login in 'UI\Login.pas' {LoginForm},
  Accounts in 'UI\Accounts.pas' {AccountsForm},
  AccountCreate in 'UI\AccountCreate.pas' {AccountCreateForm},
  AccountChangePassword in 'UI\AccountChangePassword.pas' {AccountChangePasswordForm},
  AccountProperties in 'UI\AccountProperties.pas' {AccountPropertiesForm},
  Comments in 'UI\Comments.pas' {CommentsForm},
  Permissions in 'UI\Permissions.pas' {PermissionsForm},
  Thread_Do_SIC_03 in 'Logic\Classes\Thread_Do_SIC_03.pas',
  OverseerTypes in 'Logic\Types\OverseerTypes.pas',
  OverseerConsts in 'Logic\Other\OverseerConsts.pas',
  Thread_Do_SIC_01 in 'Logic\Classes\Thread_Do_SIC_01.pas',
  Thread_Do_SIC_07 in 'Logic\Classes\Thread_Do_SIC_07.pas',
  Thread_Do_SIC_04 in 'Logic\Classes\Thread_Do_SIC_04.pas',
  Thread_Do_SIC_05 in 'Logic\Classes\Thread_Do_SIC_05.pas',
  Thread_Do_SIC_08 in 'Logic\Classes\Thread_Do_SIC_08.pas',
  Thread_Do_SIC_09 in 'Logic\Classes\Thread_Do_SIC_09.pas',
  Thread_Do_SIC_10 in 'Logic\Classes\Thread_Do_SIC_10.pas',
  OverseerRoutines in 'Logic\Other\OverseerRoutines.pas',
  Thread_Do_ASKR in 'Logic\Classes\Thread_Do_ASKR.pas',
  Thread_Do_SIC_06 in 'Logic\Classes\Thread_Do_SIC_06.pas',
  Vcl.Themes,
  Vcl.Styles;

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
