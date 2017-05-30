unit Budgeting.Logic.Interfaces.Views.IBudgetItemView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  System.Classes,
  Data.DB;

type
  IBudgetItemView = interface(ICustomEditView)
    ['{8697ED03-85A3-428B-9A76-9FEAA0E8959E}']
    procedure SetBudgetItemTypes(const aValue: TStringList);
    property BudgetItemTypes: TStringList write SetBudgetItemTypes;
  end;

implementation

end.
