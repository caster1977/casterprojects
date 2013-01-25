unit DBAutoTest.uTConfiguration;

interface

uses
  DBAutoTest.uIConfiguration,
  CastersPackage.uTIniFileDataStorage,
  DBAutoTest.uConsts,
  System.IniFiles,
  DBAutoTest.uIRecents;

type
  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict private
    FRecents: IRecents;
    FEnablePlaySoundOnComplete: Boolean;
    FEnableQuitConfirmation: Boolean;
    FEnableSplashAtStart: Boolean;
    FEnableStatusbar: Boolean;
    FEnableToolbar: Boolean;
    function GetRecents: IRecents;
    function GetEnablePlaySoundOnComplete: Boolean;
    function GetEnableQuitConfirmation: Boolean;
    function GetEnableSplashAtStart: Boolean;
    function GetEnableStatusbar: Boolean;
    function GetEnableToolbar: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    procedure SetEnableStatusbar(const AValue: Boolean);
    procedure SetEnableToolbar(const AValue: Boolean);
  protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading; override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving; override;
  public
    constructor Create(const AConfigurationFileName: string = ''); override;
    property Modified: Boolean read GetModified nodefault;
    property Recents: IRecents read GetRecents;
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete
      write SetEnablePlaySoundOnComplete
      default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation
      write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart
      default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar
      default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar
      default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
  end;

function GetIConfiguration(const AConfigurationFileName: string = ''): IConfiguration;

implementation

uses
  System.Classes,
  System.SysUtils,
  DBAutoTest.uEConfiguration,
  DBAutoTest.uTRecents;

resourcestring
  RsInterface = 'Интерфейс';
  RsOther = 'Прочие';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл!';

  RsEnableQuitConfirmation = 'EnableQuitConfirmation';
  RsEnableSplashAtStart = 'EnableSplashAtStart';
  RsEnableStatusbar = 'EnableStatusbar';
  RsEnableToolbar = 'EnableToolbar';
  RsEnablePlaySoundOnComplete = 'EnablePlaySoundOnComplete';

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

function TConfiguration.GetEnablePlaySoundOnComplete: Boolean;
begin
  Result := FEnablePlaySoundOnComplete;
end;

function TConfiguration.GetEnableQuitConfirmation: Boolean;
begin
  Result := FEnableQuitConfirmation;
end;

function TConfiguration.GetEnableSplashAtStart: Boolean;
begin
  Result := FEnableSplashAtStart;
end;

function TConfiguration.GetEnableStatusbar: Boolean;
begin
  Result := FEnableStatusbar;
end;

function TConfiguration.GetEnableToolbar: Boolean;
begin
  Result := FEnableToolbar;
end;

function TConfiguration.GetRecents: IRecents;
begin
  if not Assigned(FRecents) then
  begin
    FRecents := GetIRecents;
  end;
  Result := FRecents;
end;

procedure TConfiguration.Initialize;
begin
  inherited;
  FRecents := GetIRecents;
  EnablePlaySoundOnComplete := CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
  EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
  EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
  EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
  EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
end;

procedure TConfiguration.Finalize;
begin
  inherited;
end;

procedure TConfiguration.Loading;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
    begin
      EnableQuitConfirmation := ReadBool(RsInterface, RsEnableQuitConfirmation,
        CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION);
      EnableSplashAtStart := ReadBool(RsInterface, RsEnableSplashAtStart,
        CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START);
      EnableStatusbar := ReadBool(RsInterface, RsEnableStatusbar,
        CONFIGURATION_DEFAULT_ENABLE_STATUSBAR);
      EnableToolbar := ReadBool(RsInterface, RsEnableToolbar, CONFIGURATION_DEFAULT_ENABLE_TOOLBAR);
      EnablePlaySoundOnComplete := ReadBool(RsOther, RsEnablePlaySoundOnComplete,
        CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE);
    end;
  end;
end;

procedure TConfiguration.Saving;
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
        if EnablePlaySoundOnComplete <> CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE then
        begin
          WriteBool(RsOther, RsEnablePlaySoundOnComplete, EnablePlaySoundOnComplete);
        end;
      except
        on EIniFileException do
        begin
          raise EConfiguration.Create(RsConfigurationSaveError);
        end;
      end;
  end;
end;

procedure TConfiguration.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  if FEnablePlaySoundOnComplete <> AValue then
  begin
    FEnablePlaySoundOnComplete := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfiguration.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  if FEnableQuitConfirmation <> AValue then
  begin
    FEnableQuitConfirmation := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfiguration.SetEnableSplashAtStart(const AValue: Boolean);
begin
  if FEnableSplashAtStart <> AValue then
  begin
    FEnableSplashAtStart := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfiguration.SetEnableStatusbar(const AValue: Boolean);
begin
  if FEnableStatusbar <> AValue then
  begin
    FEnableStatusbar := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfiguration.SetEnableToolbar(const AValue: Boolean);
begin
  if FEnableToolbar <> AValue then
  begin
    FEnableToolbar := AValue;
    inherited Modified := True;
  end;
end;

initialization

begin
  RegisterClass(TConfiguration);
end;

end.
