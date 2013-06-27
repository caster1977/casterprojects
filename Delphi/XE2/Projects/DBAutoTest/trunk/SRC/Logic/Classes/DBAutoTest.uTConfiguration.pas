unit DBAutoTest.uTConfiguration;

interface

uses
  System.IniFiles,
  CastersPackage.uTIniFileDataStorage,
  DBAutoTest.uIConfiguration,
  DBAutoTest.uConsts,
  DBAutoTest.uIRecents,
  DBAutoTest.uIConfigurationProperties;

type
  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Loading; override;
    procedure Saving; override;
    //function GetModified: Boolean; override;
  public
    constructor Create(const AConfigurationFileName: string = ''); override;
    property Modified: Boolean read GetModified nodefault;

  strict private
    FRecents: IRecents;
    function GetRecents: IRecents;
  public
    property Recents: IRecents read GetRecents;

  strict private
    FProperties: IConfigurationProperties;
    function GetProperties: IConfigurationProperties;
  public
    property Properties: IConfigurationProperties read GetProperties;
  end;

function GetIConfiguration(const AConfigurationFileName: string = ''): IConfiguration;

implementation

uses
  CastersPackage.uIModified,
  System.SysUtils,
  DBAutoTest.uEConfiguration,
  DBAutoTest.uTConfigurationProperties,
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent,
  DBAutoTest.uTRecent;

resourcestring
  RsInterface = 'Интерфейс';
  RsRecents = 'Ранее открытые профили';
  RsRecentProfile = 'Профиль %s';
  RsOther = 'Прочие';
  RsReports = 'Отчёты';
  RsQuantity = 'Количество';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

  RsEnableQuitConfirmation = 'EnableQuitConfirmation';
  RsEnableSplashAtStart = 'EnableSplashAtStart';
  RsEnableStatusbar = 'EnableStatusbar';
  RsEnableToolbar = 'EnableToolbar';
  RsEnablePlaySoundOnComplete = 'EnablePlaySoundOnComplete';
  RsEnableStoreMainFormSizesAndPosition = 'EnableStoreMainFormSizesAndPosition';
  RsEnableGenerateFastReportDocument = 'EnableGenerateFastReportDocument';
  RsEnableGenerateExcelDocument = 'EnableGenerateExcelDocument';

function GetIConfiguration(const AConfigurationFileName: string): IConfiguration;
begin
  Result := TConfiguration.Create(AConfigurationFileName);
end;

{function TConfiguration.GetModified: Boolean;
begin
  Result := (inherited Modified) and (Properties as IModified).Modified;
end;}

function TConfiguration.GetProperties: IConfigurationProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties := GetIConfigurationProperties;
  end;
  Result := FProperties;
end;

function TConfiguration.GetRecents: IRecents;
begin
  if not Assigned(FRecents) then
  begin
    FRecents := GetIRecents;
  end;
  Result := FRecents;
end;

constructor TConfiguration.Create(const AConfigurationFileName: string);
begin
  inherited;
end;

procedure TConfiguration.Initialize;
begin
  inherited;
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
      Properties.EnableQuitConfirmation := ReadBool(RsInterface, RsEnableQuitConfirmation, CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION);
      Properties.EnableSplashAtStart := ReadBool(RsInterface, RsEnableSplashAtStart, CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START);
      Properties.EnableStatusbar := ReadBool(RsInterface, RsEnableStatusbar, CONFIGURATION_DEFAULT_ENABLE_STATUSBAR);
      Properties.EnableToolbar := ReadBool(RsInterface, RsEnableToolbar, CONFIGURATION_DEFAULT_ENABLE_TOOLBAR);
      Properties.EnablePlaySoundOnComplete := ReadBool(RsOther, RsEnablePlaySoundOnComplete, CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE);
      Properties.EnableStoreMainFormSizesAndPosition := ReadBool(RsInterface, RsEnableStoreMainFormSizesAndPosition, CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION);
      Properties.EnableGenerateFastReportDocument := ReadBool(RsReports, RsEnableGenerateFastReportDocument, CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT);
      Properties.EnableGenerateExcelDocument := ReadBool(RsReports, RsEnableGenerateExcelDocument, CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT);

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
        if Properties.EnableQuitConfirmation <> CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION then
        begin
          WriteBool(RsInterface, RsEnableQuitConfirmation, Properties.EnableQuitConfirmation);
        end;
        if Properties.EnableSplashAtStart <> CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START then
        begin
          WriteBool(RsInterface, RsEnableSplashAtStart, Properties.EnableSplashAtStart);
        end;
        if Properties.EnableStatusbar <> CONFIGURATION_DEFAULT_ENABLE_STATUSBAR then
        begin
          WriteBool(RsInterface, RsEnableStatusbar, Properties.EnableStatusbar);
        end;
        if Properties.EnableToolbar <> CONFIGURATION_DEFAULT_ENABLE_TOOLBAR then
        begin
          WriteBool(RsInterface, RsEnableToolbar, Properties.EnableToolbar);
        end;
        if Properties.EnableStoreMainFormSizesAndPosition <> CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION then
        begin
          WriteBool(RsInterface, RsEnableStoreMainFormSizesAndPosition, Properties.EnableStoreMainFormSizesAndPosition);
        end;
        if Properties.EnableGenerateFastReportDocument <> CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT then
        begin
          WriteBool(RsReports, RsEnableGenerateFastReportDocument, Properties.EnableGenerateFastReportDocument);
        end;
        if Properties.EnableGenerateExcelDocument <> CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT then
        begin
          WriteBool(RsReports, RsEnableGenerateExcelDocument, Properties.EnableGenerateExcelDocument);
        end;
        if Properties.EnablePlaySoundOnComplete <> CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE then
        begin
          WriteBool(RsOther, RsEnablePlaySoundOnComplete, Properties.EnablePlaySoundOnComplete);
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

end.
