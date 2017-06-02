unit Budgeting.UI.Main;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxContainer,
  cxGridCustomTableView,
  cxGridTableView,
  cxLabel,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  Vcl.ExtCtrls,
  cxSplitter,
  dxBar,
  dxStatusBar,
  System.Actions,
  Vcl.ActnList,
  AboutPackage.Logic.TGSFileVersionInfo,
  Vcl.Menus,
  cxHyperLinkEdit,
  cxGridCustomPopupMenu,
  Vcl.OleCtnrs,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup,
  dxSkinsCore,
  dxSkinBlack,
  dxSkinBlue,
  dxSkinBlueprint,
  dxSkinCaramel,
  dxSkinCoffee,
  dxSkinDarkRoom,
  dxSkinDarkSide,
  dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle,
  dxSkinFoggy,
  dxSkinGlassOceans,
  dxSkinHighContrast,
  dxSkiniMaginary,
  dxSkinLilian,
  dxSkinLiquidSky,
  dxSkinLondonLiquidSky,
  dxSkinMcSkin,
  dxSkinMetropolis,
  dxSkinMetropolisDark,
  dxSkinMoneyTwins,
  dxSkinOffice2007Black,
  dxSkinOffice2007Blue,
  dxSkinOffice2007Green,
  dxSkinOffice2007Pink,
  dxSkinOffice2007Silver,
  dxSkinOffice2010Black,
  dxSkinOffice2010Blue,
  dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray,
  dxSkinOffice2013White,
  dxSkinPumpkin,
  dxSkinSeven,
  dxSkinSevenClassic,
  dxSkinSharp,
  dxSkinSharpPlus,
  dxSkinSilver,
  dxSkinSpringTime,
  dxSkinStardust,
  dxSkinSummer2008,
  dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters,
  dxSkinValentine,
  dxSkinVS2010,
  dxSkinWhiteprint,
  dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter,
  dxSkinscxPCPainter,
  dxSkinsdxBarPainter,
  cxImageComboBox,
  cxCurrencyEdit,
  cxCalendar,
  cxCalc,
  dxBarBuiltInMenu,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxPC,
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Budgeting.Logic.Interfaces.Views.IMainView,
  Budgeting.Logic.Types.TViewEnumActionArray,
  Budgeting.Logic.Types.TViewEnumAction,
  Budgeting.Logic.Types.TViewEnumEvent,
  cxProgressBar,
  cxBarEditItem,
  cxCustomData,

  cxCheckBox,
  FireDAC.Stan.Intf,
  FireDAC.Phys,

  FireDAC.Phys.MSSQL,
  Budgeting.Logic.Types.TEntity,

  FireDAC.Phys.ODBCBase,
  Vcl.ImgList,
  cxFilter,
  cxData, cxGridBandedTableView;

type
  TMainForm = class(TForm, ICustomView, IMainView)
    actQuit: TAction;
    actFile: TAction;
    actHelp: TAction;
    actHelpContext: TAction;
    actAbout: TAction;
    actStatusBar: TAction;
    actToolBar: TAction;
    actView: TAction;
    actAction: TAction;
    StatusBar: TdxStatusBar;
    dxbrmngrMain: TdxBarManager;
    cxmglstActions: TcxImageList;
    actlstMain: TActionList;
    actConfiguration: TAction;
    gsflvrsnfMain: TGSFileVersionInfo;
    mmMain: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    dxbrToolBar: TdxBar;
    btnQuit: TdxBarButton;
    btnHelpContext: TdxBarButton;
    btnAbout: TdxBarButton;
    cxgrdOperations: TcxGrid;
    cxgrdlvl2: TcxGridLevel;
    pctnbrMain: TPopupActionBar;
    N15: TMenuItem;
    N18: TMenuItem;
    btnConfiguration: TdxBarButton;
    N27: TMenuItem;
    N28: TMenuItem;
    actExportToExcel: TAction;
    btnExcel: TdxBarButton;
    btnConnect: TdxBarButton;
    actConnect: TAction;
    actDisconnect: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefresh: TAction;
    pcMain: TcxPageControl;
    shtOperations: TcxTabSheet;
    shtReferences: TcxTabSheet;
    cbbReferences: TcxComboBox;
    cxgrdReferences: TcxGrid;
    shtReports: TcxTabSheet;
    btn1: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    cxbrdtmProgress: TcxBarEditItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N20: TMenuItem;
    N31: TMenuItem;
    N19: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    lvl1: TcxGridLevel;
    btnRefresh: TdxBarButton;
    fdphysmsqldrvrlnk: TFDPhysMSSQLDriverLink;
    cxgrdlvl1: TcxGridLevel;

    cxgrdReports: TcxGrid;
    cbbReports: TcxComboBox;

    tblvAccountingCenters: TcxGridTableView;
    colAccountingCenters_Id_AccountingCenter: TcxGridColumn;
    colAccountingCenters_Code: TcxGridColumn;
    colAccountingCenters_Name: TcxGridColumn;
    colAccountingCenters_Description: TcxGridColumn;
    colAccountingCenters_Activity: TcxGridColumn;

    tblvBanks: TcxGridTableView;
    colBanks_Id_Bank: TcxGridColumn;
    colBanks_Name: TcxGridColumn;
    colBanks_Code: TcxGridColumn;
    colBanks_Address: TcxGridColumn;
    colBanks_Activity: TcxGridColumn;

    tblvBudgetItems: TcxGridTableView;
    colBudgetItems_Id_BudgetItem: TcxGridColumn;
    colBudgetItems_Id_BudgetItemType: TcxGridColumn;
    colBudgetItems_Code: TcxGridColumn;
    colBudgetItems_Description: TcxGridColumn;
    colBudgetItems_Activity: TcxGridColumn;

    tblvBudgetItemTypes: TcxGridTableView;
    colBudgetItemTypes_Id_BudgetItemType: TcxGridColumn;
    colBudgetItemTypes_Name: TcxGridColumn;
    colBudgetItemTypes_Activity: TcxGridColumn;

    tblvCosignatories: TcxGridTableView;
    colCosignatories_Id_Cosignatory: TcxGridColumn;
    colCosignatories_Id_Bank: TcxGridColumn;
    colCosignatories_Bank: TcxGridColumn;
    colCosignatories_Name: TcxGridColumn;
    colCosignatories_UNP: TcxGridColumn;
    colCosignatories_Address: TcxGridColumn;
    colCosignatories_AgreementNumber: TcxGridColumn;
    colCosignatories_AgreementStart: TcxGridColumn;
    colCosignatories_AgreementStop: TcxGridColumn;
    colCosignatories_Account: TcxGridColumn;
    colCosignatories_Activity: TcxGridColumn;

    tblvCurrencies: TcxGridTableView;
    colCurrencies_Id_Currency: TcxGridColumn;
    colCurrencies_Code: TcxGridColumn;
    colCurrencies_Description: TcxGridColumn;
    colCurrencies_Activity: TcxGridColumn;
    tblvProducts: TcxGridTableView;
    colProducts_Id_Product: TcxGridColumn;
    colProducts_Id_ProductType: TcxGridColumn;
    colProducts_Code: TcxGridColumn;
    colProducts_Description: TcxGridColumn;
    colProducts_Activity: TcxGridColumn;
    tblvProductTypes: TcxGridTableView;
    colProductTypes_Id_ProductType: TcxGridColumn;
    colProductTypes_Name: TcxGridColumn;
    colProductTypes_Activity: TcxGridColumn;

    tblvActualBudget: TcxGridTableView;
    colActualBudget_Id_ActualBudget: TcxGridColumn;
    colActualBudget_Id_BudgetItem: TcxGridColumn;
    colActualBudget_Id_AccountingCenter: TcxGridColumn;
    colActualBudget_Id_Cosignatory: TcxGridColumn;
    colActualBudget_Id_Product: TcxGridColumn;
    colActualBudget_Id_Currency: TcxGridColumn;
    colActualBudget_Document: TcxGridColumn;
    colActualBudget_DocumentDate: TcxGridColumn;
    colActualBudget_Description: TcxGridColumn;
    colActualBudget_Amount: TcxGridColumn;

    tblvPlannedBudget: TcxGridTableView;
    colPlannedBudget_Id_PlannedBudget: TcxGridColumn;
    colPlannedBudget_Id_BudgetItem: TcxGridColumn;
    colPlannedBudget_Id_AccountingCenter: TcxGridColumn;
    colPlannedBudget_Id_Currency: TcxGridColumn;
    colPlannedBudget_Year: TcxGridColumn;
    colPlannedBudget_Month: TcxGridColumn;
    colPlannedBudget_Amount: TcxGridColumn;
    pnlOperations: TPanel;
    cbbOperationTypes: TcxComboBox;
    cbbBudgetItemTypes: TcxComboBox;
    colBudgetItems_BudgetItemType: TcxGridColumn;
    colProducts_ProductType: TcxGridColumn;

    colActualBudget_AccountingCenter: TcxGridColumn;
    colActualBudget_BudgetItem: TcxGridColumn;
    colActualBudget_Cosignatory: TcxGridColumn;
    colActualBudget_Product: TcxGridColumn;
    colActualBudget_Currency: TcxGridColumn;

    colPlannedBudget_AccountingCenter: TcxGridColumn;
    colPlannedBudget_BudgetItem: TcxGridColumn;
    colPlannedBudget_Currency: TcxGridColumn;
    tblvSummaryReport: TcxGridTableView;
    colSummaryReport_BudgetItem: TcxGridColumn;
    colSummaryReport_AccountingCenter: TcxGridColumn;
    colSummaryReport_BudgetItemType: TcxGridColumn;
    colSummaryReport_Month: TcxGridColumn;
    colSummaryReport_PlannedAmount: TcxGridColumn;
    colSummaryReport_ActualAmount: TcxGridColumn;
    colSummaryReport_Balance: TcxGridColumn;
    colSummaryReport_Currency: TcxGridColumn;
    colBudgetItemTypes_Sign: TcxGridColumn;
    btblvwSummaryReport: TcxGridBandedTableView;

    procedure actQuitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actStatusBarExecute(Sender: TObject);
    procedure actToolBarExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actActionExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actHelpContextExecute(Sender: TObject);
    procedure actAddUpdate(Sender: TObject);
    procedure actQuitUpdate(Sender: TObject);
    procedure actAboutUpdate(Sender: TObject);
    procedure actHelpContextUpdate(Sender: TObject);
    procedure actConfigurationExecute(Sender: TObject);
    procedure actExportToExcelUpdate(Sender: TObject);
    procedure actExportToExcelExecute(Sender: TObject);
    procedure actConfigurationUpdate(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actFileExecute(Sender: TObject);
    procedure tblvFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure actDisconnectUpdate(Sender: TObject);
    procedure actConnectUpdate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actRefreshUpdate(Sender: TObject);
    procedure cbbReferencesPropertiesChange(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure cbbOperationTypesPropertiesChange(Sender: TObject);
    procedure cbbBudgetItemTypesPropertiesChange(Sender: TObject);

  strict private
    FProcessing: Boolean;
    FOnEventSimple: TProc<TViewEnumEvent>;
    FActionStates: TViewEnumActionArray;
    FPresenter: IInterface;

    procedure ApplyConfiguration();
    function ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
    function GetControl: TWinControl;
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    procedure ShowProgress(const aTitle: string; const aMax: Integer);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();
    procedure RefreshStates();
    procedure StorePresenter(const aPresenter: IInterface);
    procedure SetCaption(const aValue: string);
    function GetActiveGrid(): TcxGrid;
    function GetCurrentEntity(): TEntity;
    function GetCurrentBudgetItemType(): Integer;
    function GetCurrentId(const aEntityType: TEntity): Integer;
    procedure SetEnableStatusbar(const aValue: Boolean);
    procedure SetEnableToolbar(const aValue: Boolean);
    procedure SetAccountingCenters(const aValue: TDataSet);
    procedure SetBanks(const aValue: TDataSet);
    procedure SetBudgetItems(const aValue: TDataSet);
    procedure SetBudgetItemTypes(const aValue: TDataSet);
    procedure SetCosignatories(const aValue: TDataSet);
    procedure SetCurrencies(const aValue: TDataSet);
    procedure SetProducts(const aValue: TDataSet);
    procedure SetProductTypes(const aValue: TDataSet);
    procedure SetActualBudget(const aValue: TDataSet);
    procedure SetPlannedBudget(const aValue: TDataSet);
    procedure SetSummaryReport(const aValue: TDataSet);
    procedure Initialize();
    procedure OnEventSimpleStub(aValue: TViewEnumEvent);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses

  FireDAC.Comp.Client,
  FireDAC.Stan.ASync,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  // Budgeting.Logic.Classes.Configuration.Sections.TGeneralSection,
  Budgeting.Logic.Classes.Configuration.Sections.TInterfaceSection,
  System.Generics.Collections,
  Budgeting.Logic.Consts,
  Budgeting.Logic.Classes.TQuery;

procedure TMainForm.actViewExecute(Sender: TObject);
begin
  // заглушка для корня меню
end;

procedure TMainForm.actActionExecute(Sender: TObject);
begin
  // заглушка для корня меню
end;

procedure TMainForm.actHelpExecute(Sender: TObject);
begin
  // заглушка для корня меню
end;

procedure TMainForm.actFileExecute(Sender: TObject);
begin
  // заглушка для корня меню
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veAboutExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Close();
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actConfigurationExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veConfigurationExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actHelpContextExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veHelpContextExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actEditExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veEditExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actExportToExcelExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veExportToExcelExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actQuitUpdate(Sender: TObject);
begin
  FOnEventSimple(veQuitUpdate);
  (Sender as TAction).Enabled := FActionStates[vaCloseQuery];
end;

procedure TMainForm.actRefreshExecute(Sender: TObject);
var
  tmpCursor: TCursor;
  tmpGrid: TcxGrid;
  tmpActiveView: TcxCustomGridView;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    tmpGrid := GetActiveGrid();

    if Assigned(tmpGrid) then
    begin
      tmpActiveView := tmpGrid.ActiveView;
      if Assigned(tmpActiveView) then
      begin
        FOnEventSimple(veRefreshExecute);
      end;
    end;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actRefreshUpdate(Sender: TObject);
begin
  FOnEventSimple(veRefreshUpdate);
  (Sender as TAction).Enabled := FActionStates[vaRefresh];
end;

procedure TMainForm.actConfigurationUpdate(Sender: TObject);
begin
  FOnEventSimple(veConfigurationUpdate);
  (Sender as TAction).Enabled := FActionStates[vaConfiguration];
end;

procedure TMainForm.actAboutUpdate(Sender: TObject);
begin
  FOnEventSimple(veAboutUpdate);
  (Sender as TAction).Enabled := FActionStates[vaAbout];
end;

procedure TMainForm.actHelpContextUpdate(Sender: TObject);
begin
  FOnEventSimple(veHelpContextUpdate);
  (Sender as TAction).Enabled := FActionStates[vaHelpContext];
end;

procedure TMainForm.actExportToExcelUpdate(Sender: TObject);
begin
  FOnEventSimple(veExportToExcelUpdate);
  (Sender as TAction).Enabled := FActionStates[vaExportToExcel];
end;

procedure TMainForm.actAddUpdate(Sender: TObject);
begin
  FOnEventSimple(veAddUpdate);
  (Sender as TAction).Enabled := FActionStates[vaAdd];
end;

procedure TMainForm.actDeleteUpdate(Sender: TObject);
begin
  FOnEventSimple(veDeleteUpdate);
  (Sender as TAction).Enabled := FActionStates[vaDelete];
end;

procedure TMainForm.actConnectUpdate(Sender: TObject);
begin
  FOnEventSimple(veConnectUpdate);
  (Sender as TAction).Enabled := FActionStates[vaConnect];
end;

procedure TMainForm.actDisconnectUpdate(Sender: TObject);
begin
  FOnEventSimple(veDisconnectUpdate);
  (Sender as TAction).Enabled := FActionStates[vaDisconnect];
end;

procedure TMainForm.actEditUpdate(Sender: TObject);
begin
  FOnEventSimple(veEditUpdate);
  (Sender as TAction).Enabled := FActionStates[vaEdit];
end;

procedure TMainForm.actDisconnectExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veDisconnectExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actConnectExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veConnectExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actAddExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veAddExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actStatusBarExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veStatusBarExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.SetEnableStatusbar(const aValue: Boolean);
begin
  if StatusBar.Visible <> aValue then
  begin
    StatusBar.Visible := aValue;
  end;
  if actStatusBar.Checked <> aValue then
  begin
    actStatusBar.Checked := aValue;
  end;
end;

procedure TMainForm.SetEnableToolbar(const aValue: Boolean);
begin
  if dxbrToolBar.Visible <> aValue then
  begin
    dxbrToolBar.Visible := aValue;
  end;
  if actToolBar.Checked <> aValue then
  begin
    actToolBar.Checked := aValue;
  end;
end;

procedure TMainForm.SetPlannedBudget(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvPlannedBudget.BeginUpdate();
  try
    tblvPlannedBudget.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvPlannedBudget.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Id_PlannedBudget.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Id).AsInteger;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Id_BudgetItem.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Id_BudgetItem).AsInteger;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_BudgetItem.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.BudgetItem).AsString;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Id_AccountingCenter.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Id_AccountingCenter).AsInteger;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_AccountingCenter.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.AccountingCenter).AsString;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Id_Currency.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Id_Currency).AsInteger;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Currency.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Currency).AsString;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Year.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Year).AsInteger;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Month.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Month).AsInteger;
      tblvPlannedBudget.DataController.Values[i, colPlannedBudget_Amount.Index] := aValue.FieldByName(TQuery.sp_planned_budget_sel.Field.Amount).AsCurrency;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvPlannedBudget.EndUpdate();
  end;
end;

procedure TMainForm.SetProducts(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvProducts.BeginUpdate();
  try
    tblvProducts.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvProducts.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvProducts.DataController.Values[i, colProducts_Id_Product.Index] := aValue.FieldByName(TQuery.sp_products_sel.Field.Id).AsInteger;
      tblvProducts.DataController.Values[i, colProducts_Id_ProductType.Index] := aValue.FieldByName(TQuery.sp_products_sel.Field.Id_ProductType).AsInteger;
      tblvProducts.DataController.Values[i, colProducts_ProductType.Index] := aValue.FieldByName(TQuery.sp_products_sel.Field.ProductType).AsString;
      tblvProducts.DataController.Values[i, colProducts_Code.Index] := aValue.FieldByName(TQuery.sp_products_sel.Field.Code).AsString;
      tblvProducts.DataController.Values[i, colProducts_Description.Index] := aValue.FieldByName(TQuery.sp_products_sel.Field.Description).AsString;
      tblvProducts.DataController.Values[i, colProducts_Activity.Index] := aValue.FieldByName(TQuery.sp_products_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvProducts.EndUpdate();
  end;
end;

procedure TMainForm.SetProductTypes(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvProductTypes.BeginUpdate();
  try
    tblvProductTypes.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvProductTypes.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvProductTypes.DataController.Values[i, colProductTypes_Id_ProductType.Index] := aValue.FieldByName(TQuery.sp_product_types_sel.Field.Id).AsInteger;
      tblvProductTypes.DataController.Values[i, colProductTypes_Name.Index] := aValue.FieldByName(TQuery.sp_product_types_sel.Field.Name).AsString;
      tblvProductTypes.DataController.Values[i, colProductTypes_Activity.Index] := aValue.FieldByName(TQuery.sp_product_types_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvProductTypes.EndUpdate();
  end;
end;

procedure TMainForm.actToolBarExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veToolBarExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.actDeleteExecute(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veDeleteExecute);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  tmpCursor: TCursor;
begin
  CanClose := True;
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veCloseQuery);
    CanClose := FActionStates[vaCloseQuery];
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  tmpPair: TPair<string, TcxGridTableView>;
  tmpList: TDictionary<string, TcxGridTableView>;
begin
  FProcessing := False;
  FOnEventSimple := OnEventSimpleStub;
  tmpList := TDictionary<string, TcxGridTableView>.Create;
  try
    tmpList.Add('Центры учёта затрат', tblvAccountingCenters);
    tmpList.Add('Банки', tblvBanks);
    tmpList.Add('Статьи бюджета', tblvBudgetItems);
    tmpList.Add('Типы статей бюджета', tblvBudgetItemTypes);
    tmpList.Add('Субъекты', tblvCosignatories);
    tmpList.Add('Валюты', tblvCurrencies);
    tmpList.Add('Товары', tblvProducts);
    tmpList.Add('Виды товаров', tblvProductTypes);

    for tmpPair in tmpList do
    begin
      cbbReferences.Properties.Items.AddObject(tmpPair.Key, tmpPair.Value);
    end;

    tmpList.Clear();

    tmpList.Add('План', tblvPlannedBudget);
    tmpList.Add('Факт', tblvActualBudget);

    for tmpPair in tmpList do
    begin
      cbbOperationTypes.Properties.Items.AddObject(tmpPair.Key, tmpPair.Value);
    end;

    tmpList.Clear();

    tmpList.Add('Итоговый отчёт за год', tblvSummaryReport);

    for tmpPair in tmpList do
    begin
      cbbReports.Properties.Items.AddObject(tmpPair.Key, tmpPair.Value);
    end;
  finally
    FreeAndNil(tmpList);
  end;

  gsflvrsnfMain.Filename := Application.ExeName;
  Caption := gsflvrsnfMain.InternalName;
  Application.HelpFile := ChangeFileExt(Application.ExeName, '.hlp');
  ApplyConfiguration();
end;

function TMainForm.GetActionStates(const aValue: TViewEnumAction): Boolean;
begin
  Result := FActionStates[aValue];
end;

function TMainForm.GetActiveGrid(): TcxGrid;
begin
  Result := nil;
  if pcMain.ActivePage = shtReferences then
  begin
    Result := cxgrdReferences;
  end
  else
  begin
    if pcMain.ActivePage = shtOperations then
    begin
      Result := cxgrdOperations;
    end
    else
    begin
      if pcMain.ActivePage = shtReports then
      begin
        Result := cxgrdReports;
      end;
    end;
  end;
end;

function TMainForm.GetControl(): TWinControl;
begin
  Result := Self;
end;

function TMainForm.GetCurrentBudgetItemType(): Integer;
begin
  Result := -1;
  if cbbBudgetItemTypes.ItemIndex > -1 then
  begin
    Result := Integer(cbbBudgetItemTypes.Properties.Items.Objects[cbbBudgetItemTypes.ItemIndex]);
  end;
end;

function TMainForm.GetCurrentEntity(): TEntity;
var
  tmpGrid: TcxGrid;
  tmpActiveView: TcxCustomGridView;
begin
  Result := etUnknown;
  tmpGrid := GetActiveGrid();
  if Assigned(tmpGrid) then
  begin
    tmpActiveView := tmpGrid.ActiveView;
    if Assigned(tmpActiveView) then
    begin
      if tmpActiveView = tblvAccountingCenters then
        Result := etAccountingCenters;
      if tmpActiveView = tblvBanks then
        Result := etBanks;
      if tmpActiveView = tblvBudgetItems then
        Result := etBudgetItems;
      if tmpActiveView = tblvBudgetItemTypes then
        Result := etBudgetItemTypes;
      if tmpActiveView = tblvCosignatories then
        Result := etCosignatories;
      if tmpActiveView = tblvCurrencies then
        Result := etCurrencies;
      if tmpActiveView = tblvProducts then
        Result := etProducts;
      if tmpActiveView = tblvProductTypes then
        Result := etProductTypes;
      if tmpActiveView = tblvActualBudget then
        Result := etActualBudget;
      if tmpActiveView = tblvPlannedBudget then
        Result := etPlannedBudget;
      if tmpActiveView = tblvSummaryReport then
        Result := etSummaryReport;
    end;
  end;
end;

function TMainForm.GetCurrentId(const aEntityType: TEntity): Integer;
var
  tmpController: TcxGridTableController;
begin
  Result := -1;
  tmpController := nil;

  case aEntityType of
    etAccountingCenters:
      tmpController := tblvAccountingCenters.Controller;
    etBanks:
      tmpController := tblvBanks.Controller;
    etBudgetItems:
      tmpController := tblvBudgetItems.Controller;
    etBudgetItemTypes:
      tmpController := tblvBudgetItemTypes.Controller;
    etCosignatories:
      tmpController := tblvCosignatories.Controller;
    etCurrencies:
      tmpController := tblvCurrencies.Controller;
    etProducts:
      tmpController := tblvProducts.Controller;
    etProductTypes:
      tmpController := tblvProductTypes.Controller;
    etActualBudget:
      tmpController := tblvActualBudget.Controller;
    etPlannedBudget:
      tmpController := tblvPlannedBudget.Controller;
  end;
  if Assigned(tmpController) then
  begin
    if tmpController.SelectedRecordCount = 1 then
    begin
      Result := tmpController.SelectedRecords[0].Values[0]
    end;
  end;
end;

procedure TMainForm.HideProgress();
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := EmptyStr;
  cxbrdtmProgress.Visible := ivNever;
end;

procedure TMainForm.Initialize();
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veInitialization);
    cbbReferences.ItemIndex := 0;
    cbbOperationTypes.ItemIndex := 0;
    cbbReports.ItemIndex := 0;
    cbbBudgetItemTypes.ItemIndex := 0;
    pcMain.ActivePage := shtReferences;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.OnEventSimpleStub(aValue: TViewEnumEvent);
begin
end;

procedure TMainForm.pcMainChange(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veEntityChanged);
    btnRefresh.Click();
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.RefreshStates();
var
  i: Integer;
begin
  for i := 0 to Pred(actlstMain.ActionCount) do
    actlstMain.Actions[i].Update();
end;

procedure TMainForm.SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
begin
  FActionStates[aKey] := aValue;
end;

procedure TMainForm.SetActualBudget(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvActualBudget.BeginUpdate();
  try
    tblvActualBudget.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvActualBudget.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvActualBudget.DataController.Values[i, colActualBudget_Id_ActualBudget.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Id).AsInteger;
      tblvActualBudget.DataController.Values[i, colActualBudget_Id_BudgetItem.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_BudgetItem).AsInteger;
      tblvActualBudget.DataController.Values[i, colActualBudget_BudgetItem.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.BudgetItem).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_Id_AccountingCenter.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_AccountingCenter).AsInteger;
      tblvActualBudget.DataController.Values[i, colActualBudget_AccountingCenter.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.AccountingCenter).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_Id_Cosignatory.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_Cosignatory).AsInteger;
      tblvActualBudget.DataController.Values[i, colActualBudget_Cosignatory.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Cosignatory).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_Id_Product.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_Product).AsInteger;
      tblvActualBudget.DataController.Values[i, colActualBudget_Product.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Product).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_Id_Currency.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Id_Currency).AsInteger;
      tblvActualBudget.DataController.Values[i, colActualBudget_Currency.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Currency).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_Document.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Document).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_DocumentDate.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.DocumentDate).AsDateTime;
      tblvActualBudget.DataController.Values[i, colActualBudget_Description.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Description).AsString;
      tblvActualBudget.DataController.Values[i, colActualBudget_Amount.Index] := aValue.FieldByName(TQuery.sp_actual_budget_sel.Field.Amount).AsCurrency;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvActualBudget.EndUpdate();
  end;
end;

procedure TMainForm.SetBanks(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvBanks.BeginUpdate();
  try
    tblvBanks.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvBanks.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvBanks.DataController.Values[i, colBanks_Id_Bank.Index] := aValue.FieldByName(TQuery.sp_banks_sel.Field.Id).AsInteger;
      tblvBanks.DataController.Values[i, colBanks_Name.Index] := aValue.FieldByName(TQuery.sp_banks_sel.Field.Name).AsString;
      tblvBanks.DataController.Values[i, colBanks_Code.Index] := aValue.FieldByName(TQuery.sp_banks_sel.Field.Code).AsString;
      tblvBanks.DataController.Values[i, colBanks_Address.Index] := aValue.FieldByName(TQuery.sp_banks_sel.Field.Address).AsString;
      tblvBanks.DataController.Values[i, colBanks_Activity.Index] := aValue.FieldByName(TQuery.sp_banks_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvBanks.EndUpdate();
  end;
end;

procedure TMainForm.SetBudgetItems(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvBudgetItems.BeginUpdate();
  try
    tblvBudgetItems.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvBudgetItems.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvBudgetItems.DataController.Values[i, colBudgetItems_Id_BudgetItem.Index] := aValue.FieldByName(TQuery.sp_budget_items_sel.Field.Id).AsInteger;
      tblvBudgetItems.DataController.Values[i, colBudgetItems_Id_BudgetItemType.Index] := aValue.FieldByName(TQuery.sp_budget_items_sel.Field.Id_BudgetItemType).AsInteger;
      tblvBudgetItems.DataController.Values[i, colBudgetItems_BudgetItemType.Index] := aValue.FieldByName(TQuery.sp_budget_items_sel.Field.BudgetItemType).AsString;
      tblvBudgetItems.DataController.Values[i, colBudgetItems_Code.Index] := aValue.FieldByName(TQuery.sp_budget_items_sel.Field.Code).AsString;
      tblvBudgetItems.DataController.Values[i, colBudgetItems_Description.Index] := aValue.FieldByName(TQuery.sp_budget_items_sel.Field.Description).AsString;
      tblvBudgetItems.DataController.Values[i, colBudgetItems_Activity.Index] := aValue.FieldByName(TQuery.sp_budget_items_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvBudgetItems.EndUpdate();
  end;
end;

procedure TMainForm.SetBudgetItemTypes(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvBudgetItemTypes.BeginUpdate();
  try
    tblvBudgetItemTypes.DataController.RecordCount := 0;

    cbbBudgetItemTypes.Properties.Items.BeginUpdate();
    try
      cbbBudgetItemTypes.Properties.Items.Clear();

      if not Assigned(aValue) then
      begin
        Exit;
      end;

      if aValue.IsEmpty() then
      begin
        Exit;
      end;

      aValue.First();
      tblvBudgetItemTypes.DataController.RecordCount := aValue.RecordCount;

      for i := 0 to Pred(aValue.RecordCount) do
      begin
        tblvBudgetItemTypes.DataController.Values[i, colBudgetItemTypes_Id_BudgetItemType.Index] := aValue.FieldByName(TQuery.sp_budget_item_types_sel.Field.Id).AsInteger;
        tblvBudgetItemTypes.DataController.Values[i, colBudgetItemTypes_Name.Index] := aValue.FieldByName(TQuery.sp_budget_item_types_sel.Field.Name).AsString;
        tblvBudgetItemTypes.DataController.Values[i, colBudgetItemTypes_Sign.Index] := aValue.FieldByName(TQuery.sp_budget_item_types_sel.Field.Sign).AsBoolean;
        tblvBudgetItemTypes.DataController.Values[i, colBudgetItemTypes_Activity.Index] := aValue.FieldByName(TQuery.sp_budget_item_types_sel.Field.Activity).AsBoolean;

        cbbBudgetItemTypes.Properties.Items.AddObject(aValue.FieldByName(TQuery.sp_budget_item_types_sel.Field.Name).AsString, TObject(aValue.FieldByName(TQuery.sp_budget_item_types_sel.Field.Id).AsInteger));

        StepProgress();

        aValue.Next();
      end;
    finally
      cbbBudgetItemTypes.Properties.Items.EndUpdate();
      cbbBudgetItemTypes.ItemIndex := 0;
    end;
  finally
    tblvBudgetItemTypes.EndUpdate();
  end;
end;

procedure TMainForm.SetCaption(const aValue: string);
begin
  Caption := aValue;
end;

procedure TMainForm.SetCosignatories(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvCosignatories.BeginUpdate();
  try
    tblvCosignatories.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvCosignatories.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvCosignatories.DataController.Values[i, colCosignatories_Id_Cosignatory.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Id).AsInteger;
      tblvCosignatories.DataController.Values[i, colCosignatories_Id_Bank.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Id_Bank).AsInteger;
      tblvCosignatories.DataController.Values[i, colCosignatories_Bank.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Bank).AsString;
      tblvCosignatories.DataController.Values[i, colCosignatories_Name.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Name).AsString;
      tblvCosignatories.DataController.Values[i, colCosignatories_UNP.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.UNP).AsString;
      tblvCosignatories.DataController.Values[i, colCosignatories_Address.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Address).AsString;
      tblvCosignatories.DataController.Values[i, colCosignatories_AgreementNumber.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.AgreementNumber).AsString;
      tblvCosignatories.DataController.Values[i, colCosignatories_AgreementStart.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.AgreementStart).AsDateTime;
      tblvCosignatories.DataController.Values[i, colCosignatories_AgreementStop.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.AgreementStop).AsDateTime;
      tblvCosignatories.DataController.Values[i, colCosignatories_Account.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Account).AsString;
      tblvCosignatories.DataController.Values[i, colCosignatories_Activity.Index] := aValue.FieldByName(TQuery.sp_cosignatories_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvCosignatories.EndUpdate();
  end;
end;

procedure TMainForm.SetCurrencies(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvCurrencies.BeginUpdate();
  try
    tblvCurrencies.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvCurrencies.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvCurrencies.DataController.Values[i, colCurrencies_Id_Currency.Index] := aValue.FieldByName(TQuery.sp_currencies_sel.Field.Id).AsInteger;
      tblvCurrencies.DataController.Values[i, colCurrencies_Code.Index] := aValue.FieldByName(TQuery.sp_currencies_sel.Field.Code).AsString;
      tblvCurrencies.DataController.Values[i, colCurrencies_Description.Index] := aValue.FieldByName(TQuery.sp_currencies_sel.Field.Description).AsString;
      tblvCurrencies.DataController.Values[i, colCurrencies_Activity.Index] := aValue.FieldByName(TQuery.sp_currencies_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvCurrencies.EndUpdate();
  end;
end;

procedure TMainForm.SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
begin
  if Assigned(aValue) then
  begin
    FOnEventSimple := aValue;
  end
  else
  begin
    FOnEventSimple := OnEventSimpleStub;
  end;
end;

function TMainForm.ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;
var
  sCaption: string;
begin
  case aStatus of
    MESSAGE_TYPE_OK:
      sCaption := Format('%s - Информация', [Application.Title]);
    MESSAGE_TYPE_ERROR:
      sCaption := Format('%s - Ошибка', [Application.Title]);
    MESSAGE_TYPE_WARNING, MESSAGE_TYPE_CONFIRMATION_WARNING_OK, MESSAGE_TYPE_CONFIRMATION_WARNING_CANCEL:
      sCaption := Format('%s - Внимание', [Application.Title]);
    MESSAGE_TYPE_CONFIRMATION_QUESTION:
      sCaption := Format('%s - Подтверждение', [Application.Title]);
  end;
  Result := MessageBox(Handle, PWideChar(aMessage), PWideChar(sCaption), aStatus);
end;

procedure TMainForm.ShowProgress(const aTitle: string; const aMax: Integer);
begin
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aTitle.Trim();
  (cxbrdtmProgress.Properties as TcxProgressBarProperties).Max := aMax;
  cxbrdtmProgress.EditValue := 0;
  cxbrdtmProgress.Visible := ivAlways;
  Application.ProcessMessages();
end;

procedure TMainForm.StepProgress(const aNewTitle: string; const aToPosition: Integer);
var
  i: Integer;
begin
  if aNewTitle <> EmptyStr then
  begin
    (cxbrdtmProgress.Properties as TcxProgressBarProperties).Text := aNewTitle.Trim();
  end;
  if aToPosition > -1 then
  begin
    cxbrdtmProgress.EditValue := aToPosition;
  end
  else
  begin
    i := cxbrdtmProgress.EditValue;
    cxbrdtmProgress.EditValue := Succ(i);
  end;
end;

procedure TMainForm.StorePresenter(const aPresenter: IInterface);
begin
  FPresenter := aPresenter;
end;

procedure TMainForm.tblvFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veSelectedRecordChanged);
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.ApplyConfiguration();
begin
  SetEnableStatusbar(TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStatusbar);
  SetEnableToolbar(TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableToolbar);
end;

procedure TMainForm.cbbBudgetItemTypesPropertiesChange(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FOnEventSimple(veBudgetItemTypeChanged);
    if GetCurrentEntity() in [etActualBudget, etPlannedBudget] then
    begin
      btnRefresh.Click();
    end;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.cbbOperationTypesPropertiesChange(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    cxgrdOperations.ActiveLevel.GridView := cbbOperationTypes.Properties.Items.Objects[cbbOperationTypes.ItemIndex] as TcxGridTableView;
    FOnEventSimple(veEntityChanged);
    btnRefresh.Click();
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.cbbReferencesPropertiesChange(Sender: TObject);
var
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    cxgrdReferences.ActiveLevel.GridView := cbbReferences.Properties.Items.Objects[cbbReferences.ItemIndex] as TcxGridTableView;
    FOnEventSimple(veEntityChanged);
    btnRefresh.Click();
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

procedure TMainForm.SetAccountingCenters(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvAccountingCenters.BeginUpdate();
  try
    tblvAccountingCenters.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvAccountingCenters.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvAccountingCenters.DataController.Values[i, colAccountingCenters_Id_AccountingCenter.Index] := aValue.FieldByName(TQuery.sp_accounting_centers_sel.Field.Id).AsInteger;
      tblvAccountingCenters.DataController.Values[i, colAccountingCenters_Code.Index] := aValue.FieldByName(TQuery.sp_accounting_centers_sel.Field.Code).AsString;
      tblvAccountingCenters.DataController.Values[i, colAccountingCenters_Name.Index] := aValue.FieldByName(TQuery.sp_accounting_centers_sel.Field.Name).AsString;
      tblvAccountingCenters.DataController.Values[i, colAccountingCenters_Description.Index] := aValue.FieldByName(TQuery.sp_accounting_centers_sel.Field.Description).AsString;
      tblvAccountingCenters.DataController.Values[i, colAccountingCenters_Activity.Index] := aValue.FieldByName(TQuery.sp_accounting_centers_sel.Field.Activity).AsBoolean;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvAccountingCenters.EndUpdate();
  end;
end;

procedure TMainForm.SetSummaryReport(const aValue: TDataSet);
var
  i: Integer;
begin
  tblvSummaryReport.BeginUpdate();
  try
    tblvSummaryReport.DataController.RecordCount := 0;

    if not Assigned(aValue) then
    begin
      Exit;
    end;

    if aValue.IsEmpty() then
    begin
      Exit;
    end;

    aValue.First();
    tblvSummaryReport.DataController.RecordCount := aValue.RecordCount;

    for i := 0 to Pred(aValue.RecordCount) do
    begin
      tblvSummaryReport.DataController.Values[i, colSummaryReport_BudgetItem.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.BudgetItem).AsString;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_BudgetItemType.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.BudgetItemType).AsString;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_AccountingCenter.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.AccountingCenter).AsString;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_Month.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.Month).AsString;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_Currency.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.Currency).AsString;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_PlannedAmount.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.PlannedAmount).AsCurrency;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_ActualAmount.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.ActualAmount).AsCurrency;
      tblvSummaryReport.DataController.Values[i, colSummaryReport_Balance.Index] := aValue.FieldByName(TQuery.sp_summary_report_sel.Field.Balance).AsCurrency;

      StepProgress();

      aValue.Next();
    end;
  finally
    tblvSummaryReport.EndUpdate();
  end;
end;

end.
