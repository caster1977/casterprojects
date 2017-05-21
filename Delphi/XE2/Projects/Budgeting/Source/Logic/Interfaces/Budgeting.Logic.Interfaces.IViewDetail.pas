unit Budgeting.Logic.Interfaces.IViewDetail;

interface

uses
  Budgeting.Logic.Interfaces.IView,
  Data.DB,
  System.Generics.Collections;

type
  IViewDetail = interface(IView)
    //procedure SetList(const aValue: TDataSet);
    //property List: TDataSet write SetList;
  end;

implementation

end.
