unit Beeper.uTConfiguration;

interface

uses
  System.SysUtils,
  Beeper.uIConfiguration,
  Winapi.Windows,
  System.IniFiles,
  CastersPackage.uTIniFileDataStorage,
  CastersPackage.uIIniFileDataStorage,
  Beeper.uConsts,
  Beeper.uISignalList;

type
  EConfiguration = class(Exception);

  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict private
    FShowBaloonHints: Boolean;
    FSoundEnabled: Boolean;
    FModifierOn, FModifierOff: Integer;
    FVirtualKeyOn, FVirtualKeyOff: Cardinal;
    FSignalList: ISignalList;
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
    function GetSignalList: ISignalList;
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading(const AIniFile: TCustomIniFile); override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving(const AIniFile: TCustomIniFile); override;
  public
    property ShowBaloonHints: Boolean read GetShowBaloonHints write SetShowBaloonHints
      default DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS;
    property SoundEnabled: Boolean read GetSoundEnabled write SetSoundEnabled default DEFAULT_CONFIGURATION_SOUND_ENABLED;
    property ModifierOn: Integer read GetModifierOn write SetModifierOn default DEFAULT_CONFIGURATION_MODIFIER_ON;
    property VirtualKeyOn: Cardinal read GetVirtualKeyOn write SetVirtualKeyOn default DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON;
    property ModifierOff: Integer read GetModifierOff write SetModifierOff default DEFAULT_CONFIGURATION_MODIFIER_OFF;
    property VirtualKeyOff: Cardinal read GetVirtualKeyOff write SetVirtualKeyOff
      default DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF;
    property SignalList: ISignalList read GetSignalList nodefault;
  end;

function GetIConfiguration(const AIniFileName: string = ''): IConfiguration;

implementation

uses
  System.Classes,
  Beeper.uTSignalList,
  Beeper.uResourceStrings,
  Beeper.uISignal,
  Beeper.uTSignal,
  Beeper.uTPeriodType,
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
  RsIniFileSaveError = 'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

function GetIConfiguration(const AIniFileName: string): IConfiguration;
begin
  Result := TConfiguration.Create(AIniFileName);
end;

procedure TConfiguration.AfterLoad;
begin
  inherited;
end;

procedure TConfiguration.BeforeSave;
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

function TConfiguration.GetSignalList: ISignalList;
begin
  if not Assigned(FSignalList) then
  begin
    FSignalList := GetISignalList;
  end;
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
end;

procedure TConfiguration.Loading(const AIniFile: TCustomIniFile);
var
  i: Integer;
  signal_count: Integer;
  signal: ISignal;
  s: string;
begin
  inherited;
  with AIniFile do
  begin
    ShowBaloonHints := ReadBool(RsHints, RsInTray, DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS);
    SoundEnabled := ReadBool(RsSounds, RsEnabled, DEFAULT_CONFIGURATION_SOUND_ENABLED);
    ModifierOn := ReadInteger(RsHotKeys, RsModifierOn, DEFAULT_CONFIGURATION_MODIFIER_ON);
    VirtualKeyOn := ReadInteger(RsHotKeys, RsVirtualKeyOn, DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON);
    ModifierOff := ReadInteger(RsHotKeys, RsModifierOff, DEFAULT_CONFIGURATION_MODIFIER_OFF);
    VirtualKeyOff := ReadInteger(RsHotKeys, RsVirtualKeyOff, DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF);
    signal_count := ReadInteger(RsSignals, RsQuantity, DEFAULT_SIGNAL_COUNT);
    SignalList.Clear;
    for i := 0 to signal_count - 1 do
    begin
      s := Format(RsSignal, [IntToStr(i)]);
      signal := GetISignal;
      signal.Title := ReadString(s, RsTitle, DEFAULT_SIGNAL_TITLE);
      signal.Period := ReadInteger(s, RsPeriod, DEFAULT_SIGNAL_PERIOD);
      signal.PeriodType := TPeriodType(ReadInteger(s, RsPeriodType, Integer(DEFAULT_SIGNAL_PERIOD_TYPE)));
      signal.MessageEnabled := ReadBool(s, RsMessageEnabled, DEFAULT_SIGNAL_MESSAGE_ENABLED);
      signal.Message := ReadString(s, RsMessage, DEFAULT_SIGNAL_MESSAGE);
      signal.WaveFileEnabled := ReadBool(s, RsWaveFileEnabled, DEFAULT_SIGNAL_WAVE_FILE_ENABLED);
      signal.WaveFile := ReadString(s, RsWaveFile, DEFAULT_SIGNAL_WAVE_FILE);
      signal.Enabled := ReadBool(s, RsEnabled, DEFAULT_SIGNAL_ENABLED);
      signal.Timer.Enabled := False;
      SignalList.Add(signal);
    end;
  end;
end;

procedure TConfiguration.Saving(const AIniFile: TCustomIniFile);
var
  i: Integer;
  s: string;
  _signal: ISignal;
begin
  inherited;
  if Assigned(AIniFile) then
  begin
    try
      if ShowBaloonHints <> DEFAULT_CONFIGURATION_SHOW_BALOON_HINTS then
      begin
        AIniFile.WriteBool(RsHints, RsInTray, ShowBaloonHints);
      end;
      if SoundEnabled <> DEFAULT_CONFIGURATION_SOUND_ENABLED then
      begin
        AIniFile.WriteBool(RsSounds, RsEnabled, SoundEnabled);
      end;
      if ModifierOn <> DEFAULT_CONFIGURATION_MODIFIER_ON then
      begin
        AIniFile.WriteInteger(RsHotKeys, RsModifierOn, ModifierOn);
      end;
      if VirtualKeyOn <> DEFAULT_CONFIGURATION_VIRTUAL_KEY_ON then
      begin
        AIniFile.WriteInteger(RsHotKeys, RsVirtualKeyOn, VirtualKeyOn);
      end;
      if ModifierOff <> DEFAULT_CONFIGURATION_MODIFIER_OFF then
      begin
        AIniFile.WriteInteger(RsHotKeys, RsModifierOff, ModifierOff);
      end;
      if VirtualKeyOff <> DEFAULT_CONFIGURATION_VIRTUAL_KEY_OFF then
      begin
        AIniFile.WriteInteger(RsHotKeys, RsVirtualKeyOff, VirtualKeyOff);
      end;
      if Assigned(SignalList) then
      begin
        if SignalList.Count <> DEFAULT_SIGNAL_COUNT then
        begin
          AIniFile.WriteInteger(RsSignals, RsQuantity, SignalList.Count);
          for i := 0 to SignalList.Count - 1 do
          begin
            s := Format(RsSignal, [IntToStr(i)]);
            _signal := SignalList.Items[i];
            if Assigned(_signal) then
            begin
              if _signal.Title <> DEFAULT_SIGNAL_TITLE then
              begin
                AIniFile.WriteString(s, RsTitle, _signal.Title);
              end;
              if _signal.Period <> DEFAULT_SIGNAL_PERIOD then
              begin
                AIniFile.WriteInteger(s, RsPeriod, _signal.Period);
              end;
              if _signal.PeriodType <> DEFAULT_SIGNAL_PERIOD_TYPE then
              begin
                AIniFile.WriteInteger(s, RsPeriodType, Integer(_signal.PeriodType));
              end;
              if _signal.MessageEnabled <> DEFAULT_SIGNAL_MESSAGE_ENABLED then
              begin
                AIniFile.WriteBool(s, RsMessageEnabled, _signal.MessageEnabled);
              end;
              if _signal.Message <> DEFAULT_SIGNAL_MESSAGE then
              begin
                AIniFile.WriteString(s, RsMessage, _signal.Message);
              end;
              if _signal.WaveFileEnabled <> DEFAULT_SIGNAL_WAVE_FILE_ENABLED then
              begin
                AIniFile.WriteBool(s, RsWaveFileEnabled, _signal.WaveFileEnabled);
              end;
              if _signal.WaveFile <> DEFAULT_SIGNAL_WAVE_FILE then
              begin
                AIniFile.WriteString(s, RsWaveFile, _signal.WaveFile);
              end;
              if _signal.Enabled <> DEFAULT_SIGNAL_ENABLED then
              begin
                AIniFile.WriteBool(s, RsEnabled, _signal.Enabled);
              end;
            end;
          end;
        end;
      end;
    except
      on EIniFileException do
      begin
        raise EIniFileException.Create(RsIniFileSaveError);
      end;
    end;
  end;
end;

initialization

begin
  RegisterClass(TConfiguration);
end;

end.
