unit Budgeting.Logic.Interfaces.Views.IMainView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Vcl.Controls,
  Data.DB,
  cxGridTableView,
  cxGrid,
  System.Generics.Collections,
  Budgeting.Logic.Types.TEntity;

type
  IMainView = interface(ICustomView)
    ['{AF3E7317-B9D4-4D57-B775-459B16FC81F2}']
    function GetActiveGrid(): TcxGrid;
    // function GetBeginDate(): TDate;
    // procedure SetBeginDate(const aValue: TDate);
    // property BeginDate: TDate read GetBeginDate write SetBeginDate;

    // function GetEndDate(): TDate;
    // procedure SetEndDate(const aValue: TDate);
    // property EndDate: TDate read GetEndDate write SetEndDate;

    // function GetOrderCode(): string;
    // procedure SetOrderCode(const aValue: string);
    // property OrderCode: string read GetOrderCode write SetOrderCode;

    procedure SetAccountingCenters(const aValue: TDataSet);
    property AccountingCenters: TDataSet write SetAccountingCenters;

    procedure SetBanks(const aValue: TDataSet);
    property Banks: TDataSet write SetBanks;

    procedure SetBudgetItems(const aValue: TDataSet);
    property BudgetItems: TDataSet write SetBudgetItems;

    procedure SetBudgetItemTypes(const aValue: TDataSet);
    property BudgetItemTypes: TDataSet write SetBudgetItemTypes;

    procedure SetCosignatories(const aValue: TDataSet);
    property Cosignatories: TDataSet write SetCosignatories;

    procedure SetCurrencies(const aValue: TDataSet);
    property Currencies: TDataSet write SetCurrencies;

    procedure SetProducts(const aValue: TDataSet);
    property Products: TDataSet write SetProducts;

    procedure SetProductTypes(const aValue: TDataSet);
    property ProductTypes: TDataSet write SetProductTypes;

    procedure SetActualBudget(const aValue: TDataSet);
    property ActualBudget: TDataSet write SetActualBudget;

    procedure SetPlannedBudget(const aValue: TDataSet);
    property PlannedBudget: TDataSet write SetPlannedBudget;

    function GetCurrentEntity(): TEntity;
    property CurrentEntity: TEntity read GetCurrentEntity;

    function GetCurrentId(const aEntity: TEntity): Integer;

    procedure SetEnableStatusbar(const aValue: Boolean);
    property EnableStatusbar: Boolean write SetEnableStatusbar;

    procedure SetEnableToolbar(const aValue: Boolean);
    property EnableToolbar: Boolean write SetEnableToolbar;

    procedure Initialize();
  end;

implementation

end.
