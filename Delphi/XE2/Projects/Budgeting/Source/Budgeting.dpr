program Budgeting;

uses
  CodeSiteLogging,
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  Budgeting.UI.Configuration in 'UI\Budgeting.UI.Configuration.pas' {ConfigurationForm},
  Budgeting.Logic.Consts in 'Logic\Budgeting.Logic.Consts.pas',
  Budgeting.UI.Main in 'UI\Budgeting.UI.Main.pas' {MainForm},
  Budgeting.Logic.TViewEnumAction in 'Logic\Budgeting.Logic.TViewEnumAction.pas',
  Budgeting.Logic.TViewEnumActionArray in 'Logic\Budgeting.Logic.TViewEnumActionArray.pas',
  Budgeting.Logic.TViewEnumEvent in 'Logic\Budgeting.Logic.TViewEnumEvent.pas',
  Budgeting.Logic.Interfaces.IPresenter in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IPresenter.pas',
  Budgeting.Logic.Classes.TPresenter in 'Logic\Classes\Budgeting.Logic.Classes.TPresenter.pas',
  Budgeting.Logic.Classes.TPresenterMain in 'Logic\Classes\Budgeting.Logic.Classes.TPresenterMain.pas',
  Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection.pas',
  Budgeting.Logic.Classes.Configuration.Section.TGeneral in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TGeneral.pas',
  Budgeting.Logic.Classes.Configuration.Section.TInterface in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TInterface.pas',
  Budgeting.Logic.Classes.Configuration.Section.TOther in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.Section.TOther.pas',
  Budgeting.Logic.Classes.Configuration.TConfiguration in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TConfiguration.pas',
  Budgeting.Logic.Interfaces.IView in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IView.pas',
  Budgeting.Logic.Interfaces.IViewMain in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IViewMain.pas',
  Budgeting.Logic.Classes.TQuery in 'Logic\Classes\Budgeting.Logic.Classes.TQuery.pas',
  Budgeting.Logic.TEntityType in 'Logic\Budgeting.Logic.TEntityType.pas',
  Budgeting.Logic.Interfaces.IAccountingCenter in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IAccountingCenter.pas',
  Budgeting.Logic.Interfaces.IBank in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IBank.pas',
  Budgeting.Logic.Interfaces.IBudgetItem in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IBudgetItem.pas',
  Budgeting.Logic.Interfaces.IBudgetItemType in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IBudgetItemType.pas',
  Budgeting.Logic.Interfaces.ICurrency in 'Logic\Interfaces\Budgeting.Logic.Interfaces.ICurrency.pas',
  Budgeting.Logic.Interfaces.IGoodsType in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IGoodsType.pas',
  Budgeting.Logic.Interfaces.IGood in 'Logic\Interfaces\Budgeting.Logic.Interfaces.IGood.pas',
  Budgeting.Logic.Interfaces.ICosignatory in 'Logic\Interfaces\Budgeting.Logic.Interfaces.ICosignatory.pas',
  Budgeting.Logic.Classes.TBank in 'Logic\Classes\Budgeting.Logic.Classes.TBank.pas',
  Budgeting.Logic.Classes.TBudgetItem in 'Logic\Classes\Budgeting.Logic.Classes.TBudgetItem.pas',
  Budgeting.Logic.Classes.TAccountingCenter in 'Logic\Classes\Budgeting.Logic.Classes.TAccountingCenter.pas',
  Budgeting.Logic.Classes.TBudgetItemType in 'Logic\Classes\Budgeting.Logic.Classes.TBudgetItemType.pas',
  Budgeting.Logic.Classes.TCurrency in 'Logic\Classes\Budgeting.Logic.Classes.TCurrency.pas',
  Budgeting.Logic.Classes.TGood in 'Logic\Classes\Budgeting.Logic.Classes.TGood.pas',
  Budgeting.Logic.Classes.TGoodsType in 'Logic\Classes\Budgeting.Logic.Classes.TGoodsType.pas',
  Budgeting.Logic.Classes.TCosignatory in 'Logic\Classes\Budgeting.Logic.Classes.TCosignatory.pas';

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
  MainForm.cbbReferences.ItemIndex := 0;
  Application.Run();

end.
