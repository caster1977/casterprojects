unit Budgeting.Logic.Interfaces.Presenters.IPlannedBudgetPresenter;

interface

uses
  System.Classes,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter;

type
  IPlannedBudgetPresenter = interface(ICustomPresenter)
    ['{D96FA3B3-98B4-41ED-AAE5-63A8C1A4F35B}']
    procedure LoadBudgetItems(var aList: TStringList);
    procedure LoadAccountingCenters(var aList: TStringList);
    procedure LoadCurrencies(var aList: TStringList);
    procedure LoadYears(var aList: TStringList);
    procedure LoadMonths(var aList: TStringList);
  end;

implementation

end.
