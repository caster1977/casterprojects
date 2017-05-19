program Budgeting;

uses
  Vcl.Forms,
  Budgeting.UI.Configuration in 'UI\Budgeting.UI.Configuration.pas' {ConfigurationForm},
  Budgeting.Logic.Consts in 'Logic\Budgeting.Logic.Consts.pas',
  Budgeting.Logic.Classes.Configuration.TConfiguration in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TConfiguration.pas',
  Budgeting.Logic.Classes.Configuration.TDatabaseConnectionSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TDatabaseConnectionSection.pas',
  Budgeting.Logic.Classes.Configuration.TGeneralSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TGeneralSection.pas',
  Budgeting.Logic.Classes.Configuration.TInterfaceSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TInterfaceSection.pas',
  Budgeting.Logic.Classes.Configuration.TOtherSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TOtherSection.pas';

{$R *.res}

begin
  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.Run();

end.
