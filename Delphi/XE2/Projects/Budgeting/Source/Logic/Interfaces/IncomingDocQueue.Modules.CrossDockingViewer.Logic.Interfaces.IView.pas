unit IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IView;

interface

uses
  System.SysUtils,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumEvent,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumAction;

type
  IView = interface(IInterface)
    ['{59B0614C-7F7F-4752-A166-BF3F277489E2}']
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    property OnEventSimple: TProc<TViewEnumEvent> write SetOnEventSimple;
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    property ActionStates[const aValue: TViewEnumAction]: Boolean read GetActionStates write SetActionStates;
    procedure RefreshStates();
    procedure ShowMessage(const aMessage: string; const aStatus: Integer);
    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

end.
