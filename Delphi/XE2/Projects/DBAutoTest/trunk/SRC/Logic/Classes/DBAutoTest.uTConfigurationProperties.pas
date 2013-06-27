unit DBAutoTest.uTConfigurationProperties;

interface

uses
  DBAutoTest.uConsts,
  CastersPackage.uTCustomProperties,
  DBAutoTest.uIConfigurationProperties;

type
  TConfigurationProperties = class(TCustomProperties, IConfigurationProperties)
  strict protected
    procedure Initialize; override;
  public
    property Modified: Boolean read GetModified nodefault;

  strict private
    FEnablePlaySoundOnComplete: Boolean;
    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
  public
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;

  strict private
    FEnableQuitConfirmation: Boolean;
    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
  public
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;

  strict private
    FEnableSplashAtStart: Boolean;
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
  public
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;

  strict private
    FEnableStatusbar: Boolean;
    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
  public
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;

  strict private
    FEnableToolbar: Boolean;
    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
  public
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;

  strict private
    FEnableStoreMainFormSizesAndPosition: Boolean;
    function GetEnableStoreMainFormSizesAndPosition: Boolean;
    procedure SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
  public
    property EnableStoreMainFormSizesAndPosition: Boolean read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition default CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;

  strict private
    FEnableGenerateFastReportDocument: Boolean;
    function GetEnableGenerateFastReportDocument: Boolean;
    procedure SetEnableGenerateFastReportDocument(const AValue: Boolean);
  public
    property EnableGenerateFastReportDocument: Boolean read GetEnableGenerateFastReportDocument write SetEnableGenerateFastReportDocument default CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT;

  strict private
    FEnableGenerateExcelDocument: Boolean;
    function GetEnableGenerateExcelDocument: Boolean;
    procedure SetEnableGenerateExcelDocument(const AValue: Boolean);
  public
    property EnableGenerateExcelDocument: Boolean read GetEnableGenerateExcelDocument write SetEnableGenerateExcelDocument default CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT;
  end;

function GetIConfigurationProperties: IConfigurationProperties;

implementation

function GetIConfigurationProperties: IConfigurationProperties;
begin
  Result := TConfigurationProperties.Create;
end;

function TConfigurationProperties.GetEnableGenerateExcelDocument: Boolean;
begin
  Result := FEnableGenerateExcelDocument;
end;

function TConfigurationProperties.GetEnableGenerateFastReportDocument: Boolean;
begin
  Result := FEnableGenerateFastReportDocument;
end;

function TConfigurationProperties.GetEnablePlaySoundOnComplete: Boolean;
begin
  Result := FEnablePlaySoundOnComplete;
end;

procedure TConfigurationProperties.SetEnableGenerateExcelDocument(const AValue: Boolean);
begin
  if FEnableGenerateExcelDocument <> AValue then
  begin
    FEnableGenerateExcelDocument := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfigurationProperties.SetEnableGenerateFastReportDocument(
  const AValue: Boolean);
begin
  if FEnableGenerateFastReportDocument <> AValue then
  begin
    FEnableGenerateFastReportDocument := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfigurationProperties.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  if FEnablePlaySoundOnComplete <> AValue then
  begin
    FEnablePlaySoundOnComplete := AValue;
    inherited Modified := True;
  end;
end;

function TConfigurationProperties.GetEnableQuitConfirmation: Boolean;
begin
  Result := FEnableQuitConfirmation;
end;

procedure TConfigurationProperties.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  if FEnableQuitConfirmation <> AValue then
  begin
    FEnableQuitConfirmation := AValue;
    inherited Modified := True;
  end;
end;

function TConfigurationProperties.GetEnableSplashAtStart: Boolean;
begin
  Result := FEnableSplashAtStart;
end;

procedure TConfigurationProperties.SetEnableSplashAtStart(const AValue: Boolean);
begin
  if FEnableSplashAtStart <> AValue then
  begin
    FEnableSplashAtStart := AValue;
    inherited Modified := True;
  end;
end;

function TConfigurationProperties.GetEnableStatusbar: Boolean;
begin
  Result := FEnableStatusbar;
end;

procedure TConfigurationProperties.SetEnableStatusbar(const AValue: Boolean);
begin
  if FEnableStatusbar <> AValue then
  begin
    FEnableStatusbar := AValue;
    inherited Modified := True;
  end;
end;

function TConfigurationProperties.GetEnableStoreMainFormSizesAndPosition: Boolean;
begin
  Result := FEnableStoreMainFormSizesAndPosition;
end;

procedure TConfigurationProperties.SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
begin
  if FEnableStoreMainFormSizesAndPosition <> AValue then
  begin
    FEnableStoreMainFormSizesAndPosition := AValue;
    inherited Modified := True;
  end;
end;

function TConfigurationProperties.GetEnableToolbar: Boolean;
begin
  Result := FEnableToolbar;
end;

procedure TConfigurationProperties.SetEnableToolbar(const AValue: Boolean);
begin
  if FEnableToolbar <> AValue then
  begin
    FEnableToolbar := AValue;
    inherited Modified := True;
  end;
end;

procedure TConfigurationProperties.Initialize;
begin
  EnablePlaySoundOnComplete := CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
  EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
  EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
  EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
  EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
  EnableStoreMainFormSizesAndPosition := CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;
  EnableGenerateFastReportDocument := CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT;
  EnableGenerateExcelDocument := CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT;
  inherited;
end;

end.
