unit Budgeting.Logic.Interfaces.IViewMain;

interface

uses
  Budgeting.Logic.Interfaces.IView,
  Vcl.Controls,
  Data.DB,
  cxGrid;

type
  IViewMain = interface(IView)
    ['{AF3E7317-B9D4-4D57-B775-459B16FC81F2}']
    function GetActiveGrid(): TcxGrid;
    // function GetBeginDate(): TDate;
    // procedure SetBeginDate(const aValue: TDate);
    // property BeginDate: TDate read GetBeginDate write SetBeginDate;

    // function GetEndDate(): TDate;
    // procedure SetEndDate(const aValue: TDate);
    // property EndDate: TDate read GetEndDate write SetEndDate;

    // function GetOrderCode(): string;
    // procedure SetOrderCode(const aValue: string);
    // property OrderCode: string read GetOrderCode write SetOrderCode;

    // procedure SetQueue(const aValue: TDataSet);
    // property Queue: TDataSet write SetQueue;

    function GetCurrentDocumentId(): Integer;
    property CurrentDocumentId: Integer read GetCurrentDocumentId;

    procedure SetEnableStatusbar(const aValue: Boolean);
    property EnableStatusbar: Boolean write SetEnableStatusbar;

    procedure SetEnableToolbar(const aValue: Boolean);
    property EnableToolbar: Boolean write SetEnableToolbar;
  end;

implementation

end.
