unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass, LogKeeperData, Types;

type
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);

  TConfiguration=class
  type
    TFormPosition= record
      bCenter: boolean;
      x, y: integer;
    end;
  strict private
    // вкладка "настройки интерфейса"
    FShowAboutWindowAtLaunch: boolean; // Отображать окно "О программе..." при запуске
    FShowToolbarAtLaunch: boolean; // Отображать панель кнопок при запуске программы
    FShowStatusbarAtLaunch: boolean; // Отображать панель статуса при запуске программы
    FShowEditboxHints: boolean; // Отображать всплывающие подсказки для полей ввода
    FShowCommonSearchEditbox: boolean; // Отображать единое поле ввода для поиска данных
    FShowID: boolean; // Отображать поле ID записей базы данных при работе программы
    FUseMultibuffer: boolean; // Использовать мультибуфер для операций копирования мероприятий
    FShowConfirmationOnQuit: boolean; // Требовать подтверждение при выходе из программы

    // вкладка "настройки ведения протокола работы"
    FUseLog: boolean; // Вести лог работы программы
    FKeepLogTypes: TLogMessagesTypes; // выводить сообщения перечисленных типов
    FFlushLogOnExit: boolean; // Сбрасывать протокол работы в текстовый файл при завершении работы программы
    FFlushLogOnStrings: boolean; // Сбрасывать протокол работы в текстовый файл при достижении количества строк
    FFlushLogOnStringsQuantity: word; // Сбрасывать протокол работы в текстовый файл при достижении количества строк (непосредственно количество)
    FFlushLogOnClearingLog: boolean; // Сбрасывать протокол работы в текстовый файл при операции очистки протокола
    FFlushLogOnApply: boolean; // Сбрасывать протокол работы в текстовый файл при нажатии кнопки "Применить"
    FCustomLogClientFile: boolean; // Использовать внешний клиент протоколирования
    FCustomLogClientFileName: string; // имя файла внешнего клиента протоколирования

    // вкладка "настройки положения диалоговых окон"
    FMainFormPosition,
    FLoginFormPosition,
    FOptionsFormPosition,
    FUsersFormPosition,
    FSetPasswordFormPosition,
    FStatisticFormPosition,
    FMaintenanceFormPosition,
    FClearingFormPosition,
    FViewPostListFormPosition,
    FCreateViewPostFormPosition,
    FPhonesFormPosition,
    FAddEditPhoneFormPosition,
    FAddMassMsrFormPosition: TFormPosition;

    // вкладка "настройки процедуры логирования"
    FStoreLastLogin: boolean; // Сохранять логин последнего пользователя
    FStoreLastPassword: boolean; // Сохранять пароль последнего пользователя
    FAutoLogon: boolean; // Выполнять автоматический вход, используя сохранённые логин и пароль пользователя

    // вкладка "настройки подключения к серверу базы данных услуги"

    // вкладка "настройки подключения к серверу системы обмена сообщениями"

    // вкладка "настройки формирования отчётов"
    FReportFolder: TReportFolders; //
    FSelectedReportFolder: string; //
    FDontDemandOverwriteConfirmation: boolean; //
    FAskForFileName: boolean; //

    // вкладка "настройки списка автозамены"

    // вкладка "настройки прочие

    // вкладка "настройки главного окна
    FMainFormWidth: TPoint;
    FMainFormWidth: integer;
    FMainFormHeight: integer;

    // вкладка "настройки отображения информации

    procedure SetUseLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
  public
    RNE4Server, MessagesServer: TMySQLConnection;
    // sLastLogin, sLastPassword: string;
    //
    // sLocalHost: string;
    iConfigurationFormPage: integer; // номер последней открытой страницы окна конфигурации программы
    //
    // bAlwaysShowTrayIcon: boolean; // всегда отобращать иконку в трее
    // bShowQuitConfirmation: boolean;
    // bUseExternalLog: boolean;
    // sDefaultAction: string;
    // bNoStatusBar: boolean;
    // bScrollToLastLogMessage: boolean;
    // bAutorun: boolean;
    // bStartInTray: boolean;
    // bPlaySoundAfterAction: boolean;
    // bShowBaloonHintAfterAction: boolean;
    //
    // bFlushLogOnExit: boolean; // выполнять ли сохранение лога в файл при выходе из программы
    iFlushLogOnStringsQuantity: integer; // при каком количестве строк лога скидывать их в файл
    iGetMessagesCycleDuration: integer; // количество минут, через которое нужно проверять новые сообщения
    // bFlushLogOnClearingLog: boolean; // выполнять ли сохранение лога в файл при очистке лога
    //
    // sApplicationFolder: string;
    // sTempFolder: string;
    // sCustomFolder: string;
    // trfReportFolder: TReportFolders;
    // bDontDemandOverwriteConfirmation: boolean;
    // bAskForFileName: boolean;

    // bNoLogo: boolean;
    // bShowID: boolean;
    // bDontShowQuitConfirmation: boolean;
    // bImmediatelyQuit: boolean;
    // bNoToolBar: boolean;
    // bShowDataInOtherInfoPanel: boolean;
    // bShowMeasuresListAsRichEdit: boolean;
    // bMarkSearchedStrings: boolean;
    // bPutTownAtTheEnd: boolean;
    // bHideEditBoxToolTips: boolean;
    // bShowSearchAddressOtherEditBox: boolean;
    // bUseMultibuffer: boolean;
    // bGetMessages: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    // bFullScreen: boolean;

    // iOrgPanelHeight: integer;
    // bOrgPanelHalfHeight: boolean;
    // iDataPanelWidth: integer;
    // bDataPanelHalfWidth: boolean;
  public
    property UseLog: boolean read FUseLog write SetUseLog default True; // нужно ли вести лог работы программы
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError,lmtWarning,lmtInfo];

    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // нужно ли хранить последний введённый логин
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // нужно ли хранить последний введённый пароль
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // нужно ли выполнять автологирование
  end;

implementation

uses
  SysUtils;

procedure TConfiguration.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes := Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  if FUseLog<>Value then
    FUseLog:=Value;
end;

procedure TConfiguration.SetStoreLastLogin(const Value: boolean);
begin
  if FStoreLastLogin<>Value then
    begin
      FStoreLastLogin:=Value;
      if not(Value and StoreLastPassword) then
        AutoLogon:=False;
    end;
end;

procedure TConfiguration.SetStoreLastPassword(const Value: boolean);
begin
  if FStoreLastPassword<>Value then
    begin
      FStoreLastPassword:=Value;
      if not(Value and StoreLastLogin) then
        AutoLogon:=False;
    end;
end;

procedure TConfiguration.SetAutoLogon(const Value: boolean);
begin
  if Value then
    begin
      if not(StoreLastLogin and StoreLastPassword) then
        raise Exception.Create('Для включения настройки автологирования необходимо сначала включить слхранение логина и пароля последнего пользователя!')
    end
  else
    FAutoLogon:=Value;
end;

end.
