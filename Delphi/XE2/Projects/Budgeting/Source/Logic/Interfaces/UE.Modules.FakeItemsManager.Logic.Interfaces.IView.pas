unit UE.Modules.FakeItemsManager.Logic.Interfaces.IView;

interface

uses
  System.SysUtils,
  UE.Modules.FakeItemsManager.Logic.TViewEnumEvent,
  UE.Modules.FakeItemsManager.Logic.TViewEnumAction;

type
  IView = interface(IInterface)
    ['{72C9F68C-3E4F-47C5-96AA-AE44C33B3C60}']
    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    property OnEventSimple: TProc<TViewEnumEvent> write SetOnEventSimple;
    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    property ActionStates[const aValue: TViewEnumAction]: Boolean read GetActionStates write SetActionStates;
    procedure RefreshStates();
    procedure ShowMessage(const aMessage: string; const aStatus: Integer);
    procedure SetCaption(const aValue: string);
    property Caption: string write SetCaption;
    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

end.
