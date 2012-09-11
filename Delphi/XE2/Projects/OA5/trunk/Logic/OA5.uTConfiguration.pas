unit OA5.uTConfiguration;

interface

uses
  System.Types,
  System.IniFiles,
  CastersPackage.uLogKeeperData,
  CastersPackage.uMysql,
  CastersPackage.uTIniFileDataStorage,
  OA5.uTMySQLConnection,
  CastersPackage.uTDialogPosition,
  OA5.uDefaultConsts,
  CastersPackage.uTReportFolder,
  CastersPackage.uTLogMessagesType,
  CastersPackage.uTLogMessagesTypes;

type
  TConfiguration = class(TIniFileDataStorage)
  strict private
    FFileName: string;
    FConfigurationFormPage: Integer;
    FLogin: string;
    FPassword: string;

    // вкладка "настройки интерфейса"
    FShowSplashAtStart: Boolean; // Отображать окно "О программе..." при запуске
    FShowToolbar: Boolean; // Отображать панель кнопок
    FShowStatusbar: Boolean; // Отображать панель статуса
    FShowEditboxHints: Boolean; // Отображать всплывающие подсказки для полей ввода
    FShowCommonSearchEditbox: Boolean; // Отображать единое поле ввода для поиска данных
    FShowID: Boolean; // Отображать поле ID записей базы данных при работе программы
    FUseMultibuffer: Boolean; // Использовать мультибуфер для операций копирования мероприятий
    FShowConfirmationOnQuit: Boolean; // Требовать подтверждение при выходе из программы

    // вкладка "настройки ведения протокола работы"
    FEnableLog: Boolean; // Вести лог работы программы
    FKeepLogTypes: TLogMessagesTypes; // выводить сообщения перечисленных типов
    FFlushLogOnExit: Boolean; // Сбрасывать протокол работы в текстовый файл при завершении работы программы
    FFlushLogOnStringsQuantity: Boolean; // Сбрасывать протокол работы в текстовый файл при достижении количества строк
    FFlushLogOnStringsQuantityValue: Integer;
    // Сбрасывать протокол работы в текстовый файл при достижении количества строк (непосредственно количество)
    FFlushLogOnClearingLog: Boolean; // Сбрасывать протокол работы в текстовый файл при операции очистки протокола
    FFlushLogOnApply: Boolean; // Сбрасывать протокол работы в текстовый файл при нажатии кнопки "Применить"
    FCustomLogClientFile: Boolean; // Использовать внешний клиент протоколирования
    FCustomLogClientFileValue: string; // имя файла внешнего клиента протоколирования

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

    // вкладка "настройки процедуры логирования"
    FStoreLogin: Boolean; // Сохранять логин последнего пользователя
    FStorePassword: Boolean; // Сохранять пароль последнего пользователя
    FAutoLogon: Boolean; // Выполнять автоматический вход, используя сохранённые логин и пароль пользователя

    // вкладка "настройки подключения к серверу базы данных услуги"
    FRNE4Server: TMySQLConnection;

    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    FMessagesServer: TMySQLConnection;

    // вкладка "настройки формирования отчётов"
    FReportFolder: TReportFolder; //
    FCustomReportFolderValue: string; //
    FDontDemandOverwriteConfirmation: Boolean; //
    FAskForFileName: Boolean; //

    // вкладка "настройки списка автозамены"

    // вкладка "настройки прочие"
    FLaunchAtStartup: Boolean;
    FPlaySoundOnComplete: Boolean;
    FEnableAutoGetMessages: Boolean;
    FAutoGetMessagesCycleDurationValue: Integer;
    FCustomHelpFile: Boolean;
    FCustomHelpFileValue: string;

    // вкладка "настройки главного окна"
    FMainFormLeft: Integer;
    FMainFormTop: Integer;
    FMainFormWidth: Integer;
    FMainFormHeight: Integer;
    FMainFormPositionByCenter: Boolean;
    FFullScreenAtLaunch: Boolean;

    // вкладка "настройки отображения информации"
    FOrganizationPanelHeightValue: Integer; // Высота панели организаций
    FOrganizationPanelHalfHeight: Boolean; // половина высоты окна
    FDataPanelWidthValue: Integer; // Ширина панели данных
    FDataPanelHalfWidth: Boolean; // половина ширины окна
    FShowDataInOtherInfoPanel: Boolean; // В режиме просмотра показывать данные в окне прочей информации
    FShowMeasuresListAsRichEdit: Boolean; // В режиме просмотра объединять меропрятия в общий спиcок
    FMarkSearchedStrings: Boolean; // В режиме просмотра выделять искомые фрагменты строк
    FPutTownAtTheEnd: Boolean; // Поместить название города в конец строки адреса

    procedure SetUseLog(const Value: Boolean);
    procedure SetStoreLogin(const Value: Boolean);
    procedure SetStorePassword(const Value: Boolean);
    procedure SetAutoLogon(const Value: Boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    function GetTempFolder: string;
    function GetApplicationFolder: string;
    function GetReportFolderValue: string;
    procedure SetFileName(const Value: string);
    procedure SetAddEditPhoneFormPosition(const AValue: TDialogPosition);
    procedure SetAddMassMsrFormPosition(const AValue: TDialogPosition);
    procedure SetPermissionsFormPosition(const AValue: TDialogPosition);
    procedure SetMultibufferFormPosition(const AValue: TDialogPosition);
    procedure SetAskForFileName(const Value: Boolean);
    procedure SetAutoGetMessagesCycleDurationValue(const Value: Integer);
    procedure SetClearingFormPosition(const AValue: TDialogPosition);
    procedure SetCustomHelpFile(const Value: Boolean);
    procedure SetCustomHelpFileValue(const Value: string);
    procedure SetCustomLogClientFile(const Value: Boolean);
    procedure SetCustomLogClientFileValue(const Value: string);
    procedure SetDataPanelHalfWidth(const Value: Boolean);
    procedure SetDataPanelWidthValue(const Value: Integer);
    procedure SetDontDemandOverwriteConfirmation(const Value: Boolean);
    procedure SetEnableAutoGetMessages(const Value: Boolean);
    procedure SetFlushLogOnApply(const Value: Boolean);
    procedure SetFlushLogOnClearingLog(const Value: Boolean);
    procedure SetFlushLogOnExit(const Value: Boolean);
    procedure SetFlushLogOnStringsQuantity(const Value: Boolean);
    procedure SetFlushLogOnStringsQuantityValue(const Value: Integer);
    procedure SetFullScreenAtLaunch(const Value: Boolean);
    procedure SetLaunchAtStartup(const Value: Boolean);
    procedure SetLoginFormPosition(const AValue: TDialogPosition);
    procedure SetMainFormPositionByCenter(const Value: Boolean);
    procedure SetMaintenanceFormPosition(const AValue: TDialogPosition);
    procedure SetMarkSearchedStrings(const Value: Boolean);
    procedure SetMessagesServer(const Value: TMySQLConnection);
    procedure SetConfigurationFormPosition(const AValue: TDialogPosition);
    procedure SetOrganizationPanelHalfHeight(const Value: Boolean);
    procedure SetOrganizationPanelHeightValue(const Value: Integer);
    procedure SetPhonesFormPosition(const AValue: TDialogPosition);
    procedure SetPlaySoundOnComplete(const Value: Boolean);
    procedure SetPutTownAtTheEnd(const Value: Boolean);
    procedure SetReportFolder(const AValue: TReportFolder);
    procedure SetRNE4Server(const Value: TMySQLConnection);
    procedure SetCustomReportFolderValue(const Value: string);
    procedure SetSetPasswordFormPosition(const AValue: TDialogPosition);
    procedure SetShowSplashAtStart(const Value: Boolean);
    procedure SetShowCommonSearchEditbox(const Value: Boolean);
    procedure SetShowConfirmationOnQuit(const Value: Boolean);
    procedure SetShowDataInOtherInfoPanel(const Value: Boolean);
    procedure SetShowEditboxHints(const Value: Boolean);
    procedure SetShowID(const Value: Boolean);
    procedure SetShowMeasuresListAsRichEdit(const Value: Boolean);
    procedure SetShowStatusbar(const Value: Boolean);
    procedure SetShowToolbar(const Value: Boolean);
    procedure SetReportFormPosition(const AValue: TDialogPosition);
    procedure SetUseMultibuffer(const Value: Boolean);
    procedure SetUsersFormPosition(const AValue: TDialogPosition);
    procedure SetViewMessagesFormPosition(const AValue: TDialogPosition);
    procedure SetMainFormHeight(const Value: Integer);
    procedure SetMainFormLeft(const Value: Integer);
    procedure SetMainFormTop(const Value: Integer);
    procedure SetMainFormWidth(const Value: Integer);
    procedure SetCreateMessageFormPosition(const AValue: TDialogPosition);
    procedure SetViewMessageFormPosition(const AValue: TDialogPosition);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
  strict protected
    procedure Loading(const AIniFile: TCustomIniFile); override;
    procedure Saving(const AIniFile: TCustomIniFile); override;
    procedure AfterLoad; override;
    procedure BeforeSave; override;
    procedure Initialize; override;
    procedure Finalize; override;
  public
    // sDefaultAction: string;
    // bImmediatelyQuit: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;

    destructor Destroy; override;

    property FileName: string read FFileName write SetFileName stored False;
    property ConfigurationFormPage: Integer read FConfigurationFormPage write FConfigurationFormPage default 0;

    // вкладка "настройки интерфейса"
    property ShowSplashAtStart: Boolean read FShowSplashAtStart write SetShowSplashAtStart default DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
    property ShowToolbar: Boolean read FShowToolbar write SetShowToolbar default DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
    property ShowStatusbar: Boolean read FShowStatusbar write SetShowStatusbar default DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
    property ShowEditboxHints: Boolean read FShowEditboxHints write SetShowEditboxHints default DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
    property ShowCommonSearchEditbox: Boolean read FShowCommonSearchEditbox write SetShowCommonSearchEditbox default DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
    property ShowID: Boolean read FShowID write SetShowID default DEFAULT_CONFIGURATION_ENABLE_ID;
    property UseMultibuffer: Boolean read FUseMultibuffer write SetUseMultibuffer default DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
    property ShowConfirmationOnQuit: Boolean read FShowConfirmationOnQuit write SetShowConfirmationOnQuit default DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;

    // вкладка "настройки ведения протокола работы"
    property EnableLog: Boolean read FEnableLog write SetUseLog default DEFAULT_CONFIGURATION_ENABLE_LOG;
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default DEFAULT_CONFIGURATION_KEEP_LOG_TYPES;
    property FlushLogOnExit: Boolean read FFlushLogOnExit write SetFlushLogOnExit default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT;
    property FlushLogOnStringsQuantity: Boolean read FFlushLogOnStringsQuantity write SetFlushLogOnStringsQuantity default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY;
    property FlushLogOnStringsQuantityValue: Integer read FFlushLogOnStringsQuantityValue write SetFlushLogOnStringsQuantityValue default DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE;
    property FlushLogOnClearingLog: Boolean read FFlushLogOnClearingLog write SetFlushLogOnClearingLog default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG;
    property FlushLogOnApply: Boolean read FFlushLogOnApply write SetFlushLogOnApply default DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY;
    property CustomLogClientFile: Boolean read FCustomLogClientFile write SetCustomLogClientFile default DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT;
    property CustomLogClientFileValue: string read FCustomLogClientFileValue write SetCustomLogClientFileValue nodefault;

    // вкладка "настройки положения диалоговых окон"
    property LoginFormPosition: TDialogPosition read FLoginFormPosition write SetLoginFormPosition stored False;
    property ConfigurationFormPosition: TDialogPosition read FConfigurationFormPosition write SetConfigurationFormPosition stored False;
    property UsersFormPosition: TDialogPosition read FUsersFormPosition write SetUsersFormPosition stored False;
    property SetPasswordFormPosition: TDialogPosition read FSetPasswordFormPosition write SetSetPasswordFormPosition stored False;
    property ReportFormPosition: TDialogPosition read FReportFormPosition write SetReportFormPosition stored False;
    property MaintenanceFormPosition: TDialogPosition read FMaintenanceFormPosition write SetMaintenanceFormPosition stored False;
    property ClearingFormPosition: TDialogPosition read FClearingFormPosition write SetClearingFormPosition stored False;
    property ViewMessagesFormPosition: TDialogPosition read FViewMessagesFormPosition write SetViewMessagesFormPosition stored False;
    property CreateMessageFormPosition: TDialogPosition read FCreateMessageFormPosition write SetCreateMessageFormPosition stored False;
    property ViewMessageFormPosition: TDialogPosition read FViewMessageFormPosition write SetViewMessageFormPosition stored False;
    property PhonesFormPosition: TDialogPosition read FPhonesFormPosition write SetPhonesFormPosition stored False;
    property AddEditPhoneFormPosition: TDialogPosition read FAddEditPhoneFormPosition write SetAddEditPhoneFormPosition stored False;
    property AddMassMsrFormPosition: TDialogPosition read FAddMassMsrFormPosition write SetAddMassMsrFormPosition stored False;
    property PermissionsFormPosition: TDialogPosition read FPermissionsFormPosition write SetPermissionsFormPosition stored False;
    property MultibufferFormPosition: TDialogPosition read FMultibufferFormPosition write SetMultibufferFormPosition stored False;

    // вкладка "настройки процедуры логирования"
    property StoreLogin: Boolean read FStoreLogin write SetStoreLogin default DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
    // нужно ли хранить последний введённый логин
    property Login: string read FLogin write SetLogin stored False;
    property StorePassword: Boolean read FStorePassword write SetStorePassword default DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
    // нужно ли хранить последний введённый пароль
    property Password: string read FPassword write SetPassword stored False;
    property AutoLogon: Boolean read FAutoLogon write SetAutoLogon default DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON;
    // нужно ли выполнять автологирование

    // вкладка "настройки подключения к серверу базы данных услуги"
    property RNE4Server: TMySQLConnection read FRNE4Server write SetRNE4Server stored False;

    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    property MessagesServer: TMySQLConnection read FMessagesServer write SetMessagesServer stored False;

    // вкладка "настройки формирования отчётов"
    property ReportFolder: TReportFolder read FReportFolder write SetReportFolder default DEFAULT_CONFIGURATION_REPORT_FOLDER;
    property ReportFolderValue: string read GetReportFolderValue stored False;
    property CustomReportFolderValue: string read FCustomReportFolderValue write SetCustomReportFolderValue stored False;
    property DontDemandOverwriteConfirmation: Boolean read FDontDemandOverwriteConfirmation write SetDontDemandOverwriteConfirmation default DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
    property AskForFileName: Boolean read FAskForFileName write SetAskForFileName default DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;

    // вкладка "настройки прочие"
    property LaunchAtStartup: Boolean read FLaunchAtStartup write SetLaunchAtStartup default DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
    property PlaySoundOnComplete: Boolean read FPlaySoundOnComplete write SetPlaySoundOnComplete default DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
    property EnableAutoGetMessages: Boolean read FEnableAutoGetMessages write SetEnableAutoGetMessages default DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGE;
    property AutoGetMessagesCycleDurationValue: Integer read FAutoGetMessagesCycleDurationValue write SetAutoGetMessagesCycleDurationValue
      default DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE;
    property CustomHelpFile: Boolean read FCustomHelpFile write SetCustomHelpFile default DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
    property CustomHelpFileValue: string read FCustomHelpFileValue write SetCustomHelpFileValue stored False;

    // вкладка "настройки главного окна"
    property MainFormLeft: Integer read FMainFormLeft write SetMainFormLeft default DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
    property MainFormTop: Integer read FMainFormTop write SetMainFormTop default DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
    property MainFormWidth: Integer read FMainFormWidth write SetMainFormWidth default DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
    property MainFormHeight: Integer read FMainFormHeight write SetMainFormHeight default DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
    property MainFormPositionByCenter: Boolean read FMainFormPositionByCenter write SetMainFormPositionByCenter default DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_POSITION_BY_CENTER;
    property FullScreenAtLaunch: Boolean read FFullScreenAtLaunch write SetFullScreenAtLaunch default DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;

    // вкладка "настройки отображения информации"
    property OrganizationPanelHeightValue: Integer read FOrganizationPanelHeightValue write SetOrganizationPanelHeightValue default DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE;
    property OrganizationPanelHalfHeight: Boolean read FOrganizationPanelHalfHeight write SetOrganizationPanelHalfHeight default DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
    property DataPanelWidthValue: Integer read FDataPanelWidthValue write SetDataPanelWidthValue default DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE;
    property DataPanelHalfWidth: Boolean read FDataPanelHalfWidth write SetDataPanelHalfWidth default DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
    property ShowDataInOtherInfoPanel: Boolean read FShowDataInOtherInfoPanel write SetShowDataInOtherInfoPanel default DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
    property ShowMeasuresListAsRichEdit: Boolean read FShowMeasuresListAsRichEdit write SetShowMeasuresListAsRichEdit default DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
    property MarkSearchedStrings: Boolean read FMarkSearchedStrings write SetMarkSearchedStrings default DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRING;
    property PutTownAtTheEnd: Boolean read FPutTownAtTheEnd write SetPutTownAtTheEnd default DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;
  end;

implementation

uses
  Vcl.Controls,
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Forms;

resourcestring
  TEXT_INIFILESECTION_INTERFACE = 'Интерфейс';
  TEXT_INIFILESECTION_LOGS = 'Протоколирование';
  TEXT_INIFILESECTION_DIALOGS_POSITION = 'Положение диалоговых окон';
  TEXT_INIFILESECTION_IDENTIFICATION = 'Идентификация';
  TEXT_INIFILESECTION_SERVERS = 'Сервера и базы данных';
  TEXT_INIFILESECTION_REPORTS = 'Формирование отчётов';
  TEXT_INIFILESECTION_OTHER = 'Прочие';
  TEXT_INIFILESECTION_MAINFORM = 'Главное окно';
  TEXT_INIFILESECTION_INFO = 'Отображение информации';

procedure TConfiguration.Loading(const AIniFile: TCustomIniFile);
var
  FormPosition: TDialogPosition;
begin
  inherited;
  with AIniFile do
  begin
    // вкладка "настройки интерфейса"
    ShowSplashAtStart := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowSplashAtStart', DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START);
    ShowToolbar := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowToolbar', DEFAULT_CONFIGURATION_ENABLE_TOOLBAR);
    ShowStatusbar := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowStatusbar', DEFAULT_CONFIGURATION_ENABLE_STATUSBAR);
    ShowEditboxHints := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowEditboxHints', DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS);
    ShowCommonSearchEditbox := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowCommonSearchEditbox', DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX);
    ShowID := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowID', DEFAULT_CONFIGURATION_ENABLE_ID);
    UseMultibuffer := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bUseMultibuffer', DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER);
    ShowConfirmationOnQuit := ReadBool(TEXT_INIFILESECTION_INTERFACE, 'bShowConfirmationOnQuit', DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION);

    // вкладка "настройки ведения протокола работы"
    EnableLog := ReadBool(TEXT_INIFILESECTION_LOGS, 'bEnableLog', DEFAULT_CONFIGURATION_ENABLE_LOG);
    FlushLogOnExit := ReadBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnExit', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT);
    FlushLogOnStringsQuantity := ReadBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnStringsQuantity', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY);
    FlushLogOnStringsQuantityValue := ReadInteger(TEXT_INIFILESECTION_LOGS, 'iFlushLogOnStringsQuantityValue', DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE);
    FlushLogOnClearingLog := ReadBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnClearingLog', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG);
    FlushLogOnApply := ReadBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnApply', DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY);
    CustomLogClientFile := ReadBool(TEXT_INIFILESECTION_LOGS, 'bCustomLogClientFile', DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT);
    CustomLogClientFileValue := ReadString(TEXT_INIFILESECTION_LOGS, 'sCustomLogClientFileValue', DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE);
    if ReadBool(TEXT_INIFILESECTION_LOGS, 'bKeepErrorLog', lmtError in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtError]
    else
      KeepLogTypes := KeepLogTypes - [lmtError];
    if ReadBool(TEXT_INIFILESECTION_LOGS, 'bKeepWarningLog', lmtWarning in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtWarning]
    else
      KeepLogTypes := KeepLogTypes - [lmtWarning];
    if ReadBool(TEXT_INIFILESECTION_LOGS, 'bKeepInfoLog', lmtInfo in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtInfo]
    else
      KeepLogTypes := KeepLogTypes - [lmtInfo];
    if ReadBool(TEXT_INIFILESECTION_LOGS, 'bKeepSQLLog', lmtSQL in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtSQL]
    else
      KeepLogTypes := KeepLogTypes - [lmtSQL];
    if ReadBool(TEXT_INIFILESECTION_LOGS, 'bKeepDebugLog', lmtDebug in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) then
      KeepLogTypes := KeepLogTypes + [lmtDebug]
    else
      KeepLogTypes := KeepLogTypes - [lmtDebug];

    // вкладка "настройки положения диалоговых окон"
    with FormPosition do
    begin
      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'LoginFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'LoginFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'LoginFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      LoginFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ConfigurationFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ConfigurationFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ConfigurationFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ConfigurationFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'UsersFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'UsersFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'UsersFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      UsersFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'SetPasswordFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'SetPasswordFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'SetPasswordFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      SetPasswordFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ReportFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ReportFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ReportFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ReportFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'MaintenanceFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'MaintenanceFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'MaintenanceFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      MaintenanceFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ClearingFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ClearingFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ClearingFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ClearingFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ViewMessagesFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ViewMessagesFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ViewMessagesFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ViewMessagesFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'CreateMessageFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'CreateMessageFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'CreateMessageFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      CreateMessageFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ViewMessageFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ViewMessageFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'ViewMessageFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      ViewMessageFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'PhonesFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'PhonesFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'PhonesFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      PhonesFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'AddEditPhoneFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'AddEditPhoneFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'AddEditPhoneFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      AddEditPhoneFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'AddMassMsrFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'AddMassMsrFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'AddMassMsrFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      AddMassMsrFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'PermissionsFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'PermissionsFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'PermissionsFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      PermissionsFormPosition := FormPosition;

      Centered := ReadBool(TEXT_INIFILESECTION_DIALOGS_POSITION, 'MultibufferFormPosition.bCenter', DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED);
      Left := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'MultibufferFormPosition.ix', DEFAULT_CONFIGURATION_DIALOG_LEFT);
      Top := ReadInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, 'MultibufferFormPosition.iy', DEFAULT_CONFIGURATION_DIALOG_TOP);
      MultibufferFormPosition := FormPosition;
    end;

    // вкладка "настройки процедуры логирования"
    StoreLogin := ReadBool(TEXT_INIFILESECTION_IDENTIFICATION, 'bStoreLogin', DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN);
    if StoreLogin then
      Login := ReadString(TEXT_INIFILESECTION_IDENTIFICATION, 'sLogin', EmptyStr)
    else
      Login := EmptyStr;
    StorePassword := ReadBool(TEXT_INIFILESECTION_IDENTIFICATION, 'bStorePassword', DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD);
    if StorePassword then
      Password := ReadString(TEXT_INIFILESECTION_IDENTIFICATION, 'sPassword', EmptyStr)
    else
      Password := EmptyStr;
    AutoLogon := ReadBool(TEXT_INIFILESECTION_IDENTIFICATION, 'bAutoLogon', DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON);

    // вкладка "подключения к серверу базы данных услуги"
    with RNE4Server do
    begin
      Host := ReadString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sHost', DEFAULT_CONFIGURATION_RNE4SERVER_HOST);
      Port := ReadInteger(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.iPort', DEFAULT_CONFIGURATION_RNE4SERVER_PORT);
      Timeout := ReadInteger(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.iTimeout', DEFAULT_CONFIGURATION_RNE4SERVER_TIMEOUT);
      Compression := ReadBool(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.bCompression', DEFAULT_CONFIGURATION_RNE4SERVER_COMPRESSION);
      Login := ReadString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sLogin', DEFAULT_CONFIGURATION_RNE4SERVER_LOGIN);
      Password := ReadString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sPassword', DEFAULT_CONFIGURATION_RNE4SERVER_PASSWORD);
      Database := ReadString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sDatabase', DEFAULT_CONFIGURATION_RNE4SERVER_DATABESE);
    end;

    // вкладка "подключения к серверу системы обмена сообщениями"
    with MessagesServer do
    begin
      Host := ReadString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sHost', DEFAULT_CONFIGURATION_MESSAGESERVER_HOST);
      Port := ReadInteger(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.iPort', DEFAULT_CONFIGURATION_MESSAGESERVER_PORT);
      Timeout := ReadInteger(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.iTimeout', DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT);
      Compression := ReadBool(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.bCompression', DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION);
      Login := ReadString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sLogin', DEFAULT_CONFIGURATION_MESSAGESERVER_LOGIN);
      Password := ReadString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sPassword', DEFAULT_CONFIGURATION_MESSAGESERVER_PASSWORD);
      Database := ReadString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sDatabase', DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE);
    end;

    // вкладка "настройки формирования отчётов"
    ReportFolder := TReportFolder(ReadInteger(TEXT_INIFILESECTION_REPORTS, 'iReportFolder', Integer(rfApplicationFolder)));
    CustomReportFolderValue := ReadString(TEXT_INIFILESECTION_REPORTS, 'sCustomReportFolderValue', EmptyStr);
    DontDemandOverwriteConfirmation := ReadBool(TEXT_INIFILESECTION_REPORTS, 'bDontDemandOverwriteConfirmation', False);
    AskForFileName := ReadBool(TEXT_INIFILESECTION_REPORTS, 'bAskForFileName', True);

    // вкладка "настройки прочие"
    LaunchAtStartup := ReadBool(TEXT_INIFILESECTION_OTHER, 'bLaunchAtStartup', DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP);
    PlaySoundOnComplete := ReadBool(TEXT_INIFILESECTION_OTHER, 'bPlaySoundOnComplete', DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE);
    EnableAutoGetMessages := ReadBool(TEXT_INIFILESECTION_OTHER, 'bEnableAutoGetMessages', DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGE);
    AutoGetMessagesCycleDurationValue := ReadInteger(TEXT_INIFILESECTION_OTHER, 'iAutoGetMessagesCycleDurationValue', DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE);
    CustomHelpFile := ReadBool(TEXT_INIFILESECTION_OTHER, 'bCustomHelpFile', DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE);
    CustomHelpFileValue := ReadString(TEXT_INIFILESECTION_OTHER, 'sCustomHelpFileValue', DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE);

    // вкладка "настройки главного окна"
    MainFormLeft := ReadInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormLeft', DEFAULT_CONFIGURATION_MAIN_FORM_LEFT);
    MainFormTop := ReadInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormTop', DEFAULT_CONFIGURATION_MAIN_FORM_TOP);
    MainFormWidth := ReadInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormWidth', DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH);
    MainFormHeight := ReadInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormHeight', DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT);
    MainFormPositionByCenter := ReadBool(TEXT_INIFILESECTION_MAINFORM, 'bMainFormPositionByCenter', DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_POSITION_BY_CENTER);
    FullScreenAtLaunch := ReadBool(TEXT_INIFILESECTION_MAINFORM, 'bFullScreenAtLaunch', DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH);

    // вкладка "настройки отображения информации"
    OrganizationPanelHeightValue := ReadInteger(TEXT_INIFILESECTION_INFO, 'iOrganizationPanelHeightValue', DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE);
    OrganizationPanelHalfHeight := ReadBool(TEXT_INIFILESECTION_INFO, 'bOrganizationPanelHalfHeight', DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT);
    DataPanelWidthValue := ReadInteger(TEXT_INIFILESECTION_INFO, 'iDataPanelWidthValue', DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE);
    DataPanelHalfWidth := ReadBool(TEXT_INIFILESECTION_INFO, 'bOrganizationPanelHalfHeight', DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH);
    ShowDataInOtherInfoPanel := ReadBool(TEXT_INIFILESECTION_INFO, 'bShowDataInOtherInfoPanel', DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL);
    ShowMeasuresListAsRichEdit := ReadBool(TEXT_INIFILESECTION_INFO, 'bShowMeasuresListAsRichEdit', DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT);
    MarkSearchedStrings := ReadBool(TEXT_INIFILESECTION_INFO, 'bMarkSearchedStrings', DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRING);
    PutTownAtTheEnd := ReadBool(TEXT_INIFILESECTION_INFO, 'bPutTownAtTheEnd', DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END);
  end;
end;

procedure TConfiguration.Saving(const AIniFile: TCustomIniFile);

  procedure WriteFormPosition(IniFile: TCustomIniFile; FormPosition: TDialogPosition; const FormPositionName: string);
  begin
    with IniFile do
    begin
      WriteBool(TEXT_INIFILESECTION_DIALOGS_POSITION, FormPositionName + '.Centered', FormPosition.Centered);
      WriteInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, FormPositionName + '.Left', FormPosition.Left);
      WriteInteger(TEXT_INIFILESECTION_DIALOGS_POSITION, FormPositionName + '.Top', FormPosition.Top);
    end;
  end;

begin
  inherited;
  with AIniFile do
    try
      // вкладка "настройки интерфейса"
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowSplashAtStart', ShowSplashAtStart);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowToolbar', ShowToolbar);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowStatusbar', ShowStatusbar);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowEditboxHints', ShowEditboxHints);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowCommonSearchEditbox', ShowCommonSearchEditbox);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowID', ShowID);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bUseMultibuffer', UseMultibuffer);
      WriteBool(TEXT_INIFILESECTION_INTERFACE, 'bShowConfirmationOnQuit', ShowConfirmationOnQuit);

      // вкладка "настройки ведения протокола работы"
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bEnableLog', EnableLog);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnExit', FlushLogOnExit);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnStringsQuantity', FlushLogOnStringsQuantity);
      WriteInteger(TEXT_INIFILESECTION_LOGS, 'iFlushLogOnStringsQuantityValue', FlushLogOnStringsQuantityValue);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnClearingLog', FlushLogOnClearingLog);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bFlushLogOnApply', FlushLogOnApply);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bCustomLogClientFile', CustomLogClientFile);
      WriteString(TEXT_INIFILESECTION_LOGS, 'sCustomLogClientFileValue', CustomLogClientFileValue);

      WriteBool(TEXT_INIFILESECTION_LOGS, 'bKeepErrorLog', lmtError in KeepLogTypes);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bKeepWarningLog', lmtWarning in KeepLogTypes);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bKeepInfoLog', lmtInfo in KeepLogTypes);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bKeepSQLLog', lmtSQL in KeepLogTypes);
      WriteBool(TEXT_INIFILESECTION_LOGS, 'bKeepDebugLog', lmtDebug in KeepLogTypes);

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
      WriteBool(TEXT_INIFILESECTION_IDENTIFICATION, 'bStoreLogin', StoreLogin);
      WriteBool(TEXT_INIFILESECTION_IDENTIFICATION, 'bStorePassword', StorePassword);
      if StoreLogin then
        WriteString(TEXT_INIFILESECTION_IDENTIFICATION, 'sLogin', Login)
      else
        DeleteKey(TEXT_INIFILESECTION_IDENTIFICATION, 'sLogin');
      if StorePassword then
        WriteString(TEXT_INIFILESECTION_IDENTIFICATION, 'sPassword', Password)
      else
        DeleteKey(TEXT_INIFILESECTION_IDENTIFICATION, 'sPassword');
      WriteBool(TEXT_INIFILESECTION_IDENTIFICATION, 'bAutoLogon', AutoLogon);

      // вкладка "подключения к серверу базы данных услуги"
      with RNE4Server do
      begin
        WriteString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sHost', Host);
        WriteInteger(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.iPort', Port);
        WriteInteger(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.iTimeout', Timeout);
        WriteBool(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.bCompression', Compression);
        // WriteString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sLogin', Login);
        // WriteString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sPassword', Password);
        WriteString(TEXT_INIFILESECTION_SERVERS, 'RNE4Server.sDatabase', Database);
      end;

      // вкладка "подключения к серверу системы обмена сообщениями"
      with MessagesServer do
      begin
        WriteString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sHost', Host);
        WriteInteger(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.iPort', Port);
        WriteInteger(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.iTimeout', Timeout);
        WriteBool(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.bCompression', Compression);
        // WriteString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sLogin', Login);
        // WriteString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sPassword', Password);
        WriteString(TEXT_INIFILESECTION_SERVERS, 'MessagesServer.sDatabase', Database);
      end;

      // вкладка "настройки формирования отчётов"
      WriteInteger(TEXT_INIFILESECTION_REPORTS, 'iReportFolder', Integer(ReportFolder));
      WriteString(TEXT_INIFILESECTION_REPORTS, 'sCustomReportFolderValue', CustomReportFolderValue);
      WriteBool(TEXT_INIFILESECTION_REPORTS, 'bDontDemandOverwriteConfirmation', DontDemandOverwriteConfirmation);
      WriteBool(TEXT_INIFILESECTION_REPORTS, 'bAskForFileName', AskForFileName);

      // вкладка "настройки прочие"
      WriteBool(TEXT_INIFILESECTION_OTHER, 'bLaunchAtStartup', LaunchAtStartup);
      WriteBool(TEXT_INIFILESECTION_OTHER, 'bPlaySoundOnComplete', PlaySoundOnComplete);
      WriteBool(TEXT_INIFILESECTION_OTHER, 'bEnableAutoGetMessages', EnableAutoGetMessages);
      WriteInteger(TEXT_INIFILESECTION_OTHER, 'iAutoGetMessagesCycleDurationValue', AutoGetMessagesCycleDurationValue);
      WriteBool(TEXT_INIFILESECTION_OTHER, 'bCustomHelpFile', CustomHelpFile);
      WriteString(TEXT_INIFILESECTION_OTHER, 'bCustomHelpFileValue', CustomHelpFileValue);

      // вкладка "настройки главного окна"
      WriteInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormLeft', MainFormLeft);
      WriteInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormTop', MainFormTop);
      WriteInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormWidth', MainFormWidth);
      WriteInteger(TEXT_INIFILESECTION_MAINFORM, 'iMainFormHeight', MainFormHeight);
      WriteBool(TEXT_INIFILESECTION_MAINFORM, 'bMainFormPositionByCenter', MainFormPositionByCenter);
      WriteBool(TEXT_INIFILESECTION_MAINFORM, 'bFullScreenAtLaunch', FullScreenAtLaunch);

      // вкладка "настройки отображения информации"
      WriteInteger(TEXT_INIFILESECTION_INFO, 'iOrganizationPanelHeightValue', OrganizationPanelHeightValue);
      WriteBool(TEXT_INIFILESECTION_INFO, 'bOrganizationPanelHalfHeight', OrganizationPanelHalfHeight);
      WriteInteger(TEXT_INIFILESECTION_INFO, 'iDataPanelWidthValue', DataPanelWidthValue);
      WriteBool(TEXT_INIFILESECTION_INFO, 'bOrganizationPanelHalfHeight', OrganizationPanelHalfHeight);
      WriteBool(TEXT_INIFILESECTION_INFO, 'bShowDataInOtherInfoPanel', ShowDataInOtherInfoPanel);
      WriteBool(TEXT_INIFILESECTION_INFO, 'bShowMeasuresListAsRichEdit', ShowMeasuresListAsRichEdit);
      WriteBool(TEXT_INIFILESECTION_INFO, 'bMarkSearchedStrings', MarkSearchedStrings);
      WriteBool(TEXT_INIFILESECTION_INFO, 'bPutTownAtTheEnd', PutTownAtTheEnd);
    except
      on EIniFileException do
        raise EIniFileException.Create('Произошла ошибка при попытке записи настроек программы в файл конфигурации!');
    end;
end;

procedure TConfiguration.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes <> Value then
    FKeepLogTypes := Value;
end;

procedure TConfiguration.SetLaunchAtStartup(const Value: Boolean);
begin
  if FLaunchAtStartup <> Value then
    FLaunchAtStartup := Value;
end;

procedure TConfiguration.SetLoginFormPosition(const AValue: TDialogPosition);
begin
  if not FLoginFormPosition.Equals(AValue) then
    FLoginFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetMainFormHeight(const Value: Integer);
begin
  if FMainFormHeight <> Value then
    FMainFormHeight := Value;
end;

procedure TConfiguration.SetMainFormLeft(const Value: Integer);
begin
  if FMainFormLeft <> Value then
    FMainFormLeft := Value;
end;

procedure TConfiguration.SetMainFormPositionByCenter(const Value: Boolean);
begin
  if FMainFormPositionByCenter <> Value then
    FMainFormPositionByCenter := Value;
end;

procedure TConfiguration.SetMainFormTop(const Value: Integer);
begin
  if FMainFormTop <> Value then
    FMainFormTop := Value;
end;

procedure TConfiguration.SetMainFormWidth(const Value: Integer);
begin
  if FMainFormWidth <> Value then
    FMainFormWidth := Value;
end;

procedure TConfiguration.SetMaintenanceFormPosition(const AValue: TDialogPosition);
begin
  if not FMaintenanceFormPosition.Equals(AValue) then
    FMaintenanceFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetMarkSearchedStrings(const Value: Boolean);
begin
  if FMarkSearchedStrings <> Value then
    FMarkSearchedStrings := Value;
end;

procedure TConfiguration.SetMessagesServer(const Value: TMySQLConnection);
begin
  if FMessagesServer <> Value then
    FMessagesServer := Value;
end;

procedure TConfiguration.SetConfigurationFormPosition(const AValue: TDialogPosition);
begin
  if not FConfigurationFormPosition.Equals(AValue) then
    FConfigurationFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetOrganizationPanelHalfHeight(const Value: Boolean);
begin
  if FOrganizationPanelHalfHeight <> Value then
    FOrganizationPanelHalfHeight := Value;
end;

procedure TConfiguration.SetOrganizationPanelHeightValue(const Value: Integer);
begin
  if FOrganizationPanelHeightValue <> Value then
    FOrganizationPanelHeightValue := Value;
end;

procedure TConfiguration.SetPhonesFormPosition(const AValue: TDialogPosition);
begin
  if not FPhonesFormPosition.Equals(AValue) then
    FPhonesFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetPlaySoundOnComplete(const Value: Boolean);
begin
  if FPlaySoundOnComplete <> Value then
    FPlaySoundOnComplete := Value;
end;

procedure TConfiguration.SetPutTownAtTheEnd(const Value: Boolean);
begin
  if FPutTownAtTheEnd <> Value then
    FPutTownAtTheEnd := Value;
end;

procedure TConfiguration.SetReportFolder(const AValue: TReportFolder);
begin
  if FReportFolder <> AValue then
    FReportFolder := AValue;
end;

procedure TConfiguration.SetRNE4Server(const Value: TMySQLConnection);
begin
  if FRNE4Server <> Value then
    FRNE4Server := Value;
end;

procedure TConfiguration.SetUseLog(const Value: Boolean);
begin
  if FEnableLog <> Value then
    FEnableLog := Value;
end;

procedure TConfiguration.SetCustomReportFolderValue(const Value: string);
begin
  if FCustomReportFolderValue <> Value then
    FCustomReportFolderValue := Value;
end;

procedure TConfiguration.SetSetPasswordFormPosition(const AValue: TDialogPosition);
begin
  if not FSetPasswordFormPosition.Equals(AValue) then
    FSetPasswordFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetShowSplashAtStart(const Value: Boolean);
begin
  if FShowSplashAtStart <> Value then
    FShowSplashAtStart := Value;
end;

procedure TConfiguration.SetShowCommonSearchEditbox(const Value: Boolean);
begin
  if FShowCommonSearchEditbox <> Value then
    FShowCommonSearchEditbox := Value;
end;

procedure TConfiguration.SetShowConfirmationOnQuit(const Value: Boolean);
begin
  if FShowConfirmationOnQuit <> Value then
    FShowConfirmationOnQuit := Value;
end;

procedure TConfiguration.SetShowDataInOtherInfoPanel(const Value: Boolean);
begin
  if FShowDataInOtherInfoPanel <> Value then
    FShowDataInOtherInfoPanel := Value;
end;

procedure TConfiguration.SetShowEditboxHints(const Value: Boolean);
begin
  if FShowEditboxHints <> Value then
    FShowEditboxHints := Value;
end;

procedure TConfiguration.SetShowID(const Value: Boolean);
begin
  if FShowID <> Value then
    FShowID := Value;
end;

procedure TConfiguration.SetShowMeasuresListAsRichEdit(const Value: Boolean);
begin
  if FShowMeasuresListAsRichEdit <> Value then
    FShowMeasuresListAsRichEdit := Value;
end;

procedure TConfiguration.SetShowStatusbar(const Value: Boolean);
begin
  if FShowStatusbar <> Value then
    FShowStatusbar := Value;
end;

procedure TConfiguration.SetShowToolbar(const Value: Boolean);
begin
  if FShowToolbar <> Value then
    FShowToolbar := Value;
end;

procedure TConfiguration.SetReportFormPosition(const AValue: TDialogPosition);
begin
  if not FReportFormPosition.Equals(AValue) then
    FReportFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetUseMultibuffer(const Value: Boolean);
begin
  if FUseMultibuffer <> Value then
    FUseMultibuffer := Value;
end;

procedure TConfiguration.SetUsersFormPosition(const AValue: TDialogPosition);
begin
  if not FUsersFormPosition.Equals(AValue) then
    FUsersFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetViewMessageFormPosition(const AValue: TDialogPosition);
begin
  if not FViewMessageFormPosition.Equals(AValue) then
    FViewMessageFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetViewMessagesFormPosition(const AValue: TDialogPosition);
begin
  if not FViewMessagesFormPosition.Equals(AValue) then
    FViewMessagesFormPosition.Assign(AValue);
end;

function TConfiguration.GetReportFolderValue: string;
begin
  case FReportFolder of
    rfTempFolder:
      Result := GetTempFolder;
    rfApplicationFolder:
      Result := GetApplicationFolder;
    rfCustomFolder:
      Result := CustomReportFolderValue;
  end;
end;

destructor TConfiguration.Destroy;
begin
  FreeAndNil(FMessagesServer);
  FreeAndNil(FRNE4Server);
  inherited;
end;

procedure TConfiguration.Finalize;
begin
  inherited;
end;

function TConfiguration.GetApplicationFolder: string;
var
  s: string;
begin
  GetApplicationFolder := EmptyStr;

  s := ExtractFilePath(ExpandFileName(Application.ExeName));
  if DirectoryExists(s) then
    GetApplicationFolder := s
  else
    raise Exception.Create('Возникла ошибка при попытке получения пути рабочей папки программы!')
end;

function TConfiguration.GetTempFolder: string;
var
  r: cardinal;
  TempPathNameBuffer: PWideChar;
begin
  TempPathNameBuffer := nil;
  GetTempFolder := EmptyStr;

  try
    GetMem(TempPathNameBuffer, 1024 + 1);
    r := GetTempPath(1024, TempPathNameBuffer);
    if r > 0 then
    begin
      if r > 1024 then
      begin
        FreeMem(TempPathNameBuffer);
        GetMem(TempPathNameBuffer, r + 1);
      end;
      if DirectoryExists(TempPathNameBuffer) then
        GetTempFolder := TempPathNameBuffer
      else
        raise Exception.Create('Возникла ошибка при попытке получения пути временной папки!')
    end;
  finally
    if TempPathNameBuffer <> nil then
      FreeMem(TempPathNameBuffer);
  end;
end;

procedure TConfiguration.Initialize;
begin
  inherited;
  // инициализация динамических членов класса
  FRNE4Server := TMySQLConnection.Create;
  FMessagesServer := TMySQLConnection.Create;

  // инициализация пеерменных класса
  FFileName := ChangeFileExt(ExpandFileName(Application.ExeName), '.ini');
  FConfigurationFormPage := 0;
  FLogin := EmptyStr;
  FPassword := EmptyStr;

  // вкладка "настройки интерфейса"
  FShowSplashAtStart := DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
  FShowToolbar := DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
  FShowStatusbar := DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
  FShowEditboxHints := DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
  FShowCommonSearchEditbox := DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
  FShowID := DEFAULT_CONFIGURATION_ENABLE_ID;
  FUseMultibuffer := DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
  FShowConfirmationOnQuit := DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;

  // вкладка "настройки ведения протокола работы"
  FEnableLog := DEFAULT_CONFIGURATION_ENABLE_LOG;
  FKeepLogTypes := DEFAULT_CONFIGURATION_KEEP_LOG_TYPES;
  FFlushLogOnExit := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT;
  FFlushLogOnStringsQuantity := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY;
  FFlushLogOnStringsQuantityValue := DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE;
  FFlushLogOnClearingLog := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG;
  FFlushLogOnApply := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY;
  FCustomLogClientFile := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT;
  FCustomLogClientFileValue := DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE;

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
  FStoreLogin := DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
  FStorePassword := DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
  FLogin := DEFAULT_CONFIGURATION_LOGIN;
  FPassword := DEFAULT_CONFIGURATION_PASSWORD;
  FAutoLogon := DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON;

  // вкладка "настройки подключения к серверу базы данных услуги"
  with FRNE4Server do
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
  with FMessagesServer do
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
  FReportFolder := DEFAULT_CONFIGURATION_REPORT_FOLDER;
  FCustomReportFolderValue := DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE;
  FDontDemandOverwriteConfirmation := DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
  AskForFileName := DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;

  // вкладка "настройки прочие"
  FLaunchAtStartup := DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
  FPlaySoundOnComplete := DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
  FEnableAutoGetMessages := DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGE;
  FAutoGetMessagesCycleDurationValue := DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE;
  FCustomHelpFile := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
  FCustomHelpFileValue := DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE;

  // вкладка "настройки главного окна"
  MainFormLeft := DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
  MainFormTop := DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
  MainFormWidth := DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
  MainFormHeight := DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
  FMainFormPositionByCenter := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_POSITION_BY_CENTER;
  FFullScreenAtLaunch := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;

  // вкладка "настройки отображения информации"
  FOrganizationPanelHeightValue := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE;
  FOrganizationPanelHalfHeight := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
  FDataPanelWidthValue := DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE;
  FDataPanelHalfWidth := DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
  FShowDataInOtherInfoPanel := DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
  FShowMeasuresListAsRichEdit := DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
  FMarkSearchedStrings := DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRING;
  FPutTownAtTheEnd := DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;
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

procedure TConfiguration.SetAskForFileName(const Value: Boolean);
begin
  if FAskForFileName <> Value then
    FAskForFileName := Value;
end;

procedure TConfiguration.SetAutoGetMessagesCycleDurationValue(const Value: Integer);
begin
  if FAutoGetMessagesCycleDurationValue <> Value then
    FAutoGetMessagesCycleDurationValue := Value;
end;

procedure TConfiguration.SetAutoLogon(const Value: Boolean);
begin
  if Value then
  begin
    if not(StoreLogin and StorePassword) then
      raise Exception.Create('Для включения настройки автологирования необходимо сначала включить слхранение логина и пароля последнего пользователя!')
    else
      if FAutoLogon <> Value then
        FAutoLogon := Value;
  end
  else
    if FAutoLogon <> Value then
      FAutoLogon := Value;
end;

procedure TConfiguration.SetClearingFormPosition(const AValue: TDialogPosition);
begin
  if not FClearingFormPosition.Equals(AValue) then
    FClearingFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetCreateMessageFormPosition(const AValue: TDialogPosition);
begin
  if not FCreateMessageFormPosition.Equals(AValue) then
    FCreateMessageFormPosition.Assign(AValue);
end;

procedure TConfiguration.SetCustomHelpFileValue(const Value: string);
begin
  if FCustomHelpFileValue <> Value then
    FCustomHelpFileValue := Value;
end;

procedure TConfiguration.SetCustomLogClientFile(const Value: Boolean);
begin
  if FCustomLogClientFile <> Value then
    FCustomLogClientFile := Value;
end;

procedure TConfiguration.SetCustomLogClientFileValue(const Value: string);
begin
  if FCustomLogClientFileValue <> Value then
    FCustomLogClientFileValue := Value;
end;

procedure TConfiguration.SetDataPanelHalfWidth(const Value: Boolean);
begin
  if FDataPanelHalfWidth <> Value then
    FDataPanelHalfWidth := Value;
end;

procedure TConfiguration.SetDataPanelWidthValue(const Value: Integer);
begin
  if FDataPanelWidthValue <> Value then
    FDataPanelWidthValue := Value;
end;

procedure TConfiguration.SetDontDemandOverwriteConfirmation(const Value: Boolean);
begin
  if FDontDemandOverwriteConfirmation <> Value then
    FDontDemandOverwriteConfirmation := Value;
end;

procedure TConfiguration.SetEnableAutoGetMessages(const Value: Boolean);
begin
  if FEnableAutoGetMessages <> Value then
    FEnableAutoGetMessages := Value;
end;

procedure TConfiguration.SetCustomHelpFile(const Value: Boolean);
begin
  if FCustomHelpFile <> Value then
    FCustomHelpFile := Value;
end;

procedure TConfiguration.SetFileName(const Value: string);
begin
  if FFileName <> Value then
    if Trim(Value) <> EmptyStr then
      FFileName := Trim(Value)
    else
      raise Exception.Create('Имя файла конфигурации не должно быть пустым!');
end;

procedure TConfiguration.SetFlushLogOnApply(const Value: Boolean);
begin
  if FFlushLogOnApply <> Value then
    FFlushLogOnApply := Value;
end;

procedure TConfiguration.SetFlushLogOnClearingLog(const Value: Boolean);
begin
  if FFlushLogOnClearingLog <> Value then
    FFlushLogOnClearingLog := Value;
end;

procedure TConfiguration.SetFlushLogOnExit(const Value: Boolean);
begin
  if FFlushLogOnExit <> Value then
    FFlushLogOnExit := Value;
end;

procedure TConfiguration.SetFlushLogOnStringsQuantity(const Value: Boolean);
begin
  if FFlushLogOnStringsQuantity <> Value then
    FFlushLogOnStringsQuantity := Value;
end;

procedure TConfiguration.SetFlushLogOnStringsQuantityValue(const Value: Integer);
begin
  if FFlushLogOnStringsQuantityValue <> Value then
    FFlushLogOnStringsQuantityValue := Value;
end;

procedure TConfiguration.SetFullScreenAtLaunch(const Value: Boolean);
begin
  if FFullScreenAtLaunch <> Value then
    FFullScreenAtLaunch := Value;
end;

procedure TConfiguration.AfterLoad;
begin
end;

procedure TConfiguration.BeforeSave;
begin
end;

procedure TConfiguration.SetStoreLogin(const Value: Boolean);
begin
  if FStoreLogin <> Value then
  begin
    FStoreLogin := Value;
    if not FStoreLogin then
    begin
      FLogin := EmptyStr;
      FPassword := EmptyStr;
      FStorePassword := False;
      FAutoLogon := False;
    end;
  end
end;

procedure TConfiguration.SetStorePassword(const Value: Boolean);
begin
  if FStorePassword <> Value then
  begin
    FStorePassword := Value;
    if not FStorePassword then
    begin
      FPassword := EmptyStr;
      FAutoLogon := False;
    end;
  end;
end;

procedure TConfiguration.SetLogin(const Value: string);
begin
  if StoreLogin then
  begin
    if FLogin <> Value then
      FLogin := Value
  end
  else
    FLogin := EmptyStr;
end;

procedure TConfiguration.SetPassword(const Value: string);
begin
  if StorePassword then
  begin
    if FPassword <> Value then
      FPassword := Value
  end
  else
    FPassword := EmptyStr;
end;

initialization

begin
  System.Classes.RegisterClass(TConfiguration);
end;

end.
