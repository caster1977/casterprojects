unit Beeper.uTConfiguration;

interface

uses
  Winapi.Windows,
  System.IniFiles,
  CastersPackage.uTIniFileDataStorage,
  Beeper.uConsts;

type
  TConfiguration = class(TIniFileDataStorage)
  strict private
    FShowBaloonHints: Boolean;
    FSoundEnabled: Boolean;
    FModifierOn, FModifierOff: Integer;
    FVirtualKeyOn, FVirtualKeyOff: Cardinal;
    FSignalCount: Integer;
    function GetShowBaloonHints: Boolean;
    function GetSoundEnabled: Boolean;
    procedure SetShowBaloonHints(const Value: Boolean);
    procedure SetSoundEnabled(const Value: Boolean);
    function GetModifierOff: Integer;
    function GetModifierOn: Integer;
    function GetVirtualKeyOff: Cardinal;
    function GetVirtualKeyOn: Cardinal;
    procedure SetModifierOff(const Value: Integer);
    procedure SetModifierOn(const Value: Integer);
    procedure SetVirtualKeyOff(const Value: Cardinal);
    procedure SetVirtualKeyOn(const Value: Cardinal);
  strict protected
    function GetSignalCount: Integer;
    procedure SetSignalCount(const Value: Integer); protected
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
    property SignalCount: Integer read GetSignalCount write SetSignalCount default DEFAULT_SIGNAL_COUNT;
  end;

var
  Configuration: TConfiguration;

implementation

uses
  Beeper.uResourceStrings;

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
  Result:=FModifierOff;
end;

function TConfiguration.GetModifierOn: Integer;
begin
  Result:=FModifierOn;
end;

function TConfiguration.GetShowBaloonHints: Boolean;
begin
  Result := FShowBaloonHints;
end;

function TConfiguration.GetSignalCount: Integer;
begin
  Result := FSignalCount;
end;

function TConfiguration.GetSoundEnabled: Boolean;
begin
  Result := FSoundEnabled;
end;

function TConfiguration.GetVirtualKeyOff: Cardinal;
begin
  Result:=FVirtualKeyOff;
end;

function TConfiguration.GetVirtualKeyOn: Cardinal;
begin
  Result:=FVirtualKeyOn;
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

procedure TConfiguration.SetSignalCount(const Value: Integer);
begin
  if FSignalCount <> Value then
    FSignalCount := Value;
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
  FSignalCount := DEFAULT_SIGNAL_COUNT;
end;

procedure TConfiguration.Loading(const AIniFile: TIniFile);
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
      SignalCount := ReadInteger(RsSignals, RsQuantity, DEFAULT_SIGNAL_COUNT);
    end;
end;

procedure TConfiguration.Saving(const AIniFile: TIniFile);
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
      WriteInteger(RsSignals, RsQuantity, SignalCount);
    except
      on EIniFileException do
        raise EIniFileException.Create(RsIniFileSaveError);
    end;
end;

end.
