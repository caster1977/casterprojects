unit Beeper.uISignal;

interface

uses
  Beeper.uTPeriodType;

type
  ISignal = interface
    ['{8FB4586E-5BBB-430D-AD29-EE5B9776088F}']
    procedure Initialize;
    function PeriodToSeconds(const ASeconds: Word; const AMinutes: Word = 0; const AHours: Word = 0; const ADays: Word = 0; const AWeeks: Word = 0;
      const AMonths: Word = 0; const AYears: Word = 0): Int64;

    function GetTitle: string;
    procedure SetTitle(const AValue: string);

    function GetPeriod: Int64;
    procedure SetPeriod(const AValue: Int64);

    function GetPeriodType: TPeriodType;
    procedure SetPeriodType(const AValue: TPeriodType);

    function GetMessageEnabled: Boolean;
    procedure SetMessageEnabled(const AValue: Boolean);

    function GetMessage: string;
    procedure SetMessage(const AValue: string);

    function GetWaveFileEnabled: Boolean;
    procedure SetWaveFileEnabled(const AValue: Boolean);

    function GetWaveFile: string;
    procedure SetWaveFile(const AValue: string);

    function GetEnabled: Boolean;
    procedure SetEnabled(const AValue: Boolean);

    property Title: string read GetTitle write SetTitle;
    property Period: Int64 read GetPeriod write SetPeriod;
    property PeriodType: TPeriodType read GetPeriodType write SetPeriodType;
    property MessageEnabled: boolean read GetMessageEnabled write SetMessageEnabled;
    property Message: string read GetMessage write SetMessage;
    property WaveFileEnabled: boolean read GetWaveFileEnabled write SetWaveFileEnabled;
    property WaveFile: string read GetWaveFile write SetWaveFile;
    property Enabled: Boolean read GetEnabled write SetEnabled;
  end;

implementation

end.
