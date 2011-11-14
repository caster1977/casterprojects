program OA4;

uses
  Forms,
  IniFiles,
  SysUtils,
  ShellAPI,
  Windows,
  Users in 'Users.pas' {UsersForm},
  About in 'About.pas' {AboutForm},
  Login in 'Login.pas' {LoginForm},
  ViewPostList in 'ViewPostList.pas' {ViewPostListForm},
  SetPassword in 'SetPassword.pas' {SetPasswordForm},
  Main in 'Main.pas' {MainForm},
  Options in 'Options.pas' {OptionsForm},
  Statistic in 'Statistic.pas' {StatisticForm},
  CreateViewPost in 'CreateViewPost.pas' {CreateViewPostForm},
  Phones in 'Phones.pas' {PhonesForm},
  AddEditPhone in 'AddEditPhone.pas' {AddEditPhoneForm},
  Clearing in 'Clearing.pas' {ClearingForm},
  Maintenance in 'Maintenance.pas' {MaintenanceForm},
  AddMassMsr in 'AddMassMsr.pas' {AddMassMsrForm},
  MultiBuffer in 'MultiBuffer.pas' {MultiBufferForm},
  mysql in 'mysql.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

var
  sCustomLogClientFile: string;

begin
  Application.Initialize;
  Application.Title:='OA4';
  with TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4.ini') do
    try
      sCustomLogClientFile:=ReadString('Лог-клиент', 'sCustomLogClientFile', '');
    finally
      Free;
    end;
  if (((sCustomLogClientFile='')and FileExists(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.exe'))or((sCustomLogClientFile<>'')and FileExists(sCustomLogClientFile))) then
    begin
      Application.CreateForm(TMainForm, MainForm);
  Application.Run;
    end
  else
    begin
      MessageBox(Application.Handle, PChar('Файл исполняемого модуля лог-клиента, требующийся для работы программы, не обнаружен!'+sLineBreak+'Обратитесь к администратору!'), PChar('Ошибка при запуске программы!'), MB_OK+MB_ICONERROR);
      Application.Terminate;
    end;
end.
