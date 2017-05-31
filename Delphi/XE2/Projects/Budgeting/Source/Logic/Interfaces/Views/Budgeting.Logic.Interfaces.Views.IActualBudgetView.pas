unit Budgeting.Logic.Interfaces.Views.IActualBudgetView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  System.Classes,
  Data.DB;

type
  IActualBudgetView = interface(ICustomEditView)
    ['{EAD3395C-A726-43CB-AB02-BA93DDD09F8A}']
    procedure SetBudgetItems(const aValue: TStringList);
    property BudgetItems: TStringList write SetBudgetItems;

    procedure SetAccountingCenters(const aValue: TStringList);
    property AccountingCenters: TStringList write SetAccountingCenters;

    procedure SetCosignatories(const aValue: TStringList);
    property Cosignatories: TStringList write SetCosignatories;

    procedure SetProducts(const aValue: TStringList);
    property Products: TStringList write SetProducts;

    procedure SetCurrencies(const aValue: TStringList);
    property Currencies: TStringList write SetCurrencies;
  end;

implementation

end.
