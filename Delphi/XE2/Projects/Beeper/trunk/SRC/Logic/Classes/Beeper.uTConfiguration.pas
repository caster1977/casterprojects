unit Beeper.uTConfiguration;

interface

uses
  System.SysUtils,
  Beeper.uIConfiguration,
  Winapi.Windows,
  System.IniFiles,
  CastersPackage.uTIniFileDataStorage,
  Beeper.uConsts,
  Beeper.uISignalList;

type
  EConfiguration = class(Exception);

  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict private
    FSignals: ISignalList;
    FShowBaloonHints: Boolean;
    FSoundEnabled: Boolean;
    FModifierOn, FModifierOff: Integer;
    FVirtualKeyOn, FVirtualKeyOff: Cardinal;
    function GetShowBaloonHints: Boolean;
    procedure SetShowBaloonHints(const AValue: Boolean);
    function GetSoundEnabled: Boolean;
    procedure SetSoundEnabled(const AValue: Boolean);
    function GetModifierOff: Integer;
    procedure SetModifierOff(const AValue: Integer);
    function GetModifierOn: Integer;
    procedure SetModifierOn(const AValue: Integer);
    function GetVirtualKeyOff: Cardinal;
    procedure SetVirtualKeyOff(const AValue: Cardinal);
    function GetVirtualKeyOn: Cardinal;
    procedure SetVirtualKeyOn(const AValue: Cardinal);
    function GetSignals: ISignalList;
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading; override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving; override;
  public
    constructor Create(const AConfigurationFileName: string = ''); override;
    property ShowBaloonHints: Boolean read GetShowBaloonHints write SetShowBaloonHints
      default DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS;
    property SoundEnabled: Boolean read GetSoundEnabled write SetSoundEnabled
      default DEFAULT_CONFIGURATION_SOUND_ENABLED;
    property ModifierOn: Integer read GetModifierOn write SetModifierOn
      default DEFAULT_CONFIGURATION_MODIFIER_ON;
    property VirtualKeyOn: Cardinal read GetVirtualKeyOn write SetVirtualKeyOn
      default DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON;
    property ModifierOff: Integer read GetModifierOff write SetModifierOff
      default DEFAULT_CONFIGURATION_MODIFIER_OFF;
    property VirtualKeyOff: Cardinal read GetVirtualKeyOff write SetVirtualKeyOff
      default DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF;
    property Signals: ISignalList read GetSignals nodefault;
  end;

function GetIConfiguration(const AConfigurationFileName: string = ''): IConfiguration;

implementation

uses
  System.Classes,
  Beeper.uResourceStrings,
  Beeper.uISignal,
  Beeper.uTSignal,
  Beeper.uTSignalList,
  Beeper.uTPeriodTypes,
  CastersPackage.uRoutines;

resourcestring
  RsHints = 'Подсказки';
  RsSounds = 'Звуки';
  RsHotKeys = 'Горячие клавиши';
  RsSignals = 'Сигналы';
  RsSignal = 'Сигнал %s';

  RsInTray = 'В трее';
  RsEnabled = 'Включен(ы)';
  RsModifierOn = 'Модификатор клавиши включения';
  RsVirtualKeyOn = 'Клавиша включения';
  RsModifierOff = 'Модификатор клавиши отключения';
  RsVirtualKeyOff = 'Клавиша отключения';
  RsQuantity = 'Количество';
  RsTitle = 'Наименование';
  RsPeriodType = 'Тип периода';
  RsPeriod = 'Период';
  RsMessageEnabled = 'Выводить сообщение';
  RsMessage = 'Сообщение';
  RsWaveFileEnabled = 'Проигрывать звуковой файл';
  RsIniFileSaveError =
    'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

function GetIConfiguration(const AConfigurationFileName: string): IConfiguration;
begin
  Result := TConfiguration.Create(AConfigurationFileName);
end;

procedure TConfiguration.AfterLoad;
begin
  inherited;
end;

procedure TConfiguration.BeforeSave;
begin
  inherited;
end;

constructor TConfiguration.Create(const AConfigurationFileName: string);
begin
  inherited;
end;

procedure TConfiguration.Finalize;
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

function TConfiguration.GetSignals: ISignalList;
begin
  if not Assigned(FSignals) then
  begin
    FSignals := GetISignalList;
  end;
  Result := FSignals;
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

procedure TConfiguration.SetModifierOff(const AValue: Integer);
begin
  Routines.SetField(AValue, FModifierOff);
end;

procedure TConfiguration.SetModifierOn(const AValue: Integer);
begin
  Routines.SetField(AValue, FModifierOn);
end;

procedure TConfiguration.SetShowBaloonHints(const AValue: Boolean);
begin
  Routines.SetField(AValue, FShowBaloonHints);
end;

procedure TConfiguration.SetSoundEnabled(const AValue: Boolean);
begin
  Routines.SetField(AValue, FSoundEnabled);
end;

procedure TConfiguration.SetVirtualKeyOff(const AValue: Cardinal);
begin
  Routines.SetField(AValue, FVirtualKeyOff);
end;

procedure TConfiguration.SetVirtualKeyOn(const AValue: Cardinal);
begin
  Routines.SetField(AValue, FVirtualKeyOn);
end;

procedure TConfiguration.Initialize;
begin
  inherited;
  ShowBaloonHints := DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS;
  SoundEnabled := DEFAULT_CONFIGURATION_SOUND_ENABLED;
  ModifierOn := DEFAULT_CONFIGURATION_MODIFIER_ON;
  ModifierOff := DEFAULT_CONFIGURATION_MODIFIER_OFF;
  VirtualKeyOn := DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON;
  VirtualKeyOff := DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF;
  Signals.Clear;
end;

procedure TConfiguration.Loading;
var
  i: Integer;
  signal: ISignal;
  s: string;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
    begin
      ShowBaloonHints := ReadBool(RsHints, RsInTray, DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS);
      SoundEnabled := ReadBool(RsSounds, RsEnabled, DEFAULT_CONFIGURATION_SOUND_ENABLED);
      ModifierOn := ReadInteger(RsHotKeys, RsModifierOn, DEFAULT_CONFIGURATION_MODIFIER_ON);
      VirtualKeyOn := ReadInteger(RsHotKeys, RsVirtualKeyOn, DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON);
      ModifierOff := ReadInteger(RsHotKeys, RsModifierOff, DEFAULT_CONFIGURATION_MODIFIER_OFF);
      VirtualKeyOff := ReadInteger(RsHotKeys, RsVirtualKeyOff,
        DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF);
      Signals.Clear;
      for i := 0 to ReadInteger(RsSignals, RsQuantity, DEFAULT_SIGNAL_COUNT) - 1 do
      begin
        s := Format(RsSignal, [IntToStr(i)]);
        signal := GetISignal;
        signal.Title := ReadString(s, RsTitle, DEFAULT_SIGNAL_TITLE);
        signal.Period := ReadInteger(s, RsPeriod, DEFAULT_SIGNAL_PERIOD);
        signal.PeriodType := TPeriodTypes(ReadInteger(s, RsPeriodType,
          Integer(DEFAULT_SIGNAL_PERIOD_TYPE)));
        signal.MessageEnabled := ReadBool(s, RsMessageEnabled, DEFAULT_SIGNAL_MESSAGE_ENABLED);
        signal.Message := ReadString(s, RsMessage, DEFAULT_SIGNAL_MESSAGE);
        signal.WaveFileEnabled := ReadBool(s, RsWaveFileEnabled, DEFAULT_SIGNAL_WAVE_FILE_ENABLED);
        signal.WaveFile := ReadString(s, RsWaveFile, DEFAULT_SIGNAL_WAVE_FILE);
        signal.Enabled := ReadBool(s, RsEnabled, DEFAULT_SIGNAL_ENABLED);
        signal.Timer.Enabled := False;
        Signals.Add(signal);
      end;
    end;
  end;
end;

procedure TConfiguration.Saving;
var
  i: Integer;
  j: Integer;
  s: string;
  _signal: ISignal;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
      try
        if ShowBaloonHints <> DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS then
        begin
          WriteBool(RsHints, RsInTray, ShowBaloonHints);
        end;
        if SoundEnabled <> DEFAULT_CONFIGURATION_SOUND_ENABLED then
        begin
          WriteBool(RsSounds, RsEnabled, SoundEnabled);
        end;
        if ModifierOn <> DEFAULT_CONFIGURATION_MODIFIER_ON then
        begin
          WriteInteger(RsHotKeys, RsModifierOn, ModifierOn);
        end;
        if VirtualKeyOn <> DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON then
        begin
          WriteInteger(RsHotKeys, RsVirtualKeyOn, VirtualKeyOn);
        end;
        if ModifierOff <> DEFAULT_CONFIGURATION_MODIFIER_OFF then
        begin
          WriteInteger(RsHotKeys, RsModifierOff, ModifierOff);
        end;
        if VirtualKeyOff <> DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF then
        begin
          WriteInteger(RsHotKeys, RsVirtualKeyOff, VirtualKeyOff);
        end;
        if Assigned(Signals) then
        begin
          if Signals.Count <> DEFAULT_SIGNAL_COUNT then
          begin
            j := 0;
            for i := 0 to Signals.Count - 1 do
            begin
              s := Format(RsSignal, [IntToStr(j)]);
              _signal := Signals.Items[i];
              if Assigned(_signal) then
              begin
                if _signal.Title <> DEFAULT_SIGNAL_TITLE then
                begin
                  WriteString(s, RsTitle, _signal.Title);
                end;
                if _signal.Period <> DEFAULT_SIGNAL_PERIOD then
                begin
                  WriteInteger(s, RsPeriod, _signal.Period);
                end;
                if _signal.PeriodType <> DEFAULT_SIGNAL_PERIOD_TYPE then
                begin
                  WriteInteger(s, RsPeriodType, Integer(_signal.PeriodType));
                end;
                if _signal.MessageEnabled <> DEFAULT_SIGNAL_MESSAGE_ENABLED then
                begin
                  WriteBool(s, RsMessageEnabled, _signal.MessageEnabled);
                end;
                if _signal.Message <> DEFAULT_SIGNAL_MESSAGE then
                begin
                  WriteString(s, RsMessage, _signal.Message);
                end;
                if _signal.WaveFileEnabled <> DEFAULT_SIGNAL_WAVE_FILE_ENABLED then
                begin
                  WriteBool(s, RsWaveFileEnabled, _signal.WaveFileEnabled);
                end;
                if _signal.WaveFile <> DEFAULT_SIGNAL_WAVE_FILE then
                begin
                  WriteString(s, RsWaveFile, _signal.WaveFile);
                end;
                if _signal.Enabled <> DEFAULT_SIGNAL_ENABLED then
                begin
                  WriteBool(s, RsEnabled, _signal.Enabled);
                end;
                Inc(j);
              end;
            end;
            WriteInteger(RsSignals, RsQuantity, j);
          end;
        end;
      except
        on EIniFileException do
        begin
          raise EConfiguration.Create(RsIniFileSaveError);
        end;
      end;
  end;
end;

initialization

begin
  RegisterClass(TConfiguration);
end;

end.
