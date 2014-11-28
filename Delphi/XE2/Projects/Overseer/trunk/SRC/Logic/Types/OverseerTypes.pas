unit OverseerTypes;

interface

uses
  Classes,
  SysUtils,
  CastersPackage.uMysql,
  ComCtrls;

type
  tXRD=(XRDInput, XRDOutput);
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug); // типы сообщений передаваемых в лог
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);
  tTTI=(TTI_NONE, TTI_INFO, TTI_WARNING, TTI_ERROR);
  TGroupByPeriod=(gbpNone, gbpHours, gbpDays, gbpWeeks, gbpMonths, gbpQuarters, gbpYears);

  trService=record
    sNumber: string;
    sName: string;
    bAutoService: boolean;
    bUsedInReport_SIC_03: boolean;
  end;

  trNet=record
    sName: string;
    sHTMLMobileNetName: string;
    sHTMLAbonentsName: string;
    sQuery: string;
  end;

  trIRDTableRecord=record
    ani: string;
    ddi: string;
    datum: string;
    vrijeme: string;
    dur: string;
    rm: string;
    izg: string;
    izgnum: string;
    v_oper: string;
    v_mreza: string;
  end;

  TUserRec=record
    sID: string;
    sLogin: string;
    sPassword: string;
    sFullName: string;
    sPosition: string;
    sContactPhone: string;
    bIsAdmin: boolean;
    bLogged: boolean;
  end;

  TMySQLServerConnectionDetails=record
    bConnected: boolean;
    hConnection: PMYSQL;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
    sMySQLDatabase_IRD_Location, sMySQLDatabase_ORD_Location, sMySQLDatabase_IRDA_Location, sMySQLDatabase_ORDA_Location, sMySQLDatabase_PRIJAVE_Location, sMySQLDatabase_PRIJAVE_Q_Location, sMySQLDatabase_T_DAY_Location: string;
  end;

  TConfigurationRec=record
    OverseerServer, DBServer, StatServer, RNE4Server: TMySQLServerConnectionDetails;

    bAutoLogon, bStoreLastLogin, bStoreLastPassword: boolean;
    sLastLogin, sLastPassword: string;

    sLocalHost: string;
    iConfigurationFormPage: integer;

    bAlwaysShowTrayIcon: boolean; // всегда отобращать иконку в трее
    bShowQuitConfirmation: boolean;
    bUseExternalLog: boolean;
    sDefaultAction: string;
    bNoStatusBar: boolean;
    bScrollToLastLogMessage: boolean;
    bAutorun: boolean;
    bStartInTray: boolean;
    bPlaySoundAfterAction: boolean;
    bShowBaloonHintAfterAction: boolean;

    bKeepErrorLog: boolean; // нужно ли вести лог сообщений типа error
    bKeepWarningLog: boolean; // нужно ли вести лог сообщений типа warning
    bKeepInfoLog: boolean; // нужно ли вести лог сообщений типа info
    bKeepSQLLog: boolean; // нужно ли вести лог запросов MySQL
    bKeepDebugLog: boolean; // нужно ли вести лог отладочной информации
    bFlushLogOnExit: boolean; // выполнять ли сохранение лога в файл при выходе из программы
    iFlushLogOnStringsQuantity: integer; // при каком количестве строк лога скидывать их в файл
    bFlushLogOnClearingLog: boolean; // выполнять ли сохранение лога в файл при очистке лога

    sApplicationFolder: string;
    sTempFolder: string;
    sCustomFolder: string;
    trfReportFolder: TReportFolders;
    bDontDemandOverwriteConfirmation: boolean;
    bAskForFileName: boolean;
  end;

type
  TThread_Do_SIC=class(TThread)
  private
    FttsActionStart: TTimeStamp;
    FlwTotalTime: LongWord;
    FStartDate, FStopDate: TDate;
    FOpenWithBrowser: boolean;
    FCurrentUser: TUserRec;
    FEnableTimer: boolean;
    FLogGroupGUID: string;
    procedure SetEnableTimer(const Value: boolean);
    procedure SetConfiguration(const Value: TConfigurationRec);
    function GetDatesDiff: char;
    procedure _StartTimer(const aLogGroupGUID: string);
    procedure _StopTimer(const aLogGroupGUID: string);
  protected
    FConfiguration: TConfigurationRec;
    procedure _MySQL_OpenConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure _MySQL_CloseConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure _MySQL_CreateTable(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
    procedure _MySQL_CheckTableExistance(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
    procedure _MySQL_LockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
    procedure _MySQL_UnlockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    function _MySQL_InsertRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
    function _MySQL_UpdateRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
    procedure ProcedureHeader(aTitle: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aError: boolean; const aErrorMessage: string);
    procedure _CreateProgressBar(const aTime: TDateTime; const aTitle: string; const aMax: integer);
    procedure StepProgressBar;
    procedure LogThis(aMessage: string; aMessageType: TLogMessagesType);
    function GetWeeksList(const aStartDate, aStopDate: TDate; const aCalculateWeekFromMonday: boolean): TStringList;
    procedure PlaySound;
    procedure ShowBaloonHint(const aBalloonTitle, aBalloonHint: string);

    property EnableTimer: boolean read FEnableTimer write SetEnableTimer default False;
    property LogGroupGUID: string read FLogGroupGUID write FLogGroupGUID;
    property StartDate: TDate read FStartDate write FStartDate;
    property StopDate: TDate read FStopDate write FStopDate;
    property CurrentUser: TUserRec read FCurrentUser write FCurrentUser;
    property OpenWithBrowser: boolean read FOpenWithBrowser write FOpenWithBrowser;
    property DatesDiffChar: char read GetDatesDiff;
  public
    _ProgressBar: TProgressBar;
    _ListItem: TListItem;
    property Configuration: TConfigurationRec read FConfiguration write SetConfiguration;
    constructor Create;
  end;

implementation

uses
  Windows,
  Messages,
  Controls,
  DateUtils,
  Main,
  OverseerConsts,
  OverseerRoutines,
  MMSystem,
  ExtCtrls;

function TThread_Do_SIC.GetDatesDiff: char;
var
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  bStartOfTheYear, bStartOfTheMonth, bEndOfTheYear, bEndOfTheMonth, bStartOfTheWeek, bEndOfTheWeek, bStartOfTheQuarter, bEndOfTheQuarter: boolean;
begin
  wStartDay:=DayOf(StartDate);
  wStartMonth:=MonthOf(StartDate);
  wStartYear:=YearOf(StartDate);
  wStopDay:=DayOf(StopDate);
  wStopMonth:=MonthOf(StopDate);
  wStopYear:=YearOf(StopDate);

  bStartOfTheYear:=SameDate(StartOfTheYear(StartDate), StartDate);
  bEndOfTheYear:=SameDate(EndOfTheYear(StopDate), StopDate);
  bStartOfTheMonth:=SameDate(StartOfTheMonth(StartDate), StartDate);
  bEndOfTheMonth:=SameDate(EndOfTheMonth(StopDate), StopDate);
  bStartOfTheQuarter:=(wStartMonth in [1, 4, 7, 10])and bStartOfTheMonth;
  bEndOfTheQuarter:=(wStopMonth in [3, 6, 9, 12])and bEndOfTheMonth;
  bStartOfTheWeek:=SameDate(StartOfTheWeek(StartDate), StartDate);
  bEndOfTheWeek:=SameDate(EndOfTheWeek(StopDate), StopDate);

  // Формирование имени суффикса для номера отчёта
  // если начальная дата является началом года и конечная является концом года
  if bStartOfTheYear and bEndOfTheYear and(wStartYear=wStopYear) then
    Result:='Г'
  else
    // если начальная дата является началом квартала и конечная является концом квартала
    if bStartOfTheQuarter and bEndOfTheQuarter and(wStartYear=wStopYear)and(wStopMonth=wStartMonth+2) then
      Result:='К'
    else
      // если начальная дата является началом месяца и конечная является концом месяца
      if bStartOfTheMonth and bEndOfTheMonth and(wStartYear=wStopYear)and(wStartMonth=wStopMonth) then
        Result:='М'
      else
        // если начальная дата является началом недели и конечная дата является концом этой же недели
        if bStartOfTheWeek and bEndOfTheWeek and SameDate(IncDay(StartDate, 6), StopDate) then
          Result:='Н'
        else
          // если начальная дата и конечная совпадают
          if (wStartYear=wStopYear)and(wStartMonth=wStopMonth)and(wStartDay=wStopDay) then
            Result:='Д'
          else
            Result:='П';
end;

procedure TThread_Do_SIC._MySQL_OpenConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      LogThis('>> Выполняется операция подключения к MySQL-серверу '+sMySQLHost+'...', lmtDebug);
      if bConnected then
        Routines_GenerateError('Была предпринята попытка подключения к подключенному в настоящий момент серверу MySQL!', sErrorMessage, bError)
      else
        begin
          hConnection:=mysql_init(nil);
          if hConnection=nil then
            Routines_GenerateError('Возникла ошибка при инициализации объекта соединения с сервером MySQL!', sErrorMessage, bError)
          else
            begin
              LogThis('Инициализация объекта соединения с сервером MySQL выполнена успешно.', lmtDebug);
              bConnected:=mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar('overseer'), PAnsiChar(''), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil, integer(bMySQLCompress)*CLIENT_COMPRESS)<>nil;
              if not bConnected then
                Routines_GenerateError('Возникла ошибка при попытке подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('Подключение к серверу MySQL выполнено успешно.', lmtDebug);
            end;
        end;
      LogThis('<< Выполнение операции подключения к MySQL-серверу '+sMySQLHost+' завершено.', lmtDebug);
    end;
end;

procedure TThread_Do_SIC._MySQL_CheckTableExistance(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
var
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  i: integer;
begin
  LogThis('>> Выполняется операция проверки наличия таблицы данных "'+aTableName+'" в базе данных...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              q:='SHOW TABLES FROM '+aMySQLDatabase+' LIKE "'+LowerCase(aTableName)+'";';
              LogThis(q, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                begin
                  LogThis('Запрос выполнен успешно.', lmtDebug);
                  ResultSet:=mysql_store_result(hConnection);
                  if ResultSet=nil then
                    Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
                  else
                    begin
                      LogThis('Результирующая выборка получена успешно.', lmtDebug);
                      i:=mysql_num_rows(ResultSet);
                      LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtDebug);
                      if i<0 then
                        Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                      else
                        begin
                          if i<>1 then
                            Routines_GenerateError('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                          else
                            begin
                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                              ResultRow:=mysql_fetch_row(ResultSet);
                              if ResultRow=nil then
                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
                              else
                                begin
                                  if LowerCase(string(ResultRow[0]))<>LowerCase(aTableName) then
                                    Routines_GenerateError('Полученное имя таблицы данных не соответствует требуемому!', sErrorMessage, bError)
                                  else
                                    LogThis('Наличие таблицы данных проверено успешно.', lmtDebug);
                                end;
                            end;
                        end;
                      mysql_free_result(ResultSet);
                      LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                    end;
                end;
            end;
        end;
    end;
  LogThis('<< Выполнение операции проверки наличия таблицы данных "'+aTableName+'" в базе данных завершено.', lmtDebug);
end;

procedure TThread_Do_SIC._MySQL_CloseConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      if bConnected then
        begin
          LogThis('>> Выполняется операция отключения от MySQL-сервера '+sMySQLHost+'...', lmtDebug);
          if hConnection<>nil then
            begin
              mysql_close(hConnection);
              hConnection:=nil;
            end;
          bConnected:=False;
          LogThis('Отключение от MySQL-сервера выполнено.', lmtDebug);
          LogThis('<< Выполнение операции отключения от MySQL-сервера '+sMySQLHost+' завершено.', lmtDebug);
        end;
    end;
end;

procedure TThread_Do_SIC._MySQL_LockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
var
  q: string;
begin
  LogThis('>> Выполняется операция блокировки таблицы базы данных...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              q:='LOCK TABLE '+aTablesList+';';
              LogThis(q, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('Запрос выполнен успешно.', lmtDebug);
            end;
        end;
    end;
  LogThis('<< Выполнение операции блокировки таблицы базы данных завершено.', lmtDebug);
end;

procedure TThread_Do_SIC._MySQL_UnlockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
var
  q: string;
begin
  LogThis('>> Выполняется операция разблокирования всех ранее заблокированных таблиц базы данных...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              q:='UNLOCK TABLES;';
              LogThis(q, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('Запрос выполнен успешно.', lmtDebug);
            end;
        end;
    end;
  LogThis('<< Выполнение операции разблокирования таблиц базы данных завершено.', lmtDebug);
end;

function TThread_Do_SIC._MySQL_UpdateRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> Выполняется операция обновления данных таблицы...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              LogThis(aQuery, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                begin
                  LogThis('Запрос выполнен успешно.', lmtDebug);
                  Result:=mysql_affected_rows(hConnection);
                  LogThis('Количество обработанных строк равно '+IntToStr(Result)+'.', lmtDebug);
                  if Result<0 then
                    Routines_GenerateError('Количество обработанных строк ('+IntToStr(Result)+') не соответствует требуемому (>=0)!', sErrorMessage, bError)
                  else
                    LogThis('Обновление данных выполнено успешно.', lmtDebug);
                end;
            end;
        end;
    end;
  LogThis('<< Выполнение операции обновления данных таблицы завершено.', lmtDebug);
end;

procedure TThread_Do_SIC.ProcedureHeader(aTitle: string);
begin
  LogThis('['+aTitle+']', lmtDebug);
  LogThis('Начало процедуры...', lmtDebug);
  Synchronize( procedure begin MainForm.Inc_BusyState(LogGroupGUID); end);
end;

procedure TThread_Do_SIC.PreFooter(const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    begin
      Synchronize( //
        procedure //
      begin //
        _ListItem.ImageIndex:=2; //
        _ProgressBar.State:=pbsError; //
      end //
        ); //
      LogThis(aErrorMessage, lmtError);
    end
  else
    begin
      Synchronize( procedure begin _ListItem.ImageIndex:=1; end);
      LogThis('Процедура выполнена без ошибок.', lmtDebug);
    end;
  PlaySound;
end;

procedure TThread_Do_SIC.ProcedureFooter;
begin
  Synchronize( procedure begin MainForm.Dec_BusyState(LogGroupGUID); end);
  LogThis('Окончание процедуры.', lmtDebug);
end;

procedure TThread_Do_SIC._MySQL_CreateTable(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
begin
  LogThis('>> Выполняется операция по созданию таблицы данных...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        if mysql_ping(hConnection)<>0 then
          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
        else
          begin
            LogThis(aQuery, lmtSQL);
            if mysql_real_query(hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
            else
              LogThis('Запрос выполнен успешно.', lmtDebug);
          end;
    end;
  LogThis('<< Выполнение операции по созданию таблицы данных завершено.', lmtDebug);
end;

function TThread_Do_SIC._MySQL_InsertRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> Выполняется операция вставки записей в таблицу...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              LogThis(aQuery, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                begin
                  LogThis('Запрос выполнен успешно.', lmtDebug);
                  Result:=mysql_affected_rows(hConnection);
                  LogThis('Количество обработанных строк равно '+IntToStr(Result)+'.', lmtDebug);
                  if Result<0 then
                    Routines_GenerateError('Количество обработанных строк ('+IntToStr(Result)+') не соответствует требуемому (>=0)!', sErrorMessage, bError)
                  else
                    LogThis('Вставка данных выполнена успешно.', lmtDebug);
                end;
            end;
        end;
    end;
  LogThis('<< Выполнение операции вставки записей в таблицу завершено.', lmtDebug);
end;

procedure TThread_Do_SIC.LogThis(aMessage: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_THREADLOG)+';'+s+';'+aMessage+';'+LogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TThread_Do_SIC.StepProgressBar;
begin
  Synchronize(procedure
  begin //
    _ProgressBar.Position:=_ProgressBar.Position+_ProgressBar.Step;
  end); //
end;

procedure TThread_Do_SIC._CreateProgressBar(const aTime: TDateTime; const aTitle: string; const aMax: integer);
var
  ProgressBarRect: TRect;
begin
  Synchronize( //
    procedure begin //
    _ListItem:=MainForm.lvActionList.Items.Add; //
    _ListItem.SubItems.Add(''); //
    _ListItem.SubItems.Add(FormatDateTime('yyyy.mm.dd hh:nn:ss', aTime)); //
    _ListItem.SubItems.Add('выполняется...'); //
    _ListItem.SubItems.Add(aTitle); //
    _ListItem.ImageIndex:=0; //

    ProgressBarRect:=_ListItem.DisplayRect(drBounds); //
    ProgressBarRect.Top:=ProgressBarRect.Top+1; //
    ProgressBarRect.Bottom:=ProgressBarRect.Bottom-2; //
    ProgressBarRect.Left:=ProgressBarRect.Left+MainForm.lvActionList.Columns[0].Width+1; //
    ProgressBarRect.Right:=ProgressBarRect.Left+MainForm.lvActionList.Columns[1].Width-1; //

    _ProgressBar:=TProgressBar.Create(MainForm.lvActionList); //
    _ProgressBar.Parent:=MainForm.lvActionList; //
    _ProgressBar.BoundsRect:=ProgressBarRect; //
    _ProgressBar.Cursor:=crHandPoint; _ProgressBar.Min:=0; //
    _ProgressBar.Max:=aMax; //
    _ProgressBar.Position:=_ProgressBar.Min; //
    _ProgressBar.Step:=1; //
    _ProgressBar.State:=pbsNormal; //
    _ProgressBar.TabStop:=False; //
    _ListItem.Data:=_ProgressBar; //
    _ProgressBar.OnMouseUp:=MainForm._ProgressBarMouseUp; //
  end //
    ); //
end;

procedure TThread_Do_SIC._StartTimer(const aLogGroupGUID: string);
begin
  // старт замера времени выполнения процедуры
  FttsActionStart:=DateTimeToTimeStamp(Now);
  LogThis('Замер времени выполнения действия начат.', lmtDebug);
end;

procedure TThread_Do_SIC._StopTimer(const aLogGroupGUID: string);
begin
  // окончание замера времени выполнения процедуры
  FlwTotalTime:=DateTimeToTimeStamp(Now).Time-FttsActionStart.Time;
  Synchronize( procedure begin _ListItem.SubItems[2]:=IntToStr(integer(FlwTotalTime)); end);
  LogThis('Время выполнения действия составило '+Format('%.3f', [integer(FlwTotalTime)/1000])+' сек.', lmtInfo);
end;

procedure TThread_Do_SIC.SetConfiguration(const Value: TConfigurationRec);
begin
  FConfiguration:=Value;
  with FConfiguration do
    begin
      OverseerServer.bConnected:=False;
      DBServer.bConnected:=False;
      StatServer.bConnected:=False;
      RNE4Server.bConnected:=False;
    end;
end;

procedure TThread_Do_SIC.SetEnableTimer(const Value: boolean);
begin
  if Value<>FEnableTimer then
    begin
      FEnableTimer:=Value;
      if FEnableTimer then
        _StartTimer(LogGroupGUID)
      else
        _StopTimer(LogGroupGUID);
      LogThis('Таймер замера длительности выполнения процесса '+Routines_GetConditionalMessage(FEnableTimer, 'в', 'от')+'ключён.', lmtDebug);
    end;
end;

function TThread_Do_SIC.GetWeeksList(const aStartDate, aStopDate: TDate; const aCalculateWeekFromMonday: boolean): TStringList;
var
  dtDate: TDate;
  slDatesFullList: TStringList;
  iRoutineCounter: integer;
  dtStartOfTheWeek, dtEndOfTheWeek: TDate;
begin
  dtDate:=aStartDate;
  Result:=TStringList.Create;
  try
    Result.Sorted:=False;
    Result.Duplicates:=dupIgnore;
    if aCalculateWeekFromMonday then
      begin
        slDatesFullList:=TStringList.Create;
        try
          slDatesFullList.Duplicates:=dupIgnore;
          slDatesFullList.Sorted:=False;
          repeat
            slDatesFullList.Add(FormatDateTime('dd.mm.yyyy', dtDate));
            dtDate:=IncDay(dtDate, 1);
          until dtDate>aStopDate;
          for iRoutineCounter:=0 to slDatesFullList.Count-1 do
            begin
              dtStartOfTheWeek:=StartOfTheWeek(StrToDate(slDatesFullList[iRoutineCounter]));
              if dtStartOfTheWeek<aStartDate then
                dtStartOfTheWeek:=aStartDate;
              dtEndOfTheWeek:=EndOfTheWeek(StrToDate(slDatesFullList[iRoutineCounter]));
              if dtEndOfTheWeek>aStopDate then
                dtEndOfTheWeek:=aStopDate;
              if Result.IndexOf(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek))=-1 then
                Result.Add(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek));
            end;
        finally
          slDatesFullList.Free;
        end;
      end
    else
      begin
        repeat
          dtStartOfTheWeek:=dtDate;
          dtEndOfTheWeek:=IncDay(dtDate, 6);
          if dtEndOfTheWeek>aStopDate then
            dtEndOfTheWeek:=aStopDate;
          dtDate:=IncDay(dtDate, 7);
          if Result.IndexOf(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek))=-1 then
            Result.Add(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek));
        until dtDate>aStopDate;
      end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

constructor TThread_Do_SIC.Create;
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
end;

procedure TThread_Do_SIC.ShowBaloonHint(const aBalloonTitle, aBalloonHint: string);
begin
  if Configuration.bShowBaloonHintAfterAction then
    begin
      Synchronize( procedure begin with MainForm.TrayIcon1 do begin BalloonHint:=aBalloonHint; BalloonTitle:=aBalloonTitle; BalloonFlags:=bfInfo; ShowBalloonHint; end; end);
    end;
end;

procedure TThread_Do_SIC.PlaySound;
begin
  if Configuration.bPlaySoundAfterAction then
    MMSystem.PlaySound('WAVE_0', HInstance, SND_RESOURCE or SND_ASYNC);
  // MMSystem.PlaySound(PWideChar('C:\Windows\Media\tada.wav'), 0, SND_FILENAME or SND_ASYNC);
end;

end.
