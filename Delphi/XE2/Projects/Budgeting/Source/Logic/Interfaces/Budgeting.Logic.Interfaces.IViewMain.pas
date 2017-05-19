unit Budgeting.Logic.Interfaces.IViewMain;

interface

uses
  Budgeting.Logic.TViewEnumEvent, Budgeting.Logic.TViewEnumAction, System.SysUtils, Vcl.Controls;

type
  IViewMain = interface
    function GetControl(): TWinControl;
    property Control: TWinControl read GetControl;

    procedure SetOnEventSimple(const aValue: TProc<TViewEnumEvent>);
    property OnEventSimple: TProc<TViewEnumEvent> write SetOnEventSimple;

    {procedure SetDestinationFolderName(const aValue: string);
    property DestinationFolderName: string write SetDestinationFolderName;

    procedure SetOldFileName(const aValue: string);
    property OldFileName: string write SetOldFileName;

    procedure SetNewFileName(const aValue: string);
    property NewFileName: string write SetNewFileName;}

    function GetActionStates(const aValue: TViewEnumAction): Boolean;
    procedure SetActionStates(const aKey: TViewEnumAction; const aValue: Boolean);
    property ActionStates[const aValue: TViewEnumAction]: Boolean read GetActionStates write SetActionStates;

    procedure ShowProgress(const aTitle: string; const aMax: Integer = 100);
    procedure StepProgress(const aNewTitle: string = ''; const aToPosition: Integer = -1);
    procedure HideProgress();
    procedure RefreshStates();

    procedure StorePresenter(const aPresenter: IInterface);
  end;

implementation

end.
