unit LogKeeper.uTypes;

interface

uses
  CastersPackage.uMysql;

type
  TLogMessagesType = (lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug); // типы сообщений передаваемых в лог

  TMySQLServerConnectionDetails = record
    bConnected: boolean;
    hConnection: PMYSQL;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
    sMySQLUser: AnsiString; // имя пользователя для подключения к базе MySQL-сервера
    sMySQLPassword: AnsiString; // пароль пользователя для подключения к базе MySQL-сервера
  end;

  // типы сообщений передаваемых в лог
  TConfigurationRec = record
    LogServer: TMySQLServerConnectionDetails;

    bInterraptionInitiated: boolean; // было ли инициировано прерывание работы программы
    wExitCicleCounter: word; // счётчик циклов проверки перед выходом из программы
    sLocalHost: string; // имя локального хоста
    sCustomHelpFile: string; // имя стороннего файла справки
    bNoStatusBar: boolean; // видимость панели статуса
    bFullScreen: boolean; // находится ли окно в максимизированном состоянии
    iMainFormHeight: integer; // фиксированная высота главного окна
    bBottomMainFormAlignment: boolean; // производить ли выравнивание к низу (True) или к верху (False) десктопа
    bAlwaysShowTrayIcon: boolean; // всегда отобращать иконку в трее
    bKeepErrorLog: boolean; // нужно ли вести лог сообщений типа error
    bKeepWarningLog: boolean; // нужно ли вести лог сообщений типа warning
    bKeepInfoLog: boolean; // нужно ли вести лог сообщений типа info
    bKeepSQLLog: boolean; // нужно ли вести лог запросов MySQL
    bKeepDebugLog: boolean; // нужно ли вести лог отладочной информации
    bFlushLogOnExit: boolean; // выполнять ли сохранение лога в файл при выходе из программы
    iFlushLogOnStringsQuantity: integer; // при каком количестве строк лога скидывать их в файл
    bFlushLogOnClearingLog: boolean; // выполнять ли сохранение лога в файл при очистке лога
    bShowBaloonHintAfterAction: boolean;
    bScrollToLastLogMessage: boolean;
  end;

implementation

end.
