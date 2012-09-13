unit OA5.uIConfiguration;

interface

uses
  System.IniFiles,
  OA5.uTMySQLConnection,
  CastersPackage.uTDialogPosition,
  CastersPackage.uTReportFolder,
  CastersPackage.uIIniFileDataStorage,
  CastersPackage.uTLogMessagesTypes;

type
  IConfiguration = interface(IIniFileDataStorage)
    ['{9B4F356D-B5B8-4D48-930C-A176FD88302D}']

    // вкладка "настройки интерфейса"
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    /// <summary>
    /// Отображать окно "О программе..." при запуске
    /// </summary>
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart;

    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    /// <summary>
    /// Отображать панель кнопок
    /// </summary>
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar;

    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    /// <summary>
    /// Отображать панель статуса
    /// </summary>
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar;

    function GetEnableEditboxHints: Boolean;
    procedure SetEnableEditboxHints(const AValue: Boolean);
    /// <summary>
    /// Отображать всплывающие подсказки для полей ввода
    /// </summary>
    property EnableEditboxHints: Boolean read GetEnableEditboxHints write SetEnableEditboxHints;

    function GetEnableCommonSearchEditbox: Boolean;
    procedure SetEnableCommonSearchEditbox(const AValue: Boolean);
    /// <summary>
    /// Отображать единое поле ввода для поиска данных
    /// </summary>
    property EnableCommonSearchEditbox: Boolean read GetEnableCommonSearchEditbox write SetEnableCommonSearchEditbox;

    function GetEnableID: Boolean;
    procedure SetEnableID(const AValue: Boolean);
    /// <summary>
    /// Отображать поле ID записей базы данных при работе программы
    /// </summary>
    property EnableID: Boolean read GetEnableID write SetEnableID;

    function GetEnableMultibuffer: Boolean;
    procedure SetEnableMultibuffer(const AValue: Boolean);
    /// <summary>
    /// Использовать мультибуфер для операций копирования мероприятий
    /// </summary>
    property EnableMultibuffer: Boolean read GetEnableMultibuffer write SetEnableMultibuffer;

    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    /// <summary>
    /// Требовать подтверждение при выходе из программы
    /// </summary>
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation;

    // вкладка "настройки ведения протокола работы"
    function GetEnableLog: Boolean;
    procedure SetEnableLog(const AValue: Boolean);
    /// <summary>
    /// Вести лог работы программы
    /// </summary>
    property EnableLog: Boolean read GetEnableLog write SetEnableLog;

    function GetKeepLogTypes: TLogMessagesTypes;
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    /// <summary>
    /// Выводить сообщения перечисленных типов
    /// </summary>
    property KeepLogTypes: TLogMessagesTypes read GetKeepLogTypes write SetKeepLogTypes;

    function GetEnableFlushLogOnExit: Boolean;
    procedure SetEnableFlushLogOnExit(const AValue: Boolean);
    /// <summary>
    /// Сбрасывать протокол работы в текстовый файл при завершении работы
    /// программы
    /// </summary>
    property EnableFlushLogOnExit: Boolean read GetEnableFlushLogOnExit write SetEnableFlushLogOnExit;

    function GetEnableFlushLogOnStringsQuantity: Boolean;
    procedure SetEnableFlushLogOnStringsQuantity(const AValue: Boolean);
    /// <summary>
    /// Сбрасывать протокол работы в текстовый файл при достижении количества
    /// строк
    /// </summary>
    property EnableFlushLogOnStringsQuantity: Boolean read GetEnableFlushLogOnStringsQuantity
      write SetEnableFlushLogOnStringsQuantity;

    function GetEnableFlushLogOnStringsQuantityValue: Integer;
    procedure SetEnableFlushLogOnStringsQuantityValue(const AValue: Integer);
    /// <summary>
    /// Сбрасывать протокол работы в текстовый файл при достижении количества
    /// строк (непосредственно количество)
    /// </summary>
    property EnableFlushLogOnStringsQuantityValue: Integer read GetEnableFlushLogOnStringsQuantityValue
      write SetEnableFlushLogOnStringsQuantityValue;

    function GetEnableFlushLogOnClearingLog: Boolean;
    procedure SetEnableFlushLogOnClearingLog(const AValue: Boolean);
    /// <summary>
    /// Сбрасывать протокол работы в текстовый файл при операции очистки
    /// протокола
    /// </summary>
    property EnableFlushLogOnClearingLog: Boolean read GetEnableFlushLogOnClearingLog write SetEnableFlushLogOnClearingLog;

    function GetEnableFlushLogOnApply: Boolean;
    procedure SetEnableFlushLogOnApply(const AValue: Boolean);
    /// <summary>
    /// Сбрасывать протокол работы в текстовый файл при нажатии кнопки
    /// "Применить"
    /// </summary>
    property EnableFlushLogOnApply: Boolean read GetEnableFlushLogOnApply write SetEnableFlushLogOnApply;

    function GetEnableCustomLogClient: Boolean;
    procedure SetEnableCustomLogClient(const AValue: Boolean);
    /// <summary>
    /// Использовать внешний клиент протоколирования
    /// </summary>
    property EnableCustomLogClient: Boolean read GetEnableCustomLogClient write SetEnableCustomLogClient;

    function GetCustomLogClientValue: string;
    procedure SetCustomLogClientValue(const AValue: string);
    /// <summary>
    /// Имя файла внешнего клиента протоколирования
    /// </summary>
    property CustomLogClientValue: string read GetCustomLogClientValue write SetCustomLogClientValue;

    // вкладка "настройки процедуры логирования"
    function GetEnableAutoLogon: Boolean;
    procedure SetEnableAutoLogon(const AValue: Boolean);
    /// <summary>
    /// Выполнять автоматический вход, используя сохранённые логин и пароль
    /// пользователя
    /// </summary>
    property EnableAutoLogon: Boolean read GetEnableAutoLogon write SetEnableAutoLogon;

    function GetEnableStoreLogin: Boolean;
    procedure SetEnableStoreLogin(const AValue: Boolean);
    /// <summary>
    /// Сохранять логин последнего пользователя
    /// </summary>
    property EnableStoreLogin: Boolean read GetEnableStoreLogin write SetEnableStoreLogin;

    procedure SetEnableStorePassword(const AValue: Boolean);
    function GetEnableStorePassword: Boolean;
    /// <summary>
    /// Сохранять пароль последнего пользователя
    /// </summary>
    property EnableStorePassword: Boolean read GetEnableStorePassword write SetEnableStorePassword;

    function GetStoredLogin: string;
    procedure SetStoredLogin(const AValue: string);
    /// <summary>
    /// Логин последнего пользователя
    /// </summary>
    property StoredLogin: string read GetStoredLogin write SetStoredLogin;

    function GetStoredPassword: string;
    procedure SetStoredPassword(const AValue: string);
    /// <summary>
    /// Пароль последнего пользователя
    /// </summary>
    property StoredPassword: string read GetStoredPassword write SetStoredPassword;

    // вкладка "настройки формирования отчётов"
    function GetCustomReportFolderValue: string;
    procedure SetCustomReportFolderValue(const AValue: string);
    property CustomReportFolderValue: string read GetCustomReportFolderValue write SetCustomReportFolderValue;

    function GetEnableAskForFileName: Boolean;
    procedure SetEnableAskForFileName(const AValue: Boolean);
    property EnableAskForFileName: Boolean read GetEnableAskForFileName write SetEnableAskForFileName;

    function GetEnableOverwriteConfirmation: Boolean;
    procedure SetEnableOverwriteConfirmation(const AValue: Boolean);
    property EnableOverwriteConfirmation: Boolean read GetEnableOverwriteConfirmation write SetEnableOverwriteConfirmation;

    function GetReportFolderType: TReportFolder;
    procedure SetReportFolderType(const AValue: TReportFolder);
    property ReportFolderType: TReportFolder read GetReportFolderType write SetReportFolderType;

    // вкладка "настройки прочие"
    function GetAutoGetMessagesCycleDurationValue: Integer;
    procedure SetAutoGetMessagesCycleDurationValue(const AValue: Integer);
    property AutoGetMessagesCycleDurationValue: Integer read GetAutoGetMessagesCycleDurationValue
      write SetAutoGetMessagesCycleDurationValue;

    function GetCustomHelpFileValue: string;
    procedure SetCustomHelpFileValue(const AValue: string);
    property CustomHelpFileValue: string read GetCustomHelpFileValue write SetCustomHelpFileValue;

    function GetEnableAutoGetMessages: Boolean;
    procedure SetEnableAutoGetMessages(const AValue: Boolean);
    property EnableAutoGetMessages: Boolean read GetEnableAutoGetMessages write SetEnableAutoGetMessages;

    function GetEnableCustomHelpFile: Boolean;
    procedure SetEnableCustomHelpFile(const AValue: Boolean);
    property EnableCustomHelpFile: Boolean read GetEnableCustomHelpFile write SetEnableCustomHelpFile;

    function GetEnableLaunchAtStartup: Boolean;
    procedure SetEnableLaunchAtStartup(const AValue: Boolean);
    property EnableLaunchAtStartup: Boolean read GetEnableLaunchAtStartup write SetEnableLaunchAtStartup;

    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete;

    // вкладка "настройки главного окна"
    function GetMainFormEnableFullScreenAtLaunch: Boolean;
    procedure SetMainFormEnableFullScreenAtLaunch(const AValue: Boolean);
    property MainFormEnableFullScreenAtLaunch: Boolean read GetMainFormEnableFullScreenAtLaunch
      write SetMainFormEnableFullScreenAtLaunch;

    function GetMainFormEnableCentered: Boolean;
    procedure SetMainFormEnableCentered(const AValue: Boolean);
    property MainFormEnableCentered: Boolean read GetMainFormEnableCentered write SetMainFormEnableCentered;

    function GetMainFormHeight: Integer;
    procedure SetMainFormHeight(const AValue: Integer);
    property MainFormHeight: Integer read GetMainFormHeight write SetMainFormHeight;

    function GetMainFormLeft: Integer;
    procedure SetMainFormLeft(const AValue: Integer);
    property MainFormLeft: Integer read GetMainFormLeft write SetMainFormLeft;

    function GetMainFormTop: Integer;
    procedure SetMainFormTop(const AValue: Integer);
    property MainFormTop: Integer read GetMainFormTop write SetMainFormTop;

    function GetMainFormWidth: Integer;
    procedure SetMainFormWidth(const AValue: Integer);
    property MainFormWidth: Integer read GetMainFormWidth write SetMainFormWidth;

    // вкладка "настройки отображения информации"
    function GetDataPanelEnableHalfWidth: Boolean;
    procedure SetDataPanelEnableHalfWidth(const AValue: Boolean);
    property DataPanelEnableHalfWidth: Boolean read GetDataPanelEnableHalfWidth write SetDataPanelEnableHalfWidth;

    function GetDataPanelWidthValue: Integer;
    procedure SetDataPanelWidthValue(const AValue: Integer);
    property DataPanelWidthValue: Integer read GetDataPanelWidthValue write SetDataPanelWidthValue;

    function GetEnableDataInOtherInfoPanel: Boolean;
    procedure SetEnableDataInOtherInfoPanel(const AValue: Boolean);
    property EnableDataInOtherInfoPanel: Boolean read GetEnableDataInOtherInfoPanel write SetEnableDataInOtherInfoPanel;

    function GetEnableMarkSearchedStrings: Boolean;
    procedure SetEnableMarkSearchedStrings(const AValue: Boolean);
    property EnableMarkSearchedStrings: Boolean read GetEnableMarkSearchedStrings write SetEnableMarkSearchedStrings;

    function GetEnableMeasuresListAsRichEdit: Boolean;
    procedure SetEnableMeasuresListAsRichEdit(const AValue: Boolean);
    property EnableMeasuresListAsRichEdit: Boolean read GetEnableMeasuresListAsRichEdit
      write SetEnableMeasuresListAsRichEdit;

    function GetEnablePutTownAtTheEnd: Boolean;
    procedure SetEnablePutTownAtTheEnd(const AValue: Boolean);
    property EnablePutTownAtTheEnd: Boolean read GetEnablePutTownAtTheEnd write SetEnablePutTownAtTheEnd;

    function GetOrganizationPanelEnableHalfHeight: Boolean;
    procedure SetOrganizationPanelEnableHalfHeight(const AValue: Boolean);
    property OrganizationPanelEnableHalfHeight: Boolean read GetOrganizationPanelEnableHalfHeight
      write SetOrganizationPanelEnableHalfHeight;

    function GetOrganizationPanelHeightValue: Integer;
    procedure SetOrganizationPanelHeightValue(const AValue: Integer);
    property OrganizationPanelHeightValue: Integer read GetOrganizationPanelHeightValue
      write SetOrganizationPanelHeightValue;

    // вкладка "настройки положения диалоговых окон"
    function GetAddEditPhoneFormPosition: TDialogPosition;
    procedure SetAddEditPhoneFormPosition(const AValue: TDialogPosition);
    property AddEditPhoneFormPosition: TDialogPosition read GetAddEditPhoneFormPosition write SetAddEditPhoneFormPosition;

    function GetAddMassMsrFormPosition: TDialogPosition;
    procedure SetAddMassMsrFormPosition(const AValue: TDialogPosition);
    property AddMassMsrFormPosition: TDialogPosition read GetAddMassMsrFormPosition write SetAddMassMsrFormPosition;

    function GetClearingFormPosition: TDialogPosition;
    procedure SetClearingFormPosition(const AValue: TDialogPosition);
    property ClearingFormPosition: TDialogPosition read GetClearingFormPosition write SetClearingFormPosition;

    function GetConfigurationFormPosition: TDialogPosition;
    procedure SetConfigurationFormPosition(const AValue: TDialogPosition);
    property ConfigurationFormPosition: TDialogPosition read GetConfigurationFormPosition write SetConfigurationFormPosition;

    function GetCreateMessageFormPosition: TDialogPosition;
    procedure SetCreateMessageFormPosition(const AValue: TDialogPosition);
    property CreateMessageFormPosition: TDialogPosition read GetCreateMessageFormPosition write SetCreateMessageFormPosition;

    function GetLoginFormPosition: TDialogPosition;
    procedure SetLoginFormPosition(const AValue: TDialogPosition);
    property LoginFormPosition: TDialogPosition read GetLoginFormPosition write SetLoginFormPosition;

    function GetMaintenanceFormPosition: TDialogPosition;
    procedure SetMaintenanceFormPosition(const AValue: TDialogPosition);
    property MaintenanceFormPosition: TDialogPosition read GetMaintenanceFormPosition write SetMaintenanceFormPosition;

    function GetMultibufferFormPosition: TDialogPosition;
    procedure SetMultibufferFormPosition(const AValue: TDialogPosition);
    property MultibufferFormPosition: TDialogPosition read GetMultibufferFormPosition write SetMultibufferFormPosition;

    function GetPermissionsFormPosition: TDialogPosition;
    procedure SetPermissionsFormPosition(const AValue: TDialogPosition);
    property PermissionsFormPosition: TDialogPosition read GetPermissionsFormPosition write SetPermissionsFormPosition;

    function GetPhonesFormPosition: TDialogPosition;
    procedure SetPhonesFormPosition(const AValue: TDialogPosition);
    property PhonesFormPosition: TDialogPosition read GetPhonesFormPosition write SetPhonesFormPosition;

    function GetReportFormPosition: TDialogPosition;
    procedure SetReportFormPosition(const AValue: TDialogPosition);
    property ReportFormPosition: TDialogPosition read GetReportFormPosition write SetReportFormPosition;

    function GetSetPasswordFormPosition: TDialogPosition;
    procedure SetSetPasswordFormPosition(const AValue: TDialogPosition);
    property SetPasswordFormPosition: TDialogPosition read GetSetPasswordFormPosition write SetSetPasswordFormPosition;

    function GetUsersFormPosition: TDialogPosition;
    procedure SetUsersFormPosition(const AValue: TDialogPosition);
    property UsersFormPosition: TDialogPosition read GetUsersFormPosition write SetUsersFormPosition;

    function GetViewMessageFormPosition: TDialogPosition;
    procedure SetViewMessageFormPosition(const AValue: TDialogPosition);
    property ViewMessageFormPosition: TDialogPosition read GetViewMessageFormPosition write SetViewMessageFormPosition;

    function GetViewMessagesFormPosition: TDialogPosition;
    procedure SetViewMessagesFormPosition(const AValue: TDialogPosition);
    property ViewMessagesFormPosition: TDialogPosition read GetViewMessagesFormPosition write SetViewMessagesFormPosition;

    // вкладка "настройки подключения к серверу базы данных услуги"
    function GetDBServer: TMySQLConnection;
    procedure SetDBServer(const AValue: TMySQLConnection);
    property DBServer: TMySQLConnection read GetDBServer write SetDBServer;

    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    function GetMessageServer: TMySQLConnection;
    procedure SetMessageServer(const AValue: TMySQLConnection);
    property MessageServer: TMySQLConnection read GetMessageServer write SetMessageServer;

    function GetCurrentPage: Integer;
    procedure SetCurrentPage(const AValue: Integer);
    property CurrentPage: Integer read GetCurrentPage write SetCurrentPage;

    function GetMeasuresSortedByColumn: Integer;
    procedure SetMeasuresSortedByColumn(const AValue: Integer);
    property MeasuresSortedByColumn: Integer read GetMeasuresSortedByColumn write SetMeasuresSortedByColumn;

    function GetOrganizationsSortedByColumn: Integer;
    procedure SetOrganizationsSortedByColumn(const AValue: Integer);
    property OrganizationsSortedByColumn: Integer read GetOrganizationsSortedByColumn write SetOrganizationsSortedByColumn;

    function GetReportFolder: string;
    property ReportFolder: string read GetReportFolder;
  end;

implementation

end.
