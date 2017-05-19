program Budgeting;

uses
  CodeSiteLogging,
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  Budgeting.UI.Configuration in 'UI\Budgeting.UI.Configuration.pas' {ConfigurationForm},
  Budgeting.Logic.Consts in 'Logic\Budgeting.Logic.Consts.pas',
  Budgeting.Logic.Classes.Configuration.TConfiguration in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TConfiguration.pas',
  Budgeting.Logic.Classes.Configuration.TDatabaseConnectionSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TDatabaseConnectionSection.pas',
  Budgeting.Logic.Classes.Configuration.TGeneralSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TGeneralSection.pas',
  Budgeting.Logic.Classes.Configuration.TInterfaceSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TInterfaceSection.pas',
  Budgeting.Logic.Classes.Configuration.TOtherSection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TOtherSection.pas',
  Budgeting.UI.Main in 'UI\Budgeting.UI.Main.pas' {MainForm};

{$R *.res}

var
  CodeSiteDestination: TCodeSiteDestination;

begin
  CodeSiteManager.ConnectUsingTcp();
  CodeSiteDestination := TCodeSiteDestination.Create(nil);
  if Assigned(CodeSiteDestination) then
  begin
    CodeSiteDestination.LogFile.filename := ChangeFileExt(ExtractFileName(IfThen(ModuleIsLib, GetModuleName(HInstance), ParamStr(0))),
      '.' + FormatDateTime('yyyymmddhhnnss', Now(), TFormatSettings.Create('ru-ru')) + '.csl');
    CodeSiteDestination.LogFile.FilePath := ExtractFilePath(IfThen(ModuleIsLib, GetModuleName(HInstance), ParamStr(0))).Replace('\\?\', EmptyStr);
    CodeSiteDestination.LogFile.MaxSize := 5120;
    CodeSiteDestination.LogFile.Active := True;
    CodeSiteDestination.Viewer.Active := False;
    CodeSite.Destination := CodeSiteDestination;
  end;

  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run();
end.