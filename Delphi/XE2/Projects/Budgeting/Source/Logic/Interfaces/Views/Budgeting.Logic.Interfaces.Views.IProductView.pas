unit Budgeting.Logic.Interfaces.Views.IProductView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  System.Classes,
  Data.DB;

type
  IProductView = interface(ICustomEditView)
    ['{EBAE338C-4B4B-4272-9A6F-AB0DF4FCF291}']
    procedure SetProductTypes(const aValue: TStringList);
    property ProductTypes: TStringList write SetProductTypes;
  end;

implementation

end.
