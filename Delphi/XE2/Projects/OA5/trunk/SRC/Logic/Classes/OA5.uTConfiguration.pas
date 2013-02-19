unit OA5.uTConfiguration;

interface

uses
  System.SysUtils,
  System.IniFiles,
  CastersPackage.uLogKeeperData,
  CastersPackage.uTIniFileDataStorage,
  CastersPackage.uTDialogPosition,
  CastersPackage.uTReportFolder,
  CastersPackage.uTLogMessagesTypes,
  OA5.uIConfiguration,
  OA5.uIMySQLConnection,
  OA5.uTMySQLConnection,
  OA5.uDefaultConsts;

type
  EConfiguration = class(Exception);

  TConfiguration = class(TIniFileDataStorage, IConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
    procedure Loading; override;
    procedure Saving; override;
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
    FEnableDataInOtherInfoPanel: Boolean;
    // В режиме просмотра показывать данные в окне прочей информации
    FEnableMeasuresListAsRichEdit: Boolean;
    // В режиме просмотра объединять меропрятия в общий спиcок
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
    FPhoneListFormPosition: TDialogPosition;
    FAddEditPhoneFormPosition: TDialogPosition;
    FAddMassMsrFormPosition: TDialogPosition;
    FPermissionsFormPosition: TDialogPosition;
    FMultibufferFormPosition: TDialogPosition;
    // вкладка "настройки подключения к серверу базы данных услуги"
    FDBServer: IMySQLConnection;
    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    FMessageServer: IMySQLConnection;
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
    function GetPhoneListFormPosition: TDialogPosition;
    procedure SetPhoneListFormPosition(const AValue: TDialogPosition);
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
    function GetDBServer: IMySQLConnection;
    function GetMessageServer: IMySQLConnection;
  published
    // вкладка "настройки интерфейса"
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart
      default DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar
      default DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar
      default DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
    property EnableEditboxHints: Boolean read GetEnableEditboxHints write SetEnableEditboxHints
      default DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
    property EnableCommonSearchEditbox: Boolean read GetEnableCommonSearchEditbox
      write SetEnableCommonSearchEditbox default DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
    property EnableID: Boolean read GetEnableID write SetEnableID
      default DEFAULT_CONFIGURATION_ENABLE_ID;
    property EnableMultibuffer: Boolean read GetEnableMultibuffer write SetEnableMultibuffer
      default DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation
      write SetEnableQuitConfirmation default DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;
    // вкладка "настройки ведения протокола работы"
    property EnableLog: Boolean read GetEnableLog write SetEnableLog
      default DEFAULT_CONFIGURATION_ENABLE_LOG;
    property KeepLogTypes: TLogMessagesTypes read GetKeepLogTypes write SetKeepLogTypes
      default DEFAULT_CONFIGURATION_KEEP_LOG_TYPES;
    property EnableFlushLogOnExit: Boolean read GetEnableFlushLogOnExit
      write SetEnableFlushLogOnExit default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT;
    property EnableFlushLogOnStringsQuantity: Boolean read GetEnableFlushLogOnStringsQuantity
      write SetEnableFlushLogOnStringsQuantity
      default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY;
    property EnableFlushLogOnStringsQuantityValue: Integer
      read GetEnableFlushLogOnStringsQuantityValue write SetEnableFlushLogOnStringsQuantityValue
      default DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE;
    property EnableFlushLogOnClearingLog: Boolean read GetEnableFlushLogOnClearingLog
      write SetEnableFlushLogOnClearingLog
      default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG;
    property EnableFlushLogOnApply: Boolean read GetEnableFlushLogOnApply
      write SetEnableFlushLogOnApply default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY;
    property EnableCustomLogClient: Boolean read GetEnableCustomLogClient
      write SetEnableCustomLogClient default DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT;
    property CustomLogClientValue: string read GetCustomLogClientValue
      write SetCustomLogClientValue nodefault;
    // вкладка "настройки процедуры логирования"
    property EnableAutoLogon: Boolean read GetEnableAutoLogon write SetEnableAutoLogon
      default DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON;
    property EnableStoreLogin: Boolean read GetEnableStoreLogin write SetEnableStoreLogin
      default DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword
      default DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
    property StoredLogin: string read GetStoredLogin write SetStoredLogin stored False;
    property StoredPassword: string read GetStoredPassword write SetStoredPassword stored False;
    // вкладка "настройки формирования отчётов"
    property ReportFolderType: TReportFolder read GetReportFolderType write SetReportFolderType
      default DEFAULT_CONFIGURATION_REPORT_FOLDER_TYPE;
    property CustomReportFolderValue: string read GetCustomReportFolderValue
      write SetCustomReportFolderValue nodefault;
    property EnableOverwriteConfirmation: Boolean read GetEnableOverwriteConfirmation
      write SetEnableOverwriteConfirmation
      default DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
    property EnableAskForFileName: Boolean read GetEnableAskForFileName
      write SetEnableAskForFileName default DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;
    // вкладка "настройки прочие"
    property EnableLaunchAtStartup: Boolean read GetEnableLaunchAtStartup
      write SetEnableLaunchAtStartup default DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete
      write SetEnablePlaySoundOnComplete
      default DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
    property EnableAutoGetMessages: Boolean read GetEnableAutoGetMessages
      write SetEnableAutoGetMessages default DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES;
    property AutoGetMessagesCycleDurationValue: Integer read GetAutoGetMessagesCycleDurationValue
      write SetAutoGetMessagesCycleDurationValue
      default DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE;
    property EnableCustomHelpFile: Boolean read GetEnableCustomHelpFile
      write SetEnableCustomHelpFile default DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
    property CustomHelpFileValue: string read GetCustomHelpFileValue
      write SetCustomHelpFileValue nodefault;
    // вкладка "настройки главного окна"
    property MainFormLeft: Integer read GetMainFormLeft write SetMainFormLeft
      default DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
    property MainFormTop: Integer read GetMainFormTop write SetMainFormTop
      default DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
    property MainFormWidth: Integer read GetMainFormWidth write SetMainFormWidth
      default DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
    property MainFormHeight: Integer read GetMainFormHeight write SetMainFormHeight
      default DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
    property MainFormEnableCentered: Boolean read GetMainFormEnableCentered
      write SetMainFormEnableCentered default DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED;
    property MainFormEnableFullScreenAtLaunch: Boolean read GetMainFormEnableFullScreenAtLaunch
      write SetMainFormEnableFullScreenAtLaunch
      default DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;
    // вкладка "настройки отображения информации"
    property OrganizationPanelHeightValue: Integer read GetOrganizationPanelHeightValue
      write SetOrganizationPanelHeightValue
      default DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE;
    property OrganizationPanelEnableHalfHeight: Boolean read GetOrganizationPanelEnableHalfHeight
      write SetOrganizationPanelEnableHalfHeight
      default DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
    property DataPanelWidthValue: Integer read GetDataPanelWidthValue write SetDataPanelWidthValue
      default DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE;
    property DataPanelEnableHalfWidth: Boolean read GetDataPanelEnableHalfWidth
      write SetDataPanelEnableHalfWidth default DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
    property EnableDataInOtherInfoPanel: Boolean read GetEnableDataInOtherInfoPanel
      write SetEnableDataInOtherInfoPanel
      default DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
    property EnableMeasuresListAsRichEdit: Boolean read GetEnableMeasuresListAsRichEdit
      write SetEnableMeasuresListAsRichEdit
      default DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
    property EnableMarkSearchedStrings: Boolean read GetEnableMarkSearchedStrings
      write SetEnableMarkSearchedStrings default DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS;
    property EnablePutTownAtTheEnd: Boolean read GetEnablePutTownAtTheEnd
      write SetEnablePutTownAtTheEnd default DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;
    // вкладка "настройки положения диалоговых окон"
    property AddEditPhoneFormPosition: TDialogPosition read GetAddEditPhoneFormPosition
      write SetAddEditPhoneFormPosition nodefault;
    property AddMassMsrFormPosition: TDialogPosition read GetAddMassMsrFormPosition
      write SetAddMassMsrFormPosition nodefault;
    property ConfigurationFormPosition: TDialogPosition read GetConfigurationFormPosition
      write SetConfigurationFormPosition nodefault;
    property CreateMessageFormPosition: TDialogPosition read GetCreateMessageFormPosition
      write SetCreateMessageFormPosition nodefault;
    property LoginFormPosition: TDialogPosition read GetLoginFormPosition
      write SetLoginFormPosition nodefault;
    property MultibufferFormPosition: TDialogPosition read GetMultibufferFormPosition
      write SetMultibufferFormPosition nodefault;
    property PermissionsFormPosition: TDialogPosition read GetPermissionsFormPosition
      write SetPermissionsFormPosition nodefault;
    property ReportFormPosition: TDialogPosition read GetReportFormPosition
      write SetReportFormPosition nodefault;
    property SetPasswordFormPosition: TDialogPosition read GetSetPasswordFormPosition
      write SetSetPasswordFormPosition nodefault;
    property ViewMessageFormPosition: TDialogPosition read GetViewMessageFormPosition
      write SetViewMessageFormPosition nodefault;
    property ViewMessagesFormPosition: TDialogPosition read GetViewMessagesFormPosition
      write SetViewMessagesFormPosition nodefault;
    property UsersFormPosition: TDialogPosition read GetUsersFormPosition
      write SetUsersFormPosition nodefault;
    property MaintenanceFormPosition: TDialogPosition read GetMaintenanceFormPosition
      write SetMaintenanceFormPosition nodefault;
    property ClearingFormPosition: TDialogPosition read GetClearingFormPosition
      write SetClearingFormPosition nodefault;
    property PhoneListFormPosition: TDialogPosition read GetPhoneListFormPosition
      write SetPhoneListFormPosition nodefault;
    // вкладка "настройки подключения к серверу базы данных услуги"
    property DBServer: IMySQLConnection read GetDBServer nodefault;
    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    property MessageServer: IMySQLConnection read GetMessageServer nodefault;
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
    constructor Create(const AConfigurationFileName: string = ''); override;
    property ReportFolder: string read GetReportFolder stored False;
    property CurrentPage: Integer read GetCurrentPage write SetCurrentPage
      default DEFAULT_CONFIGURATION_CURRENT_PAGE;
    property OrganizationsSortedByColumn: Integer read GetOrganizationsSortedByColumn
      write SetOrganizationsSortedByColumn
      default DEFAULT_CONFIGURATION_ORGANIZATIONS_SORTED_BY_COLUMN;
    property MeasuresSortedByColumn: Integer read GetMeasuresSortedByColumn
      write SetMeasuresSortedByColumn default DEFAULT_CONFIGURATION_MEASURES_SORTED_BY_COLUMN;
  end;

function GetIConfiguration(const AConfigurationFileName: string = ''): IConfiguration;

implementation

uses
  CastersPackage.uTLogMessagesType,
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
  RsConfigurationSaveError =
    'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  RsAutoLogonEnableError = 'Для включения настройки автологирования необходи' +
    'мо сначала включить сохранение логина и пароля последнего пользователя!';

function GetIConfiguration(const AConfigurationFileName: string): IConfiguration;
begin
  Result := TConfiguration.Create(AConfigurationFileName);
end;

procedure TConfiguration.SetKeepLogTypes(const AValue: TLogMessagesTypes);
begin
  if FKeepLogTypes <> AValue then
    FKeepLogTypes := AValue;
end;

procedure TConfiguration.SetEnableLaunchAtStartup(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEnableLaunchAtStartup);
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

procedure TConfiguration.SetPhoneListFormPosition(const AValue: TDialogPosition);
begin
  if not FPhoneListFormPosition.Equals(AValue) then
  begin
    FPhoneListFormPosition.Assign(AValue);
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
      raise EConfiguration.Create
        ('Возникла ошибка при попытке получения пути рабочей папки программы!')
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

function TConfiguration.GetDBServer: IMySQLConnection;
begin
  if not Assigned(FDBServer) then
  begin
    FDBServer := GetIMySQLConnection;
  end;
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

function TConfiguration.GetMessageServer: IMySQLConnection;
begin
  if not Assigned(FMessageServer) then
  begin
    FMessageServer := GetIMySQLConnection;
  end;
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

function TConfiguration.GetPhoneListFormPosition: TDialogPosition;
begin
  Result := FPhoneListFormPosition;
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
var
  dialog_position: TDialogPosition;
begin
  inherited;
  // инициализация пеерменных класса
  CurrentPage := DEFAULT_CONFIGURATION_CURRENT_PAGE;
  OrganizationsSortedByColumn := DEFAULT_CONFIGURATION_ORGANIZATIONS_SORTED_BY_COLUMN;
  MeasuresSortedByColumn := DEFAULT_CONFIGURATION_MEASURES_SORTED_BY_COLUMN;

  // вкладка "настройки интерфейса"
  EnableSplashAtStart := DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
  EnableToolbar := DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
  EnableStatusbar := DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
  EnableEditboxHints := DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
  EnableCommonSearchEditbox := DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
  EnableID := DEFAULT_CONFIGURATION_ENABLE_ID;
  EnableMultibuffer := DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
  EnableQuitConfirmation := DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;

  // вкладка "настройки ведения протокола работы"
  EnableLog := DEFAULT_CONFIGURATION_ENABLE_LOG;
  KeepLogTypes := DEFAULT_CONFIGURATION_KEEP_LOG_TYPES;
  EnableFlushLogOnExit := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT;
  EnableFlushLogOnStringsQuantity := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY;
  EnableFlushLogOnStringsQuantityValue := DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE;
  EnableFlushLogOnClearingLog := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG;
  EnableFlushLogOnApply := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY;
  EnableCustomLogClient := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT;
  CustomLogClientValue := DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE;

  // вкладка "настройки положения диалоговых окон"
  dialog_position.Centered := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
  dialog_position.Left := DEFAULT_CONFIGURATION_DIALOG_LEFT;
  dialog_position.Top := DEFAULT_CONFIGURATION_DIALOG_TOP;
  LoginFormPosition := dialog_position;
  ConfigurationFormPosition := dialog_position;
  UsersFormPosition := dialog_position;
  SetPasswordFormPosition := dialog_position;
  ReportFormPosition := dialog_position;
  MaintenanceFormPosition := dialog_position;
  ClearingFormPosition := dialog_position;
  ViewMessagesFormPosition := dialog_position;
  CreateMessageFormPosition := dialog_position;
  ViewMessageFormPosition := dialog_position;
  PhoneListFormPosition := dialog_position;
  AddEditPhoneFormPosition := dialog_position;
  AddMassMsrFormPosition := dialog_position;
  PermissionsFormPosition := dialog_position;
  MultibufferFormPosition := dialog_position;

  // вкладка "настройки процедуры логирования"
  EnableStoreLogin := DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
  EnableStorePassword := DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
  StoredLogin := DEFAULT_CONFIGURATION_STORED_LOGIN;
  StoredPassword := DEFAULT_CONFIGURATION_STORED_PASSWORD;
  EnableAutoLogon := DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON;

  // вкладка "настройки подключения к серверу базы данных услуги"
  DBServer.Active := False;
  DBServer.LogProvider := nil;
  DBServer.Host := DEFAULT_CONFIGURATION_DBSERVER_HOST;
  DBServer.Port := DEFAULT_CONFIGURATION_DBSERVER_PORT;
  DBServer.Timeout := DEFAULT_CONFIGURATION_DBSERVER_TIMEOUT;
  DBServer.Compression := DEFAULT_CONFIGURATION_DBSERVER_COMPRESSION;
  DBServer.Login := DEFAULT_CONFIGURATION_DBSERVER_LOGIN;
  DBServer.Password := DEFAULT_CONFIGURATION_DBSERVER_PASSWORD;
  DBServer.Database := DEFAULT_CONFIGURATION_DBSERVER_DATABESE;

  // вкладка "настройки подключения к серверу системы обмена сообщениями"
  MessageServer.Active := False;
  MessageServer.LogProvider := nil;
  MessageServer.Host := DEFAULT_CONFIGURATION_MESSAGESERVER_HOST;
  MessageServer.Port := DEFAULT_CONFIGURATION_MESSAGESERVER_PORT;
  MessageServer.Timeout := DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT;
  MessageServer.Compression := DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION;
  MessageServer.Login := DEFAULT_CONFIGURATION_MESSAGESERVER_LOGIN;
  MessageServer.Password := DEFAULT_CONFIGURATION_MESSAGESERVER_PASSWORD;
  MessageServer.Database := DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE;

  // вкладка "настройки формирования отчётов"
  ReportFolderType := DEFAULT_CONFIGURATION_REPORT_FOLDER_TYPE;
  CustomReportFolderValue := DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE;
  EnableOverwriteConfirmation := DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
  EnableAskForFileName := DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;

  // вкладка "настройки прочие"
  EnableLaunchAtStartup := DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
  EnablePlaySoundOnComplete := DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
  EnableAutoGetMessages := DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES;
  AutoGetMessagesCycleDurationValue := DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE;
  EnableCustomHelpFile := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
  CustomHelpFileValue := DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE;

  // вкладка "настройки главного окна"
  MainFormLeft := DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
  MainFormTop := DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
  MainFormWidth := DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
  MainFormHeight := DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
  MainFormEnableCentered := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED;
  MainFormEnableFullScreenAtLaunch := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;

  // вкладка "настройки отображения информации"
  OrganizationPanelHeightValue := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE;
  OrganizationPanelEnableHalfHeight := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
  DataPanelWidthValue := DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE;
  DataPanelEnableHalfWidth := DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
  EnableDataInOtherInfoPanel := DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
  EnableMeasuresListAsRichEdit := DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
  EnableMarkSearchedStrings := DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS;
  EnablePutTownAtTheEnd := DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;
end;

procedure TConfiguration.SetAddEditPhoneFormPosition(const AValue: TDialogPosition);
begin
  if not FAddEditPhoneFormPosition.Equals(AValue) then
  begin
    FAddEditPhoneFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetAddMassMsrFormPosition(const AValue: TDialogPosition);
begin
  if not FAddMassMsrFormPosition.Equals(AValue) then
  begin
    FAddMassMsrFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetPermissionsFormPosition(const AValue: TDialogPosition);
begin
  if not FPermissionsFormPosition.Equals(AValue) then
  begin
    FPermissionsFormPosition.Assign(AValue);
  end;
end;

procedure TConfiguration.SetMultibufferFormPosition(const AValue: TDialogPosition);
begin
  if not FMultibufferFormPosition.Equals(AValue) then
  begin
    FMultibufferFormPosition.Assign(AValue);
  end;
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
      raise EConfiguration.Create(RsAutoLogonEnableError);
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

constructor TConfiguration.Create(const AConfigurationFileName: string);
begin
  inherited;
end;

procedure TConfiguration.Finalize;
begin
  inherited;
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

procedure TConfiguration.Loading;
begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
    begin
      // вкладка "настройки интерфейса"
      EnableSplashAtStart := ReadBool(RsInterface, 'EnableSplashAtStart',
        DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START);
      EnableToolbar := ReadBool(RsInterface, 'EnableToolbar', DEFAULT_CONFIGURATION_ENABLE_TOOLBAR);
      EnableStatusbar := ReadBool(RsInterface, 'EnableStatusbar',
        DEFAULT_CONFIGURATION_ENABLE_STATUSBAR);
      EnableEditboxHints := ReadBool(RsInterface, 'EnableEditboxHints',
        DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS);
      EnableCommonSearchEditbox := ReadBool(RsInterface, 'EnableCommonSearchEditbox',
        DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX);
      EnableID := ReadBool(RsInterface, 'EnableID', DEFAULT_CONFIGURATION_ENABLE_ID);
      EnableMultibuffer := ReadBool(RsInterface, 'EnableMultibuffer',
        DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER);
      EnableQuitConfirmation := ReadBool(RsInterface, 'EnableQuitConfirmation',
        DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION);

      // вкладка "настройки ведения протокола работы"
      EnableLog := ReadBool(RsLogging, 'EnableLog', DEFAULT_CONFIGURATION_ENABLE_LOG);
      EnableFlushLogOnExit := ReadBool(RsLogging, 'EnableFlushLogOnExit',
        DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT);
      EnableFlushLogOnStringsQuantity := ReadBool(RsLogging, 'EnableFlushLogOnStringsQuantity',
        DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY);
      EnableFlushLogOnStringsQuantityValue :=
        ReadInteger(RsLogging, 'EnableFlushLogOnStringsQuantityValue',
        DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE);
      EnableFlushLogOnClearingLog := ReadBool(RsLogging, 'EnableFlushLogOnClearingLog',
        DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG);
      EnableFlushLogOnApply := ReadBool(RsLogging, 'EnableFlushLogOnApply',
        DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY);
      EnableCustomLogClient := ReadBool(RsLogging, 'EnableCustomLogClient',
        DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT);
      CustomLogClientValue := ReadString(RsLogging, 'CustomLogClientValue',
        DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE);
      if ReadBool(RsLogging, 'KeepErrorLog', lmtError in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      begin
        KeepLogTypes := KeepLogTypes + [lmtError];
      end
      else
      begin
        KeepLogTypes := KeepLogTypes - [lmtError];
      end;
      if ReadBool(RsLogging, 'KeepWarningLog', lmtWarning in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES)
      then
      begin
        KeepLogTypes := KeepLogTypes + [lmtWarning];
      end
      else
      begin
        KeepLogTypes := KeepLogTypes - [lmtWarning];
      end;
      if ReadBool(RsLogging, 'KeepInfoLog', lmtInfo in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      begin
        KeepLogTypes := KeepLogTypes + [lmtInfo];
      end
      else
      begin
        KeepLogTypes := KeepLogTypes - [lmtInfo];
      end;
      if ReadBool(RsLogging, 'KeepSQLLog', lmtSQL in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      begin
        KeepLogTypes := KeepLogTypes + [lmtSQL];
      end
      else
      begin
        KeepLogTypes := KeepLogTypes - [lmtSQL];
      end;
      if ReadBool(RsLogging, 'KeepDebugLog', lmtDebug in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      begin
        KeepLogTypes := KeepLogTypes + [lmtDebug];
      end
      else
      begin
        KeepLogTypes := KeepLogTypes - [lmtDebug];
      end;

      // вкладка "настройки положения диалоговых окон"
      LoginFormPosition.Centered := ReadBool(RsDialogsPosition, 'LoginFormPosition.Centered',
        DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      LoginFormPosition.Left := ReadInteger(RsDialogsPosition, 'LoginFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      LoginFormPosition.Top := ReadInteger(RsDialogsPosition, 'LoginFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      ConfigurationFormPosition.Centered := ReadBool(RsDialogsPosition,
        'ConfigurationFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      ConfigurationFormPosition.Left := ReadInteger(RsDialogsPosition,
        'ConfigurationFormPosition.Left', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      ConfigurationFormPosition.Top := ReadInteger(RsDialogsPosition,
        'ConfigurationFormPosition.Top', DEFAULT_CONFIGURATION_DIALOG_TOP);

      UsersFormPosition.Centered := ReadBool(RsDialogsPosition, 'UsersFormPosition.Centered',
        DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      UsersFormPosition.Left := ReadInteger(RsDialogsPosition, 'UsersFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      UsersFormPosition.Top := ReadInteger(RsDialogsPosition, 'UsersFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      SetPasswordFormPosition.Centered := ReadBool(RsDialogsPosition,
        'SetPasswordFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      SetPasswordFormPosition.Left := ReadInteger(RsDialogsPosition, 'SetPasswordFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      SetPasswordFormPosition.Top := ReadInteger(RsDialogsPosition, 'SetPasswordFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      ReportFormPosition.Centered := ReadBool(RsDialogsPosition, 'ReportFormPosition.Centered',
        DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      ReportFormPosition.Left := ReadInteger(RsDialogsPosition, 'ReportFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      ReportFormPosition.Top := ReadInteger(RsDialogsPosition, 'ReportFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      MaintenanceFormPosition.Centered := ReadBool(RsDialogsPosition,
        'MaintenanceFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      MaintenanceFormPosition.Left := ReadInteger(RsDialogsPosition, 'MaintenanceFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      MaintenanceFormPosition.Top := ReadInteger(RsDialogsPosition, 'MaintenanceFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      ClearingFormPosition.Centered := ReadBool(RsDialogsPosition, 'ClearingFormPosition.Centered',
        DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      ClearingFormPosition.Left := ReadInteger(RsDialogsPosition, 'ClearingFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      ClearingFormPosition.Top := ReadInteger(RsDialogsPosition, 'ClearingFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      ViewMessagesFormPosition.Centered := ReadBool(RsDialogsPosition,
        'ViewMessagesFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      ViewMessagesFormPosition.Left := ReadInteger(RsDialogsPosition,
        'ViewMessagesFormPosition.Left', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      ViewMessagesFormPosition.Top := ReadInteger(RsDialogsPosition, 'ViewMessagesFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      CreateMessageFormPosition.Centered := ReadBool(RsDialogsPosition,
        'CreateMessageFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      CreateMessageFormPosition.Left := ReadInteger(RsDialogsPosition,
        'CreateMessageFormPosition.Left', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      CreateMessageFormPosition.Top := ReadInteger(RsDialogsPosition,
        'CreateMessageFormPosition.Top', DEFAULT_CONFIGURATION_DIALOG_TOP);

      ViewMessageFormPosition.Centered := ReadBool(RsDialogsPosition,
        'ViewMessageFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      ViewMessageFormPosition.Left := ReadInteger(RsDialogsPosition, 'ViewMessageFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      ViewMessageFormPosition.Top := ReadInteger(RsDialogsPosition, 'ViewMessageFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      PhoneListFormPosition.Centered := ReadBool(RsDialogsPosition,
        'PhoneListFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      PhoneListFormPosition.Left := ReadInteger(RsDialogsPosition, 'PhoneListFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      PhoneListFormPosition.Top := ReadInteger(RsDialogsPosition, 'PhoneListFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      AddEditPhoneFormPosition.Centered := ReadBool(RsDialogsPosition,
        'AddEditPhoneFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      AddEditPhoneFormPosition.Left := ReadInteger(RsDialogsPosition,
        'AddEditPhoneFormPosition.Left', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      AddEditPhoneFormPosition.Top := ReadInteger(RsDialogsPosition, 'AddEditPhoneFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      AddMassMsrFormPosition.Centered := ReadBool(RsDialogsPosition,
        'AddMassMsrFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      AddMassMsrFormPosition.Left := ReadInteger(RsDialogsPosition, 'AddMassMsrFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      AddMassMsrFormPosition.Top := ReadInteger(RsDialogsPosition, 'AddMassMsrFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      PermissionsFormPosition.Centered := ReadBool(RsDialogsPosition,
        'PermissionsFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      PermissionsFormPosition.Left := ReadInteger(RsDialogsPosition, 'PermissionsFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      PermissionsFormPosition.Top := ReadInteger(RsDialogsPosition, 'PermissionsFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      MultibufferFormPosition.Centered := ReadBool(RsDialogsPosition,
        'MultibufferFormPosition.Centered', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      MultibufferFormPosition.Left := ReadInteger(RsDialogsPosition, 'MultibufferFormPosition.Left',
        DEFAULT_CONFIGURATION_DIALOG_LEFT);
      MultibufferFormPosition.Top := ReadInteger(RsDialogsPosition, 'MultibufferFormPosition.Top',
        DEFAULT_CONFIGURATION_DIALOG_TOP);

      // вкладка "настройки процедуры логирования"
      EnableStoreLogin := ReadBool(RsIdentity, 'EnableStoreLogin',
        DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN);
      StoredLogin := ReadString(RsIdentity, 'StoredLogin', DEFAULT_CONFIGURATION_STORED_LOGIN);
      EnableStorePassword := ReadBool(RsIdentity, 'EnableStorePassword',
        DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD);
      StoredPassword := ReadString(RsIdentity, 'StoredPassword',
        DEFAULT_CONFIGURATION_STORED_PASSWORD);
      EnableAutoLogon := ReadBool(RsIdentity, 'EnableAutoLogon',
        DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON);

      // вкладка "подключения к серверу базы данных услуги"
      DBServer.Host := ReadString(RsServers, 'DBServer.Host', DEFAULT_CONFIGURATION_DBSERVER_HOST);
      DBServer.Port := ReadInteger(RsServers, 'DBServer.Port', DEFAULT_CONFIGURATION_DBSERVER_PORT);
      DBServer.Timeout := ReadInteger(RsServers, 'DBServer.Timeout',
        DEFAULT_CONFIGURATION_DBSERVER_TIMEOUT);
      DBServer.Compression := ReadBool(RsServers, 'DBServer.Compression',
        DEFAULT_CONFIGURATION_DBSERVER_COMPRESSION);
      DBServer.Login := ReadString(RsServers, 'DBServer.Login',
        DEFAULT_CONFIGURATION_DBSERVER_LOGIN);
      DBServer.Password := ReadString(RsServers, 'DBServer.Password',
        DEFAULT_CONFIGURATION_DBSERVER_PASSWORD);
      DBServer.Database := ReadString(RsServers, 'DBServer.Database',
        DEFAULT_CONFIGURATION_DBSERVER_DATABESE);

      // вкладка "подключения к серверу системы обмена сообщениями"
      MessageServer.Host := ReadString(RsServers, 'MessageServer.Host',
        DEFAULT_CONFIGURATION_MESSAGESERVER_HOST);
      MessageServer.Port := ReadInteger(RsServers, 'MessageServer.Port',
        DEFAULT_CONFIGURATION_MESSAGESERVER_PORT);
      MessageServer.Timeout := ReadInteger(RsServers, 'MessageServer.Timeout',
        DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT);
      MessageServer.Compression := ReadBool(RsServers, 'MessageServer.Compression',
        DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION);
      MessageServer.Login := ReadString(RsServers, 'MessageServer.Login',
        DEFAULT_CONFIGURATION_MESSAGESERVER_LOGIN);
      MessageServer.Password := ReadString(RsServers, 'MessageServer.Password',
        DEFAULT_CONFIGURATION_MESSAGESERVER_PASSWORD);
      MessageServer.Database := ReadString(RsServers, 'MessageServer.Database',
        DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE);

      // вкладка "настройки формирования отчётов"
      ReportFolderType := TReportFolder(ReadInteger(RsReports, 'ReportFolderType',
        Integer(DEFAULT_CONFIGURATION_REPORT_FOLDER_TYPE)));
      CustomReportFolderValue := ReadString(RsReports, 'CustomReportFolderValue',
        DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE);
      EnableOverwriteConfirmation := ReadBool(RsReports, 'EnableOverwriteConfirmation',
        DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION);
      EnableAskForFileName := ReadBool(RsReports, 'EnableAskForFileName',
        DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME);

      // вкладка "настройки прочие"
      EnableLaunchAtStartup := ReadBool(RsOther, 'EnableLaunchAtStartup',
        DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP);
      EnablePlaySoundOnComplete := ReadBool(RsOther, 'EnablePlaySoundOnComplete',
        DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE);
      EnableAutoGetMessages := ReadBool(RsOther, 'EnableAutoGetMessages',
        DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES);
      AutoGetMessagesCycleDurationValue := ReadInteger(RsOther, 'AutoGetMessagesCycleDurationValue',
        DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE);
      EnableCustomHelpFile := ReadBool(RsOther, 'EnableCustomHelpFile',
        DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE);
      CustomHelpFileValue := ReadString(RsOther, 'CustomHelpFileValue',
        DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE);

      // вкладка "настройки главного окна"
      MainFormLeft := ReadInteger(RsMainForm, 'MainFormLeft', DEFAULT_CONFIGURATION_MAIN_FORM_LEFT);
      MainFormTop := ReadInteger(RsMainForm, 'MainFormTop', DEFAULT_CONFIGURATION_MAIN_FORM_TOP);
      MainFormWidth := ReadInteger(RsMainForm, 'MainFormWidth',
        DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH);
      MainFormHeight := ReadInteger(RsMainForm, 'MainFormHeight',
        DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT);
      MainFormEnableCentered := ReadBool(RsMainForm, 'MainFormEnableCentered',
        DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED);
      MainFormEnableFullScreenAtLaunch := ReadBool(RsMainForm, 'MainFormEnableFullScreenAtLaunch',
        DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH);

      // вкладка "настройки отображения информации"
      OrganizationPanelHeightValue := ReadInteger(RsInfo, 'OrganizationPanelHeightValue',
        DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE);
      OrganizationPanelEnableHalfHeight := ReadBool(RsInfo, 'OrganizationPanelEnableHalfHeight',
        DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT);
      DataPanelWidthValue := ReadInteger(RsInfo, 'DataPanelWidthValue',
        DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE);
      DataPanelEnableHalfWidth := ReadBool(RsInfo, 'DataPanelEnableHalfWidth',
        DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH);
      EnableDataInOtherInfoPanel := ReadBool(RsInfo, 'EnableDataInOtherInfoPanel',
        DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL);
      EnableMeasuresListAsRichEdit := ReadBool(RsInfo, 'EnableMeasuresListAsRichEdit',
        DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT);
      EnableMarkSearchedStrings := ReadBool(RsInfo, 'EnableMarkSearchedStrings',
        DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS);
      EnablePutTownAtTheEnd := ReadBool(RsInfo, 'EnablePutTownAtTheEnd',
        DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END);

      // дополнительные настройки (не выводимые в окне конфигурации)
      OrganizationsSortedByColumn := ReadInteger(RsInfo, 'OrganizationsSortedByColumn',
        DEFAULT_CONFIGURATION_ORGANIZATIONS_SORTED_BY_COLUMN);
      MeasuresSortedByColumn := ReadInteger(RsInfo, 'MeasuresSortedByColumn',
        DEFAULT_CONFIGURATION_MEASURES_SORTED_BY_COLUMN);
    end;
  end;
end;

procedure TConfiguration.Saving;

  procedure WriteFormPosition(IniFile: TCustomIniFile; FormPosition: TDialogPosition;
    const FormPositionName: string);
  begin
    with IniFile do
    begin
      if FormPosition.Centered <> DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED then
      begin
        WriteBool(RsDialogsPosition, FormPositionName + '.Centered', FormPosition.Centered);
      end;
      if FormPosition.Left <> DEFAULT_CONFIGURATION_DIALOG_LEFT then
      begin
        WriteInteger(RsDialogsPosition, FormPositionName + '.Left', FormPosition.Left);
      end;
      if FormPosition.Top <> DEFAULT_CONFIGURATION_DIALOG_TOP then
      begin
        WriteInteger(RsDialogsPosition, FormPositionName + '.Top', FormPosition.Top);
      end;
    end;
  end;

begin
  inherited;
  if Assigned(IniFile) then
  begin
    with IniFile do
      try
        // вкладка "настройки интерфейса"
        if EnableSplashAtStart <> DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START then
        begin
          WriteBool(RsInterface, 'EnableSplashAtStart', EnableSplashAtStart);
        end;
        if EnableToolbar <> DEFAULT_CONFIGURATION_ENABLE_TOOLBAR then
        begin
          WriteBool(RsInterface, 'EnableToolbar', EnableToolbar);
        end;
        if EnableStatusbar <> DEFAULT_CONFIGURATION_ENABLE_STATUSBAR then
        begin
          WriteBool(RsInterface, 'EnableStatusbar', EnableStatusbar);
        end;
        if EnableEditboxHints <> DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS then
        begin
          WriteBool(RsInterface, 'EnableEditboxHints', EnableEditboxHints);
        end;
        if EnableCommonSearchEditbox <> DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX then
        begin
          WriteBool(RsInterface, 'EnableCommonSearchEditbox', EnableCommonSearchEditbox);
        end;
        if EnableID <> DEFAULT_CONFIGURATION_ENABLE_ID then
        begin
          WriteBool(RsInterface, 'EnableID', EnableID);
        end;
        if EnableMultibuffer <> DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER then
        begin
          WriteBool(RsInterface, 'EnableMultibuffer', EnableMultibuffer);
        end;
        if EnableQuitConfirmation <> DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION then
        begin
          WriteBool(RsInterface, 'EnableQuitConfirmation', EnableQuitConfirmation);
        end;

        // вкладка "настройки ведения протокола работы"
        if EnableLog <> DEFAULT_CONFIGURATION_ENABLE_LOG then
        begin
          WriteBool(RsLogging, 'EnableLog', EnableLog);
        end;
        if EnableFlushLogOnExit <> DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT then
        begin
          WriteBool(RsLogging, 'EnableFlushLogOnExit', EnableFlushLogOnExit);
        end;
        if EnableFlushLogOnStringsQuantity <> DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY
        then
        begin
          WriteBool(RsLogging, 'EnableFlushLogOnStringsQuantity', EnableFlushLogOnStringsQuantity);
        end;
        if EnableFlushLogOnStringsQuantityValue <> DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE
        then
        begin
          WriteInteger(RsLogging, 'EnableFlushLogOnStringsQuantityValue',
            EnableFlushLogOnStringsQuantityValue);
        end;
        if EnableFlushLogOnClearingLog <> DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG
        then
        begin
          WriteBool(RsLogging, 'EnableFlushLogOnClearingLog', EnableFlushLogOnClearingLog);
        end;
        if EnableFlushLogOnApply <> DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY then
        begin
          WriteBool(RsLogging, 'EnableFlushLogOnApply', EnableFlushLogOnApply);
        end;
        if EnableCustomLogClient <> DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT then
        begin
          WriteBool(RsLogging, 'EnableCustomLogClient', EnableCustomLogClient);
        end;
        if CustomLogClientValue <> DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE then
        begin
          WriteString(RsLogging, 'CustomLogClientValue', CustomLogClientValue);
        end;
        if (lmtError in KeepLogTypes) <> (lmtError in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
        begin
          WriteBool(RsLogging, 'KeepErrorLog', lmtError in KeepLogTypes);
        end;
        if (lmtWarning in KeepLogTypes) <> (lmtWarning in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
        begin
          WriteBool(RsLogging, 'KeepWarningLog', lmtWarning in KeepLogTypes);
        end;
        if (lmtInfo in KeepLogTypes) <> (lmtInfo in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
        begin
          WriteBool(RsLogging, 'KeepInfoLog', lmtInfo in KeepLogTypes);
        end;
        if (lmtSQL in KeepLogTypes) <> (lmtSQL in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
        begin
          WriteBool(RsLogging, 'KeepSQLLog', lmtSQL in KeepLogTypes);
        end;
        if (lmtDebug in KeepLogTypes) <> (lmtDebug in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
        begin
          WriteBool(RsLogging, 'KeepDebugLog', lmtDebug in KeepLogTypes);
        end;

        // вкладка "настройки положения диалоговых окон"
        WriteFormPosition(IniFile, LoginFormPosition, 'LoginFormPosition');
        WriteFormPosition(IniFile, ConfigurationFormPosition, 'ConfigurationFormPosition');
        WriteFormPosition(IniFile, UsersFormPosition, 'UsersFormPosition');
        WriteFormPosition(IniFile, SetPasswordFormPosition, 'SetPasswordFormPosition');
        WriteFormPosition(IniFile, ReportFormPosition, 'ReportFormPosition');
        WriteFormPosition(IniFile, MaintenanceFormPosition, 'MaintenanceFormPosition');
        WriteFormPosition(IniFile, ClearingFormPosition, 'ClearingFormPosition');
        WriteFormPosition(IniFile, ViewMessagesFormPosition, 'ViewMessagesFormPosition');
        WriteFormPosition(IniFile, CreateMessageFormPosition, 'CreateMessageFormPosition');
        WriteFormPosition(IniFile, ViewMessageFormPosition, 'ViewMessageFormPosition');
        WriteFormPosition(IniFile, PhoneListFormPosition, 'PhoneListFormPosition');
        WriteFormPosition(IniFile, AddEditPhoneFormPosition, 'AddEditPhoneFormPosition');
        WriteFormPosition(IniFile, AddMassMsrFormPosition, 'AddMassMsrFormPosition');
        WriteFormPosition(IniFile, PermissionsFormPosition, 'PermissionsFormPosition');
        WriteFormPosition(IniFile, MultibufferFormPosition, 'MultibufferFormPosition');

        // вкладка "настройки процедуры логирования"
        if EnableStoreLogin <> DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN then
        begin
          WriteBool(RsIdentity, 'EnableStoreLogin', EnableStoreLogin);
          if EnableStoreLogin then
          begin
            if StoredLogin <> DEFAULT_CONFIGURATION_STORED_LOGIN then
            begin
              WriteString(RsIdentity, 'StoredLogin', StoredLogin);
              if EnableStorePassword <> DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD then
              begin
                WriteBool(RsIdentity, 'EnableStorePassword', EnableStorePassword);
                if EnableStorePassword then
                begin
                  if StoredPassword <> DEFAULT_CONFIGURATION_STORED_PASSWORD then
                  begin
                    WriteString(RsIdentity, 'StoredPassword', StoredPassword);
                    if EnableAutoLogon <> DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON then
                    begin
                      WriteBool(RsIdentity, 'EnableAutoLogon', EnableAutoLogon);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;

        // вкладка "подключения к серверу базы данных услуги"
        if DBServer.Host <> DEFAULT_CONFIGURATION_DBSERVER_HOST then
        begin
          WriteString(RsServers, 'DBServer.Host', DBServer.Host);
        end;
        if DBServer.Port <> DEFAULT_CONFIGURATION_DBSERVER_PORT then
        begin
          WriteInteger(RsServers, 'DBServer.Port', DBServer.Port);
        end;
        if DBServer.Timeout <> DEFAULT_CONFIGURATION_DBSERVER_TIMEOUT then
        begin
          WriteInteger(RsServers, 'DBServer.Timeout', DBServer.Timeout);
        end;
        if DBServer.Compression <> DEFAULT_CONFIGURATION_DBSERVER_COMPRESSION then
        begin
          WriteBool(RsServers, 'DBServer.Compression', DBServer.Compression);
        end;
        if DBServer.Login <> DEFAULT_CONFIGURATION_DBSERVER_LOGIN then
        begin
          WriteString(RsServers, 'DBServer.Login', DBServer.Login);
        end;
        if DBServer.Password <> DEFAULT_CONFIGURATION_DBSERVER_PASSWORD then
        begin
          WriteString(RsServers, 'DBServer.Password', DBServer.Password);
        end;
        if DBServer.Database <> DEFAULT_CONFIGURATION_DBSERVER_DATABESE then
        begin
          WriteString(RsServers, 'DBServer.Database', DBServer.Database);
        end;

        // вкладка "подключения к серверу системы обмена сообщениями"
        if MessageServer.Host <> DEFAULT_CONFIGURATION_MESSAGESERVER_HOST then
        begin
          WriteString(RsServers, 'MessageServer.Host', MessageServer.Host);
        end;
        if MessageServer.Port <> DEFAULT_CONFIGURATION_MESSAGESERVER_PORT then
        begin
          WriteInteger(RsServers, 'MessageServer.Port', MessageServer.Port);
        end;
        if MessageServer.Timeout <> DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT then
        begin
          WriteInteger(RsServers, 'MessageServer.Timeout', MessageServer.Timeout);
        end;
        if MessageServer.Compression <> DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION then
        begin
          WriteBool(RsServers, 'MessageServer.Compression', MessageServer.Compression);
        end;
        if MessageServer.Login <> DEFAULT_CONFIGURATION_MESSAGESERVER_LOGIN then
        begin
          WriteString(RsServers, 'MessageServer.Login', MessageServer.Login);
        end;
        if MessageServer.Password <> DEFAULT_CONFIGURATION_MESSAGESERVER_PASSWORD then
        begin
          WriteString(RsServers, 'MessageServer.Password', MessageServer.Password);
        end;
        if MessageServer.Database <> DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE then
        begin
          WriteString(RsServers, 'MessageServer.Database', MessageServer.Database);
        end;

        // вкладка "настройки формирования отчётов"
        if ReportFolderType <> DEFAULT_CONFIGURATION_REPORT_FOLDER_TYPE then
        begin
          WriteInteger(RsReports, 'ReportFolderType', Integer(ReportFolderType));
        end;
        if CustomReportFolderValue <> DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE then
        begin
          WriteString(RsReports, 'CustomReportFolderValue', CustomReportFolderValue);
        end;
        if EnableOverwriteConfirmation <> DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION then
        begin
          WriteBool(RsReports, 'EnableOverwriteConfirmation', EnableOverwriteConfirmation);
        end;
        if EnableAskForFileName <> DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME then
        begin
          WriteBool(RsReports, 'EnableAskForFileName', EnableAskForFileName);
        end;

        // вкладка "настройки прочие"
        if EnableLaunchAtStartup <> DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP then
        begin
          WriteBool(RsOther, 'EnableLaunchAtStartup', EnableLaunchAtStartup);
        end;
        if EnablePlaySoundOnComplete <> DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE then
        begin
          WriteBool(RsOther, 'EnablePlaySoundOnComplete', EnablePlaySoundOnComplete);
        end;
        if EnableAutoGetMessages <> DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGES then
        begin
          WriteBool(RsOther, 'EnableAutoGetMessages', EnableAutoGetMessages);
        end;
        if AutoGetMessagesCycleDurationValue <> DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE
        then
        begin
          WriteInteger(RsOther, 'AutoGetMessagesCycleDurationValue',
            AutoGetMessagesCycleDurationValue);
        end;
        if EnableCustomHelpFile <> DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE then
        begin
          WriteBool(RsOther, 'EnableCustomHelpFile', EnableCustomHelpFile);
        end;
        if CustomHelpFileValue <> DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE then
        begin
          WriteString(RsOther, 'CustomHelpFileValue', CustomHelpFileValue);
        end;

        // вкладка "настройки главного окна"
        if MainFormLeft <> DEFAULT_CONFIGURATION_MAIN_FORM_LEFT then
        begin
          WriteInteger(RsMainForm, 'MainFormLeft', MainFormLeft);
        end;
        if MainFormTop <> DEFAULT_CONFIGURATION_MAIN_FORM_TOP then
        begin
          WriteInteger(RsMainForm, 'MainFormTop', MainFormTop);
        end;
        if MainFormWidth <> DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH then
        begin
          WriteInteger(RsMainForm, 'MainFormWidth', MainFormWidth);
        end;
        if MainFormHeight <> DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT then
        begin
          WriteInteger(RsMainForm, 'MainFormHeight', MainFormHeight);
        end;
        if MainFormEnableCentered <> DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_CENTERED then
        begin
          WriteBool(RsMainForm, 'MainFormEnableCentered', MainFormEnableCentered);
        end;
        if MainFormEnableFullScreenAtLaunch <> DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH
        then
        begin
          WriteBool(RsMainForm, 'MainFormEnableFullScreenAtLaunch',
            MainFormEnableFullScreenAtLaunch);
        end;

        // вкладка "настройки отображения информации"
        if OrganizationPanelHeightValue <> DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE
        then
        begin
          WriteInteger(RsInfo, 'OrganizationPanelHeightValue', OrganizationPanelHeightValue);
        end;
        if OrganizationPanelEnableHalfHeight <> DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT
        then
        begin
          WriteBool(RsInfo, 'OrganizationPanelEnableHalfHeight', OrganizationPanelEnableHalfHeight);
        end;
        if DataPanelWidthValue <> DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE then
        begin
          WriteInteger(RsInfo, 'DataPanelWidthValue', DataPanelWidthValue);
        end;
        if OrganizationPanelEnableHalfHeight <> DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT
        then
        begin
          WriteBool(RsInfo, 'OrganizationPanelEnableHalfHeight', OrganizationPanelEnableHalfHeight);
        end;
        if EnableDataInOtherInfoPanel <> DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL then
        begin
          WriteBool(RsInfo, 'EnableDataInOtherInfoPanel', EnableDataInOtherInfoPanel);
        end;
        if EnableMeasuresListAsRichEdit <> DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT
        then
        begin
          WriteBool(RsInfo, 'EnableMeasuresListAsRichEdit', EnableMeasuresListAsRichEdit);
        end;
        if EnableMarkSearchedStrings <> DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRINGS then
        begin
          WriteBool(RsInfo, 'EnableMarkSearchedStrings', EnableMarkSearchedStrings);
        end;
        if EnablePutTownAtTheEnd <> DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END then
        begin
          WriteBool(RsInfo, 'EnablePutTownAtTheEnd', EnablePutTownAtTheEnd);
        end;

        // дополнительные настройки (не выводимые в окне конфигурации)
        if OrganizationsSortedByColumn <> DEFAULT_CONFIGURATION_ORGANIZATIONS_SORTED_BY_COLUMN then
        begin
          WriteInteger(RsInfo, 'OrganizationsSortedByColumn', OrganizationsSortedByColumn);
        end;
        if MeasuresSortedByColumn <> DEFAULT_CONFIGURATION_MEASURES_SORTED_BY_COLUMN then
        begin
          WriteInteger(RsInfo, 'MeasuresSortedByColumn', MeasuresSortedByColumn);
        end;
      except
        on EIniFileException do
        begin
          raise EIniFileException.Create(RsConfigurationSaveError);
        end;
      end;
  end;
end;

initialization

begin
  System.Classes.RegisterClass(TConfiguration);
end;

end.
