unit Budgeting.Logic.Interfaces.Views.ICustom;

interface

uses
  System.SysUtils,
  Vcl.Controls,
  Data.DB,
  Budgeting.Logic.TViewEnumEvent,
  Budgeting.Logic.TViewEnumAction;

type
  ICustomView = interface(IInterface)
    function ShowMessage(const aMessage: string; const aStatus: Cardinal): Integer;

    function GetControl(): TWinControl;
    property Control: TWinControl read GetControl;

    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    property OnEventSimple: TProc<TViewEnumEvent> write SetOnEventSimple;

    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    property ActionStates[const aValue: TViewEnumAction]: Boolean read GetActionStates write SetActionStates;

    procedure ShowProgress(const aTitle: string; const aMax: Integer = 100);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();
    procedure RefreshStates();

    procedure StorePresenter(const aPresenter: IInterface);
    procedure SetCaption(const aValue: string);
  end;

implementation

end.
