unit Beeper.uSignalClass;

interface

uses
  System.IniFiles,
  CastersPackage.uIIniFileDataStorage,
  CastersPackage.uTIniFileDataStorage;

type
  TPeriodType = (rtSeconds, rtMinutes, rtHours, rtDays, rtWeeks, rtMonths, rtYears);

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

  TSignal = class(TIniFileDataStorage, IIniFileDataStorage, ISignal)
  strict private
    FTitle: string;
    FPeriod: integer;
    FPeriodType: TPeriodType;
    FHint: string;
    FWaveFile: string;
  public
    function PeriodToSeconds(const ASeconds: word; const AMinutes: word = 0; const AHours: word = 0; const ADays: word = 0; const AWeeks: word = 0;
      const AMonths: word = 0; const AYears: word = 0): Int64;
  published
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetPeriod: Int64;
    procedure SetPeriod(const Value: Int64);
    function GetPeriodType: TPeriodType;
    procedure SetPeriodType(const Value: TPeriodType);
    function GetHint: string;
    procedure SetHint(const Value: string);
    function GetWaveFile: string;
    procedure SetWaveFile(const Value: string);
  public
    property Title: string read GetTitle write SetTitle;
    property Period: Int64 read GetPeriod write SetPeriod;
    property PeriodType: TPeriodType read GetPeriodType write SetPeriodType;
    property Hint: string read GetHint write SetHint;
    property WaveFile: string read GetWaveFile write SetWaveFile;
    procedure Loading; override;
    procedure Saving; override;
  end;

implementation

uses
  System.SysUtils;

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

function TSignal.PeriodToSeconds(const ASeconds, AMinutes, AHours, ADays, AWeeks, AMonths, AYears: word): Int64;
begin
  Result := 0;
end;

procedure TSignal.SetHint(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if FHint <> s then
    FHint := s;
end;

procedure TSignal.SetTitle(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if FTitle <> s then
    FTitle := s;
end;

procedure TSignal.SetPeriod(const Value: Int64);
begin
  if FPeriod <> Value then
    FPeriod := Value;
end;

procedure TSignal.SetPeriodType(const Value: TPeriodType);
begin
  if FPeriodType <> Value then
    FPeriodType := Value;
end;

procedure TSignal.SetWaveFile(const Value: string);
var
  s: string;
begin
  s := Trim(Value);
  if FWaveFile <> s then
    FWaveFile := s;
end;

procedure TSignal.Loading;
begin
  inherited;

end;

procedure TSignal.Saving;
begin
  inherited;

end;

end.
