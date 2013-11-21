unit uIPeriodFilter;

interface

type
  IPeriodFilter = interface
    ['{807CFC40-3E1F-4F95-9420-6C4F2BF1EAF8}']
    function GetCaption: string;
    procedure SetCaption(const AValue: string);
    property Caption: string read GetCaption write SetCaption;

    function GetStartDate: TDate;
    procedure SetStartDate(const AValue: TDate);
    property StartDate: TDate read GetStartDate write SetStartDate;

    function GetStopDate: TDate;
    procedure SetStopDate(const AValue: TDate);
    property StopDate: TDate read GetStopDate write SetStopDate;

    function GetActive: Boolean;
    procedure SetActive(const AValue: Boolean);
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

end.
