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
    FFileName: string;
    FConfigurationFormPage: integer;
    FLastLogin: string;
    FLastPassword: string;

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
    FRNE4Server: TMySQLConnection;

    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    FMessagesServer: TMySQLConnection;

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
    FOrganizationPanelHeight: integer; // Высота панели организаций
    FOrganizationPanelHalfHeight: boolean; // половина высоты окна
    FDataPanelWidth: integer; // Ширина панели данных
    FDataPanelHalfWidth: boolean; // половина ширины окна
    FShowDataInOtherInfoPanel: boolean; // В режиме просмотра показывать данные в окне прочей информации
    FShowMeasuresListAsRichEdit: boolean; // В режиме просмотра объединять меропрятия в общий спиcок
    FMarkSearchedStrings: boolean; // В режиме просмотра выделять искомые фрагменты строк
    FPutTownAtTheEnd: boolean; // Поместить название города в конец строки адреса

    procedure SetUseLog(const Value: boolean);
    procedure SetStoreLastLogin(const Value: boolean);
    procedure SetStoreLastPassword(const Value: boolean);
    procedure SetAutoLogon(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    function GetTempFolder: string;
    function GetApplicationFolder: string;
    function GetReportFolderValue: string;
    procedure SetFileName(const Value: string);
  public
    // sDefaultAction: string;
    // sApplicationFolder: string;
    // sTempFolder: string;
    // sCustomFolder: string;
    // trfReportFolder: TReportFolders;
    // bImmediatelyQuit: boolean;
    // iOrgSortColumn: integer;
    // iMsrSortColumn: integer;
    // bFullScreen: boolean;
    constructor Create; override;
    procedure Load;
    procedure Save;
    destructor Destroy; override;

    property FileName: string read FFileName write SetFileName stored False;
    property ConfigurationFormPage: integer read FConfigurationFormPage write FConfigurationFormPage default 0; // номер последней открытой страницы окна конфигурации программы
    property LastLogin: string read FLastLogin;
    property LastPassword: string read FLastPassword;

    // вкладка "настройки интерфейса"
    property ShowAboutWindowAtLaunch: boolean read FShowAboutWindowAtLaunch write FShowAboutWindowAtLaunch default True;
    property ShowToolbarAtLaunch: boolean read FShowToolbarAtLaunch write FShowToolbarAtLaunch default True;
    property ShowStatusbarAtLaunch: boolean read FShowStatusbarAtLaunch write FShowStatusbarAtLaunch default True;
    property ShowEditboxHints: boolean read FShowEditboxHints write FShowEditboxHints default True;
    property ShowCommonSearchEditbox: boolean read FShowCommonSearchEditbox write FShowCommonSearchEditbox default True;
    property ShowID: boolean read FShowID write FShowID default False;
    property UseMultibuffer: boolean read FUseMultibuffer write FUseMultibuffer default True;
    property ShowConfirmationAtQuit: boolean read FShowConfirmationAtQuit write FShowConfirmationAtQuit default True;

    // вкладка "настройки ведения протокола работы"
    property EnableLog: boolean read FEnableLog write SetUseLog default True; // нужно ли вести лог работы программы
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError, lmtWarning, lmtInfo];
    property FlushLogOnExit: boolean read FFlushLogOnExit write FFlushLogOnExit default True;
    property FlushLogOnStringsQuantity: boolean read FFlushLogOnStringsQuantity write FFlushLogOnStringsQuantity default True;
    property FlushLogOnStringsQuantityValue: integer read FFlushLogOnStringsQuantityValue write FFlushLogOnStringsQuantityValue default -1;
    property FlushLogOnClearingLog: boolean read FFlushLogOnClearingLog write FFlushLogOnClearingLog default True;
    property FlushLogOnApply: boolean read FFlushLogOnApply write FFlushLogOnApply default False;
    property CustomLogClientFile: boolean read FCustomLogClientFile write FCustomLogClientFile default False;
    property CustomLogClientFileValue: string read FCustomLogClientFileValue write FCustomLogClientFileValue;

    // вкладка "настройки положения диалоговых окон"
    property LoginFormPosition: TFormPosition read FLoginFormPosition write FLoginFormPosition stored False;
    property OptionsFormPosition: TFormPosition read FOptionsFormPosition write FOptionsFormPosition stored False;
    property UsersFormPosition: TFormPosition read FUsersFormPosition write FUsersFormPosition stored False;
    property SetPasswordFormPosition: TFormPosition read FSetPasswordFormPosition write FSetPasswordFormPosition stored False;
    property StatisticFormPosition: TFormPosition read FStatisticFormPosition write FStatisticFormPosition stored False;
    property MaintenanceFormPosition: TFormPosition read FMaintenanceFormPosition write FMaintenanceFormPosition stored False;
    property ClearingFormPosition: TFormPosition read FClearingFormPosition write FClearingFormPosition stored False;
    property ViewPostListFormPosition: TFormPosition read FViewPostListFormPosition write FViewPostListFormPosition stored False;
    property CreateViewPostFormPosition: TFormPosition read FCreateViewPostFormPosition write FCreateViewPostFormPosition stored False;
    property PhonesFormPosition: TFormPosition read FPhonesFormPosition write FPhonesFormPosition stored False;
    property AddEditPhoneFormPosition: TFormPosition read FAddEditPhoneFormPosition write FAddEditPhoneFormPosition stored False;
    property AddMassMsrFormPosition: TFormPosition read FAddMassMsrFormPosition write FAddMassMsrFormPosition stored False;

    // вкладка "настройки процедуры логирования"
    property StoreLastLogin: boolean read FStoreLastLogin write SetStoreLastLogin default False; // нужно ли хранить последний введённый логин
    property StoreLastPassword: boolean read FStoreLastPassword write SetStoreLastPassword default False; // нужно ли хранить последний введённый пароль
    property AutoLogon: boolean read FAutoLogon write SetAutoLogon default False; // нужно ли выполнять автологирование

    // вкладка "настройки подключения к серверу базы данных услуги"
    property RNE4Server: TMySQLConnection read FRNE4Server write FRNE4Server stored False;

    // вкладка "настройки подключения к серверу системы обмена сообщениями"
    property MessagesServer: TMySQLConnection read FMessagesServer write FMessagesServer stored False;

    // вкладка "настройки формирования отчётов"
    property ReportFolder: TReportFolders write FReportFolder;
    property ReportFolderValue: string read GetReportFolderValue stored False;
    property SelectedReportFolder: string read FSelectedReportFolder write FSelectedReportFolder stored False;
    property DontDemandOverwriteConfirmation: boolean read FDontDemandOverwriteConfirmation write FDontDemandOverwriteConfirmation stored False;
    property AskForFileName: boolean read FAskForFileName write FAskForFileName default True;

    // вкладка "настройки прочие"
    property LaunchAtStartup: boolean read FLaunchAtStartup write FLaunchAtStartup default False;
    property PlaySoundOnComplete: boolean read FPlaySoundOnComplete write FPlaySoundOnComplete default True;
    property EnableAutoGetMessages: boolean read FEnableAutoGetMessages write FEnableAutoGetMessages default True;
    property AutoGetMessagesCycleDuration: integer read FAutoGetMessagesCycleDuration write FAutoGetMessagesCycleDuration default 5;
    property EnableCustomHelpFile: boolean read FEnableCustomHelpFile write FEnableCustomHelpFile default False;
    property CustomHelpFile: string read FCustomHelpFile write FCustomHelpFile;

    // вкладка "настройки главного окна"
    property MainFormRect: TRect read FMainFormRect write FMainFormRect stored False;
    property MainFormPositionByCenter: boolean read FMainFormPositionByCenter write FMainFormPositionByCenter default True;
    property FullScreenAtLaunch: boolean read FFullScreenAtLaunch write FFullScreenAtLaunch default False;

    // вкладка "настройки отображения информации"
    property OrganizationPanelHeight: integer read FOrganizationPanelHeight write FOrganizationPanelHeight default 100;
    property OrganizationPanelHalfHeight: boolean read FOrganizationPanelHalfHeight write FOrganizationPanelHalfHeight default True;
    property DataPanelWidth: integer read FDataPanelWidth write FDataPanelWidth default 340;
    property DataPanelHalfWidth: boolean read FDataPanelHalfWidth write FDataPanelHalfWidth default False;
    property ShowDataInOtherInfoPanel: boolean read FShowDataInOtherInfoPanel write FShowDataInOtherInfoPanel default True;
    property ShowMeasuresListAsRichEdit: boolean read FShowMeasuresListAsRichEdit write FShowMeasuresListAsRichEdit default True;
    property MarkSearchedStrings: boolean read FMarkSearchedStrings write FMarkSearchedStrings default True;
    property PutTownAtTheEnd: boolean read FPutTownAtTheEnd write FPutTownAtTheEnd default False;
  end;

implementation

uses
  SysUtils,
  Windows,
  Forms,
  IniFiles,
  mysql;

procedure TConfiguration.Load;
var
  FormPosition: TFormPosition;
  Rect: TRect;
begin
  if FileName>'' then
    with TIniFile.Create(FileName) do
      begin
        // вкладка "настройки интерфейса"
        ShowAboutWindowAtLaunch:=ReadBool('Интерфейс', 'bShowAboutWindowAtLaunch', True);
        ShowToolbarAtLaunch:=ReadBool('Интерфейс', 'bShowToolbarAtLaunch', True);
        ShowStatusbarAtLaunch:=ReadBool('Интерфейс', 'bShowStatusbarAtLaunch', True);
        ShowEditboxHints:=ReadBool('Интерфейс', 'bShowEditboxHints', True);
        ShowCommonSearchEditbox:=ReadBool('Интерфейс', 'bShowCommonSearchEditbox', True);
        ShowID:=ReadBool('Интерфейс', 'bShowID', False);
        UseMultibuffer:=ReadBool('Интерфейс', 'bUseMultibuffer', True);
        ShowConfirmationAtQuit:=ReadBool('Интерфейс', 'bShowConfirmationAtQuit', True);

        // вкладка "настройки ведения протокола работы"
        EnableLog:=ReadBool('Протоколирование', 'bEnableLog', True);
        FlushLogOnExit:=ReadBool('Протоколирование', 'bFlushLogOnExit', True);
        FlushLogOnStringsQuantity:=ReadBool('Протоколирование', 'bFlushLogOnStringsQuantity', True);
        FlushLogOnStringsQuantityValue:=ReadInteger('Протоколирование', 'iFlushLogOnStringsQuantityValue', -1);
        FlushLogOnClearingLog:=ReadBool('Протоколирование', 'bFlushLogOnClearingLog', True);
        FlushLogOnApply:=ReadBool('Протоколирование', 'bFlushLogOnApply', False);
        CustomLogClientFile:=ReadBool('Протоколирование', 'bCustomLogClientFile', False);
        CustomLogClientFileValue:=ReadString('Протоколирование', 'sCustomLogClientFileValue', '');
        if ReadBool('Протоколирование', 'bKeepErrorLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtError]
        else
          KeepLogTypes:=KeepLogTypes-[lmtError];
        if ReadBool('Протоколирование', 'bKeepWarningLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtWarning]
        else
          KeepLogTypes:=KeepLogTypes-[lmtWarning];
        if ReadBool('Протоколирование', 'bKeepInfoLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtInfo]
        else
          KeepLogTypes:=KeepLogTypes-[lmtInfo];
        if ReadBool('Протоколирование', 'bKeepSQLLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtSQL]
        else
          KeepLogTypes:=KeepLogTypes-[lmtSQL];
        if ReadBool('Протоколирование', 'bKeepDebugLog', True) then
          KeepLogTypes:=KeepLogTypes+[lmtDebug]
        else
          KeepLogTypes:=KeepLogTypes-[lmtDebug];

        // вкладка "настройки положения диалоговых окон"
        with FormPosition do
          begin
            bCenter:=ReadBool('Положение диалоговых окон', 'LoginFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'LoginFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'LoginFormPosition.iy', -1);
            LoginFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'OptionsFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'OptionsFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'OptionsFormPosition.iy', -1);
            OptionsFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'UsersFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'UsersFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'UsersFormPosition.iy', -1);
            UsersFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'SetPasswordFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'SetPasswordFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'SetPasswordFormPosition.iy', -1);
            SetPasswordFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'StatisticFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'StatisticFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'StatisticFormPosition.iy', -1);
            StatisticFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'MaintenanceFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'MaintenanceFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'MaintenanceFormPosition.iy', -1);
            MaintenanceFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'ClearingFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'ClearingFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'ClearingFormPosition.iy', -1);
            ClearingFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'ViewPostListFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'ViewPostListFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'ViewPostListFormPosition.iy', -1);
            ViewPostListFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'CreateViewPostFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'CreateViewPostFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'CreateViewPostFormPosition.iy', -1);
            CreateViewPostFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'PhonesFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'PhonesFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'PhonesFormPosition.iy', -1);
            PhonesFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'AddEditPhoneFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'AddEditPhoneFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'AddEditPhoneFormPosition.iy', -1);
            AddEditPhoneFormPosition:=FormPosition;

            bCenter:=ReadBool('Положение диалоговых окон', 'AddMassMsrFormPosition.bCenter', True);
            x:=ReadInteger('Положение диалоговых окон', 'AddMassMsrFormPosition.ix', -1);
            y:=ReadInteger('Положение диалоговых окон', 'AddMassMsrFormPosition.iy', -1);
            AddMassMsrFormPosition:=FormPosition;
          end;

        // вкладка "настройки процедуры логирования"
        StoreLastLogin:=ReadBool('Идентификация', 'bStoreLastLogin', False);
        StoreLastPassword:=ReadBool('Идентификация', 'bStoreLastPassword', False);
        AutoLogon:=ReadBool('Идентификация', 'bAutoLogon', False);

        // вкладка "подключения к серверу базы данных услуги"
        with RNE4Server do
          begin
            Host:=ReadString('Сервер и база данных', 'RNE4Server.sHost', 'localhost');
            Port:=ReadInteger('Сервер и база данных', 'RNE4Server.iPort', MYSQL_PORT);
            Timeout:=ReadInteger('Сервер и база данных', 'RNE4Server.iTimeout', 30);
            Compression:=ReadBool('Сервер и база данных', 'RNE4Server.bCompression', True);
            // Login:=ReadString('Сервер и база данных', 'RNE4Server.sLogin', '');
            // Password:=ReadString('Сервер и база данных', 'RNE4Server.sPassword', '');
            Database:=ReadString('Сервер и база данных', 'RNE4Server.sDatabase', 'rne4');
          end;

        // вкладка "подключения к серверу системы обмена сообщениями"
        with MessagesServer do
          begin
            Host:=ReadString('Сервер и база данных', 'MessagesServer.sHost', 'localhost');
            Port:=ReadInteger('Сервер и база данных', 'MessagesServer.iPort', MYSQL_PORT);
            Timeout:=ReadInteger('Сервер и база данных', 'MessagesServer.iTimeout', 30);
            Compression:=ReadBool('Сервер и база данных', 'MessagesServer.bCompression', True);
            // Login:=ReadString('Сервер и база данных', 'MessagesServer.sLogin', '');
            // Password:=ReadString('Сервер и база данных', 'MessagesServer.sPassword', '');
            Database:=ReadString('Сервер и база данных', 'MessagesServer.sDatabase', 'rne4messages');
          end;

        // вкладка "настройки прочие"
        LaunchAtStartup:=ReadBool('Прочие', 'bLaunchAtStartup', False);
        PlaySoundOnComplete:=ReadBool('Прочие', 'bPlaySoundOnComplete', True);
        EnableAutoGetMessages:=ReadBool('Прочие', 'bEnableAutoGetMessages', True);
        AutoGetMessagesCycleDuration:=ReadInteger('Протоколирование', 'iAutoGetMessagesCycleDuration', 5);
        EnableCustomHelpFile:=ReadBool('Прочие', 'bEnableCustomHelpFile', False);
        CustomHelpFile:=ReadString('Прочие', 'sCustomHelpFile', '');

        // вкладка "настройки главного окна"
        with Rect do
          begin
            Left:=ReadInteger('Главное окно', 'MainFormRect.iLeft', 0);
            Top:=ReadInteger('Главное окно', 'MainFormRect.iTop', 0);
            Right:=ReadInteger('Главное окно', 'MainFormRect.iRight', 800);
            Bottom:=ReadInteger('Главное окно', 'MainFormRect.iBottom', 600);
            MainFormRect:=Rect;
          end;
        MainFormPositionByCenter:=ReadBool('Главное окно', 'bMainFormPositionByCenter', True);
        FullScreenAtLaunch:=ReadBool('Главное окно', 'bFullScreenAtLaunch', False);

        // вкладка "настройки отображения информации"
        OrganizationPanelHeight:=ReadInteger('Отображение информации', 'iOrganizationPanelHeight', 100);
        OrganizationPanelHalfHeight:=ReadBool('Отображение информации', 'bOrganizationPanelHalfHeight', True);
        DataPanelWidth:=ReadInteger('Отображение информации', 'iDataPanelWidth', 340);
        DataPanelHalfWidth:=ReadBool('Отображение информации', 'bOrganizationPanelHalfHeight', False);
        ShowDataInOtherInfoPanel:=ReadBool('Отображение информации', 'bShowDataInOtherInfoPanel', True);
        ShowMeasuresListAsRichEdit:=ReadBool('Отображение информации', 'bShowMeasuresListAsRichEdit', True);
        MarkSearchedStrings:=ReadBool('Отображение информации', 'bMarkSearchedStrings', True);
        PutTownAtTheEnd:=ReadBool('Отображение информации', 'bPutTownAtTheEnd', False);
      end
  else
    raise Exception.Create('Имя файла конфигурации не должно быть пустым!');
end;

procedure TConfiguration.Save;
begin

end;

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

function TConfiguration.GetReportFolderValue: string;
begin
  case FReportFolder of
    rfTempFolder:
      Result:=GetTempFolder;
    rfApplicationFolder:
      Result:=GetApplicationFolder;
    rfCustomFolder:
      Result:=FSelectedReportFolder;
  end;
end;

constructor TConfiguration.Create;
begin
  inherited;
  RNE4Server:=TMySQLConnection.Create;
  MessagesServer:=TMySQLConnection.Create;
  FFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase]);
end;

destructor TConfiguration.Destroy;
begin
  MessagesServer.Free;
  RNE4Server.Free;
  inherited;
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

procedure TConfiguration.SetFileName(const Value: string);
begin
  if FFileName<>Value then
    if Trim(Value)<>'' then
      FFileName:=Trim(Value)
    else
      raise Exception.Create('Имя файла конфигурации не должно быть пустым!');
end;

end.
