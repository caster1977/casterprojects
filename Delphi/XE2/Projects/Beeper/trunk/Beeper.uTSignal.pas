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
    FMessageEnabled: Boolean;
    FMessage: string;
    FWaveFileEnabled: Boolean;
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
  strict protected
    procedure Initialize; virtual;
  public
    constructor Create; virtual; final;
    property Title: string read GetTitle write SetTitle nodefault;
    property PeriodType: TPeriodType read GetPeriodType write SetPeriodType default DEFAULT_PERIOD_TYPE;
    property Period: Int64 read GetPeriod write SetPeriod default DEFAULT_PERIOD;
    property MessageEnabled: boolean read GetMessageEnabled write SetMessageEnabled;
    property Message: string read GetMessage write SetMessage;
    property WaveFileEnabled: boolean read GetWaveFileEnabled write SetWaveFileEnabled;
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

function TSignal.GetMessage: string;
begin
  Result := FMessage;
end;

function TSignal.GetMessageEnabled: Boolean;
begin
  Result := FMessageEnabled;
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

function TSignal.GetWaveFileEnabled: Boolean;
begin
  Result := FWaveFileEnabled;
end;

procedure TSignal.SetEnabled(const AValue: Boolean);
begin
  if FEnabled <> AValue then
    FEnabled := AValue;
end;

procedure TSignal.SetMessage(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FMessage <> s then
    FMessage := s;
end;

procedure TSignal.SetMessageEnabled(const AValue: Boolean);
begin
  if FMessageEnabled <> AValue then
    FMessageEnabled := AValue;
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

procedure TSignal.SetWaveFileEnabled(const AValue: Boolean);
begin
  if FWaveFileEnabled <> AValue then
    FWaveFileEnabled := AValue;
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
  FMessageEnabled := DEFAULT_MESSAGE_ENABLED;
  FMessage := DEFAULT_MESSAGE;
  FWaveFileEnabled := DEFAULT_WAVE_FILE_ENABLED;
  FWaveFile := DEFAULT_WAVE_FILE;
end;

end.
