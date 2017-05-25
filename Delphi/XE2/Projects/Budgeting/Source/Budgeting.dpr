program Budgeting;

uses
  CodeSiteLogging,
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  Budgeting.Logic.Consts in 'Logic\Budgeting.Logic.Consts.pas',
  Budgeting.Logic.Classes.TQuery in 'Logic\Classes\Budgeting.Logic.Classes.TQuery.pas',
  Budgeting.Logic.Types.TEntity in 'Logic\Types\Budgeting.Logic.Types.TEntity.pas',
  Budgeting.Logic.Types.TViewEnumAction in 'Logic\Types\Budgeting.Logic.Types.TViewEnumAction.pas',
  Budgeting.Logic.Types.TViewEnumActionArray in 'Logic\Types\Budgeting.Logic.Types.TViewEnumActionArray.pas',
  Budgeting.Logic.Types.TViewEnumEvent in 'Logic\Types\Budgeting.Logic.Types.TViewEnumEvent.pas',
  Budgeting.UI.Configuration in 'UI\Budgeting.UI.Configuration.pas' {ConfigurationForm},
  Budgeting.UI.Main in 'UI\Budgeting.UI.Main.pas' {MainForm},
  Budgeting.Logic.Classes.Models.TAccountingCenter in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TAccountingCenter.pas',
  Budgeting.Logic.Classes.Models.TBank in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TBank.pas',
  Budgeting.Logic.Classes.Models.TBudgetItem in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TBudgetItem.pas',
  Budgeting.Logic.Classes.Models.TBudgetItemType in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TBudgetItemType.pas',
  Budgeting.Logic.Classes.Models.TCosignatory in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TCosignatory.pas',
  Budgeting.Logic.Classes.Models.TCurrency in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TCurrency.pas',
  Budgeting.Logic.Classes.Models.TGood in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TGood.pas',
  Budgeting.Logic.Classes.Models.TGoodsType in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TGoodsType.pas',
  Budgeting.Logic.Classes.Presenters.TCustomPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TCustomPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TMainPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TMainPresenter.pas',
  Budgeting.Logic.Classes.Configuration.Sections.TDatabaseSection in 'Logic\Classes\Configuration\Sections\Budgeting.Logic.Classes.Configuration.Sections.TDatabaseSection.pas',
  Budgeting.Logic.Classes.Configuration.Sections.TGeneralSection in 'Logic\Classes\Configuration\Sections\Budgeting.Logic.Classes.Configuration.Sections.TGeneralSection.pas',
  Budgeting.Logic.Classes.Configuration.Sections.TInterfaceSection in 'Logic\Classes\Configuration\Sections\Budgeting.Logic.Classes.Configuration.Sections.TInterfaceSection.pas',
  Budgeting.Logic.Classes.Configuration.Sections.TOtherSection in 'Logic\Classes\Configuration\Sections\Budgeting.Logic.Classes.Configuration.Sections.TOtherSection.pas',
  Budgeting.Logic.Classes.Configuration.TConfiguration in 'Logic\Classes\Configuration\Budgeting.Logic.Classes.Configuration.TConfiguration.pas',
  Budgeting.Logic.Interfaces.Models.IAccountingCenterModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IAccountingCenterModel.pas',
  Budgeting.Logic.Interfaces.Models.IBankModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IBankModel.pas',
  Budgeting.Logic.Interfaces.Models.IBudgetItemModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IBudgetItemModel.pas',
  Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel.pas',
  Budgeting.Logic.Interfaces.Models.ICosignatoryModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.ICosignatoryModel.pas',
  Budgeting.Logic.Interfaces.Models.ICurrencyModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.ICurrencyModel.pas',
  Budgeting.Logic.Interfaces.Models.IProductModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IProductModel.pas',
  Budgeting.Logic.Interfaces.Models.IProductTypeModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IProductTypeModel.pas',
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter in 'Logic\Interfaces\Presenters\Budgeting.Logic.Interfaces.Presenters.ICustomPresenter.pas',
  Budgeting.Logic.Interfaces.Views.IBankView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IBankView.pas',
  Budgeting.Logic.Interfaces.Views.ICustomView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.ICustomView.pas',
  Budgeting.Logic.Interfaces.Views.IMainView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IMainView.pas';

{$R *.res}

var
  CodeSiteDestination: TCodeSiteDestination;
  MainPresenter: ICustomPresenter;

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
  Application.CreateForm(TConfigurationForm, ConfigurationForm);
  Application.CreateForm(TMainForm, MainForm);
  MainPresenter := TMainPresenter.Create(MainForm);
  MainForm.cbbReferences.ItemIndex := 0;
  Application.Run();

end.
