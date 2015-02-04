program DBUServerManager;

uses
  Vcl.Forms,
  System.SysUtils,
  Winapi.Windows,
  CastersPackage.uISingletonAppSession,
  CastersPackage.uTSingletonAppSession,
  DBUServerManager.uTMainForm in 'UI\DBUServerManager.uTMainForm.pas' {MainForm},
  DBUServerManager.uConsts in 'Logic\Other\DBUServerManager.uConsts.pas',
  DBUServerManager.Configuration.uTInterface in 'Logic\Classes\DBUServerManager.Configuration.uTInterface.pas',
  DBUServerManager.Configuration.uTConnection in 'Logic\Classes\DBUServerManager.Configuration.uTConnection.pas',
  DBUServerManager.uTConfiguration in 'Logic\Classes\DBUServerManager.uTConfiguration.pas',
  DBUServerManager.uTConfigurationForm in 'UI\DBUServerManager.uTConfigurationForm.pas' {Form1},
  DBUServerManager.uTUserForm in 'UI\DBUServerManager.uTUserForm.pas' {UserForm},
  DBUServerManager.uTPasswordForm in 'UI\DBUServerManager.uTPasswordForm.pas' {PasswordForm};

{$R *.res}

var
  AppSession: ISingletonAppSession;

begin
  Application.Initialize;
  Application.Title := APPLICATION_NAME;
  AppSession := GetISingletonAppSession;
  if not Assigned(AppSession) then
  begin
    Exit;
  end;

  if not AppSession.Start then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      AppSession.Activate;
    end
    else
    begin
      AppSession.ShowError;
    end;
    Exit;
  end;

  Application.HelpFile := EmptyStr;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
  if not AppSession.Stop then
  begin
    AppSession.ShowError;
  end;

end.
