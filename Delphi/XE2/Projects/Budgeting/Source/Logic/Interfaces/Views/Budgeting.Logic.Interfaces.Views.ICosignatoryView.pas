unit Budgeting.Logic.Interfaces.Views.ICosignatoryView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomEditView,
  System.Classes,
  Data.DB;

type
  ICosignatoryView = interface(ICustomEditView)
    ['{D8CD1D73-A6EC-45DC-8B33-EF027C34440B}']
    procedure SetBanks(const aValue: TStringList);
    property Banks: TStringList write SetBanks;
  end;

implementation

end.
