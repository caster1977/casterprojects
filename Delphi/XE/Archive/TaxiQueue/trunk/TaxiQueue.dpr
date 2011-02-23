program TaxiQueue;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  Login in 'Login.pas' {LoginForm},
  ConfirmDelete in 'ConfirmDelete.pas' {ConfirmDeleteForm},
  mysql in 'mysql.pas',
  InvalidePassword in 'InvalidePassword.pas' {InvalidePasswordForm},
  AddingCar in 'AddingCar.pas' {AddingCarForm},
  Logoff in 'Logoff.pas' {LogoffForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TaxiQueue 1.11';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
