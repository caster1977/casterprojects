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
  Budgeting.Logic.Classes.Models.TAccountingCenterModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TAccountingCenterModel.pas',
  Budgeting.Logic.Classes.Models.TBankModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TBankModel.pas',
  Budgeting.Logic.Classes.Models.TBudgetItemModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TBudgetItemModel.pas',
  Budgeting.Logic.Classes.Models.TBudgetItemTypeModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TBudgetItemTypeModel.pas',
  Budgeting.Logic.Classes.Models.TCosignatoryModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TCosignatoryModel.pas',
  Budgeting.Logic.Classes.Models.TCurrencyModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TCurrencyModel.pas',
  Budgeting.Logic.Classes.Models.TProductModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TProductModel.pas',
  Budgeting.Logic.Classes.Models.TProductTypeModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TProductTypeModel.pas',
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
  Budgeting.Logic.Interfaces.Views.IMainView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IMainView.pas',
  Budgeting.Logic.Interfaces.Models.IActualBudgetModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IActualBudgetModel.pas',
  Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel.pas',
  Budgeting.Logic.Classes.Models.TActualBudgetModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TActualBudgetModel.pas',
  Budgeting.Logic.Classes.Models.TPlannedBudgetModel in 'Logic\Classes\Models\Budgeting.Logic.Classes.Models.TPlannedBudgetModel.pas',
  Budgeting.Logic.Interfaces.Views.ICustomEditView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.ICustomEditView.pas',
  Budgeting.UI.CustomEdit in 'UI\Budgeting.UI.CustomEdit.pas' {frmCustomEdit},
  Budgeting.UI.AccountingCenter in 'UI\Budgeting.UI.AccountingCenter.pas' {frmAccountingCenter},
  Budgeting.Logic.Interfaces.Models.ICustomModel in 'Logic\Interfaces\Models\Budgeting.Logic.Interfaces.Models.ICustomModel.pas',
  Budgeting.Logic.Classes.Presenters.TBankPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TBankPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TCustomEditPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TCustomEditPresenter.pas',
  Budgeting.Logic.Classes.TfrmCustomEditClass in 'Logic\Classes\Budgeting.Logic.Classes.TfrmCustomEditClass.pas',
  Budgeting.Logic.Classes.TCustomEditPresenterClass in 'Logic\Classes\Budgeting.Logic.Classes.TCustomEditPresenterClass.pas',
  Budgeting.Logic.Classes.Presenters.TAccountingCenterPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TAccountingCenterPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TActualBudgetPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TActualBudgetPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TBudgetItemPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TBudgetItemPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TBudgetItemTypePresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TBudgetItemTypePresenter.pas',
  Budgeting.Logic.Classes.Presenters.TCurrencyPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TCurrencyPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TProductTypePresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TProductTypePresenter.pas',
  Budgeting.Logic.Classes.Presenters.TPlannedBudgetPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TPlannedBudgetPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TProductPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TProductPresenter.pas',
  Budgeting.Logic.Classes.Presenters.TCosignatoryPresenter in 'Logic\Classes\Presenters\Budgeting.Logic.Classes.Presenters.TCosignatoryPresenter.pas',
  Budgeting.UI.Bank in 'UI\Budgeting.UI.Bank.pas' {frmBank},
  Budgeting.Logic.Interfaces.Views.IAccountingCenterView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IAccountingCenterView.pas',
  Budgeting.Logic.Interfaces.Views.ICurrencyView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.ICurrencyView.pas',
  Budgeting.UI.Currency in 'UI\Budgeting.UI.Currency.pas' {frmCurrency},
  Budgeting.Logic.Interfaces.Views.IProductTypeView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IProductTypeView.pas',
  Budgeting.UI.ProductType in 'UI\Budgeting.UI.ProductType.pas' {frmProductType},
  Budgeting.UI.BudgetItemType in 'UI\Budgeting.UI.BudgetItemType.pas' {frmBudgetItemType},
  Budgeting.Logic.Interfaces.Views.IBudgetItemTypeView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IBudgetItemTypeView.pas',
  Budgeting.Logic.Interfaces.Views.IBudgetItemView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IBudgetItemView.pas',
  Budgeting.UI.BudgetItem in 'UI\Budgeting.UI.BudgetItem.pas' {frmBudgetItem},
  Budgeting.Logic.Interfaces.Views.IProductView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IProductView.pas',
  Budgeting.UI.Product in 'UI\Budgeting.UI.Product.pas' {frmProduct},
  Budgeting.Logic.Interfaces.Presenters.IBudgetItemPresenter in 'Logic\Interfaces\Presenters\Budgeting.Logic.Interfaces.Presenters.IBudgetItemPresenter.pas',
  Budgeting.Logic.Interfaces.Presenters.ICosignatoryPresenter in 'Logic\Interfaces\Presenters\Budgeting.Logic.Interfaces.Presenters.ICosignatoryPresenter.pas',
  Budgeting.Logic.Interfaces.Views.ICosignatoryView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.ICosignatoryView.pas',
  Budgeting.Logic.Interfaces.Presenters.IProductPresenter in 'Logic\Interfaces\Presenters\Budgeting.Logic.Interfaces.Presenters.IProductPresenter.pas',
  Budgeting.UI.Cosignatory in 'UI\Budgeting.UI.Cosignatory.pas' {frmCosignatory},
  Budgeting.Logic.Interfaces.Views.IActualBudgetView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IActualBudgetView.pas',
  Budgeting.UI.ActualBudget in 'UI\Budgeting.UI.ActualBudget.pas' {frmActualBudget},
  Budgeting.Logic.Interfaces.Presenters.IActualBudgetPresenter in 'Logic\Interfaces\Presenters\Budgeting.Logic.Interfaces.Presenters.IActualBudgetPresenter.pas',
  Budgeting.UI.PlannedBudget in 'UI\Budgeting.UI.PlannedBudget.pas' {frmPlannedBudget},
  Budgeting.Logic.Interfaces.Views.IPlannedBudgetView in 'Logic\Interfaces\Views\Budgeting.Logic.Interfaces.Views.IPlannedBudgetView.pas',
  Budgeting.Logic.Interfaces.Presenters.IPlannedBudgetPresenter in 'Logic\Interfaces\Presenters\Budgeting.Logic.Interfaces.Presenters.IPlannedBudgetPresenter.pas';

{$R *.res}

var
  CodeSiteDestination: TCodeSiteDestination;
  MainPresenter: ICustomPresenter;

begin
  CodeSiteManager.ConnectUsingTcp();
  CodeSiteDestination := TCodeSiteDestination.Create(nil);
  if Assigned(CodeSiteDestination) then
  begin
    CodeSiteDestination.LogFile.filename := ChangeFileExt(ExtractFileName(IfThen(ModuleIsLib, GetModuleName(HInstance), ParamStr(0))), '.' + FormatDateTime('yyyymmddhhnnss', Now(), TFormatSettings.Create('ru-ru')) + '.csl');
    CodeSiteDestination.LogFile.FilePath := ExtractFilePath(IfThen(ModuleIsLib, GetModuleName(HInstance), ParamStr(0))).Replace('\\?\', EmptyStr);
    CodeSiteDestination.LogFile.MaxSize := 5120;
    CodeSiteDestination.LogFile.Active := True;
    CodeSiteDestination.Viewer.Active := False;
    CodeSite.Destination := CodeSiteDestination;
  end;

  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  MainPresenter := TMainPresenter.Create(MainForm);
  Application.Run();

end.
