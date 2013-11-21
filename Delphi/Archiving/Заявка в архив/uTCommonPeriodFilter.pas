unit uTCommonPeriodFilter;

interface

uses
  uIPeriodFilter;

type
  TCommonPeriodFilter = class(TInterfacedObject, IPeriodFilter)
  protected
    function GetCaption: string; virtual; abstract;
    function GetStartDate: TDate; virtual; abstract;
    function GetStopDate: TDate; virtual; abstract;
    function GetActive: Boolean; virtual; abstract;
    procedure SetCaption(const AValue: string); virtual; abstract;
    procedure SetStartDate(const AValue: TDate); virtual; abstract;
    procedure SetStopDate(const AValue: TDate); virtual; abstract;
    procedure SetActive(const AValue: Boolean); virtual; abstract;
  public
    property Caption: string read GetCaption write SetCaption nodefault;
    property StartDate: TDate read GetStartDate write SetStartDate nodefault;
    property StopDate: TDate read GetStopDate write SetStopDate nodefault;
    property Active: Boolean read GetActive write SetActive nodefault;
  end;

implementation

end.
