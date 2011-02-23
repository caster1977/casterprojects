program GAIDB;

uses
  Forms,
  IniFiles,
  SysUtils,
  ShellAPI,
  Windows,
  Main in 'Main.pas' {MainForm},
  Users in 'Users.pas' {UsersForm},
  About in 'About.pas' {AboutForm},
  Login in 'Login.pas' {LoginForm},
  Options in 'Options.pas' {OptionsForm},
  SetPassword in 'SetPassword.pas' {SetPasswordForm},
  mysql in 'mysql.pas',
  CreateViewPost in 'CreateViewPost.pas' {CreateViewPostForm},
  ViewPostList in 'ViewPostList.pas' {ViewPostListForm},
  Statistic in 'Statistic.pas' {StatisticForm};

{$R *.res}

var
  sCustomLogClientFile: string;
begin
  Application.Initialize;
  Application.Title := 'GAIDB';
  with TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'GAIDB.ini') do
    try
      sCustomLogClientFile:=ReadString('Лог-клиент','sCustomLogClientFile','');
    finally
      Free;
    end;
  if (((sCustomLogClientFile='') and FileExists(ExtractFilePath(ExpandFileName(Application.ExeName))+'GAIDBLogClient.exe')) or ((sCustomLogClientFile<>'') and FileExists(sCustomLogClientFile))) then
    begin
      Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TStatisticForm, StatisticForm);
  Application.Run;
    end
  else
    begin
      MessageBox(Application.Handle,PChar('Файл исполняемого модуля лог-клиента, требующийся для работы программы, не обнаружен!'+#13#10+'Обратитесь к администратору!'),PChar('Ошибка при запуске программы!'),MB_OK+MB_ICONERROR);
      Application.Terminate;
    end;
end.
