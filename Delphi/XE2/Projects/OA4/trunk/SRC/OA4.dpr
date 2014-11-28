program OA4;

uses
  Forms,
  IniFiles,
  SysUtils,
  ShellAPI,
  Windows,
  Users in 'UI\Users.pas' {UsersForm},
  About in 'UI\About.pas' {AboutForm},
  Login in 'UI\Login.pas' {LoginForm},
  ViewPostList in 'UI\ViewPostList.pas' {ViewPostListForm},
  SetPassword in 'UI\SetPassword.pas' {SetPasswordForm},
  Main in 'UI\Main.pas' {MainForm},
  Options in 'UI\Options.pas' {OptionsForm},
  Statistic in 'UI\Statistic.pas' {StatisticForm},
  CreateViewPost in 'UI\CreateViewPost.pas' {CreateViewPostForm},
  Phones in 'UI\Phones.pas' {PhonesForm},
  AddEditPhone in 'UI\AddEditPhone.pas' {AddEditPhoneForm},
  Clearing in 'UI\Clearing.pas' {ClearingForm},
  Maintenance in 'UI\Maintenance.pas' {MaintenanceForm},
  AddMassMsr in 'UI\AddMassMsr.pas' {AddMassMsrForm},
  MultiBuffer in 'UI\MultiBuffer.pas' {MultiBufferForm},
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
