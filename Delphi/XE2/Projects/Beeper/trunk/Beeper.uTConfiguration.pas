unit Beeper.uTConfiguration;

interface

uses
  Beeper.uIConfiguration,
  Winapi.Windows,
  System.IniFiles,
  CastersPackage.uTIniFileDataStorage,
  CastersPackage.uIIniFileDataStorage,
  Beeper.uConsts,
  Beeper.uISignalList;

type
  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict private
    FShowBaloonHints: Boolean;
    FSoundEnabled: Boolean;
    FModifierOn, FModifierOff: Integer;
    FVirtualKeyOn, FVirtualKeyOff: Cardinal;
    FSignalList: ISignalList;
    function GetShowBaloonHints: Boolean;
    procedure SetShowBaloonHints(const Value: Boolean);
    function GetSoundEnabled: Boolean;
    procedure SetSoundEnabled(const Value: Boolean);
    function GetModifierOff: Integer;
    procedure SetModifierOff(const Value: Integer);
    function GetModifierOn: Integer;
    procedure SetModifierOn(const Value: Integer);
    function GetVirtualKeyOff: Cardinal;
    procedure SetVirtualKeyOff(const Value: Cardinal);
    function GetVirtualKeyOn: Cardinal;
    procedure SetVirtualKeyOn(const Value: Cardinal);
    function GetSignalList: ISignalList;
    procedure SetSignalList(const Value: ISignalList);
  strict protected
    procedure Initialize; override;
    procedure Loading(const AIniFile: TIniFile); override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving(const AIniFile: TIniFile); override;
  public
    property ShowBaloonHints: Boolean read GetShowBaloonHints write SetShowBaloonHints default DEFAULT_SHOW_BALOON_HINTS;
    property SoundEnabled: Boolean read GetSoundEnabled write SetSoundEnabled default DEFAULT_SOUND_ENABLED;
    property ModifierOn: Integer read GetModifierOn write SetModifierOn default DEFAULT_MODIFIER_ON;
    property VirtualKeyOn: Cardinal read GetVirtualKeyOn write SetVirtualKeyOn default DEFAULT_VIRTUAL_KEY_ON;
    property ModifierOff: Integer read GetModifierOff write SetModifierOff default DEFAULT_MODIFIER_OFF;
    property VirtualKeyOff: Cardinal read GetVirtualKeyOff write SetVirtualKeyOff default DEFAULT_VIRTUAL_KEY_OFF;
    property SignalList: ISignalList read GetSignalList write SetSignalList;
  end;

implementation

uses
  System.SysUtils,
  Beeper.uTSignalList,
  Beeper.uResourceStrings,
  Beeper.uISignal,
  Beeper.uTSignal,
  Beeper.uTPeriodType;

procedure TConfiguration.AfterLoad;
begin
  inherited;
end;

procedure TConfiguration.BeforeSave;
begin
  inherited;
end;

function TConfiguration.GetModifierOff: Integer;
begin
  Result := FModifierOff;
end;

function TConfiguration.GetModifierOn: Integer;
begin
  Result := FModifierOn;
end;

function TConfiguration.GetShowBaloonHints: Boolean;
begin
  Result := FShowBaloonHints;
end;

function TConfiguration.GetSignalList: ISignalList;
begin
  Result := FSignalList;
end;

function TConfiguration.GetSoundEnabled: Boolean;
begin
  Result := FSoundEnabled;
end;

function TConfiguration.GetVirtualKeyOff: Cardinal;
begin
  Result := FVirtualKeyOff;
end;

function TConfiguration.GetVirtualKeyOn: Cardinal;
begin
  Result := FVirtualKeyOn;
end;

procedure TConfiguration.SetModifierOff(const Value: Integer);
begin
  if FModifierOff <> Value then
    FModifierOff := Value;
end;

procedure TConfiguration.SetModifierOn(const Value: Integer);
begin
  if FModifierOn <> Value then
    FModifierOn := Value;
end;

procedure TConfiguration.SetShowBaloonHints(const Value: Boolean);
begin
  if FShowBaloonHints <> Value then
    FShowBaloonHints := Value;
end;

procedure TConfiguration.SetSignalList(const Value: ISignalList);
begin
  if FSignalList <> Value then
    FSignalList := Value;
end;

procedure TConfiguration.SetSoundEnabled(const Value: Boolean);
begin
  if FSoundEnabled <> Value then
    FSoundEnabled := Value;
end;

procedure TConfiguration.SetVirtualKeyOff(const Value: Cardinal);
begin
  if FVirtualKeyOff <> Value then
    FVirtualKeyOff := Value;
end;

procedure TConfiguration.SetVirtualKeyOn(const Value: Cardinal);
begin
  if FVirtualKeyOn <> Value then
    FVirtualKeyOn := Value;
end;

procedure TConfiguration.Initialize;
begin
  inherited;
  FShowBaloonHints := DEFAULT_SHOW_BALOON_HINTS;
  FSoundEnabled := DEFAULT_SOUND_ENABLED;
  FModifierOn := DEFAULT_MODIFIER_ON;
  FModifierOff := DEFAULT_MODIFIER_OFF;
  FVirtualKeyOn := DEFAULT_VIRTUAL_KEY_ON;
  FVirtualKeyOff := DEFAULT_VIRTUAL_KEY_OFF;
  FSignalList := TSignalList.Create;
end;

procedure TConfiguration.Loading(const AIniFile: TIniFile);
var
  i, signal_count: Integer;
  signal: ISignal;
begin
  inherited;
  with AIniFile do
  begin
    ShowBaloonHints := ReadBool(RsHints, RsInTray, DEFAULT_SHOW_BALOON_HINTS);
    SoundEnabled := ReadBool(RsSounds, RsEnabled, DEFAULT_SOUND_ENABLED);
    ModifierOn := ReadInteger(RsHotKeys, RsModifierOn, DEFAULT_MODIFIER_ON);
    VirtualKeyOn := ReadInteger(RsHotKeys, RsVirtualKeyOn, DEFAULT_VIRTUAL_KEY_ON);
    ModifierOff := ReadInteger(RsHotKeys, RsModifierOff, DEFAULT_MODIFIER_OFF);
    VirtualKeyOff := ReadInteger(RsHotKeys, RsVirtualKeyOff, DEFAULT_VIRTUAL_KEY_OFF);
    signal_count := ReadInteger(RsSignals, RsQuantity, DEFAULT_SIGNAL_COUNT);
    SignalList.Clear;
    for i := 0 to signal_count - 1 do
    begin
      signal := TSignal.Create;
      signal.Title := ReadString(Format(RsSignal, [IntToStr(i)]), RsTitle, DEFAULT_TITLE);
      signal.Period := ReadInteger(Format(RsSignal, [IntToStr(i)]), RsPeriod, DEFAULT_PERIOD);
      signal.PeriodType := TPeriodType(ReadInteger(Format(RsSignal, [IntToStr(i)]), RsPeriodType, Integer(DEFAULT_PERIOD_TYPE)));
      signal.Hint := ReadString(Format(RsSignal, [IntToStr(i)]), RsHint, DEFAULT_HINT);
      signal.WaveFile := ReadString(Format(RsSignal, [IntToStr(i)]), RsWaveFile, DEFAULT_WAVE_FILE);
      SignalList.Add(signal);
    end;
  end;
end;

procedure TConfiguration.Saving(const AIniFile: TIniFile);
var
  i: Integer;
begin
  inherited;
  with AIniFile do
    try
      WriteBool(RsHints, RsInTray, ShowBaloonHints);
      WriteBool(RsSounds, RsEnabled, SoundEnabled);
      WriteInteger(RsHotKeys, RsModifierOn, ModifierOn);
      WriteInteger(RsHotKeys, RsVirtualKeyOn, VirtualKeyOn);
      WriteInteger(RsHotKeys, RsModifierOff, ModifierOff);
      WriteInteger(RsHotKeys, RsVirtualKeyOff, VirtualKeyOff);
      for i := 0 to SignalList.Count - 1 do
      begin
        WriteString(Format(RsSignal, [IntToStr(i)]), RsTitle, SignalList.Items[i].Title);
        WriteInteger(Format(RsSignal, [IntToStr(i)]), RsPeriod, SignalList.Items[i].Period);
        WriteInteger(Format(RsSignal, [IntToStr(i)]), RsPeriodType, Integer(SignalList.Items[i].PeriodType));
        WriteString(Format(RsSignal, [IntToStr(i)]), RsHint, SignalList.Items[i].Hint);
        WriteString(Format(RsSignal, [IntToStr(i)]), RsWaveFile, SignalList.Items[i].WaveFile);
      end;
    except
      on EIniFileException do
        raise EIniFileException.Create(RsIniFileSaveError);
    end;
end;

end.
