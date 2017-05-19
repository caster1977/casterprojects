unit IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IViewDetail;

interface

uses
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IView,
  Data.DB,
  System.Generics.Collections;

type
  IViewDetail = interface(IView)
    ['{2B689476-5B39-4362-867C-D734ED8D1DD4}']
    procedure SetList(const aValue: TDataSet);
    property List: TDataSet write SetList;
  end;

implementation

end.
