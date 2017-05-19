unit IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IViewMain;

interface

uses
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumEvent,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.TViewEnumAction,
  IncomingDocQueue.Modules.CrossDockingViewer.Logic.Interfaces.IView,
  System.SysUtils,
  Vcl.Controls,
  Data.DB;

type
  IViewMain = interface(IView)
    ['{AB6D047F-5C0B-422B-BA86-655956D8186C}']
    function GetBeginDate(): TDate;
    procedure SetBeginDate(const aValue: TDate);
    property BeginDate: TDate read GetBeginDate write SetBeginDate;

    function GetEndDate(): TDate;
    procedure SetEndDate(const aValue: TDate);
    property EndDate: TDate read GetEndDate write SetEndDate;

    function GetOrderCode(): string;
    procedure SetOrderCode(const aValue: string);
    property OrderCode: string read GetOrderCode write SetOrderCode;

    procedure SetQueue(const aValue: TDataSet);
    property Queue: TDataSet write SetQueue;

    procedure ShowProgress(const aTitle: string; const aMax: Integer = 100);
    procedure StepProgress(const aToPosition: Integer = -1);
    procedure HideProgress();
    procedure RefreshStates();

    function GetCurrentDocumentId(): Integer;
    property CurrentDocumentId: Integer read GetCurrentDocumentId;
  end;

implementation

end.
