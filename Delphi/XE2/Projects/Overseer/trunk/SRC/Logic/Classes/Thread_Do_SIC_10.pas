unit Thread_Do_SIC_10;

interface

uses
  Classes,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_10=class(TThread_Do_SIC)
  private
    FAllUsers: boolean;
    FCalculateWeekFromMonday: boolean;
    FCreateDetailedReport: boolean;
    FCCID: integer;
    FGroupByPeriod: TGroupByPeriod;
    FSelectedUserList: TStringList;
  protected
    procedure Execute; override;
    property AllUsers: boolean read FAllUsers write FAllUsers;
    property CalculateWeekFromMonday: boolean read FCalculateWeekFromMonday write FCalculateWeekFromMonday;
    property CreateDetailedReport: boolean read FCreateDetailedReport write FCreateDetailedReport;
    property CCID: integer read FCCID write FCCID;
    property GroupByPeriod: TGroupByPeriod read FGroupByPeriod write FGroupByPeriod;
    property SelectedUserList: TStringList read FSelectedUserList write FSelectedUserList;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aAllUsers, aCalculateWeekFromMonday, aCreateDetailedReport: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aCCID: integer;
      aGroupByPeriod: TGroupByPeriod; aSelectedUserList: TStringList);
    destructor Destroy; override;
  end;

implementation

uses
  Main,
  OverseerRoutines,
  DateUtils,
  SysUtils,
  CastersPackage.uMysql;

constructor TThread_Do_SIC_10.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aAllUsers, aCalculateWeekFromMonday, aCreateDetailedReport: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec;
  aCCID: integer; aGroupByPeriod: TGroupByPeriod; aSelectedUserList: TStringList);
begin
  inherited Create;
  with Self do
    begin
      LogGroupGUID:=aLogGroupGUID;
      StartDate:=aStartDate;
      StopDate:=aStopDate;
      OpenWithBrowser:=aOpenWithBrowser;
      CurrentUser:=aCurrentUser;
      Configuration:=aConfiguration;

      AllUsers:=aAllUsers;
      CalculateWeekFromMonday:=aCalculateWeekFromMonday;
      CreateDetailedReport:=aCreateDetailedReport;
      CCID:=aCCID;
      GroupByPeriod:=aGroupByPeriod;

      SelectedUserList:=TStringList.Create;
      SelectedUserList.Sorted:=False;
      SelectedUserList.Assign(aSelectedUserList);
    end;
end;

destructor TThread_Do_SIC_10.Destroy;
begin
  SelectedUserList.Free;
  inherited;
end;

procedure TThread_Do_SIC_10.Execute;
const
  LogGroupGUID: string='{9B268ACE-7B3E-485A-AAE9-F2304A9A3645}';
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sReportPeriod: string;
  iRoutineCounter: integer;
  iRowQuantity, iRowCounter: integer;
  slUserList: TStringList;
  q: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  sUserGroupName: string;
  sPeriodColumnQuery, sGroupByQuery: string;
  sPeriodColumn: string;
  sReportSuffix: string;
  slWeeksList: TStringList;
  iWeekCounter: integer;
  bAnyReportDataExists: boolean;
  sCCID: string;
  sCreateQuery: string;
  iSourceRowCounter, iRowCountSource: integer;
  sCCIDPrefix: string;
  iLoopCounter: integer;
  sReportCode: string;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-10-...');

  // старт замера времени выполнения процедуры
  EnableTimer:=True;

  // инициализация значений переменных
  bError:=False;
  bAnyReportDataExists:=False; // если хоть какие-нить данные будут добавлены в отчёт, переменную выставляем в true, иначе выводим строку, что данные найдены не были

  dtNow:=Now;

  wStartDay:=DayOf(StartDate);
  wStartMonth:=MonthOf(StartDate);
  wStartYear:=YearOf(StartDate);
  wStopDay:=DayOf(StopDate);
  wStopMonth:=MonthOf(StopDate);
  wStopYear:=YearOf(StopDate);

  sShortStartDate:=FormatDateTime('dd.mm.yyyy', StartDate);
  sShortStopDate:=FormatDateTime('dd.mm.yyyy', StopDate);
  sSQLFormatStartDate:=FormatDateTime('yyyy-mm-dd', StartDate);
  sSQLFormatStopDate:=FormatDateTime('yyyy-mm-dd', StopDate);
  sLongStartDate:=IntToStr(wStartDay)+' '+saMonths2[wStartMonth]+' '+IntToStr(wStartYear)+' года';
  sLongStopDate:=IntToStr(wStopDay)+' '+saMonths2[wStopMonth]+' '+IntToStr(wStopYear)+' года';

  case DatesDiffChar of
    'Г':
      sReportPeriod:=FormatDateTime('yyyy год', StartDate);
    'К':
      sReportPeriod:=saQuarters[wStopMonth div 3]+' квартал '+IntToStr(wStartYear)+' года';
    'М':
      sReportPeriod:=saMonths1[wStartMonth]+' '+IntToStr(wStartYear)+' года';
    'Н':
      sReportPeriod:='неделю с'+Routines_GetConditionalMessage(wStartDay=2, 'о', '')+' '+sLongStartDate+' по '+sLongStopDate;
    'Д':
      sReportPeriod:=sLongStartDate;
    'П':
      sReportPeriod:='период с'+Routines_GetConditionalMessage(wStartDay=2, 'о', '')+' '+sLongStartDate+' по '+sLongStopDate;
  end;

  case GroupByPeriod of
    gbpHours:
      Routines_GenerateError('Возникла ошибка при получении параметров группировки данных для формирования отчёта!', sErrorMessage, bError);
    gbpDays:
      begin
        sPeriodColumn:='<BR>(день, месяц, год)';
        sPeriodColumnQuery:='DATE_FORMAT(date, "%d.%m.%Y")';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-Д';
      end;
    gbpWeeks:
      begin
        sPeriodColumn:='<BR>(начало, конец недели)';
        if CalculateWeekFromMonday then
          sReportSuffix:=DatesDiffChar+'-НП'
        else
          sReportSuffix:=DatesDiffChar+'-НД';
      end;
    gbpMonths:
      begin
        sPeriodColumn:='<BR>(месяц, год)';
        sPeriodColumnQuery:='CONCAT(IF(DATE_FORMAT(date, "%m")=1, "январь", IF(DATE_FORMAT(date, "%m")=2, "февраль", IF(DATE_FORMAT(date, "%m")=3, "март", '+
          'IF(DATE_FORMAT(date, "%m")=4, "апрель", IF(DATE_FORMAT(date, "%m")=5, "май", IF(DATE_FORMAT(date, "%m")=6, "июнь", IF(DATE_FORMAT(date, "%m")=7, "июль", '+
          'IF(DATE_FORMAT(date, "%m")=8, "август", IF(DATE_FORMAT(date, "%m")=9, "сентябрь", IF(DATE_FORMAT(date, "%m")=10, "октябрь", '+
          'IF(DATE_FORMAT(date, "%m")=11, "ноябрь", IF(DATE_FORMAT(date, "%m")=12, "декабрь", "?"))))))))))))," ", DATE_FORMAT(date, "%Y"))';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-М';
      end;
    gbpQuarters:
      begin
        sPeriodColumn:='<BR>(номер квартала, год)';
        sPeriodColumnQuery:='CONCAT(IF(QUARTER(date)=1,"I",IF(QUARTER(date)=2,"II",IF(QUARTER(date)=3,"III",IF(QUARTER(date)=4,"IV","?")))), " квартал ", DATE_FORMAT(date, "%Y"))';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-К';
      end;
    gbpYears:
      begin
        sPeriodColumn:='<BR>(год)';
        sPeriodColumnQuery:='DATE_FORMAT(date, "%Y")';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-Г';
      end;
  end;

  case CCID of
    -1:
      begin
        sCCID:='';
        sCCIDPrefix:='0';
        sUserGroupName:='телефонистов ЦОВ, специалистов ТЦОК и BackOffice';
      end;
    1:
      begin
        sCCID:=' ccid="1" AND';
        sCCIDPrefix:='1';
        sUserGroupName:='телефонистов ЦОВ';
      end;
    2:
      begin
        sCCID:=' ccid="2" AND';
        sCCIDPrefix:='2';
        sUserGroupName:='специалистов ТЦОК и BackOffice';
      end
  else
    Routines_GenerateError('Не удалось идентифицировать выбранную группу пользователей!', sErrorMessage, bError);
  end;

  if not bError then
    begin
      sReportCode:='СИЦ-10-'+sCCIDPrefix+'-' // номер CCID
        +Routines_GetConditionalMessage(AllUsers, 'В', 'У')+'-' // все пользователи из выбранной группы или нет
        +Routines_GetConditionalMessage(CreateDetailedReport, 'Р', 'С')+'-' //
        +Routines_GetConditionalMessage(CreateDetailedReport, DatesDiffChar, sReportSuffix); // выбранный период времени и группировка в случае если не подробный отчёт и только период времени, в случае, если подробный

      LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

      // создание строки прогесса в окне прогресса действий
      _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', 17);

      // формирование временной таблицы на OVERSEERSERVER на основе таблицы t_day, находящейся на сервере DBSERVER
      if not bError then
        with FConfiguration do
          begin
            // подключение к MySQL-серверу, на котором находится таблица t_day
            _MySQL_OpenConnection(DBServer, bError, sErrorMessage);
            StepProgressBar; // 1

            if not bError then
              begin
                // проверка наличия таблицы пользователей в базе данных
                _MySQL_CheckTableExistance(DBServer, DBServer.sMySQLDatabase_T_DAY_Location, bError, sErrorMessage, 't_day');
                StepProgressBar; // 2

                if not bError then
                  begin
                    LogThis('>> Выполняется операция получения запроса на создание временной таблицы данных...', lmtDebug);
                    if not DBServer.bConnected then
                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                    else
                      begin
                        if mysql_ping(DBServer.hConnection)<>0 then
                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                        else
                          begin
                            q:='SHOW CREATE TABLE '+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day;';
                            LogThis(q, lmtSQL);
                            if mysql_real_query(DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                            else
                              begin
                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                ResultSet:=mysql_store_result(DBServer.hConnection);
                                if ResultSet=nil then
                                  Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                else
                                  begin
                                    LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                    iRoutineCounter:=mysql_num_rows(ResultSet);
                                    LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', lmtDebug);
                                    if iRoutineCounter<0 then
                                      Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                    else
                                      begin
                                        if iRoutineCounter>1 then
                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                        else
                                          begin
                                            ResultRow:=mysql_fetch_row(ResultSet);
                                            if ResultRow=nil then
                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                            else
                                              if ResultRow[1]='' then
                                                Routines_GenerateError('Возникла ошибка при получении строки запроса на создание временной таблицы данных!', sErrorMessage, bError)
                                              else
                                                begin
                                                  sCreateQuery:= //
                                                    StringReplace( //
                                                    StringReplace( //
                                                    StringReplace( //
                                                    StringReplace( //
                                                    StringReplace( //
                                                    StringReplace( //
                                                    StringReplace( //
                                                    string(ResultRow[1]), //
                                                    #$A, '', [rfReplaceAll]), //
                                                    '`', '', [rfReplaceAll]), //
                                                    '  ', ' ', [rfReplaceAll]), //
                                                    '( ', '(', [rfReplaceAll]), //
                                                    #39, '"', [rfReplaceAll]), //
                                                    '""', '"', [rfReplaceAll]), //
                                                    'CREATE TABLE t_day', 'CREATE TEMPORARY TABLE '+OverseerServer.sMySQLDatabase+'.tmp_10_1', [rfReplaceAll])+';'; //
                                                  LogThis('Запрос на создание временной таблицы данных получен успешно.', lmtDebug);
                                                end;
                                          end;
                                      end;
                                  end;
                                mysql_free_result(ResultSet);
                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                              end;
                          end;
                      end;
                    LogThis('<< Выполнение операции получения запроса на создание временной таблицы данных завершено.', lmtDebug);
                    StepProgressBar; // 3

                    if not bError then
                      begin
                        // подключение к MySQL-серверу OVERSEERSERVER
                        _MySQL_OpenConnection(OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 4

                        if not bError then
                          begin
                            // Создание временной таблицы OVERSEERSERVER
                            _MySQL_CreateTable(OverseerServer, bError, sErrorMessage, sCreateQuery); //
                            StepProgressBar; // 5

                            if not bError then
                              begin
                                // Блокирование таблицы на DBSERVER на чтение
                                _MySQL_LockTables(DBServer, bError, sErrorMessage, DBServer.sMySQLDatabase_T_DAY_Location+'.t_day READ');
                                StepProgressBar; // 6

                                // Вставка данных из таблицы с DBSERVER во временную таблицу на OVERSEERSERVER
                                if not bError then
                                  begin
                                    // Получение данных из таблицы на DBSERVER
                                    LogThis('>> Выполняется операция получения записей за указанный период времени из таблицы данных "'+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day"...', lmtDebug);
                                    if not DBServer.bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(DBServer.hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                        else
                                          begin
                                            q:='SELECT' //
                                              +' * ' //
                                              +'FROM '+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day ' //
                                              +'WHERE' //
                                              +sCCID //
                                              +' date BETWEEN "'+FormatDateTime('yyyymmdd', StartDate)+'" AND "'+FormatDateTime('yyyymmdd', StopDate)+'";'; //
                                            LogThis(q, lmtSQL);
                                            if mysql_real_query(DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                ResultSet:=mysql_store_result(DBServer.hConnection);
                                                if ResultSet=nil then
                                                  Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                    iRowCountSource:=mysql_num_rows(ResultSet);
                                                    LogThis('Количество строк выборки равно '+IntToStr(iRowCountSource)+'.', lmtDebug);
                                                    if iRowCountSource<0 then
                                                      Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        iLoopCounter:=0;
                                                        for iSourceRowCounter:=0 to iRowCountSource-1 do
                                                          if bError then
                                                            Break
                                                          else
                                                            begin
                                                              LogThis('Получение очередной строки выборки ('+IntToStr(iSourceRowCounter)+').', lmtDebug);
                                                              ResultRow:=mysql_fetch_row(ResultSet);
                                                              if ResultRow=nil then
                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iSourceRowCounter)+')!'+Routines_GetMySQLErrorInfo(DBServer),
                                                                  sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('Операция получения очередной строки выборки ('+IntToStr(iSourceRowCounter)+') прошла успешно.', lmtDebug);
                                                                  // перебор строк в цикле и накопление необходимого количества записей для одного запроса
                                                                  // добавление очередной строки с данными в запрос
                                                                  // если не (последний элемент в списке или достигнут необходимый предел строк запроса)
                                                                  // добавить охвосток запроса
                                                                  // иначе - добавить разделитель строк запроса
                                                                  { }
                                                                  // префикс запроса
                                                                  if iLoopCounter=0 then
                                                                    q:='INSERT INTO '+OverseerServer.sMySQLDatabase+'.tmp_10_1 VALUES '; //
                                                                  // очередной сегмент запроса
                                                                  q:=q+'(' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[0]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[1]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[2]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[3]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[4]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[5]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[6]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[7]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[8]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[9]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[10]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[11]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[12]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[13]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[14]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[15]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[16]), True, False)+')'; //
                                                                  if not((iSourceRowCounter=(iRowCountSource-1))or(iLoopCounter=299)) then // если последний элемент в списке источника или достигнут необходимый предел строк запроса
                                                                    begin
                                                                      q:=q+', '; // вставка между строками
                                                                      iLoopCounter:=iLoopCounter+1; // инкремент счётчика сегментов запроса
                                                                    end
                                                                  else
                                                                    begin
                                                                      q:=q+';'; // окончание очередного запроса
                                                                      iRoutineCounter:=_MySQL_InsertRecords(OverseerServer, bError, sErrorMessage, q);
                                                                      if iRoutineCounter<>(iLoopCounter+1) then
                                                                        Routines_GenerateError('Количество обработанных строк ('+IntToStr(iLoopCounter+1)+') не соответствует требуемому ('+IntToStr(iRoutineCounter)+')!', sErrorMessage, bError);
                                                                      iLoopCounter:=0; // сброс счётчика сегментов запроса
                                                                    end
                                                                  { }
                                                                  {
                                                                    // Вставка очередной строки данных во временную таблицу на OVERSEERSERVER
                                                                    iRoutineCounter:=_MySQL_InsertRecords(LogGroupGUID, OverseerServer, bError, sErrorMessage, //
                                                                    'INSERT INTO '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                                    +'VALUES (' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[0]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[1]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[2]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[3]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[4]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[5]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[6]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[7]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[8]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[9]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[10]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[11]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[12]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[13]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[14]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[15]), True, False)+', ' //
                                                                    +Routines_NormalizeStringForQuery(string(ResultRow[16]), True, False)+');');
                                                                    if iRoutineCounter<>1 then
                                                                    Routines_GenerateError('Количество обработанных строк ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError);
                                                                  }
                                                                end;
                                                            end;
                                                      end;
                                                    mysql_free_result(ResultSet);
                                                    LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                  end;
                                              end;
                                          end;
                                      end;
                                    LogThis('<< Выполнение операции получения записей за указанный период времени из таблицы данных "'+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day" завершено.', lmtDebug);
                                    StepProgressBar; // 7

                                    if not bError then
                                      begin
                                        // разблокирование таблиц
                                        _MySQL_UnlockTables(DBServer, bError, sErrorMessage);
                                        StepProgressBar; // 8

                                        if not bError then
                                          begin
                                            slUserList:=TStringList.Create;
                                            try
                                              // формирование списка пользователей на основе значения входящих параметров
                                              if AllUsers then
                                                begin
                                                  // составление списка пользователей (уникальные элементы)
                                                  LogThis('>> Выполняется операция составления списка пользователей...', lmtDebug);
                                                  if not OverseerServer.bConnected then
                                                    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      if mysql_ping(OverseerServer.hConnection)<>0 then
                                                        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                      else
                                                        begin
                                                          q:='SELECT DISTINCT name ' //
                                                            +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                            +'ORDER BY name;'; //
                                                          LogThis(q, lmtSQL);
                                                          if mysql_real_query(OverseerServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('Запрос выполнен успешно.', lmtDebug);
                                                              ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                              if ResultSet=nil then
                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                                  iRowQuantity:=mysql_num_rows(ResultSet);
                                                                  LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                  if iRowQuantity<0 then
                                                                    Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                      for iRowCounter:=0 to iRowQuantity-1 do
                                                                        if bError then
                                                                          Break
                                                                        else
                                                                          begin
                                                                            LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                                            if ResultRow=nil then
                                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                slUserList.Add(Trim(string(ResultRow[0])));
                                                                              end;
                                                                          end;
                                                                    end;
                                                                  mysql_free_result(ResultSet);
                                                                  LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                  LogThis('<< Выполнение операции составления списка пользователей завершено.', lmtDebug);
                                                  StepProgressBar; // 9
                                                end
                                              else
                                                begin
                                                  slUserList.AddStrings(SelectedUserList);
                                                  StepProgressBar; // 9
                                                end;

                                              if not bError then
                                                begin
                                                  // проверка наличия пользователей в списке
                                                  if slUserList.Count<1 then
                                                    Routines_GenerateError('Не выбрано ни одного пользователя для формирования отчёта!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      // начало формирования текста HTML-файла
                                                      sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+sLineBreak;
                                                      sHTML:=sHTML+'<HTML>'+sLineBreak;
                                                      sHTML:=sHTML+'  <HEAD>'+sLineBreak;
                                                      sHTML:=sHTML+'    <TITLE>Статистика по работе '+sUserGroupName+' за '+sReportPeriod+'</TITLE>'+sLineBreak;
                                                      sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="pragma">'+sLineBreak;
                                                      sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">'+sLineBreak;
                                                      sHTML:=sHTML+'    <META CONTENT="Dynamic" NAME="Document-state">'+sLineBreak;
                                                      sHTML:=sHTML+'    <META content="text/html; charset=Windows-1251" http-equiv="Content-Type">'+sLineBreak;
                                                      sHTML:=sHTML+'    <STYLE MEDIA="screen, print" TYPE="text/css">'+sLineBreak;
                                                      sHTML:=sHTML+'      * {'+sLineBreak;
                                                      sHTML:=sHTML+'        font-family: Verdana, Arial, Helvetica, sans-serif;'+sLineBreak;
                                                      sHTML:=sHTML+'        font-size: 7pt;'+sLineBreak;
                                                      sHTML:=sHTML+'        padding: 0;'+sLineBreak;
                                                      sHTML:=sHTML+'        margin: 0;'+sLineBreak;
                                                      sHTML:=sHTML+'        border-color: transparent;'+sLineBreak;
                                                      sHTML:=sHTML+'        border-width: 0;'+sLineBreak;
                                                      sHTML:=sHTML+'        }'+sLineBreak;
                                                      sHTML:=sHTML+'      TABLE, TD {'+sLineBreak;
                                                      sHTML:=sHTML+'        border-style: solid;'+sLineBreak;
                                                      sHTML:=sHTML+'      }'+sLineBreak;
                                                      sHTML:=sHTML+'    </STYLE>'+sLineBreak;
                                                      sHTML:=sHTML+'  </HEAD>'+sLineBreak;
                                                      sHTML:=sHTML+'  <BODY>'+sLineBreak;
                                                      sHTML:=sHTML+'    <CENTER>'+sLineBreak;
                                                      sHTML:=sHTML+
                                                        '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'
                                                        +sLineBreak;
                                                      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+sLineBreak;
                                                      sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                      if CreateDetailedReport then
                                                        begin
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="70px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="160px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="90px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                        end
                                                      else
                                                        begin
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="160px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="160px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                                        end;
                                                      sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                      sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                      sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '8', '5') //
                                                        +'" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">'
                                                        +'Форма № '+sReportCode+'</TD>'+sLineBreak;
                                                      //
                                                      sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '7', '5')+
                                                        '" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
                                                        'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+sLineBreak;
                                                      sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                      sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                      sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                        '" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">Статистика по работе '+sUserGroupName+'<BR>за '+sReportPeriod+
                                                        '</TD>'+sLineBreak;
                                                      sHTML:=sHTML+'        </TR>'+sLineBreak;

                                                      if CreateDetailedReport then
                                                        begin
                                                          LogThis('>> Выполняется операция получения данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                          if not OverseerServer.bConnected then
                                                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  q:='SELECT' //
                                                                    +' DATE_FORMAT(date, "%d.%m.%Y"),' //
                                                                    +' UCASE(name),' //
                                                                    +' sifra,' //
                                                                    +' rm,' //
                                                                    +' vripoc,' //
                                                                    +' vrizav,' //
                                                                    +' work,' //
                                                                    +' paused,' //
                                                                    +' input,' //
                                                                    +' in_serv,' //
                                                                    +' no_serv,' //
                                                                    +' voice,' //
                                                                    +' qu,' //
                                                                    +' du_call,' //
                                                                    +' du_wa ' //
                                                                    +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                                    +'WHERE' //
                                                                    +' name IN('; //
                                                                  for iRoutineCounter:=0 to slUserList.Count-1 do
                                                                    begin
                                                                      q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                                                      if iRoutineCounter<slUserList.Count-1 then
                                                                        q:=q+', ';
                                                                    end;
                                                                  q:=q+') ' //
                                                                    +'ORDER BY' //
                                                                    +' date,' //
                                                                    +' UCASE(name),' //
                                                                    +' vripoc;'; //
                                                                  LogThis(q, lmtSQL);
                                                                  if mysql_real_query(OverseerServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                      ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                      if ResultSet=nil then
                                                                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                                          iRowQuantity:=mysql_num_rows(ResultSet);
                                                                          LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                          if iRowQuantity<0 then
                                                                            Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                              if iRowQuantity>0 then
                                                                                begin
                                                                                bAnyReportDataExists:=True;
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Дата</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Ф.И.О.</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Личный номер</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Рабочее место</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время начала</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время окончания</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время работы</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время перерыва</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Поступило звонков</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Принято</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Не принято</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Скинуто на речевую</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент обслуживания</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Среднее время звонка</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Среднее время ожидания</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                                if bError then
                                                                                Break
                                                                                else
                                                                                begin
                                                                                LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+string(ResultRow[0])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[1])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[2])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[3])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[4])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[5])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[6])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[7])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[8])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[9])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[10])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[11])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[12])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[13])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[14])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                      mysql_free_result(ResultSet);
                                                                      LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                    end;
                                                                end;
                                                            end;
                                                          LogThis('<< Выполнение операции получения данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1 завершено.', lmtDebug);
                                                          StepProgressBar; // 10

                                                          if (not bError)and bAnyReportDataExists then
                                                            begin
                                                              // получение данных для итоговой строки и вывод её в отчёт
                                                              LogThis('>> Выполняется операция получения итоговых данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                              if not OverseerServer.bConnected then
                                                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      q:='SELECT' //
                                                                        +' SEC_TO_TIME(SUM(TIME_TO_SEC(work))),' //
                                                                        +' SEC_TO_TIME(SUM(TIME_TO_SEC(paused))),' //
                                                                        +' SUM(input),' //
                                                                        +' SUM(in_serv),' //
                                                                        +' SUM(no_serv),' //
                                                                        +' SUM(voice), ' //
                                                                        +' (SUM(in_serv)/SUM(input))*100 ' //
                                                                        +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                                        +'WHERE' //
                                                                        +' name IN('; //
                                                                      for iRoutineCounter:=0 to slUserList.Count-1 do
                                                                        begin
                                                                          q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                                                          if iRoutineCounter<slUserList.Count-1 then
                                                                            q:=q+', ';
                                                                        end;
                                                                      q:=q+') ' //
                                                                        +'GROUP BY' //
                                                                        +' "";'; //
                                                                      LogThis(q, lmtSQL);
                                                                      if mysql_real_query(OverseerServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                        Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                          ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                          if ResultSet=nil then
                                                                            Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                                              iRowQuantity:=mysql_num_rows(ResultSet);
                                                                              LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                              if iRowQuantity<0 then
                                                                                Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(OverseerServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 1px 2px;">Итого:</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[0])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[1])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[2])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[3])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[4])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[5])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[6])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                            end;
                                                                          mysql_free_result(ResultSet);
                                                                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                        end;
                                                                    end;
                                                                end;
                                                              LogThis('<< Выполнение операции получения итоговых данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1 завершено.', lmtDebug);
                                                              StepProgressBar; // 11
                                                              StepProgressBar; // 12
                                                              StepProgressBar; // 13
                                                            end;
                                                        end
                                                      else // !!! если отчёт свёрнутый
                                                        begin
                                                          // Создание временной таблицы
                                                          _MySQL_CreateTable(OverseerServer, bError, sErrorMessage, //
                                                            'CREATE TEMPORARY TABLE '+OverseerServer.sMySQLDatabase+'.tmp_10_2 (' //
                                                            +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
                                                            +'period char(100) NOT NULL default "", ' //
                                                            +'name char(31) default NULL, ' //
                                                            +'sifra int(3) unsigned default NULL, ' //
                                                            +'work time default NULL, ' //
                                                            +'paused time default NULL, ' //
                                                            +'input int(3) unsigned default NULL, ' //
                                                            +'in_serv int(3) unsigned default NULL, ' //
                                                            +'no_serv int(3) unsigned default NULL, ' //
                                                            +'voice int(3) unsigned default NULL, ' //
                                                            +'qu float(10,2) default "0.00", ' //
                                                            +'PRIMARY KEY (sort_id) ' //
                                                            +') TYPE=MyISAM; '); //
                                                          StepProgressBar; // 10

                                                          if not bError then
                                                            begin
                                                              if GroupByPeriod=gbpWeeks then
                                                                begin
                                                                  slWeeksList:=GetWeeksList(StartDate, StopDate, CalculateWeekFromMonday);
                                                                  if slWeeksList<>nil then
                                                                    try
                                                                      // Вставка данных в таблицу
                                                                      for iWeekCounter:=0 to slWeeksList.Count-1 do
                                                                        if bError then
                                                                          Break
                                                                        else
                                                                          begin
                                                                            q:='INSERT INTO '+OverseerServer.sMySQLDatabase+'.tmp_10_2 ' //
                                                                              +'SELECT' //
                                                                              +' "",' //
                                                                              +' "'+slWeeksList[iWeekCounter]+'" AS period,' //
                                                                              +' name,' //
                                                                              +' sifra,' //
                                                                              +' SEC_TO_TIME(SUM(TIME_TO_SEC(work))),' //
                                                                              +' SEC_TO_TIME(SUM(TIME_TO_SEC(paused))),' //
                                                                              +' SUM(input),' //
                                                                              +' SUM(in_serv),' //
                                                                              +' SUM(no_serv),' //
                                                                              +' SUM(voice),' //
                                                                              +' (SUM(in_serv)/SUM(input))*100 ' //
                                                                              +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                                              +'WHERE' //
                                                                              +' name IN('; //
                                                                            for iRoutineCounter:=0 to slUserList.Count-1 do
                                                                              begin
                                                                                q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                                                                if iRoutineCounter<slUserList.Count-1 then
                                                                                q:=q+', ';
                                                                              end;
                                                                            q:=q+')' //
                                                                              +' AND DATE_FORMAT(date,"%Y.%m.%d")' //
                                                                              +' BETWEEN "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iWeekCounter], 0, 10)))+'"' //
                                                                              +' AND "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iWeekCounter], 14, 10)))+'" ' //
                                                                              +'GROUP BY'+' period,'+' name,'+' sifra ' //
                                                                              +'ORDER BY' //
                                                                              +' date,' //
                                                                              +' name,' //
                                                                              +' sifra;'; //
                                                                            _MySQL_InsertRecords(OverseerServer, bError, sErrorMessage, q);
                                                                          end;
                                                                    finally
                                                                      slWeeksList.Free;
                                                                    end;
                                                                end
                                                              else
                                                                begin
                                                                  // Вставка данных в таблицу
                                                                  q:='INSERT INTO '+OverseerServer.sMySQLDatabase+'.tmp_10_2 ' //
                                                                    +'SELECT' //
                                                                    +' "",' //
                                                                    +' '+sPeriodColumnQuery+' AS period,' //
                                                                    +' name,' //
                                                                    +' sifra,' //
                                                                    +' SEC_TO_TIME(SUM(TIME_TO_SEC(work))),' //
                                                                    +' SEC_TO_TIME(SUM(TIME_TO_SEC(paused))),' //
                                                                    +' SUM(input),' //
                                                                    +' SUM(in_serv),' //
                                                                    +' SUM(no_serv),' //
                                                                    +' SUM(voice),' //
                                                                    +' (SUM(in_serv)/SUM(input))*100 ' //
                                                                    +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                                    +'WHERE' //
                                                                    +' name IN('; //
                                                                  for iRoutineCounter:=0 to slUserList.Count-1 do
                                                                    begin
                                                                      q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                                                      if iRoutineCounter<slUserList.Count-1 then
                                                                        q:=q+', ';
                                                                    end;
                                                                  q:=q+') ' //
                                                                    +'GROUP BY '+sGroupByQuery+' ' //
                                                                    +'ORDER BY' //
                                                                    +' date,' //
                                                                    +' name,' //
                                                                    +' sifra;'; //
                                                                  _MySQL_InsertRecords(OverseerServer, bError, sErrorMessage, q);
                                                                end;
                                                              StepProgressBar; // 11

                                                              if not bError then
                                                                begin
                                                                  LogThis('>> Выполняется операция получения данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                                  if not OverseerServer.bConnected then
                                                                    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          q:='SELECT' //
                                                                            +' period,' //
                                                                            +' name,' //
                                                                            +' sifra,' //
                                                                            +' work,' //
                                                                            +' paused,' //
                                                                            +' input,' //
                                                                            +' in_serv,' //
                                                                            +' no_serv,' //
                                                                            +' voice,' //
                                                                            +' qu ' //
                                                                            +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_2 ' //
                                                                            +'ORDER BY' //
                                                                            +' sort_id;'; //
                                                                          LogThis(q, lmtSQL);
                                                                          if mysql_real_query(OverseerServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                              ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                              if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                                                iRowQuantity:=mysql_num_rows(ResultSet);
                                                                                LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                                if iRowQuantity<0 then
                                                                                Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                                if iRowQuantity>0 then
                                                                                begin
                                                                                bAnyReportDataExists:=True;
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Период'+sPeriodColumn+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Ф.И.О.</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Личный номер</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время работы</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время перерыва</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Поступило звонков</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Принято</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Не принято</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Скинуто на речевую</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент обслуживания</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                                if bError then
                                                                                Break
                                                                                else
                                                                                begin
                                                                                LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+string(ResultRow[0])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[1])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[2])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[3])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[4])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[5])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[6])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[7])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[8])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[9])+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                              mysql_free_result(ResultSet);
                                                                              LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                            end;
                                                                        end;
                                                                    end;
                                                                  LogThis('<< Выполнение операции получения данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1 завершено.', lmtDebug);
                                                                  StepProgressBar; // 12

                                                                  if (not bError)and bAnyReportDataExists then
                                                                    begin
                                                                      // получение данных для итоговой строки и вывод её в отчёт
                                                                      LogThis('>> Выполняется операция получения итоговых данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                                      if not OverseerServer.bConnected then
                                                                        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              q:='SELECT' //
                                                                                +' SEC_TO_TIME(SUM(TIME_TO_SEC(work))),' //
                                                                                +' SEC_TO_TIME(SUM(TIME_TO_SEC(paused))),' //
                                                                                +' SUM(input),' //
                                                                                +' SUM(in_serv),' //
                                                                                +' SUM(no_serv),' //
                                                                                +' SUM(voice),' //
                                                                                +' (SUM(in_serv)/SUM(input))*100 ' //
                                                                                +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_2 ' //
                                                                                +'GROUP BY' //
                                                                                +' "";'; //
                                                                              LogThis(q, lmtSQL);
                                                                              if mysql_real_query(OverseerServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                                                iRowQuantity:=mysql_num_rows(ResultSet);
                                                                                LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                                if iRowQuantity<0 then
                                                                                Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(OverseerServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 1px 2px;">Итого:</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[0])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[1])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[2])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[3])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[4])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[5])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[6])+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                                end;
                                                                            end;
                                                                        end;
                                                                      LogThis('<< Выполнение операции получения итоговых данных из временной таблицы '+OverseerServer.sMySQLDatabase+'.tmp_10_1 завершено.', lmtDebug);
                                                                      StepProgressBar; // 13
                                                                    end;
                                                                end;
                                                            end;
                                                        end;

                                                      if not bError then
                                                        begin
                                                          // если не было выведено никаких табличных данных - выводим строку об отсутствии данных в БД
                                                          if not bAnyReportDataExists then
                                                            begin
                                                              sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                                '" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">Данные за указанный период времени отсутствуют.</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                            end;
                                                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                          sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">Исполнитель:<BR>'+Self.CurrentUser.sPosition+'<BR>'+Self.CurrentUser.sFullName+'<BR>'+
                                                            Self.CurrentUser.sContactPhone+'</TD>'+sLineBreak;
                                                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+sLineBreak;
                                                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                          dtNow:=Now;
                                                          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                                            +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow)+
                                                            ' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+sLineBreak;
                                                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                          sHTML:=sHTML+'      </TBODY>'+sLineBreak;
                                                          sHTML:=sHTML+'    </TABLE>'+sLineBreak;
                                                          sHTML:=sHTML+'    </CENTER>'+sLineBreak;
                                                          sHTML:=sHTML+'  </BODY>'+sLineBreak;
                                                          sHTML:=sHTML+'</HTML>'+sLineBreak;
                                                          // _LogThis(sHTML, lmtDebug);
                                                          StepProgressBar; // 14

                                                          // открытие отчёта браузером
                                                          if not bError then //
                                                            begin
                                                              Synchronize( procedure begin //
                                                                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика по работе '+sUserGroupName+' за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True)
                                                              then Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage, bError); end); //
                                                              StepProgressBar; // 15
                                                            end;

                                                        end;
                                                    end;
                                                end;
                                            finally
                                              slUserList.Free;
                                            end;
                                          end;
                                      end;
                                  end;
                              end;
                          end;

                        // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                        _MySQL_CloseConnection(OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 16
                      end;
                  end;
              end;

            // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
            _MySQL_CloseConnection(DBServer, bError, sErrorMessage);
            StepProgressBar; // 17
          end;
    end;

  // окончание замера времени выполнения процедуры
  EnableTimer:=False;

  // Prefooter процедуры
  PreFooter(bError, sErrorMessage);
  ShowBaloonHint('Завершено выполнение действия', 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...');

  // Footer процедуры
  ProcedureFooter;
end;

end.
