unit Budgeting.Logic.Interfaces.Presenters.IProductPresenter;

interface

uses
  System.Classes,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter;

type
  IProductPresenter = interface(ICustomPresenter)
    ['{77DB83EF-7F59-449F-8F2F-6B7FCEED4CF6}']
    procedure LoadProductTypes(var aList: TStringList);
  end;

implementation

end.
