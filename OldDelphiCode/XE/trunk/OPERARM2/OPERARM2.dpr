program OPERARM2;
{$R *.dres}

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  PopUp in 'PopUp.pas' {PopUpForm},
  Login in 'Login.pas' {LoginForm},
  Report in 'Report.pas' {ReportForm},
  SelectDate in 'SelectDate.pas' {SelectDateForm},
  Users in 'Users.pas' {UsersForm},
  Organizations in 'Organizations.pas' {OrganizationsForm},
  Measures in 'Measures.pas' {MeasuresForm},
  Options in 'Options.pas' {OptionsForm},
  mysql in 'mysql.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
