program Budgeting;

uses
  CodeSiteLogging,
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  Budgeting.UI.Configuration in 'UI\Budgeting.UI.Configuration.pas' {ConfigurationForm} ,
  Budgeting.Logic.Consts in 'Logic\Budgeting.Logic.Consts.pas',
  Budgeting.UI.Main in 'UI\Budgeting.UI.Main.pas' {MainForm} ,
  Budgeting.Logic.TViewEnumAction in 'Logic\Budgeting.Logic.TViewEnumAction.pas',
  Budgeting.Logic.TViewEnumActionArray in 'Logic\Budgeting.Logic.TViewEnumActionArray.pas',
  Budgeting.Logic.TViewEnumEvent in 'Logic\Budgeting.Logic.TViewEnumEvent.pas',
  Budgeting.Logic.Interfaces.IPresenter in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IPresenter.pas',
  Budgeting.Logic.Classes.TPresenter in 'Logic\Classes\Budgeting.Logic.Classes.TPresenter.pas',
  Budgeting.Logic.Classes.TPresenterMain in 'Logic\Classes\Budgeting.Logic.Classes.TPresenterMain.pas',
  Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection
    in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection.pas',
  Budgeting.Logic.Classes.Configuration.Section.TGeneral in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TGeneral.pas',
  Budgeting.Logic.Classes.Configuration.Section.TInterface in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TInterface.pas',
  Budgeting.Logic.Classes.Configuration.Section.TOther in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TOther.pas',
  Budgeting.Logic.Classes.Configuration.TConfiguration in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TConfiguration.pas',
  Budgeting.Logic.Interfaces.IView in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IView.pas',
  Budgeting.Logic.Interfaces.IViewMain in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IViewMain.pas';

{$R *.res}

var
  CodeSiteDestination: TCodeSiteDestination;
  PresenterMain: IPresenter;

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
  PresenterMain := TPresenterMain.Create(MainForm);
  Application.Run();

end.
