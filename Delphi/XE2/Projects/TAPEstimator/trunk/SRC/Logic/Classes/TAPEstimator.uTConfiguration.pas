unit TAPEstimator.uTConfiguration;

interface

uses
  System.IniFiles,
  CastersPackage.uTIniFileDataStorage,
  TAPEstimator.uIConfiguration,
  TAPEstimator.uConsts,
  TAPEstimator.uIRecents;

type
  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict private
    FRecents: IRecents;
    function GetRecents: IRecents;
  strict private
    FEnablePlaySoundOnComplete: Boolean;
    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
  strict private
    FEnableQuitConfirmation: Boolean;
    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
  strict private
    FEnableSplashAtStart: Boolean;
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
  strict private
    FEnableStatusbar: Boolean;
    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
  strict private
    FEnableToolbar: Boolean;
    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
  strict private
    FEnableStoreMainFormSizesAndPosition: Boolean;
    function GetEnableStoreMainFormSizesAndPosition: Boolean;
    procedure SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
  strict protected
    procedure Initialize; override;
    procedure Loading; override;
    procedure Saving; override;
  public
    constructor Create(const AConfigurationFileName: string = ''); override;
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
    property EnableStoreMainFormSizesAndPosition: Boolean read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition default CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;
    property Recents: IRecents read GetRecents;
    property Modified: Boolean read GetModified nodefault;
  end;

function GetIConfiguration(const AConfigurationFileName: string = ''): IConfiguration;

implementation

uses
  System.Classes,
  System.SysUtils,
  TAPEstimator.uEConfiguration,
  TAPEstimator.uTRecents,
  TAPEstimator.uIRecent,
  TAPEstimator.uTRecent;

resourcestring
  RsInterface = 'Интерфейс';
  RsRecents = 'Ранее открытые профили';
  RsRecentProfile = 'Профиль %s';
  RsOther = 'Прочие';
  RsQuantity = 'Количество';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

  RsEnableQuitConfirmation = 'EnableQuitConfirmation';
  RsEnableSplashAtStart = 'EnableSplashAtStart';
  RsEnableStatusbar = 'EnableStatusbar';
  RsEnableToolbar = 'EnableToolbar';
  RsEnablePlaySoundOnComplete = 'EnablePlaySoundOnComplete';
  RsEnableStoreMainFormSizesAndPosition = 'EnableStoreMainFormSizesAndPosition';

function GetIConfiguration(const AConfigurationFileName: string): IConfiguration;
begin
  Result := TConfiguration.Create(AConfigurationFileName);
end;

function TConfiguration.GetRecents: IRecents;
begin
  if not Assigned(FRecents) then
  begin
    FRecents := GetIRecents;
  end;
  Result := FRecents;
end;

function TConfiguration.GetEnablePlaySoundOnComplete: Boolean;
begin
  Result := FEnablePlaySoundOnComplete;
end;

procedure TConfiguration.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  if FEnablePlaySoundOnComplete <> AValue then
  begin
    FEnablePlaySoundOnComplete := AValue;
    inherited Modified := True;
  end;
end;

function TConfiguration.GetEnableQuitConfirmation: Boolean;
begin
  Result := FEnableQuitConfirmation;
end;

procedure TConfiguration.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  if FEnableQuitConfirmation <> AValue then
  begin
    FEnableQuitConfirmation := AValue;
    inherited Modified := True;
  end;
end;

function TConfiguration.GetEnableSplashAtStart: Boolean;
begin
  Result := FEnableSplashAtStart;
end;

procedure TConfiguration.SetEnableSplashAtStart(const AValue: Boolean);
begin
  if FEnableSplashAtStart <> AValue then
  begin
    FEnableSplashAtStart := AValue;
    inherited Modified := True;
  end;
end;

function TConfiguration.GetEnableStatusbar: Boolean;
begin
  Result := FEnableStatusbar;
end;

procedure TConfiguration.SetEnableStatusbar(const AValue: Boolean);
begin
  if FEnableStatusbar <> AValue then
  begin
    FEnableStatusbar := AValue;
    inherited Modified := True;
  end;
end;

function TConfiguration.GetEnableStoreMainFormSizesAndPosition: Boolean;
begin
  Result := FEnableStoreMainFormSizesAndPosition;
end;

procedure TConfiguration.SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
begin
  if FEnableStoreMainFormSizesAndPosition <> AValue then
  begin
    FEnableStoreMainFormSizesAndPosition := AValue;
    inherited Modified := True;
  end;
end;

function TConfiguration.GetEnableToolbar: Boolean;
begin
  Result := FEnableToolbar;
end;

procedure TConfiguration.SetEnableToolbar(const AValue: Boolean);
begin
  if FEnableToolbar <> AValue then
  begin
    FEnableToolbar := AValue;
    inherited Modified := True;
  end;
end;

constructor TConfiguration.Create(const AConfigurationFileName: string);
begin
  inherited;
end;

procedure TConfiguration.Initialize;
begin
  inherited;
  EnablePlaySoundOnComplete := CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
  EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
  EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
  EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
  EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
  EnableStoreMainFormSizesAndPosition := CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;
  Recents.Clear;
end;

procedure TConfiguration.Loading;
var
  i: Integer;
  s: string;
  r: IRecent;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
    begin
      EnableQuitConfirmation := ReadBool(RsInterface, RsEnableQuitConfirmation, CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION);
      EnableSplashAtStart := ReadBool(RsInterface, RsEnableSplashAtStart, CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START);
      EnableStatusbar := ReadBool(RsInterface, RsEnableStatusbar, CONFIGURATION_DEFAULT_ENABLE_STATUSBAR);
      EnableToolbar := ReadBool(RsInterface, RsEnableToolbar, CONFIGURATION_DEFAULT_ENABLE_TOOLBAR);
      EnablePlaySoundOnComplete := ReadBool(RsOther, RsEnablePlaySoundOnComplete, CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE);
      EnableStoreMainFormSizesAndPosition := ReadBool(RsInterface, RsEnableStoreMainFormSizesAndPosition, CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION);

      Recents.Clear;
      for i := 0 to ReadInteger(RsRecents, RsQuantity, RECENTS_DEFAULT_COUNT) - 1 do
      begin
        s := Format(RsRecentProfile, [IntToStr(i)]);
        r := GetIRecent;
        r.FullName := ReadString(RsRecents, s, RECENT_DEFAULT_FULL_NAME);
        if r.FullName <> RECENT_DEFAULT_FULL_NAME then
        begin
          Recents.Add(r);
        end;
      end;
    end;
  end;
end;

procedure TConfiguration.Saving;
var
  i: Integer;
  j: Integer;
  r: IRecent;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
      try
        if EnableQuitConfirmation <> CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION then
        begin
          WriteBool(RsInterface, RsEnableQuitConfirmation, EnableQuitConfirmation);
        end;
        if EnableSplashAtStart <> CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START then
        begin
          WriteBool(RsInterface, RsEnableSplashAtStart, EnableSplashAtStart);
        end;
        if EnableStatusbar <> CONFIGURATION_DEFAULT_ENABLE_STATUSBAR then
        begin
          WriteBool(RsInterface, RsEnableStatusbar, EnableStatusbar);
        end;
        if EnableToolbar <> CONFIGURATION_DEFAULT_ENABLE_TOOLBAR then
        begin
          WriteBool(RsInterface, RsEnableToolbar, EnableToolbar);
        end;
        if EnableStoreMainFormSizesAndPosition <> CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION then
        begin
          WriteBool(RsInterface, RsEnableStoreMainFormSizesAndPosition, EnableStoreMainFormSizesAndPosition);
        end;
        if EnablePlaySoundOnComplete <> CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE then
        begin
          WriteBool(RsOther, RsEnablePlaySoundOnComplete, EnablePlaySoundOnComplete);
        end;

        if Recents.Count <> RECENTS_DEFAULT_COUNT then
        begin
          j := 0;
          for i := 0 to Recents.Count - 1 do
          begin
            r := Recents.Items[i];
            if Assigned(r) then
            begin
              if r.FullName <> RECENT_DEFAULT_FULL_NAME then
              begin
                WriteString(RsRecents, Format(RsRecentProfile, [IntToStr(j)]), r.FullName);
                Inc(j);
              end;
            end;
          end;
          WriteInteger(RsRecents, RsQuantity, j);
        end;
      except
        on EIniFileException do
        begin
          raise EConfiguration.Create(RsConfigurationSaveError);
        end;
      end;
  end;
end;

initialization

begin
  RegisterClass(TConfiguration);
end;

end.
