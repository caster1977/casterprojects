unit OA5.uTConfiguration;

interface

uses
  System.Types,
  System.SysUtils,
  System.IniFiles,
  CastersPackage.uLogKeeperData,
  CastersPackage.uMysql,
  CastersPackage.uTIniFileDataStorage,
  OA5.uIConfiguration,
  OA5.uTMySQLConnection,
  CastersPackage.uTDialogPosition,
  OA5.uDefaultConsts,
  CastersPackage.uTReportFolder,
  CastersPackage.uTLogMessagesType,
  CastersPackage.uTLogMessagesTypes;

type
  EConfiguration = class(Exception);

  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading(const AIniFile: TCustomIniFile); override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Saving(const AIniFile: TCustomIniFile); override;
  strict private
    // вкладка "настройки интерфейса"
    FEnableSplashAtStart: Boolean;
    FEnableToolbar: Boolean;
    FEnableStatusbar: Boolean;
    FEnableEditboxHints: Boolean;
    FEnableCommonSearchEditbox: Boolean;
    FEnableID: Boolean;
    FEnableMultibuffer: Boolean;
    FEnableQuitConfirmation: Boolean;
    // вкладка "настройки ведения протокола работы"
    FEnableLog: Boolean;
    FKeepLogTypes: TLogMessagesTypes;
    FEnableFlushLogOnExit: Boolean;
    FEnableFlushLogOnStringsQuantity: Boolean;
    FEnableFlushLogOnStringsQuantityValue: Integer;
    FEnableFlushLogOnClearingLog: Boolean;
    FEnableFlushLogOnApply: Boolean;
    FEnableCustomLogClient: Boolean;
    FCustomLogClientValue: string;
    // вкладка "настройки процедуры логирования"
    FEnableStoreLogin: Boolean;
    FEnableStorePassword: Boolean;
    FEnableAutoLogon: Boolean;
    FStoredLogin: string;
    FStoredPassword: string;
    // вкладка "настройки формирования отчётов"
    FReportFolder: TReportFolder;
    FCustomReportFolderValue: string;
    FEnableOverwriteConfirmation: Boolean;
    FEnableAskForFileName: Boolean;
    // вкладка "настройки прочие"
    FEnableLaunchAtStartup: Boolean;
    FEnablePlaySoundOnComplete: Boolean;
    FEnableAutoGetMessages: Boolean;
    FAutoGetMessagesCycleDurationValue: Integer;
    FEnableCustomHelpFile: Boolean;
    FCustomHelpFileValue: string;
    // вкладка "настройки главного окна"
    FMainFormLeft: Integer;
    FMainFormTop: Integer;
    FMainFormWidth: Integer;
    FMainFormHeight: Integer;
    FMainFormEnableCentered: Boolean;
    FMainFormEnableFullScreenAtLaunch: Boolean;
    // вкладка "настройки отображения информации"
    FOrganizationPanelHeightValue: Integer; // Высота панели организаций
    FOrganizationPanelEnableHalfHeight: Boolean; // половина высоты окна
    FDataPanelWidthValue: Integer; // Ширина панели данных
    FDataPanelEnableHalfWidth: Boolean; // половина ширины окна
    FEnableDataInOtherInfoPanel: Boolean; // В режиме просмотра показывать данные в окне прочей информации
    FEnableMeasuresListAsRichEdit: Boolean; // В режиме просмотра объединять меропрятия в общий спиcок
    FEnableMarkSearchedStrings: Boolean; // В режиме просмотра выделять искомые фрагменты строк
    FEnablePutTownAtTheEnd: Boolean; // Поместить название города в конец строки адреса
    // вкладка "настройки положения диалоговых окон"
    FLoginFormPosition: TDialogPosition;
    FConfigurationFormPosition: TDialogPosition;
    FUsersFormPosition: TDialogPosition;
    FSetPasswordFormPosition: TDialogPosition;
    FReportFormPosition: TDialogPosition;
    FMaintenanceFormPosition: TDialogPosition;
    FClearingFormPosition: TDialogPosition;
    FViewMessagesFormPosition: TDialogPosition;
    FCreateMessageFormPosition: TDialogPosition;
    FViewMessageFormPosition: TDialogPosition;
    FPhonesFormPosition: TDialogPosition;
    FAddEditPhoneFormPosition: TDialogPosition;
    FAddMassMsrFormPosition: TDialogPosition;
    FPermissionsFormPosition: TDialogPosition;
    FMultibufferFormPosition: TDialogPosition;
    // вкладка "настройки подключения к серверу базы данных услуги"
    FDBServer: TMySQLConnection;
    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    FMessageServer: TMySQLConnection;
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    function GetEnableCommonSearchEditbox: Boolean;
    procedure SetEnableCommonSearchEditbox(const AValue: Boolean);
    function GetEnableEditboxHints: Boolean;
    procedure SetEnableEditboxHints(const AValue: Boolean);
    function GetEnableID: Boolean;
    procedure SetEnableID(const AValue: Boolean);
    function GetEnableMultibuffer: Boolean;
    procedure SetEnableMultibuffer(const AValue: Boolean);
    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    function GetCustomLogClientValue: string;
    procedure SetCustomLogClientValue(const AValue: string);
    function GetEnableCustomLogClient: Boolean;
    procedure SetEnableCustomLogClient(const AValue: Boolean);
    function GetEnableFlushLogOnApply: Boolean;
    procedure SetEnableFlushLogOnApply(const AValue: Boolean);
    function GetEnableFlushLogOnClearingLog: Boolean;
    procedure SetEnableFlushLogOnClearingLog(const AValue: Boolean);
    function GetEnableFlushLogOnExit: Boolean;
    procedure SetEnableFlushLogOnExit(const AValue: Boolean);
    function GetEnableFlushLogOnStringsQuantity: Boolean;
    procedure SetEnableFlushLogOnStringsQuantity(const AValue: Boolean);
    function GetEnableFlushLogOnStringsQuantityValue: Integer;
    procedure SetEnableFlushLogOnStringsQuantityValue(const AValue: Integer);
    function GetEnableLog: Boolean;
    procedure SetEnableLog(const AValue: Boolean);
    function GetKeepLogTypes: TLogMessagesTypes;
    procedure SetKeepLogTypes(const AValue: TLogMessagesTypes);
    function GetEnableAutoLogon: Boolean;
    procedure SetEnableStoreLogin(const AValue: Boolean);
    function GetEnableStoreLogin: Boolean;
    procedure SetEnableStorePassword(const AValue: Boolean);
    function GetEnableStorePassword: Boolean;
    procedure SetEnableAutoLogon(const AValue: Boolean);
    function GetStoredLogin: string;
    procedure SetStoredLogin(const AValue: string);
    function GetStoredPassword: string;
    procedure SetStoredPassword(const AValue: string);
    function GetCustomReportFolderValue: string;
    procedure SetCustomReportFolderValue(const AValue: string);
    function GetEnableAskForFileName: Boolean;
    procedure SetEnableAskForFileName(const AValue: Boolean);
    function GetEnableOverwriteConfirmation: Boolean;
    procedure SetEnableOverwriteConfirmation(const AValue: Boolean);
    function GetReportFolderType: TReportFolder;
    procedure SetReportFolderType(const AValue: TReportFolder);
    function GetAutoGetMessagesCycleDurationValue: Integer;
    procedure SetAutoGetMessagesCycleDurationValue(const AValue: Integer);
    function GetCustomHelpFileValue: string;
    procedure SetCustomHelpFileValue(const AValue: string);
    function GetEnableAutoGetMessages: Boolean;
    procedure SetEnableAutoGetMessages(const AValue: Boolean);
    function GetEnableCustomHelpFile: Boolean;
    procedure SetEnableCustomHelpFile(const AValue: Boolean);
    function GetEnableLaunchAtStartup: Boolean;
    procedure SetEnableLaunchAtStartup(const AValue: Boolean);
    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    function GetMainFormEnableFullScreenAtLaunch: Boolean;
    procedure SetMainFormEnableFullScreenAtLaunch(const AValue: Boolean);
    function GetMainFormEnableCentered: Boolean;
    procedure SetMainFormEnableCentered(const AValue: Boolean);
    function GetMainFormHeight: Integer;
    procedure SetMainFormHeight(const AValue: Integer);
    function GetMainFormLeft: Integer;
    procedure SetMainFormLeft(const AValue: Integer);
    function GetMainFormTop: Integer;
    procedure SetMainFormTop(const AValue: Integer);
    function GetMainFormWidth: Integer;
    procedure SetMainFormWidth(const AValue: Integer);
    function GetDataPanelEnableHalfWidth: Boolean;
    procedure SetDataPanelEnableHalfWidth(const AValue: Boolean);
    function GetDataPanelWidthValue: Integer;
    procedure SetDataPanelWidthValue(const AValue: Integer);
    function GetEnableDataInOtherInfoPanel: Boolean;
    procedure SetEnableDataInOtherInfoPanel(const AValue: Boolean);
    function GetEnableMarkSearchedStrings: Boolean;
    procedure SetEnableMarkSearchedStrings(const AValue: Boolean);
    function GetEnableMeasuresListAsRichEdit: Boolean;
    procedure SetEnableMeasuresListAsRichEdit(const AValue: Boolean);
    function GetEnablePutTownAtTheEnd: Boolean;
    procedure SetEnablePutTownAtTheEnd(const AValue: Boolean);
    function GetOrganizationPanelEnableHalfHeight: Boolean;
    procedure SetOrganizationPanelEnableHalfHeight(const AValue: Boolean);
    function GetOrganizationPanelHeightValue: Integer;
    procedure SetOrganizationPanelHeightValue(const AValue: Integer);
    function GetAddEditPhoneFormPosition: TDialogPosition;
    procedure SetAddEditPhoneFormPosition(const AValue: TDialogPosition);
    function GetAddMassMsrFormPosition: TDialogPosition;
    procedure SetAddMassMsrFormPosition(const AValue: TDialogPosition);
    function GetClearingFormPosition: TDialogPosition;
    procedure SetClearingFormPosition(const AValue: TDialogPosition);
    function GetConfigurationFormPosition: TDialogPosition;
    procedure SetConfigurationFormPosition(const AValue: TDialogPosition);
    function GetCreateMessageFormPosition: TDialogPosition;
    procedure SetCreateMessageFormPosition(const AValue: TDialogPosition);
    function GetLoginFormPosition: TDialogPosition;
    procedure SetLoginFormPosition(const AValue: TDialogPosition);
    function GetMaintenanceFormPosition: TDialogPosition;
    procedure SetMaintenanceFormPosition(const AValue: TDialogPosition);
    function GetMultibufferFormPosition: TDialogPosition;
    procedure SetMultibufferFormPosition(const AValue: TDialogPosition);
    function GetPermissionsFormPosition: TDialogPosition;
    procedure SetPermissionsFormPosition(const AValue: TDialogPosition);
    function GetPhonesFormPosition: TDialogPosition;
    procedure SetPhonesFormPosition(const AValue: TDialogPosition);
    function GetReportFormPosition: TDialogPosition;
    procedure SetReportFormPosition(const AValue: TDialogPosition);
    function GetSetPasswordFormPosition: TDialogPosition;
    procedure SetSetPasswordFormPosition(const AValue: TDialogPosition);
    function GetUsersFormPosition: TDialogPosition;
    procedure SetUsersFormPosition(const AValue: TDialogPosition);
    function GetViewMessageFormPosition: TDialogPosition;
    procedure SetViewMessageFormPosition(const AValue: TDialogPosition);
    function GetViewMessagesFormPosition: TDialogPosition;
    procedure SetViewMessagesFormPosition(const AValue: TDialogPosition);
    function GetDBServer: TMySQLConnection;
    procedure SetDBServer(const AValue: TMySQLConnection);
    function GetMessageServer: TMySQLConnection;
    procedure SetMessageServer(const AValue: TMySQLConnection);
  published
    // вкладка "настройки интерфейса"
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart default DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar default DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar default DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
    property EnableEditboxHints: Boolean read GetEnableEditboxHints write SetEnableEditboxHints default DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
    property EnableCommonSearchEditbox: Boolean read GetEnableCommonSearchEditbox write SetEnableCommonSearchEditbox default DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
    property EnableID: Boolean read GetEnableID write SetEnableID default DEFAULT_CONFIGURATION_ENABLE_ID;
    property EnableMultibuffer: Boolean read GetEnableMultibuffer write SetEnableMultibuffer default DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation default DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;
    // вкладка "настройки ведения протокола работы"
    property EnableLog: Boolean read GetEnableLog write SetEnableLog default DEFAULT_CONFIGURATION_ENABLE_LOG;
    property KeepLogTypes: TLogMessagesTypes read GetKeepLogTypes write SetKeepLogTypes default DEFAULT_CONFIGURATION_KEEP_LOG_TYPES;
    property EnableFlushLogOnExit: Boolean read GetEnableFlushLogOnExit write SetEnableFlushLogOnExit default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT;
    property EnableFlushLogOnStringsQuantity: Boolean read GetEnableFlushLogOnStringsQuantity write SetEnableFlushLogOnStringsQuantity
      default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY;
    property EnableFlushLogOnStringsQuantityValue: Integer read GetEnableFlushLogOnStringsQuantityValue write SetEnableFlushLogOnStringsQuantityValue
      default DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE;
    property EnableFlushLogOnClearingLog: Boolean read GetEnableFlushLogOnClearingLog write SetEnableFlushLogOnClearingLog default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG;
    property EnableFlushLogOnApply: Boolean read GetEnableFlushLogOnApply write SetEnableFlushLogOnApply default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY;
    property EnableCustomLogClient: Boolean read GetEnableCustomLogClient write SetEnableCustomLogClient default DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT;
    property CustomLogClientValue: string read GetCustomLogClientValue write SetCustomLogClientValue nodefault;
    // вкладка "настройки процедуры логирования"
    property EnableAutoLogon: Boolean read GetEnableAutoLogon write SetEnableAutoLogon default DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON;
    property EnableStoreLogin: Boolean read GetEnableStoreLogin write SetEnableStoreLogin default DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword default DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
    property Login: string read GetStoredLogin write SetStoredLogin stored False;
    property Password: string read GetStoredPassword write SetStoredPassword stored False;
    // вкладка "настройки формирования отчётов"
    property ReportFolderType: TReportFolder read GetReportFolderType write SetReportFolderType default DEFAULT_CONFIGURATION_REPORT_FOLDER_TYPE;
    property CustomReportFolderValue: string read GetCustomReportFolderValue write SetCustomReportFolderValue nodefault;
    property EnableOverwriteConfirmation: Boolean read GetEnableOverwriteConfirmation write SetEnableOverwriteConfirmation default DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
    property EnableAskForFileName: Boolean read GetEnableAskForFileName write SetEnableAskForFileName default DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;
    // вкладка "настройки прочие"
    property EnableLaunchAtStartup: Boolean read GetEnableLaunchAtStartup write SetEnableLaunchAtStartup default DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete default DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
    property EnableAutoGetMessages: Boolean read GetEnableAutoGetMessages write SetEnableAutoGetMessages default DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES;
    property AutoGetMessagesCycleDurationValue: Integer read GetAutoGetMessagesCycleDurationValue write SetAutoGetMessagesCycleDurationValue
      default DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE;
    property EnableCustomHelpFile: Boolean read GetEnableCustomHelpFile write SetEnableCustomHelpFile default DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
    property CustomHelpFileValue: string read GetCustomHelpFileValue write SetCustomHelpFileValue nodefault;
    // вкладка "настройки главного окна"
    property MainFormLeft: Integer read GetMainFormLeft write SetMainFormLeft default DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
    property MainFormTop: Integer read GetMainFormTop write SetMainFormTop default DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
    property MainFormWidth: Integer read GetMainFormWidth write SetMainFormWidth default DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
    property MainFormHeight: Integer read GetMainFormHeight write SetMainFormHeight default DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
    property MainFormEnableCentered: Boolean read GetMainFormEnableCentered write SetMainFormEnableCentered default DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED;
    property MainFormEnableFullScreenAtLaunch: Boolean read GetMainFormEnableFullScreenAtLaunch write SetMainFormEnableFullScreenAtLaunch
      default DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;
    // вкладка "настройки отображения информации"
    property OrganizationPanelHeightValue: Integer read GetOrganizationPanelHeightValue write SetOrganizationPanelHeightValue default DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE;
    property OrganizationPanelEnableHalfHeight: Boolean read GetOrganizationPanelEnableHalfHeight write SetOrganizationPanelEnableHalfHeight
      default DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
    property DataPanelWidthValue: Integer read GetDataPanelWidthValue write SetDataPanelWidthValue default DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE;
    property DataPanelEnableHalfWidth: Boolean read GetDataPanelEnableHalfWidth write SetDataPanelEnableHalfWidth default DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
    property EnableDataInOtherInfoPanel: Boolean read GetEnableDataInOtherInfoPanel write SetEnableDataInOtherInfoPanel default DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
    property EnableMeasuresListAsRichEdit: Boolean read GetEnableMeasuresListAsRichEdit write SetEnableMeasuresListAsRichEdit default DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
    property EnableMarkSearchedStrings: Boolean read GetEnableMarkSearchedStrings write SetEnableMarkSearchedStrings default DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS;
    property EnablePutTownAtTheEnd: Boolean read GetEnablePutTownAtTheEnd write SetEnablePutTownAtTheEnd default DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;
    // вкладка "настройки положения диалоговых окон"
    property AddEditPhoneFormPosition: TDialogPosition read GetAddEditPhoneFormPosition write SetAddEditPhoneFormPosition nodefault;
    property AddMassMsrFormPosition: TDialogPosition read GetAddMassMsrFormPosition write SetAddMassMsrFormPosition nodefault;
    property ConfigurationFormPosition: TDialogPosition read GetConfigurationFormPosition write SetConfigurationFormPosition nodefault;
    property CreateMessageFormPosition: TDialogPosition read GetCreateMessageFormPosition write SetCreateMessageFormPosition nodefault;
    property LoginFormPosition: TDialogPosition read GetLoginFormPosition write SetLoginFormPosition nodefault;
    property MultibufferFormPosition: TDialogPosition read GetMultibufferFormPosition write SetMultibufferFormPosition nodefault;
    property PermissionsFormPosition: TDialogPosition read GetPermissionsFormPosition write SetPermissionsFormPosition nodefault;
    property ReportFormPosition: TDialogPosition read GetReportFormPosition write SetReportFormPosition nodefault;
    property SetPasswordFormPosition: TDialogPosition read GetSetPasswordFormPosition write SetSetPasswordFormPosition nodefault;
    property ViewMessageFormPosition: TDialogPosition read GetViewMessageFormPosition write SetViewMessageFormPosition nodefault;
    property ViewMessagesFormPosition: TDialogPosition read GetViewMessagesFormPosition write SetViewMessagesFormPosition nodefault;
    property UsersFormPosition: TDialogPosition read GetUsersFormPosition write SetUsersFormPosition nodefault;
    property MaintenanceFormPosition: TDialogPosition read GetMaintenanceFormPosition write SetMaintenanceFormPosition nodefault;
    property ClearingFormPosition: TDialogPosition read GetClearingFormPosition write SetClearingFormPosition nodefault;
    property PhonesFormPosition: TDialogPosition read GetPhonesFormPosition write SetPhonesFormPosition nodefault;
    // вкладка "настройки подключения к серверу базы данных услуги"
    property DBServer: TMySQLConnection read GetDBServer write SetDBServer nodefault;
    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    property MessageServer: TMySQLConnection read GetMessageServer write SetMessageServer nodefault;
    // вкладка "настройки списка автозамены"
  strict private
    FCurrentPage: Integer;
    FOrganizationsSortedByColumn: Integer;
    FMeasuresSortedByColumn: Integer;
    function GetReportFolder: string;
    function GetCurrentPage: Integer;
    procedure SetCurrentPage(const AValue: Integer);
    function GetMeasuresSortedByColumn: Integer;
    procedure SetMeasuresSortedByColumn(const AValue: Integer);
    function GetOrganizationsSortedByColumn: Integer;
    procedure SetOrganizationsSortedByColumn(const AValue: Integer);
  public
    // sDefaultAction: string;
    // bImmediatelyQuit: Boolean;
    property ReportFolder: string read GetReportFolder stored False;
    property CurrentPage: Integer read GetCurrentPage write SetCurrentPage default DEFAULT_CONFIGURATION_CURRENT_PAGE;
    property OrganizationsSortedByColumn: Integer read GetOrganizationsSortedByColumn write SetOrganizationsSortedByColumn default DEFAULT_CONFIGURATION_ORGANIZATIONS_SORTED_BY_COLUMN;
    property MeasuresSortedByColumn: Integer read GetMeasuresSortedByColumn write SetMeasuresSortedByColumn default DEFAULT_CONFIGURATION_MEASURES_SORTED_BY_COLUMN;
  end;

function GetIConfiguration(const AIniFileName: string = ''): IConfiguration;

implementation

uses
  Vcl.Controls,
  System.IOUtils,
  System.Classes,
  Winapi.Windows,
  CastersPackage.uRoutines,
  Vcl.Forms;

resourcestring
  RsInterface = 'Интерфейс';
  RsLogging = 'Протоколирование';
  RsDialogsPosition = 'Положение диалоговых окон';
  RsIdentity = 'Идентификация';
  RsServers = 'Сервера и базы данных';
  RsReports = 'Формирование отчётов';
  RsOther = 'Прочие';
  RsMainForm = 'Главное окно';
  RsInfo = 'Отображение информации';

function GetIConfiguration(const AIniFileName: string): IConfiguration;
begin
  Result := TConfiguration.Create(AIniFileName);
end;

procedure TConfiguration.SetKeepLogTypes(const AValue: TLogMessagesTypes);
begin
  if FKeepLogTypes <> AValue then
    FKeepLogTypes := AValue;
end;

procedure TConfiguration.SetEnableLaunchAtStartup(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableSplashAtStart);
end;

procedure TConfiguration.SetMainFormHeight(const AValue: Integer);
begin
  Routines.SetField(AValue, FMainFormHeight);
end;

procedure TConfiguration.SetMainFormLeft(const AValue: Integer);
begin
  Routines.SetField(AValue, FMainFormLeft);
end;

procedure TConfiguration.SetMainFormEnableCentered(const AValue: Boolean);
begin
  Routines.SetField(AValue, FMainFormEnableCentered);
end;

procedure TConfiguration.SetMainFormTop(const AValue: Integer);
begin
  Routines.SetField(AValue, FMainFormTop);
end;

procedure TConfiguration.SetMainFormWidth(const AValue: Integer);
begin
  Routines.SetField(AValue, FMainFormWidth);
end;

procedure TConfiguration.SetLoginFormPosition(const AValue: TDialogPosition);
begin
  if not FLoginFormPosition.Equals(AValue) then
  begin
    FLoginFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetMaintenanceFormPosition(const AValue: TDialogPosition);
begin
  if not FMaintenanceFormPosition.Equals(AValue) then
  begin
    FMaintenanceFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetEnableMarkSearchedStrings(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableMarkSearchedStrings);
end;

procedure TConfiguration.SetMeasuresSortedByColumn(const AValue: Integer);
begin
  Routines.SetField(AValue, FMeasuresSortedByColumn);
end;

procedure TConfiguration.SetMessageServer(const AValue: TMySQLConnection);
begin
  if FMessageServer <> AValue then
  begin
    FMessageServer := AValue;
  end;
end;

procedure TConfiguration.SetConfigurationFormPosition(const AValue: TDialogPosition);
begin
  if not FConfigurationFormPosition.Equals(AValue) then
  begin
    FConfigurationFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetOrganizationPanelEnableHalfHeight(const AValue: Boolean);
begin
  Routines.SetField(AValue, FOrganizationPanelEnableHalfHeight);
end;

procedure TConfiguration.SetOrganizationPanelHeightValue(const AValue: Integer);
begin
  Routines.SetField(AValue, FOrganizationPanelHeightValue);
end;

procedure TConfiguration.SetOrganizationsSortedByColumn(const AValue: Integer);
begin
  Routines.SetField(AValue, FOrganizationsSortedByColumn);
end;

procedure TConfiguration.SetPhonesFormPosition(const AValue: TDialogPosition);
begin
  if not FPhonesFormPosition.Equals(AValue) then
  begin
    FPhonesFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnablePlaySoundOnComplete);
end;

procedure TConfiguration.SetEnablePutTownAtTheEnd(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnablePutTownAtTheEnd);
end;

procedure TConfiguration.SetReportFolderType(const AValue: TReportFolder);
begin
  if FReportFolder <> AValue then
  begin
    FReportFolder := AValue;
  end;
end;

procedure TConfiguration.SetDBServer(const AValue: TMySQLConnection);
begin
  if FDBServer <> AValue then
  begin
    FDBServer := AValue;
  end;
end;

procedure TConfiguration.SetEnableLog(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableLog);
end;

procedure TConfiguration.SetCustomReportFolderValue(const AValue: string);
begin
  Routines.SetField(AValue, FCustomReportFolderValue);
end;

procedure TConfiguration.SetSetPasswordFormPosition(const AValue: TDialogPosition);
begin
  if not FSetPasswordFormPosition.Equals(AValue) then
  begin
    FSetPasswordFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetEnableSplashAtStart(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableSplashAtStart);
end;

procedure TConfiguration.SetEnableCommonSearchEditbox(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableCommonSearchEditbox);
end;

procedure TConfiguration.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableQuitConfirmation);
end;

procedure TConfiguration.SetEnableDataInOtherInfoPanel(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableDataInOtherInfoPanel);
end;

procedure TConfiguration.SetEnableEditboxHints(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableEditboxHints);
end;

procedure TConfiguration.SetEnableID(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableID);
end;

procedure TConfiguration.SetEnableMeasuresListAsRichEdit(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableMeasuresListAsRichEdit);
end;

procedure TConfiguration.SetEnableStatusbar(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableStatusbar);
end;

procedure TConfiguration.SetEnableToolbar(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableToolbar);
end;

procedure TConfiguration.SetReportFormPosition(const AValue: TDialogPosition);
begin
  if not FReportFormPosition.Equals(AValue) then
  begin
    FReportFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetEnableMultibuffer(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableMultibuffer);
end;

procedure TConfiguration.SetUsersFormPosition(const AValue: TDialogPosition);
begin
  if not FUsersFormPosition.Equals(AValue) then
  begin
    FUsersFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetViewMessageFormPosition(const AValue: TDialogPosition);
begin
  if not FViewMessageFormPosition.Equals(AValue) then
  begin
    FViewMessageFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetViewMessagesFormPosition(const AValue: TDialogPosition);
begin
  if not FViewMessagesFormPosition.Equals(AValue) then
  begin
    FViewMessagesFormPosition.Assign(AValue);
  end;
end;

function TConfiguration.GetReportFolderType: TReportFolder;
begin
  Result := FReportFolder;
end;

function TConfiguration.GetClearingFormPosition: TDialogPosition;
begin
  Result := FClearingFormPosition;
end;

function TConfiguration.GetConfigurationFormPosition: TDialogPosition;
begin
  Result := FConfigurationFormPosition;
end;

function TConfiguration.GetCreateMessageFormPosition: TDialogPosition;
begin
  Result := FCreateMessageFormPosition;
end;

function TConfiguration.GetReportFormPosition: TDialogPosition;
begin
  Result := FReportFormPosition;
end;

function TConfiguration.GetCurrentPage: Integer;
begin
  Result := FCurrentPage;
end;

function TConfiguration.GetReportFolder: string;

  function GetTempFolder: string;
  var
    s: string;
  begin
    s := TPath.GetTempPath;
    if DirectoryExists(s) then
    begin
      Result := s;
    end
    else
    begin
      raise EConfiguration.Create('Возникла ошибка при попытке получения пути временной папки!')
    end;
  end;

  function GetApplicationFolder: string;
  var
    s: string;
  begin
    Result := EmptyStr;

    s := ExtractFilePath(ExpandFileName(Application.ExeName));
    if DirectoryExists(s) then
    begin
      Result := s;
    end
    else
    begin
      raise EConfiguration.Create('Возникла ошибка при попытке получения пути рабочей папки программы!')
    end;
  end;

begin
  case FReportFolder of
    rfTempFolder:
      begin
        Result := GetTempFolder;
      end;
    rfApplicationFolder:
      begin
        Result := GetApplicationFolder;
      end;
    rfCustomFolder:
      begin
        Result := CustomReportFolderValue;
      end;
  end;
end;

procedure TConfiguration.Finalize;
begin
  FreeAndNil(FMessageServer);
  FreeAndNil(FDBServer);
  inherited;
end;

function TConfiguration.GetAddEditPhoneFormPosition: TDialogPosition;
begin
  Result := FAddEditPhoneFormPosition;
end;

function TConfiguration.GetAddMassMsrFormPosition: TDialogPosition;
begin
  Result := FAddMassMsrFormPosition;
end;

function TConfiguration.GetAutoGetMessagesCycleDurationValue: Integer;
begin
  Result := FAutoGetMessagesCycleDurationValue;
end;

function TConfiguration.GetCustomHelpFileValue: string;
begin
  Result := FCustomHelpFileValue;
end;

function TConfiguration.GetCustomLogClientValue: string;
begin
  Result := FCustomLogClientValue;
end;

function TConfiguration.GetCustomReportFolderValue: string;
begin
  Result := FCustomReportFolderValue;
end;

function TConfiguration.GetDataPanelEnableHalfWidth: Boolean;
begin
  Result := FDataPanelEnableHalfWidth;
end;

function TConfiguration.GetDataPanelWidthValue: Integer;
begin
  Result := FDataPanelWidthValue;
end;

function TConfiguration.GetDBServer: TMySQLConnection;
begin
  Result := FDBServer;
end;

function TConfiguration.GetEnableAskForFileName: Boolean;
begin
  Result := FEnableAskForFileName;
end;

function TConfiguration.GetEnableAutoGetMessages: Boolean;
begin
  Result := FEnableAutoGetMessages;
end;

function TConfiguration.GetEnableAutoLogon: Boolean;
begin
  Result := FEnableAutoLogon;
end;

function TConfiguration.GetEnableCommonSearchEditbox: Boolean;
begin
  Result := FEnableCommonSearchEditbox;
end;

function TConfiguration.GetEnableCustomHelpFile: Boolean;
begin
  Result := FEnableCustomHelpFile;
end;

function TConfiguration.GetEnableCustomLogClient: Boolean;
begin
  Result := FEnableCustomLogClient;
end;

function TConfiguration.GetEnableDataInOtherInfoPanel: Boolean;
begin
  Result := FEnableDataInOtherInfoPanel;
end;

function TConfiguration.GetEnableEditboxHints: Boolean;
begin
  Result := FEnableEditboxHints;
end;

function TConfiguration.GetEnableFlushLogOnApply: Boolean;
begin
  Result := FEnableFlushLogOnApply;
end;

function TConfiguration.GetEnableFlushLogOnClearingLog: Boolean;
begin
  Result := FEnableFlushLogOnClearingLog;
end;

function TConfiguration.GetEnableFlushLogOnExit: Boolean;
begin
  Result := FEnableFlushLogOnExit;
end;

function TConfiguration.GetEnableFlushLogOnStringsQuantity: Boolean;
begin
  Result := FEnableFlushLogOnStringsQuantity;
end;

function TConfiguration.GetEnableFlushLogOnStringsQuantityValue: Integer;
begin
  Result := FEnableFlushLogOnStringsQuantityValue;
end;

function TConfiguration.GetEnableID: Boolean;
begin
  Result := FEnableID;
end;

function TConfiguration.GetEnableLaunchAtStartup: Boolean;
begin
  Result := FEnableLaunchAtStartup;
end;

function TConfiguration.GetEnableLog: Boolean;
begin
  Result := FEnableLog;
end;

function TConfiguration.GetEnableMarkSearchedStrings: Boolean;
begin
  Result := FEnableMarkSearchedStrings;
end;

function TConfiguration.GetEnableMeasuresListAsRichEdit: Boolean;
begin
  Result := FEnableMeasuresListAsRichEdit;
end;

function TConfiguration.GetEnableMultibuffer: Boolean;
begin
  Result := FEnableMultibuffer;
end;

function TConfiguration.GetEnableOverwriteConfirmation: Boolean;
begin
  Result := FEnableOverwriteConfirmation;
end;

function TConfiguration.GetEnablePlaySoundOnComplete: Boolean;
begin
  Result := FEnablePlaySoundOnComplete;
end;

function TConfiguration.GetEnablePutTownAtTheEnd: Boolean;
begin
  Result := FEnablePutTownAtTheEnd;
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

function TConfiguration.GetEnableStoreLogin: Boolean;
begin
  Result := FEnableStoreLogin;
end;

function TConfiguration.GetEnableStorePassword: Boolean;
begin
  Result := FEnableStorePassword;
end;

function TConfiguration.GetEnableToolbar: Boolean;
begin
  Result := FEnableToolbar;
end;

function TConfiguration.GetKeepLogTypes: TLogMessagesTypes;
begin
  Result := FKeepLogTypes;
end;

function TConfiguration.GetLoginFormPosition: TDialogPosition;
begin
  Result := FLoginFormPosition;
end;

function TConfiguration.GetMainFormEnableFullScreenAtLaunch: Boolean;
begin
  Result := FMainFormEnableFullScreenAtLaunch;
end;

function TConfiguration.GetMainFormEnableCentered: Boolean;
begin
  Result := FMainFormEnableCentered;
end;

function TConfiguration.GetMainFormHeight: Integer;
begin
  Result := FMainFormHeight;
end;

function TConfiguration.GetMainFormLeft: Integer;
begin
  Result := FMainFormLeft;
end;

function TConfiguration.GetMainFormTop: Integer;
begin
  Result := FMainFormTop;
end;

function TConfiguration.GetMainFormWidth: Integer;
begin
  Result := FMainFormWidth;
end;

function TConfiguration.GetMaintenanceFormPosition: TDialogPosition;
begin
  Result := FMaintenanceFormPosition;
end;

function TConfiguration.GetMeasuresSortedByColumn: Integer;
begin
  Result := FMeasuresSortedByColumn;
end;

function TConfiguration.GetMessageServer: TMySQLConnection;
begin
  Result := FMessageServer;
end;

function TConfiguration.GetMultibufferFormPosition: TDialogPosition;
begin
  Result := FMultibufferFormPosition;
end;

function TConfiguration.GetOrganizationPanelEnableHalfHeight: Boolean;
begin
  Result := FOrganizationPanelEnableHalfHeight;
end;

function TConfiguration.GetOrganizationPanelHeightValue: Integer;
begin
  Result := FOrganizationPanelHeightValue;
end;

function TConfiguration.GetOrganizationsSortedByColumn: Integer;
begin
  Result := FOrganizationsSortedByColumn;
end;

function TConfiguration.GetPermissionsFormPosition: TDialogPosition;
begin
  Result := FPermissionsFormPosition;
end;

function TConfiguration.GetPhonesFormPosition: TDialogPosition;
begin
  Result := FPhonesFormPosition;
end;

function TConfiguration.GetSetPasswordFormPosition: TDialogPosition;
begin
  Result := FSetPasswordFormPosition;
end;

function TConfiguration.GetStoredLogin: string;
begin
  Result := FStoredLogin;
end;

function TConfiguration.GetStoredPassword: string;
begin
  Result := FStoredPassword;
end;

function TConfiguration.GetUsersFormPosition: TDialogPosition;
begin
  Result := FUsersFormPosition;
end;

function TConfiguration.GetViewMessageFormPosition: TDialogPosition;
begin
  Result := FViewMessageFormPosition;
end;

function TConfiguration.GetViewMessagesFormPosition: TDialogPosition;
begin
  Result := FViewMessagesFormPosition;
end;

procedure TConfiguration.Initialize;
begin
  inherited;
  // инициализация динамических членов класса
  FDBServer := TMySQLConnection.Create;
  FMessageServer := TMySQLConnection.Create;

  // инициализация пеерменных класса
  FCurrentPage := DEFAULT_CONFIGURATION_CURRENT_PAGE;
  FOrganizationsSortedByColumn := DEFAULT_CONFIGURATION_ORGANIZATIONS_SORTED_BY_COLUMN;
  FMeasuresSortedByColumn := DEFAULT_CONFIGURATION_MEASURES_SORTED_BY_COLUMN;

  // вкладка "настройки интерфейса"
  FEnableSplashAtStart := DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
  FEnableToolbar := DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
  FEnableStatusbar := DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
  FEnableEditboxHints := DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
  FEnableCommonSearchEditbox := DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
  FEnableID := DEFAULT_CONFIGURATION_ENABLE_ID;
  FEnableMultibuffer := DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
  FEnableQuitConfirmation := DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;

  // вкладка "настройки ведения протокола работы"
  FEnableLog := DEFAULT_CONFIGURATION_ENABLE_LOG;
  FKeepLogTypes := DEFAULT_CONFIGURATION_KEEP_LOG_TYPES;
  FEnableFlushLogOnExit := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT;
  FEnableFlushLogOnStringsQuantity := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY;
  FEnableFlushLogOnStringsQuantityValue := DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE;
  FEnableFlushLogOnClearingLog := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG;
  FEnableFlushLogOnApply := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY;
  FEnableCustomLogClient := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT;
  FCustomLogClientValue := DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE;

  // вкладка "настройки положения диалоговых окон"
  with FLoginFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FConfigurationFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FUsersFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FSetPasswordFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FReportFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FMaintenanceFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FClearingFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FViewMessagesFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FCreateMessageFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FViewMessageFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FPhonesFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FAddEditPhoneFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FAddMassMsrFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FPermissionsFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  with FMultibufferFormPosition do
  begin
    Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
    Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  end;

  // вкладка "настройки процедуры логирования"
  FEnableStoreLogin := DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
  FEnableStorePassword := DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
  FStoredLogin := DEFAULT_CONFIGURATION_STORED_LOGIN;
  FStoredPassword := DEFAULT_CONFIGURATION_STORED_PASSWORD;
  FEnableAutoLogon := DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON;

  // вкладка "настройки подключения к серверу базы данных услуги"
  with FDBServer do
  begin
    Connected := False;
    LogProvider := nil;
    Host := DEFAULT_CONFIGURATION_RNE4SERVER_HOST;
    Port := DEFAULT_CONFIGURATION_RNE4SERVER_PORT;
    Timeout := DEFAULT_CONFIGURATION_RNE4SERVER_TIMEOUT;
    Compression := DEFAULT_CONFIGURATION_RNE4SERVER_COMPRESSION;
    Login := DEFAULT_CONFIGURATION_RNE4SERVER_LOGIN;
    Password := DEFAULT_CONFIGURATION_RNE4SERVER_PASSWORD;
    Database := DEFAULT_CONFIGURATION_RNE4SERVER_DATABESE;
  end;

  // вкладка "настройки подключения к серверу системы обмена сообщениями"
  with FMessageServer do
  begin
    Connected := False;
    LogProvider := nil;
    Host := DEFAULT_CONFIGURATION_MESSAGESERVER_HOST;
    Port := DEFAULT_CONFIGURATION_MESSAGESERVER_PORT;
    Timeout := DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT;
    Compression := DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION;
    Login := DEFAULT_CONFIGURATION_MESSAGESERVER_LOGIN;
    Password := DEFAULT_CONFIGURATION_MESSAGESERVER_PASSWORD;
    Database := DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE;
  end;

  // вкладка "настройки формирования отчётов"
  FReportFolder := DEFAULT_CONFIGURATION_REPORT_FOLDER_TYPE;
  FCustomReportFolderValue := DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE;
  FEnableOverwriteConfirmation := DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
  EnableAskForFileName := DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;

  // вкладка "настройки прочие"
  FEnableLaunchAtStartup := DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
  FEnablePlaySoundOnComplete := DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
  FEnableAutoGetMessages := DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES;
  FAutoGetMessagesCycleDurationValue := DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE;
  FEnableCustomHelpFile := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
  FCustomHelpFileValue := DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE;

  // вкладка "настройки главного окна"
  MainFormLeft := DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
  MainFormTop := DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
  MainFormWidth := DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
  MainFormHeight := DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
  FMainFormEnableCentered := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED;
  FMainFormEnableFullScreenAtLaunch := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;

  // вкладка "настройки отображения информации"
  FOrganizationPanelHeightValue := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE;
  FOrganizationPanelEnableHalfHeight := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
  FDataPanelWidthValue := DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE;
  FDataPanelEnableHalfWidth := DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
  FEnableDataInOtherInfoPanel := DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
  FEnableMeasuresListAsRichEdit := DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
  FEnableMarkSearchedStrings := DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS;
  FEnablePutTownAtTheEnd := DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;
end;

procedure TConfiguration.SetAddEditPhoneFormPosition(const AValue: TDialogPosition);
begin
  if not FAddEditPhoneFormPosition.Equals(AValue) then
    FAddEditPhoneFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetAddMassMsrFormPosition(const AValue: TDialogPosition);
begin
  if not FAddMassMsrFormPosition.Equals(AValue) then
    FAddMassMsrFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetPermissionsFormPosition(const AValue: TDialogPosition);
begin
  if not FPermissionsFormPosition.Equals(AValue) then
    FPermissionsFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetMultibufferFormPosition(const AValue: TDialogPosition);
begin
  if not FMultibufferFormPosition.Equals(AValue) then
    FMultibufferFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetEnableAskForFileName(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableAskForFileName);
end;

procedure TConfiguration.SetAutoGetMessagesCycleDurationValue(const AValue: Integer);
begin
  Routines.SetField(AValue, FAutoGetMessagesCycleDurationValue);
end;

procedure TConfiguration.SetEnableAutoLogon(const AValue: Boolean);
begin
  if AValue then
  begin
    if not(EnableStoreLogin and EnableStorePassword) then
    begin
      raise EConfiguration.Create('Для включения настройки автологирования необходимо сначала включить сохранение логина и пароля последнего пользователя!');
    end
    else
    begin
      Routines.SetField(AValue, FEnableAutoLogon);
    end;
  end
  else
  begin
    Routines.SetField(AValue, FEnableAutoLogon);
  end;
end;

procedure TConfiguration.SetClearingFormPosition(const AValue: TDialogPosition);
begin
  if not FClearingFormPosition.Equals(AValue) then
  begin
    FClearingFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetCreateMessageFormPosition(const AValue: TDialogPosition);
begin
  if not FCreateMessageFormPosition.Equals(AValue) then
  begin
    FCreateMessageFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetCurrentPage(const AValue: Integer);
begin
  Routines.SetField(AValue, FCurrentPage);
end;

procedure TConfiguration.SetCustomHelpFileValue(const AValue: string);
begin
  Routines.SetField(AValue, FCustomHelpFileValue);
end;

procedure TConfiguration.SetEnableCustomLogClient(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableCustomLogClient);
end;

procedure TConfiguration.SetCustomLogClientValue(const AValue: string);
begin
  Routines.SetField(AValue, FCustomLogClientValue);
end;

procedure TConfiguration.SetDataPanelEnableHalfWidth(const AValue: Boolean);
begin
  Routines.SetField(AValue, FDataPanelEnableHalfWidth);
end;

procedure TConfiguration.SetDataPanelWidthValue(const AValue: Integer);
begin
  Routines.SetField(AValue, FDataPanelWidthValue);
end;

procedure TConfiguration.SetEnableOverwriteConfirmation(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableOverwriteConfirmation);
end;

procedure TConfiguration.SetEnableAutoGetMessages(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableAutoGetMessages);
end;

procedure TConfiguration.SetEnableCustomHelpFile(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableCustomHelpFile);
end;

procedure TConfiguration.SetEnableFlushLogOnApply(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableFlushLogOnApply);
end;

procedure TConfiguration.SetEnableFlushLogOnClearingLog(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableFlushLogOnClearingLog);
end;

procedure TConfiguration.SetEnableFlushLogOnExit(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableFlushLogOnExit);
end;

procedure TConfiguration.SetEnableFlushLogOnStringsQuantity(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableFlushLogOnStringsQuantity);
end;

procedure TConfiguration.SetEnableFlushLogOnStringsQuantityValue(const AValue: Integer);
begin
  Routines.SetField(AValue, FEnableFlushLogOnStringsQuantityValue);
end;

procedure TConfiguration.SetMainFormEnableFullScreenAtLaunch(const AValue: Boolean);
begin
  Routines.SetField(AValue, FMainFormEnableFullScreenAtLaunch)
end;

procedure TConfiguration.AfterLoad;
begin
end;

procedure TConfiguration.BeforeSave;
begin
end;

procedure TConfiguration.SetEnableStoreLogin(const AValue: Boolean);
begin
  if FEnableStoreLogin <> AValue then
  begin
    FEnableStoreLogin := AValue;
    if not FEnableStoreLogin then
    begin
      FStoredLogin := EmptyStr;
      FStoredPassword := EmptyStr;
      FEnableStorePassword := False;
      FEnableAutoLogon := False;
    end;
  end
end;

procedure TConfiguration.SetEnableStorePassword(const AValue: Boolean);
begin
  if FEnableStorePassword <> AValue then
  begin
    FEnableStorePassword := AValue;
    if not FEnableStorePassword then
    begin
      FStoredPassword := EmptyStr;
      FEnableAutoLogon := False;
    end;
  end;
end;

procedure TConfiguration.SetStoredLogin(const AValue: string);
begin
  if EnableStoreLogin then
  begin
    Routines.SetField(AValue, FStoredLogin);
  end
  else
  begin
    Routines.SetField(EmptyStr, FStoredLogin);
  end;
end;

procedure TConfiguration.SetStoredPassword(const AValue: string);
begin
  if EnableStorePassword then
  begin
    Routines.SetField(AValue, FStoredPassword);
  end
  else
  begin
    Routines.SetField(EmptyStr, FStoredPassword);
  end;
end;

procedure TConfiguration.Loading(const AIniFile: TCustomIniFile);
var
  FormPosition: TDialogPosition;
begin
  inherited;
  with AIniFile do
  begin
    // вкладка "настройки интерфейса"
    EnableSplashAtStart := ReadBool(RsInterface, 'bShowSplashAtStart', DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START);
    EnableToolbar := ReadBool(RsInterface, 'bShowToolbar', DEFAULT_CONFIGURATION_ENABLE_TOOLBAR);
    EnableStatusbar := ReadBool(RsInterface, 'bShowStatusbar', DEFAULT_CONFIGURATION_ENABLE_STATUSBAR);
    EnableEditboxHints := ReadBool(RsInterface, 'bShowEditboxHints', DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS);
    EnableCommonSearchEditbox := ReadBool(RsInterface, 'bShowCommonSearchEditbox', DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX);
    EnableID := ReadBool(RsInterface, 'bShowID', DEFAULT_CONFIGURATION_ENABLE_ID);
    EnableMultibuffer := ReadBool(RsInterface, 'bUseMultibuffer', DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER);
    EnableQuitConfirmation := ReadBool(RsInterface, 'bShowConfirmationOnQuit', DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION);

    // вкладка "настройки ведения протокола работы"
    EnableLog := ReadBool(RsLogging, 'bEnableLog', DEFAULT_CONFIGURATION_ENABLE_LOG);
    EnableFlushLogOnExit := ReadBool(RsLogging, 'bFlushLogOnExit', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT);
    EnableFlushLogOnStringsQuantity := ReadBool(RsLogging, 'bFlushLogOnStringsQuantity', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY);
    EnableFlushLogOnStringsQuantityValue := ReadInteger(RsLogging, 'iFlushLogOnStringsQuantityValue', DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE);
    EnableFlushLogOnClearingLog := ReadBool(RsLogging, 'bFlushLogOnClearingLog', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG);
    EnableFlushLogOnApply := ReadBool(RsLogging, 'bFlushLogOnApply', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY);
    EnableCustomLogClient := ReadBool(RsLogging, 'bCustomLogClientFile', DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT);
    CustomLogClientValue := ReadString(RsLogging, 'sCustomLogClientFileValue', DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE);
    if ReadBool(RsLogging, 'bKeepErrorLog', lmtError in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtError]
    else
      KeepLogTypes := KeepLogTypes - [lmtError];
    if ReadBool(RsLogging, 'bKeepWarningLog', lmtWarning in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtWarning]
    else
      KeepLogTypes := KeepLogTypes - [lmtWarning];
    if ReadBool(RsLogging, 'bKeepInfoLog', lmtInfo in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtInfo]
    else
      KeepLogTypes := KeepLogTypes - [lmtInfo];
    if ReadBool(RsLogging, 'bKeepSQLLog', lmtSQL in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtSQL]
    else
      KeepLogTypes := KeepLogTypes - [lmtSQL];
    if ReadBool(RsLogging, 'bKeepDebugLog', lmtDebug in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtDebug]
    else
      KeepLogTypes := KeepLogTypes - [lmtDebug];

    // вкладка "настройки положения диалоговых окон"
    with FormPosition do
    begin
      Centered := ReadBool(RsDialogsPosition, 'LoginFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'LoginFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'LoginFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      LoginFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'ConfigurationFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'ConfigurationFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'ConfigurationFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ConfigurationFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'UsersFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'UsersFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'UsersFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      UsersFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'SetPasswordFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'SetPasswordFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'SetPasswordFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      SetPasswordFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'ReportFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'ReportFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'ReportFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ReportFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'MaintenanceFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'MaintenanceFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'MaintenanceFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      MaintenanceFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'ClearingFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'ClearingFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'ClearingFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ClearingFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'ViewMessagesFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'ViewMessagesFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'ViewMessagesFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ViewMessagesFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'CreateMessageFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'CreateMessageFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'CreateMessageFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      CreateMessageFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'ViewMessageFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'ViewMessageFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'ViewMessageFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ViewMessageFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'PhonesFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'PhonesFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'PhonesFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      PhonesFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'AddEditPhoneFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'AddEditPhoneFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'AddEditPhoneFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      AddEditPhoneFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'AddMassMsrFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'AddMassMsrFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'AddMassMsrFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      AddMassMsrFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'PermissionsFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'PermissionsFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'PermissionsFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      PermissionsFormPosition := FormPosition;

      Centered := ReadBool(RsDialogsPosition, 'MultibufferFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(RsDialogsPosition, 'MultibufferFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(RsDialogsPosition, 'MultibufferFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      MultibufferFormPosition := FormPosition;
    end;

    // вкладка "настройки процедуры логирования"
    EnableStoreLogin := ReadBool(RsIdentity, 'bStoreLogin', DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN);
    if EnableStoreLogin then
      Login := ReadString(RsIdentity, 'sLogin', EmptyStr)
    else
      Login := EmptyStr;
    EnableStorePassword := ReadBool(RsIdentity, 'bStorePassword', DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD);
    if EnableStorePassword then
      Password := ReadString(RsIdentity, 'sPassword', EmptyStr)
    else
      Password := EmptyStr;
    EnableAutoLogon := ReadBool(RsIdentity, 'bAutoLogon', DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON);

    // вкладка "подключения к серверу базы данных услуги"
    with DBServer do
    begin
      Host := ReadString(RsServers, 'RNE4Server.sHost', DEFAULT_CONFIGURATION_RNE4SERVER_HOST);
      Port := ReadInteger(RsServers, 'RNE4Server.iPort', DEFAULT_CONFIGURATION_RNE4SERVER_PORT);
      Timeout := ReadInteger(RsServers, 'RNE4Server.iTimeout', DEFAULT_CONFIGURATION_RNE4SERVER_TIMEOUT);
      Compression := ReadBool(RsServers, 'RNE4Server.bCompression', DEFAULT_CONFIGURATION_RNE4SERVER_COMPRESSION);
      Login := ReadString(RsServers, 'RNE4Server.sLogin', DEFAULT_CONFIGURATION_RNE4SERVER_LOGIN);
      Password := ReadString(RsServers, 'RNE4Server.sPassword', DEFAULT_CONFIGURATION_RNE4SERVER_PASSWORD);
      Database := ReadString(RsServers, 'RNE4Server.sDatabase', DEFAULT_CONFIGURATION_RNE4SERVER_DATABESE);
    end;

    // вкладка "подключения к серверу системы обмена сообщениями"
    with MessageServer do
    begin
      Host := ReadString(RsServers, 'MessagesServer.sHost', DEFAULT_CONFIGURATION_MESSAGESERVER_HOST);
      Port := ReadInteger(RsServers, 'MessagesServer.iPort', DEFAULT_CONFIGURATION_MESSAGESERVER_PORT);
      Timeout := ReadInteger(RsServers, 'MessagesServer.iTimeout', DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT);
      Compression := ReadBool(RsServers, 'MessagesServer.bCompression', DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION);
      Login := ReadString(RsServers, 'MessagesServer.sLogin', DEFAULT_CONFIGURATION_MESSAGESERVER_LOGIN);
      Password := ReadString(RsServers, 'MessagesServer.sPassword', DEFAULT_CONFIGURATION_MESSAGESERVER_PASSWORD);
      Database := ReadString(RsServers, 'MessagesServer.sDatabase', DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE);
    end;

    // вкладка "настройки формирования отчётов"
    ReportFolderType := TReportFolder(ReadInteger(RsReports, 'iReportFolder', Integer(rfApplicationFolder)));
    CustomReportFolderValue := ReadString(RsReports, 'sCustomReportFolderValue', EmptyStr);
    EnableOverwriteConfirmation := ReadBool(RsReports, 'bDontDemandOverwriteConfirmation', False);
    EnableAskForFileName := ReadBool(RsReports, 'bAskForFileName', True);

    // вкладка "настройки прочие"
    EnableLaunchAtStartup := ReadBool(RsOther, 'bLaunchAtStartup', DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP);
    EnablePlaySoundOnComplete := ReadBool(RsOther, 'bPlaySoundOnComplete', DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE);
    EnableAutoGetMessages := ReadBool(RsOther, 'bEnableAutoGetMessages', DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES);
    AutoGetMessagesCycleDurationValue := ReadInteger(RsOther, 'iAutoGetMessagesCycleDurationValue', DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE);
    EnableCustomHelpFile := ReadBool(RsOther, 'bCustomHelpFile', DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE);
    CustomHelpFileValue := ReadString(RsOther, 'sCustomHelpFileValue', DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE);

    // вкладка "настройки главного окна"
    MainFormLeft := ReadInteger(RsMainForm, 'iMainFormLeft', DEFAULT_CONFIGURATION_MAIN_FORM_LEFT);
    MainFormTop := ReadInteger(RsMainForm, 'iMainFormTop', DEFAULT_CONFIGURATION_MAIN_FORM_TOP);
    MainFormWidth := ReadInteger(RsMainForm, 'iMainFormWidth', DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH);
    MainFormHeight := ReadInteger(RsMainForm, 'iMainFormHeight', DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT);
    MainFormEnableCentered := ReadBool(RsMainForm, 'bMainFormPositionByCenter', DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED);
    MainFormEnableFullScreenAtLaunch := ReadBool(RsMainForm, 'bFullScreenAtLaunch', DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH);

    // вкладка "настройки отображения информации"
    OrganizationPanelHeightValue := ReadInteger(RsInfo, 'iOrganizationPanelHeightValue', DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE);
    OrganizationPanelEnableHalfHeight := ReadBool(RsInfo, 'bOrganizationPanelHalfHeight', DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT);
    DataPanelWidthValue := ReadInteger(RsInfo, 'iDataPanelWidthValue', DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE);
    DataPanelEnableHalfWidth := ReadBool(RsInfo, 'bOrganizationPanelHalfHeight', DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH);
    EnableDataInOtherInfoPanel := ReadBool(RsInfo, 'bShowDataInOtherInfoPanel', DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL);
    EnableMeasuresListAsRichEdit := ReadBool(RsInfo, 'bShowMeasuresListAsRichEdit', DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT);
    EnableMarkSearchedStrings := ReadBool(RsInfo, 'bMarkSearchedStrings', DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS);
    EnablePutTownAtTheEnd := ReadBool(RsInfo, 'bPutTownAtTheEnd', DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END);
  end;
end;

procedure TConfiguration.Saving(const AIniFile: TCustomIniFile);

  procedure WriteFormPosition(IniFile: TCustomIniFile; FormPosition: TDialogPosition; const FormPositionName: string);
  begin
    with IniFile do
    begin
      WriteBool(RsDialogsPosition, FormPositionName + '.Centered', FormPosition.Centered);
      WriteInteger(RsDialogsPosition, FormPositionName + '.Left', FormPosition.Left);
      WriteInteger(RsDialogsPosition, FormPositionName + '.Top', FormPosition.Top);
    end;
  end;

begin
  inherited;
  with AIniFile do
    try
      // вкладка "настройки интерфейса"
      WriteBool(RsInterface, 'bShowSplashAtStart', EnableSplashAtStart);
      WriteBool(RsInterface, 'bShowToolbar', EnableToolbar);
      WriteBool(RsInterface, 'bShowStatusbar', EnableStatusbar);
      WriteBool(RsInterface, 'bShowEditboxHints', EnableEditboxHints);
      WriteBool(RsInterface, 'bShowCommonSearchEditbox', EnableCommonSearchEditbox);
      WriteBool(RsInterface, 'bShowID', EnableID);
      WriteBool(RsInterface, 'bUseMultibuffer', EnableMultibuffer);
      WriteBool(RsInterface, 'bShowConfirmationOnQuit', EnableQuitConfirmation);

      // вкладка "настройки ведения протокола работы"
      WriteBool(RsLogging, 'bEnableLog', EnableLog);
      WriteBool(RsLogging, 'bFlushLogOnExit', EnableFlushLogOnExit);
      WriteBool(RsLogging, 'bFlushLogOnStringsQuantity', EnableFlushLogOnStringsQuantity);
      WriteInteger(RsLogging, 'iFlushLogOnStringsQuantityValue', EnableFlushLogOnStringsQuantityValue);
      WriteBool(RsLogging, 'bFlushLogOnClearingLog', EnableFlushLogOnClearingLog);
      WriteBool(RsLogging, 'bFlushLogOnApply', EnableFlushLogOnApply);
      WriteBool(RsLogging, 'bCustomLogClientFile', EnableCustomLogClient);
      WriteString(RsLogging, 'sCustomLogClientFileValue', CustomLogClientValue);

      WriteBool(RsLogging, 'bKeepErrorLog', lmtError in KeepLogTypes);
      WriteBool(RsLogging, 'bKeepWarningLog', lmtWarning in KeepLogTypes);
      WriteBool(RsLogging, 'bKeepInfoLog', lmtInfo in KeepLogTypes);
      WriteBool(RsLogging, 'bKeepSQLLog', lmtSQL in KeepLogTypes);
      WriteBool(RsLogging, 'bKeepDebugLog', lmtDebug in KeepLogTypes);

      // вкладка "настройки положения диалоговых окон"
      WriteFormPosition(AIniFile, LoginFormPosition, 'LoginFormPosition');
      WriteFormPosition(AIniFile, ConfigurationFormPosition, 'ConfigurationFormPosition');
      WriteFormPosition(AIniFile, UsersFormPosition, 'UsersFormPosition');
      WriteFormPosition(AIniFile, SetPasswordFormPosition, 'SetPasswordFormPosition');
      WriteFormPosition(AIniFile, ReportFormPosition, 'ReportFormPosition');
      WriteFormPosition(AIniFile, MaintenanceFormPosition, 'MaintenanceFormPosition');
      WriteFormPosition(AIniFile, ClearingFormPosition, 'ClearingFormPosition');
      WriteFormPosition(AIniFile, ViewMessagesFormPosition, 'ViewMessagesFormPosition');
      WriteFormPosition(AIniFile, CreateMessageFormPosition, 'CreateMessageFormPosition');
      WriteFormPosition(AIniFile, ViewMessageFormPosition, 'ViewMessageFormPosition');
      WriteFormPosition(AIniFile, PhonesFormPosition, 'PhonesFormPosition');
      WriteFormPosition(AIniFile, AddEditPhoneFormPosition, 'AddEditPhoneFormPosition');
      WriteFormPosition(AIniFile, AddMassMsrFormPosition, 'AddMassMsrFormPosition');
      WriteFormPosition(AIniFile, PermissionsFormPosition, 'PermissionsFormPosition');
      WriteFormPosition(AIniFile, MultibufferFormPosition, 'MultibufferFormPosition');

      // вкладка "настройки процедуры логирования"
      WriteBool(RsIdentity, 'bStoreLogin', EnableStoreLogin);
      WriteBool(RsIdentity, 'bStorePassword', EnableStorePassword);
      if EnableStoreLogin then
        WriteString(RsIdentity, 'sLogin', Login)
      else
        DeleteKey(RsIdentity, 'sLogin');
      if EnableStorePassword then
        WriteString(RsIdentity, 'sPassword', Password)
      else
        DeleteKey(RsIdentity, 'sPassword');
      WriteBool(RsIdentity, 'bAutoLogon', EnableAutoLogon);

      // вкладка "подключения к серверу базы данных услуги"
      with DBServer do
      begin
        WriteString(RsServers, 'RNE4Server.sHost', Host);
        WriteInteger(RsServers, 'RNE4Server.iPort', Port);
        WriteInteger(RsServers, 'RNE4Server.iTimeout', Timeout);
        WriteBool(RsServers, 'RNE4Server.bCompression', Compression);
        // WriteString(RsServers, 'RNE4Server.sLogin', Login);
        // WriteString(RsServers, 'RNE4Server.sPassword', Password);
        WriteString(RsServers, 'RNE4Server.sDatabase', Database);
      end;

      // вкладка "подключения к серверу системы обмена сообщениями"
      with MessageServer do
      begin
        WriteString(RsServers, 'MessagesServer.sHost', Host);
        WriteInteger(RsServers, 'MessagesServer.iPort', Port);
        WriteInteger(RsServers, 'MessagesServer.iTimeout', Timeout);
        WriteBool(RsServers, 'MessagesServer.bCompression', Compression);
        // WriteString(RsServers, 'MessagesServer.sLogin', Login);
        // WriteString(RsServers, 'MessagesServer.sPassword', Password);
        WriteString(RsServers, 'MessagesServer.sDatabase', Database);
      end;

      // вкладка "настройки формирования отчётов"
      WriteInteger(RsReports, 'iReportFolder', Integer(ReportFolderType));
      WriteString(RsReports, 'sCustomReportFolderValue', CustomReportFolderValue);
      WriteBool(RsReports, 'bDontDemandOverwriteConfirmation', EnableOverwriteConfirmation);
      WriteBool(RsReports, 'bAskForFileName', EnableAskForFileName);

      // вкладка "настройки прочие"
      WriteBool(RsOther, 'bLaunchAtStartup', EnableLaunchAtStartup);
      WriteBool(RsOther, 'bPlaySoundOnComplete', EnablePlaySoundOnComplete);
      WriteBool(RsOther, 'bEnableAutoGetMessages', EnableAutoGetMessages);
      WriteInteger(RsOther, 'iAutoGetMessagesCycleDurationValue', AutoGetMessagesCycleDurationValue);
      WriteBool(RsOther, 'bCustomHelpFile', EnableCustomHelpFile);
      WriteString(RsOther, 'bCustomHelpFileValue', CustomHelpFileValue);

      // вкладка "настройки главного окна"
      WriteInteger(RsMainForm, 'iMainFormLeft', MainFormLeft);
      WriteInteger(RsMainForm, 'iMainFormTop', MainFormTop);
      WriteInteger(RsMainForm, 'iMainFormWidth', MainFormWidth);
      WriteInteger(RsMainForm, 'iMainFormHeight', MainFormHeight);
      WriteBool(RsMainForm, 'bMainFormPositionByCenter', MainFormEnableCentered);
      WriteBool(RsMainForm, 'bFullScreenAtLaunch', MainFormEnableFullScreenAtLaunch);

      // вкладка "настройки отображения информации"
      WriteInteger(RsInfo, 'iOrganizationPanelHeightValue', OrganizationPanelHeightValue);
      WriteBool(RsInfo, 'bOrganizationPanelHalfHeight', OrganizationPanelEnableHalfHeight);
      WriteInteger(RsInfo, 'iDataPanelWidthValue', DataPanelWidthValue);
      WriteBool(RsInfo, 'bOrganizationPanelHalfHeight', OrganizationPanelEnableHalfHeight);
      WriteBool(RsInfo, 'bShowDataInOtherInfoPanel', EnableDataInOtherInfoPanel);
      WriteBool(RsInfo, 'bShowMeasuresListAsRichEdit', EnableMeasuresListAsRichEdit);
      WriteBool(RsInfo, 'bMarkSearchedStrings', EnableMarkSearchedStrings);
      WriteBool(RsInfo, 'bPutTownAtTheEnd', EnablePutTownAtTheEnd);
    except
      on EIniFileException do
      begin
        raise EIniFileException.Create('Произошла ошибка при попытке записи настроек программы в файл конфигурации!');
      end;
    end;
end;

initialization

begin
  System.Classes.RegisterClass(TConfiguration);
end;

end.
