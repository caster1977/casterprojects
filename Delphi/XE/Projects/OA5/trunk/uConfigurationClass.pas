unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass;

type
  TConfiguration=class
  strict private
    FUseLog: boolean; // нужно ли вести лог работы программы
    FKeepErrorLog: boolean; // нужно ли вести лог сообщений типа error
    FKeepWarningLog: boolean; // нужно ли вести лог сообщений типа warning
    FKeepInfoLog: boolean; // нужно ли вести лог сообщений типа info
    FKeepSQLLog: boolean; // нужно ли вести лог запросов MySQL
    FKeepDebugLog: boolean; // нужно ли вести лог отладочной информации
    FStoreLastLogin: boolean; // нужно ли хранить последний введённый логин
    FStoreLastPassword: boolean; // нужно ли хранить последний введённый пароль
    FAutoLogon: boolean; // нужно ли выполнять автологирование
    procedure SetKeepErrorLog(const Value: boolean);
    procedure SetUseLog(const Value: boolean);
    procedure SetKeepDebugLog(const Value: boolean);
    procedure SetKeepInfoLog(const Value: boolean);
    procedure SetKeepSQLLog(const Value: boolean);
    procedure SetKeepWarningLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
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
    // fpMainForm: TFormPosition;
    // iMainFormWidth: integer;
    // iMainFormHeight: integer;
    // iOrgPanelHeight: integer;
    // bOrgPanelHalfHeight: boolean;
    // iDataPanelWidth: integer;
    // bDataPanelHalfWidth: boolean;
    // fpLoginForm: TFormPosition;
    // fpOptionsForm: TFormPosition;
    // fpUsersForm: TFormPosition;
    // fpSetPasswordForm: TFormPosition;
    // fpStatisticForm: TFormPosition;
    // fpMaintenanceForm: TFormPosition;
    // fpClearingForm: TFormPosition;
    // fpViewPostListForm: TFormPosition;
    // fpCreateViewPostForm: TFormPosition;
    // fpPhonesForm: TFormPosition;
    // fpAddEditPhoneForm: TFormPosition;
    // fpAddMassMsrForm: TFormPosition;
    //
    // sCustomHelpFile: string;
    // sCustomLogClientFile: string;
  public
    property UseLog: boolean read FUseLog write SetUseLog default True; // нужно ли вести лог работы программы
    property KeepErrorLog: boolean read FKeepErrorLog write SetKeepErrorLog default True; // нужно ли вести лог сообщений типа error
    property KeepWarningLog: boolean read FKeepWarningLog write SetKeepWarningLog default True; // нужно ли вести лог сообщений типа warning
    property KeepInfoLog: boolean read FKeepInfoLog write SetKeepInfoLog default True; // нужно ли вести лог сообщений типа info
    property KeepSQLLog: boolean read FKeepSQLLog write SetKeepSQLLog default False; // нужно ли вести лог запросов MySQL
    property KeepDebugLog: boolean read FKeepDebugLog write SetKeepDebugLog default False; // нужно ли вести лог отладочной информации

    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // нужно ли хранить последний введённый логин
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // нужно ли хранить последний введённый пароль
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // нужно ли выполнять автологирование
  end;

implementation

uses
  SysUtils;

procedure TConfiguration.SetKeepInfoLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('Для включения отправки информационных сообщений необходимо сначала включить протоколирование работы программы!')
  else
    FKeepInfoLog:=Value;
end;

procedure TConfiguration.SetKeepSQLLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('Для включения отправки текста запросов MySQL необходимо сначала включить протоколирование работы программы!')
  else
    FKeepSQLLog:=Value;
end;

procedure TConfiguration.SetKeepWarningLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('Для включения отправки предупреждений необходимо сначала включить протоколирование работы программы!')
  else
    FKeepWarningLog:=Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  FUseLog:=Value;
  KeepErrorLog:=False;
  KeepWarningLog:=False;
  KeepInfoLog:=False;
  KeepSQLLog:=False;
  KeepDebugLog:=False;
end;

procedure TConfiguration.SetKeepDebugLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('Для включения отправки отладочных сообщений необходимо сначала включить протоколирование работы программы!')
  else
    FKeepDebugLog:=Value;
end;

procedure TConfiguration.SetKeepErrorLog(const Value: boolean);
begin
  if not UseLog then
    raise Exception.Create('Для включения отправки сообщений об ошибках необходимо сначала включить протоколирование работы программы!')
  else
    FKeepErrorLog:=Value;
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
