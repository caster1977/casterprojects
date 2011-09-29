unit Thread_Do_SIC_07;

interface

uses
  Classes,
  SysUtils,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_07=class(TThread_Do_SIC)
  private
    FGroupByPeriod: TGroupByPeriod;
    FCalculateWeekFromMonday: boolean;
  protected
    procedure Execute; override;
    property GroupByPeriod: TGroupByPeriod read FGroupByPeriod write FGroupByPeriod;
    property CalculateWeekFromMonday: boolean read FCalculateWeekFromMonday write FCalculateWeekFromMonday;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aCalculateWeekFromMonday: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aGroupByPeriod: TGroupByPeriod);
  end;

implementation

uses
  Main,
  OverseerRoutines,
  DateUtils,
  mysql;

constructor TThread_Do_SIC_07.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aCalculateWeekFromMonday: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aGroupByPeriod: TGroupByPeriod);
begin
  inherited Create;
  with Self do
    begin
      LogGroupGUID:=aLogGroupGUID;
      StartDate:=aStartDate;
      StopDate:=aStopDate;
      OpenWithBrowser:=aOpenWithBrowser;
      CalculateWeekFromMonday:=aCalculateWeekFromMonday;
      CurrentUser:=aCurrentUser;
      Configuration:=aConfiguration;
      GroupByPeriod:=aGroupByPeriod;
    end;
end;

procedure TThread_Do_SIC_07.Execute;
const
  LogGroupGUID: string='{2C3B00CD-0ACB-4675-9454-4337C3E46A1A}';
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sPeriodColumn: string;
  sReportPeriod: string;
  sReportSuffix: string;
  sTableName: string;
  q: string;
  iRoutineCounter, iRowQuantity, iRowCounter: integer;
  sPeriodColumnQuery, sGroupByQuery: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  slWeeksList: TStringList;
  iResultRow1Summary, iResultRow2Summary, iResultRow3Summary, iResultRow4Summary, iResultRow5Summary, iResultRow1, iResultRow2, iResultRow3, iResultRow4, iResultRow5: integer;
  sReportCode: string;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-07-...');

  // старт замера времени выполнения процедуры
  EnableTimer:=True;

  // инициализация значений переменных
  bError:=False;
  sTableName:='';

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
      begin
        sPeriodColumn:='<BR>(час, день, месяц, год)';
        sPeriodColumnQuery:='CONCAT(TIME_FORMAT(vrijeme, "%H"),":00:00-",TIME_FORMAT(vrijeme, "%H"),":59:59 ", DATE_FORMAT(datum, "%d.%m.%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-Ч';
      end;
    gbpDays:
      begin
        sPeriodColumn:='<BR>(день, месяц, год)';
        sPeriodColumnQuery:='DATE_FORMAT(datum, "%d.%m.%Y")';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-Д';
      end;
    gbpWeeks:
      begin
        sPeriodColumn:='<BR>(начало, конец недели)';
        sPeriodColumnQuery:='CONCAT(DATE_FORMAT(MIN(datum), "%d.%m.%Y")," - ",DATE_FORMAT(MAX(datum), "%d.%m.%Y"))';
        sGroupByQuery:='CONCAT(DATE_FORMAT(datum, "%Y"),"-", WEEK('+Routines_GetConditionalMessage(CalculateWeekFromMonday, 'datum', 'SUBDATE(datum, INTERVAL WEEKDAY("'+FormatDateTime('yyyymmdd', StartDate)+'") DAY)')+',1))';
        if CalculateWeekFromMonday then
          sReportSuffix:=DatesDiffChar+'-НП'
        else
          sReportSuffix:=DatesDiffChar+'-НД';
      end;
    gbpMonths:
      begin
        sPeriodColumn:='<BR>(месяц, год)';
        sPeriodColumnQuery:='CONCAT(IF(DATE_FORMAT(datum, "%m")=1, "январь", IF(DATE_FORMAT(datum, "%m")=2, "февраль", IF(DATE_FORMAT(datum, "%m")=3, "март", '+
          'IF(DATE_FORMAT(datum, "%m")=4, "апрель", IF(DATE_FORMAT(datum, "%m")=5, "май", IF(DATE_FORMAT(datum, "%m")=6, "июнь", IF(DATE_FORMAT(datum, "%m")=7, "июль", '+
          'IF(DATE_FORMAT(datum, "%m")=8, "август", IF(DATE_FORMAT(datum, "%m")=9, "сентябрь", IF(DATE_FORMAT(datum, "%m")=10, "октябрь", '+
          'IF(DATE_FORMAT(datum, "%m")=11, "ноябрь", IF(DATE_FORMAT(datum, "%m")=12, "декабрь", "?"))))))))))))," ", DATE_FORMAT(datum, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-М';
      end;
    gbpQuarters:
      begin
        sPeriodColumn:='<BR>(номер квартала, год)';
        sPeriodColumnQuery:='CONCAT(IF(QUARTER(datum)=1,"I",IF(QUARTER(datum)=2,"II",IF(QUARTER(datum)=3,"III",IF(QUARTER(datum)=4,"IV","?")))), " квартал ", DATE_FORMAT(datum, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-К';
      end;
    gbpYears:
      begin
        sPeriodColumn:='<BR>(год)';
        sPeriodColumnQuery:='DATE_FORMAT(datum, "%Y")';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-Г';
      end;
  end;

  sReportCode:='СИЦ-07-'+sReportSuffix;

  LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

  // создание строки прогесса в окне прогресса действий
  _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', 14);

  // формирование/поиск сводной таблицы orda
  Synchronize( procedure begin //
    if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDOutput, sTableName, False, True, False) then Routines_GenerateError('Произошла ошибка в процессе подготовки таблиц данных исходящих звонков!', sErrorMessage, bError); end); //
  StepProgressBar; // 1

  if not bError then
    begin
      // подключаемся к MySQL-серверу, на котором находятся таблицы orda
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2

      if not bError then
        begin
          // Создание временной таблицы
          _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
            'CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_1 (' //
            +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
            +'period char(100) NOT NULL default "", ' //
            +'initiated_connections_quantity int(20) unsigned default NULL, ' //
            +'PRIMARY KEY (sort_id)' //
            +') TYPE=MyISAM;'); //
          StepProgressBar; // 3

          if not bError then
            begin
              // Создание временной таблицы
              _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
                'CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_2 (' //
                +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
                +'period char(100) NOT NULL default "", ' //
                +'confirmed_connections_quantity int(20) unsigned default NULL, ' //
                +'confirmed_connections_duration_in_seconds int(20) unsigned default NULL, ' //
                +'confirmed_connections_duration_in_minutes int(20) unsigned default NULL, ' //
                +'confirmed_connections_duration_in_minutes_rounded int(20) unsigned default NULL, ' //
                +'PRIMARY KEY (sort_id)' //
                +') TYPE=MyISAM;'); //
              StepProgressBar; // 4

              if not bError then
                begin
                  // Создание временной таблицы
                  _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
                    'CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_3 (' //
                    +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
                    +'period char(100) NOT NULL default "", ' //
                    +'initiated_connections_quantity int(20) unsigned default NULL, ' //
                    +'confirmed_connections_quantity int(20) unsigned default NULL, ' //
                    +'confirmed_connections_duration_in_seconds int(20) unsigned default NULL, ' //
                    +'confirmed_connections_duration_in_minutes int(20) unsigned default NULL, ' //
                    +'confirmed_connections_duration_in_minutes_rounded int(20) unsigned default NULL, ' //
                    +'PRIMARY KEY (sort_id)' //
                    +') TYPE=MyISAM;'); //
                  StepProgressBar; // 5

                  if not bError then
                    begin
                      // блокирование таблицы (источника данных)
                      _MySQL_LockTables(FConfiguration.StatServer, bError, sErrorMessage, //
                        FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.'+sTableName+' READ'); //
                      StepProgressBar; // 6

                      if not bError then
                        begin
                          if GroupByPeriod=gbpWeeks then
                            begin
                              slWeeksList:=GetWeeksList(StartDate, StopDate, CalculateWeekFromMonday);
                              if slWeeksList<>nil then
                                try
                                  // Вставка данных в таблицу
                                  for iRoutineCounter:=0 to slWeeksList.Count-1 do
                                    if bError then
                                      Break
                                    else
                                      begin
                                        _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                          'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_1 ' //
                                          +'SELECT "", "'+slWeeksList[iRoutineCounter]+'" AS period, COUNT(*) ' //
                                          +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.'+sTableName+' ' //
                                          +'WHERE DATE_FORMAT(datum,"%Y.%m.%d") ' //
                                          +'BETWEEN "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iRoutineCounter], 0, 10)))+'" ' //
                                          +'AND "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iRoutineCounter], 14, 10)))+'" ' //
                                          +'GROUP BY period ' //
                                          +'ORDER BY datum, vrijeme;'); //
                                      end;
                                  StepProgressBar; // 7

                                  if not bError then
                                    // Вставка данных в таблицу
                                    begin
                                      for iRoutineCounter:=0 to slWeeksList.Count-1 do
                                        if bError then
                                          Break
                                        else
                                          begin
                                            _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                              'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_2 ' //
                                              +'SELECT "", "'+slWeeksList[iRoutineCounter]+'" AS period, COUNT(*), SUM(dur), SUM(dur)/60, SUM(ceiling(dur/60)) ' //
                                              +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.'+sTableName+' ' //
                                              +'WHERE DATE_FORMAT(datum,"%Y.%m.%d") ' //
                                              +'BETWEEN "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iRoutineCounter], 0, 10)))+'" ' //
                                              +'AND "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iRoutineCounter], 14, 10)))+'" ' //
                                              +'AND dur>0 AND v_mreza<>"" ' //
                                              +'GROUP BY period ' //
                                              +'ORDER BY datum, vrijeme;'); //
                                          end;
                                      StepProgressBar; // 8

                                    end;
                                finally
                                  slWeeksList.Free;
                                end;
                            end
                          else
                            begin
                              // Вставка данных в таблицу
                              _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_1 ' //
                                +'SELECT "", '+sPeriodColumnQuery+' AS period, COUNT(*) ' //
                                +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.'+sTableName+' ' //
                                +'GROUP BY '+sGroupByQuery+' ' //
                                +'ORDER BY datum, vrijeme;'); //
                              StepProgressBar; // 7

                              if not bError then
                                begin
                                  // Вставка данных в таблицу
                                  _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                    'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_2 ' //
                                    +'SELECT "", '+sPeriodColumnQuery+' AS period, COUNT(*), SUM(dur), SUM(dur)/60, SUM(ceiling(dur/60)) ' //
                                    +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.'+sTableName+' ' //
                                    +'WHERE dur>0 AND v_mreza<>"" ' //
                                    +'GROUP BY '+sGroupByQuery+' ' //
                                    +'ORDER BY datum, vrijeme;'); //
                                  StepProgressBar; // 8

                                end;
                            end;

                          if not bError then
                            begin
                              // разблокирование таблиц
                              _MySQL_UnlockTables(FConfiguration.StatServer, bError, sErrorMessage);
                              StepProgressBar; // 9

                              if not bError then
                                begin
                                  // Вставка данных в таблицу
                                  _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                    'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_3 ' //
                                    +'SELECT "", a.period, a.initiated_connections_quantity, b.confirmed_connections_quantity, '+
                                    'b.confirmed_connections_duration_in_seconds, confirmed_connections_duration_in_minutes, confirmed_connections_duration_in_minutes_rounded ' //
                                    +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_1 AS a ' //
                                    +'LEFT JOIN '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_2 AS b ON b.period=a.period ' //
                                    +'ORDER BY a.sort_id;'); //
                                  StepProgressBar; // 10

                                  // начало формирования текста HTML-файла
                                  if not bError then
                                    begin
                                      sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
                                      sHTML:=sHTML+'<HTML>'+#13#10;
                                      sHTML:=sHTML+'  <HEAD>'+#13#10;
                                      sHTML:=sHTML+'    <TITLE>Статистика по соединениям абонента A с искомым номером B (по наведённой справке) за '+sReportPeriod+'</TITLE>'+#13#10;
                                      sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="pragma">'+#13#10;
                                      sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">'+#13#10;
                                      sHTML:=sHTML+'    <META CONTENT="Dynamic" NAME="Document-state">'+#13#10;
                                      sHTML:=sHTML+'    <META content="text/html; charset=Windows-1251" http-equiv="Content-Type">'+#13#10;
                                      sHTML:=sHTML+'    <STYLE MEDIA="screen, print" TYPE="text/css">'+#13#10;
                                      sHTML:=sHTML+'      * {'+#13#10;
                                      sHTML:=sHTML+'        font-family: Verdana, Arial, Helvetica, sans-serif;'+#13#10;
                                      sHTML:=sHTML+'        font-size: 8pt;'+#13#10;
                                      sHTML:=sHTML+'        padding: 0;'+#13#10;
                                      sHTML:=sHTML+'        margin: 0;'+#13#10;
                                      sHTML:=sHTML+'        border-color: transparent;'+#13#10;
                                      sHTML:=sHTML+'        border-width: 0;'+#13#10;
                                      sHTML:=sHTML+'        }'+#13#10;
                                      sHTML:=sHTML+'      TABLE, TD {'+#13#10;
                                      sHTML:=sHTML+'        border-style: solid;'+#13#10;
                                      sHTML:=sHTML+'      }'+#13#10;
                                      sHTML:=sHTML+'    </STYLE>'+#13#10;
                                      sHTML:=sHTML+'  </HEAD>'+#13#10;
                                      sHTML:=sHTML+'  <BODY>'+#13#10;
                                      sHTML:=sHTML+'    <CENTER>'+#13#10;
                                      sHTML:=sHTML+
                                        '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'
                                        +#13#10;
                                      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="110px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="110px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="*" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                      sHTML:=sHTML+'        </TR>'+#13#10;
                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                      sHTML:=sHTML+
                                        '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                                        +sReportCode+'</TD>'+#13#10;
                                      sHTML:=sHTML+
                                        '          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'
                                        +'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+#13#10;
                                      sHTML:=sHTML+'        </TR>'+#13#10;
                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                      sHTML:=sHTML+
                                        '          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">Статистика по соединениям абонента A с искомым номером B<BR>(по наведённой справке)<BR>за '
                                        +sReportPeriod+'</TD>'+#13#10;
                                      sHTML:=sHTML+'        </TR>'+#13#10;

                                      iResultRow1Summary:=0;
                                      iResultRow2Summary:=0;
                                      iResultRow3Summary:=0;
                                      iResultRow4Summary:=0;
                                      iResultRow5Summary:=0;

                                      // получение данных для строк отчёта
                                      LogThis('>> Выполняется операция получения данных для строк отчёта...', lmtDebug);
                                      with FConfiguration.StatServer do
                                        if not bConnected then
                                          Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                        else
                                          begin
                                            if mysql_ping(hConnection)<>0 then
                                              Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                            else
                                              begin
                                                q:='SELECT period, initiated_connections_quantity, confirmed_connections_quantity, confirmed_connections_duration_in_seconds, ' //
                                                  +'confirmed_connections_duration_in_minutes, confirmed_connections_duration_in_minutes_rounded ' //
                                                  +'FROM '+sMySQLDatabase_ORDA_Location+'.tmp_07_3 ' //
                                                  +'ORDER BY sort_id;'; //
                                                LogThis(q, lmtSQL);
                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                  Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('Запрос выполнен успешно.', lmtDebug);
                                                    ResultSet:=mysql_store_result(hConnection);
                                                    if ResultSet=nil then
                                                      Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                        iRowQuantity:=mysql_num_rows(ResultSet);
                                                        LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                        if iRowQuantity<0 then
                                                          Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            if iRowQuantity>0 then
                                                              begin
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Период'+sPeriodColumn+'</TD>'+#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество<BR>иниции-<BR>рованных<BR>соединений</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество<BR>установ-<BR>ленных<BR>соединений</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Сумма длительностей<BR>установ-<BR>ленных<BR>соединений, секунд</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Сумма длительностей<BR>установ-<BR>ленных<BR>соединений округлённая<BR>до минут (секунды/60), минут</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Сумма округлённых<BR>до минут длительностей<BR>установ-<BR>ленных<BR>соединений, минут</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                  if bError then
                                                                    Break
                                                                  else
                                                                    begin
                                                                      LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                      ResultRow:=mysql_fetch_row(ResultSet);
                                                                      if ResultRow=nil then
                                                                        Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                          sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          LogThis('Данные очередной строки получены успешно.', lmtDebug);
                                                                          iResultRow1:=StrToIntDef(string(ResultRow[1]), 0);
                                                                          iResultRow2:=StrToIntDef(string(ResultRow[2]), 0);
                                                                          iResultRow3:=StrToIntDef(string(ResultRow[3]), 0);
                                                                          iResultRow4:=StrToIntDef(string(ResultRow[4]), 0);
                                                                          iResultRow5:=StrToIntDef(string(ResultRow[5]), 0);

                                                                          iResultRow1Summary:=iResultRow1Summary+iResultRow1;
                                                                          iResultRow2Summary:=iResultRow2Summary+iResultRow2;
                                                                          iResultRow3Summary:=iResultRow3Summary+iResultRow3;
                                                                          iResultRow4Summary:=iResultRow4Summary+iResultRow4;
                                                                          iResultRow5Summary:=iResultRow5Summary+iResultRow5;

                                                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1') //
                                                                            +'px 2px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[0])<>'', string(ResultRow[0]), '0')+'</TD>'+#13#10;
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1') //
                                                                            +'px 0px; border-color: black; padding: 1px 2px;">'+IntToStr(iResultRow1)+'</TD>'+#13#10;
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                                            'px 0px; border-color: black; padding: 1px 2px;">'+IntToStr(iResultRow2)+'</TD>'+#13#10;
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                                            'px 0px; border-color: black; padding: 1px 2px;">'+IntToStr(iResultRow3)+'</TD>'+#13#10;
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                                            'px 0px; border-color: black; padding: 1px 2px;">'+IntToStr(iResultRow4)+'</TD>'+#13#10;
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                                            'px 0px; border-color: black; padding: 1px 2px;">'+IntToStr(iResultRow5)+'</TD>'+#13#10;
                                                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                                                        end;
                                                                    end;
                                                                // вывод итоговых данных
                                                                if not bError then
                                                                  begin
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+IntToStr(iResultRow1Summary)+
                                                                      '</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+IntToStr(iResultRow2Summary)+
                                                                      '</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+IntToStr(iResultRow3Summary)+
                                                                      '</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+IntToStr(iResultRow4Summary)+
                                                                      '</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+IntToStr(iResultRow5Summary)+
                                                                      '</TD>'+#13#10;
                                                                    sHTML:=sHTML+'        </TR>'+#13#10;
                                                                  end;
                                                              end
                                                            else // если данных не было найдено
                                                              begin
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">'+
                                                                  'Данные за указанный период времени отсутствуют.</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                              end;
                                                          end;
                                                        mysql_free_result(ResultSet);
                                                        LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                      end;
                                                  end;
                                              end;
                                          end;
                                      LogThis('<< Выполнение операция получения данных для строк отчёта завершено.', lmtDebug);
                                      StepProgressBar; // 11

                                      // добавление концовки HTML-файла
                                      if not bError then
                                        begin
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="6" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">Исполнитель:<BR>'+Self.CurrentUser.sPosition+'<BR>'+
                                            Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          sHTML:=sHTML+'           <TD COLSPAN="6" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          dtNow:=Now;
                                          sHTML:=sHTML+
                                            '           <TD COLSPAN="6" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                            +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow)+
                                            ' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                                          sHTML:=sHTML+'    </TABLE>'+#13#10;
                                          sHTML:=sHTML+'    </CENTER>'+#13#10;
                                          sHTML:=sHTML+'  </BODY>'+#13#10;
                                          sHTML:=sHTML+'</HTML>'+#13#10;
                                          // _LogThis(sHTML, lmtDebug);
                                          StepProgressBar; // 12
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
      _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 13

      // открытие отчёта браузером
      if not bError then //
        begin
          Synchronize( procedure begin //
            if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика по соединениям абонента A с искомым номером B (по наведённой справке) за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True)
          then Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage, bError); end); //
          StepProgressBar; // 14
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
