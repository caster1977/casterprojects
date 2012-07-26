unit Beeper.uISignal;

interface

uses
  Beeper.uTPeriodType;

type
  ISignal = interface
    ['{8FB4586E-5BBB-430D-AD29-EE5B9776088F}']
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    property Title: string read GetTitle write SetTitle;
    function GetPeriod: Int64;
    procedure SetPeriod(const Value: Int64);
    property Period: Int64 read GetPeriod write SetPeriod;
    function GetPeriodType: TPeriodType;
    procedure SetPeriodType(const Value: TPeriodType);
    property PeriodType: TPeriodType read GetPeriodType write SetPeriodType;
    function GetHint: string;
    procedure SetHint(const Value: string);
    property Hint: string read GetHint write SetHint;
    function GetWaveFile: string;
    procedure SetWaveFile(const Value: string);
    property WaveFile: string read GetWaveFile write SetWaveFile;
    function PeriodToSeconds(const ASeconds: Word; const AMinutes: Word = 0; const AHours: Word = 0; const ADays: Word = 0; const AWeeks: Word = 0;
      const AMonths: Word = 0; const AYears: Word = 0): Int64;
  end;

implementation

end.
