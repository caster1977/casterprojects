unit Budgeting.Logic.Interfaces.Views.IPlannedBudgetView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  System.Classes,
  Data.DB;

type
  IPlannedBudgetView = interface(ICustomEditView)
    ['{FC545B03-397F-4D67-A6D8-EA913CF5DA9F}']
    procedure SetBudgetItems(const aValue: TStringList);
    property BudgetItems: TStringList write SetBudgetItems;

    procedure SetAccountingCenters(const aValue: TStringList);
    property AccountingCenters: TStringList write SetAccountingCenters;

    procedure SetCurrencies(const aValue: TStringList);
    property Currencies: TStringList write SetCurrencies;

    procedure SetYears(const aValue: TStringList);
    property Years: TStringList write SetYears;

    procedure SetMonths(const aValue: TStringList);
    property Months: TStringList write SetMonths;
  end;

implementation

end.
