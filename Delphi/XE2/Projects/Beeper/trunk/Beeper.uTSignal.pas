unit Beeper.uTSignal;

interface

uses
  System.IniFiles,
  System.Classes,
  Beeper.uTPeriodType,
  Beeper.uISignal,
  Beeper.uConsts;

type
  TSignal = class(TInterfacedPersistent, ISignal)
  strict private
    FTitle: string;
    FPeriod: integer;
    FPeriodType: TPeriodType;
    FHint: string;
    FWaveFile: string;
    FEnabled: Boolean;
    function PeriodToSeconds(const ASeconds: word; const AMinutes: word = 0; const AHours: word = 0; const ADays: word = 0; const AWeeks: word = 0;
      const AMonths: word = 0; const AYears: word = 0): Int64;

    function GetTitle: string;
    procedure SetTitle(const AValue: string);

    function GetPeriod: Int64;
    procedure SetPeriod(const AValue: Int64);

    function GetPeriodType: TPeriodType;
    procedure SetPeriodType(const AValue: TPeriodType);

    function GetHint: string;
    procedure SetHint(const AValue: string);

    function GetWaveFile: string;
    procedure SetWaveFile(const AValue: string);

    function GetEnabled: Boolean;
    procedure SetEnabled(const AValue: Boolean);
  strict protected
    procedure Initialize; virtual;
  public
    constructor Create; virtual; final;
    property Title: string read GetTitle write SetTitle nodefault;
    property PeriodType: TPeriodType read GetPeriodType write SetPeriodType default DEFAULT_PERIOD_TYPE;
    property Period: Int64 read GetPeriod write SetPeriod default DEFAULT_PERIOD;
    property Hint: string read GetHint write SetHint nodefault;
    property WaveFile: string read GetWaveFile write SetWaveFile nodefault;
    property Enabled: Boolean read GetEnabled write SetEnabled default DEFAULT_ENABLED;
  end;

implementation

uses
  System.SysUtils;

constructor TSignal.Create;
begin
  inherited;
  Initialize;
end;

function TSignal.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TSignal.GetHint: string;
begin
  Result := FHint;
end;

function TSignal.GetTitle: string;
begin
  Result := FTitle;
end;

function TSignal.GetPeriod: Int64;
begin
  Result := FPeriod;
end;

function TSignal.GetPeriodType: TPeriodType;
begin
  Result := FPeriodType;
end;

function TSignal.GetWaveFile: string;
begin
  Result := FWaveFile;
end;

procedure TSignal.SetEnabled(const AValue: Boolean);
begin
  if FEnabled <> AValue then
    FEnabled := AValue;
end;

procedure TSignal.SetHint(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FHint <> s then
    FHint := s;
end;

procedure TSignal.SetTitle(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTitle <> s then
    FTitle := s;
end;

procedure TSignal.SetPeriod(const AValue: Int64);
begin
  if FPeriod <> AValue then
    FPeriod := AValue;
end;

procedure TSignal.SetPeriodType(const AValue: TPeriodType);
begin
  if FPeriodType <> AValue then
    FPeriodType := AValue;
end;

procedure TSignal.SetWaveFile(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FWaveFile <> s then
    FWaveFile := s;
end;

function TSignal.PeriodToSeconds(const ASeconds, AMinutes, AHours, ADays, AWeeks, AMonths, AYears: word): Int64;
begin
  Result := 0;
end;

procedure TSignal.Initialize;
begin
  inherited;
  FTitle := DEFAULT_TITLE;
  FPeriod := DEFAULT_PERIOD;
  FPeriodType := DEFAULT_PERIOD_TYPE;
  FHint := DEFAULT_HINT;
  FWaveFile := DEFAULT_WAVE_FILE;
end;

end.
