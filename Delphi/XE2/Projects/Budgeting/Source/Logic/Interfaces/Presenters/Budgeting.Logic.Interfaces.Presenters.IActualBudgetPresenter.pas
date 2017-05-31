unit Budgeting.Logic.Interfaces.Presenters.IActualBudgetPresenter;

interface

uses
  System.Classes,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter;

type
  IActualBudgetPresenter = interface(ICustomPresenter)
    ['{BC5A3D84-DAC8-4255-8EFF-FB5B5B371EC6}']
    procedure LoadBudgetItems(var aList: TStringList);
    procedure LoadAccountingCenters(var aList: TStringList);
    procedure LoadCosignatories(var aList: TStringList);
    procedure LoadProducts(var aList: TStringList);
    procedure LoadCurrencies(var aList: TStringList);
  end;

implementation

end.
