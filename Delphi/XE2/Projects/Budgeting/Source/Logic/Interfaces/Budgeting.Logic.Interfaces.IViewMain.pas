unit Budgeting.Logic.Interfaces.IViewMain;

interface

uses
  Budgeting.Logic.Interfaces.IView,
  Vcl.Controls,
  Data.DB,
  cxGridTableView,
  cxGrid,
  System.Generics.Collections,
  Budgeting.Logic.TEntityType;

type
  IViewMain = interface(IView)
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

    procedure SetGoods(const aValue: TDataSet);
    property Goods: TDataSet write SetGoods;

    procedure SetGoodsTypes(const aValue: TDataSet);
    property GoodsTypes: TDataSet write SetGoodsTypes;

    function GetCurrentEntity(): TEntityType;
    property CurrentEntity: TEntityType read GetCurrentEntity;

    function GetCurrentId(const aEntityType: TEntityType): Integer;

    procedure SetEnableStatusbar(const aValue: Boolean);
    property EnableStatusbar: Boolean write SetEnableStatusbar;

    procedure SetEnableToolbar(const aValue: Boolean);
    property EnableToolbar: Boolean write SetEnableToolbar;
  end;

implementation

end.
