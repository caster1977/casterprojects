unit Budgeting.Logic.Interfaces.IBudgetItemPresenter;

interface

uses
  System.Classes,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter;

type
  IBudgetItemPresenter = interface(ICustomPresenter)
    ['{89E3A88E-22AF-4785-8A58-FDFA522ECB0C}']
    procedure LoadBudgetItemTypes(var aList: TStringList);
  end;

implementation

end.
