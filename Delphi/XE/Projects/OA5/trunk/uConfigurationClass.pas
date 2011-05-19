unit uConfigurationClass;

interface

uses
  uMySQLConnectionClass,
  LogKeeperData,
  Types,
  uSingleton;

type
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);

  TConfiguration=class(TSingleton)
  type
    TFormPosition=record
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
    FShowConfirmationAtQuit: boolean; // Требовать подтверждение при выходе из программы

    // вкладка "настройки ведения протокола работы"
    FEnableLog: boolean; // Вести лог работы программы
    FKeepLogTypes: TLogMessagesTypes; // выводить сообщения перечисленных типов
    FFlushLogOnExit: boolean; // Сбрасывать протокол работы в текстовый файл при завершении работы программы
    FFlushLogOnStringsQuantity: boolean; // Сбрасывать протокол работы в текстовый файл при достижении количества строк
    FFlushLogOnStringsQuantityValue: integer; // Сбрасывать протокол работы в текстовый файл при достижении количества строк (непосредственно количество)
    FFlushLogOnClearingLog: boolean; // Сбрасывать протокол работы в текстовый файл при операции очистки протокола
    FFlushLogOnApply: boolean; // Сбрасывать протокол работы в текстовый файл при нажатии кнопки "Применить"
    FCustomLogClientFile: boolean; // Использовать внешний клиент протоколирования
    FCustomLogClientFileValue: string; // имя файла внешнего клиента протоколирования

    // вкладка "настройки положения диалоговых окон"
    FMainFormPosition: TFormPosition;
    FLoginFormPosition: TFormPosition;
    FOptionsFormPosition: TFormPosition;
    FUsersFormPosition: TFormPosition;
    FSetPasswordFormPosition: TFormPosition;
    FStatisticFormPosition: TFormPosition;
    FMaintenanceFormPosition: TFormPosition;
    FClearingFormPosition: TFormPosition;
    FViewPostListFormPosition: TFormPosition;
    FCreateViewPostFormPosition: TFormPosition;
    FPhonesFormPosition: TFormPosition;
    FAddEditPhoneFormPosition: TFormPosition;
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

    // вкладка "настройки прочие"
    FLaunchAtStartup: boolean;
    FPlaySoundOnComplete: boolean;
    FEnableAutoGetMessages: boolean;
    FAutoGetMessagesCycleDuration: integer;
    FEnableCustomHelpFile: boolean;
    FCustomHelpFile: string;

    // вкладка "настройки главного окна"
    FMainFormRect: TRect;
    FMainFormPositionByCenter: boolean;
    FFullScreenAtLaunch: boolean;

    // вкладка "настройки отображения информации"
    FOrganizationPanelHeight: word; // Высота панели организаций
    FOrganizationPanelHalfHeight: boolean; // половина высоты окна
    FDataPanelWidth: word; // Ширина панели данных
    FDataPanelHalfWidth: boolean; // половина ширины окна
    FShowDataInOtherInfoPanel: boolean; // В режиме просмотра показывать данные в окне прочей информации
    FShowMeasuresListAsRichEdit: boolean; // В режиме просмотра объединять меропрятия в общий спиcок
    FMarkSearchedStrings: boolean; // В режиме просмотра выделять искомые фрагменты строк
    FPutTownAtTheEnd: boolean; // Поместить название города в конец строки адреса

    FLastLogin: string;
    FLastPassword: string;

    procedure SetUseLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    function GetTempFolder: string;
    function GetApplicationFolder: string;
    function GetReportFolder: string;
  public
    RNE4Server, MessagesServer: TMySQLConnection;
    //
    iConfigurationFormPage: integer; // номер последней открытой страницы окна конфигурации программы
    //
    // sDefaultAction: string;
    // sApplicationFolder: string;
    // sTempFolder: string;
    // sCustomFolder: string;
    // trfReportFolder: TReportFolders;
    // bImmediatelyQuit: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    // bFullScreen: boolean;
    property EnableLog: boolean read FEnableLog write SetUseLog default True; // нужно ли вести лог работы программы
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError, lmtWarning, lmtInfo];

    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // нужно ли хранить последний введённый логин
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // нужно ли хранить последний введённый пароль
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // нужно ли выполнять автологирование

    property LastLogin: string read FLastLogin;
    property LastPassword: string read FLastPassword;

    property ReportFolder: string read GetReportFolder stored False;
    property FlushLogOnStringsQuantityValue: integer read FFlushLogOnStringsQuantityValue write FFlushLogOnStringsQuantityValue;
    property AutoGetMessagesCycleDuration: integer read FAutoGetMessagesCycleDuration write FAutoGetMessagesCycleDuration;

  end;

implementation

uses
  SysUtils,
  Windows,
  Forms;

procedure TConfiguration.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes:=Value;
end;

procedure TConfiguration.SetUseLog(const Value: boolean);
begin
  if FEnableLog<>Value then
    FEnableLog:=Value;
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

function TConfiguration.GetReportFolder: string;
begin
  case FReportFolder of
    rfTempFolder:
      GetReportFolder:=GetTempFolder;
    rfApplicationFolder:
      GetReportFolder:=GetApplicationFolder;
    rfCustomFolder:
      GetReportFolder:=FSelectedReportFolder;
  end;
end;

function TConfiguration.GetApplicationFolder: string;
var
  s: string;
begin
  GetApplicationFolder:='';

  s:=ExtractFilePath(ExpandFileName(Application.ExeName));
  if DirectoryExists(s) then
    GetApplicationFolder:=s
  else
    raise Exception.Create('Возникла ошибка при попытке получения пути рабочей папки программы!')
end;

function TConfiguration.GetTempFolder: string;
var
  r: cardinal;
  TempPathNameBuffer: PWideChar;
begin
  TempPathNameBuffer:=nil;
  GetTempFolder:='';

  try
    GetMem(TempPathNameBuffer, 1024+1);
    r:=GetTempPath(1024, TempPathNameBuffer);
    if r>0 then
      begin
        if r>1024 then
          begin
            FreeMem(TempPathNameBuffer);
            GetMem(TempPathNameBuffer, r+1);
          end;
        if DirectoryExists(TempPathNameBuffer) then
          GetTempFolder:=TempPathNameBuffer
        else
          raise Exception.Create('Возникла ошибка при попытке получения пути временной папки!')
      end;
  finally
    if TempPathNameBuffer<>nil then
      FreeMem(TempPathNameBuffer);
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
