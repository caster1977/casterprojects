unit Thread_Do_SIC_04;

interface

uses
  Classes,
  SysUtils,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_04=class(TThread_Do_SIC)
  private
    FCreateDetailedReport: boolean;
    FShowSQLQueries: boolean;
    FAllUsers: boolean;
    FShowIdleUsers: boolean;
    FSelectedUserList: TStringList;
    FGroupByPeriod: TGroupByPeriod;
    FCalculateWeekFromMonday: boolean;
  protected
    procedure Execute; override;
    property CreateDetailedReport: boolean read FCreateDetailedReport write FCreateDetailedReport;
    property ShowSQLQueries: boolean read FShowSQLQueries write FShowSQLQueries;
    property AllUsers: boolean read FAllUsers write FAllUsers;
    property ShowIdleUsers: boolean read FShowIdleUsers write FShowIdleUsers;
    property SelectedUserList: TStringList read FSelectedUserList write FSelectedUserList;
    property GroupByPeriod: TGroupByPeriod read FGroupByPeriod write FGroupByPeriod;
    property CalculateWeekFromMonday: boolean read FCalculateWeekFromMonday write FCalculateWeekFromMonday;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aCreateDetailedReport, aShowSQLQueries, aAllUsers, aShowIdleUsers: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec;
      aGroupByPeriod: TGroupByPeriod; aSelectedUserList: TStringList);
    destructor Destroy; override;
  end;

implementation

uses
  Main,
  DateUtils,
  mysql,
  OverseerRoutines;

constructor TThread_Do_SIC_04.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aCreateDetailedReport, aShowSQLQueries, aAllUsers, aShowIdleUsers: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec;
  aGroupByPeriod: TGroupByPeriod; aSelectedUserList: TStringList);
begin
  inherited Create;
  with Self do
    begin
      LogGroupGUID:=aLogGroupGUID;
      StartDate:=aStartDate;
      StopDate:=aStopDate;
      OpenWithBrowser:=aOpenWithBrowser;
      CreateDetailedReport:=aCreateDetailedReport;
      ShowSQLQueries:=aShowSQLQueries;
      AllUsers:=aAllUsers;
      ShowIdleUsers:=aShowIdleUsers;
      CurrentUser:=aCurrentUser;
      Configuration:=aConfiguration;
      GroupByPeriod:=aGroupByPeriod;

      SelectedUserList:=TStringList.Create;
      SelectedUserList.Sorted:=False;
      SelectedUserList.Assign(aSelectedUserList);
    end;
end;

destructor TThread_Do_SIC_04.Destroy;
begin
  SelectedUserList.Free;
  inherited;
end;

procedure TThread_Do_SIC_04.Execute;
const
  LogGroupGUID: string='{B814457C-450A-462A-BC28-BE07951E99CC}';
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sReportPeriod: string;
  sTableName: string;
  iRoutineCounter: integer;
  iRowQuantity, iRowCounter: integer;
  slUserList, slPeriodList: TStringList;
  iPeriodCounter: integer;
  q: string;
  s: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  sPeriodColumnQuery, sGroupByQuery: string;
  sPeriodColumn: string;
  sReportSuffix: string;
  iQuantityCreated, iQuantityModified, iQuantityDeleted, iQuantityRecoveried: integer;
  iQuantityCreated_UserSummary, iQuantityModified_UserSummary, iQuantityDeleted_UserSummary, iQuantityRecoveried_UserSummary: integer;
  slWeeksList: TStringList;
  iWeekCounter: integer;
  bAnyReportDataExists: boolean;
  sReportCode: string;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-04-...');

  // старт замера времени выполнения процедуры
  EnableTimer:=True;

  // инициализация значений переменных
  bError:=False;
  sTableName:='';
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
      begin
        sPeriodColumn:='<BR>(час, день, месяц, год)';
        sPeriodColumnQuery:='CONCAT(TIME_FORMAT(evn_datetime, "%H"),":00:00-",TIME_FORMAT(evn_datetime, "%H"),":59:59 ", DATE_FORMAT(evn_datetime, "%d.%m.%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-Ч';
      end;
    gbpDays:
      begin
        sPeriodColumn:='<BR>(день, месяц, год)';
        sPeriodColumnQuery:='DATE_FORMAT(evn_datetime, "%d.%m.%Y")';
        sGroupByQuery:='period';
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
        sPeriodColumnQuery:='CONCAT(IF(DATE_FORMAT(evn_datetime, "%m")=1, "январь", IF(DATE_FORMAT(evn_datetime, "%m")=2, "февраль", IF(DATE_FORMAT(evn_datetime, "%m")=3, "март", '+
          'IF(DATE_FORMAT(evn_datetime, "%m")=4, "апрель", IF(DATE_FORMAT(evn_datetime, "%m")=5, "май", IF(DATE_FORMAT(evn_datetime, "%m")=6, "июнь", IF(DATE_FORMAT(evn_datetime, "%m")=7, "июль", '+
          'IF(DATE_FORMAT(evn_datetime, "%m")=8, "август", IF(DATE_FORMAT(evn_datetime, "%m")=9, "сентябрь", IF(DATE_FORMAT(evn_datetime, "%m")=10, "октябрь", '+
          'IF(DATE_FORMAT(evn_datetime, "%m")=11, "ноябрь", IF(DATE_FORMAT(evn_datetime, "%m")=12, "декабрь", "?"))))))))))))," ", DATE_FORMAT(evn_datetime, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-М';
      end;
    gbpQuarters:
      begin
        sPeriodColumn:='<BR>(номер квартала, год)';
        sPeriodColumnQuery:='CONCAT(IF(QUARTER(evn_datetime)=1,"I",IF(QUARTER(evn_datetime)=2,"II",IF(QUARTER(evn_datetime)=3,"III",IF(QUARTER(evn_datetime)=4,"IV","?")))), " квартал ", DATE_FORMAT(evn_datetime, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-К';
      end;
    gbpYears:
      begin
        sPeriodColumn:='<BR>(год)';
        sPeriodColumnQuery:='DATE_FORMAT(evn_datetime, "%Y")';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-Г';
      end;
  end;

  sReportCode:='СИЦ-04-'+Routines_GetConditionalMessage(AllUsers, 'В', 'У')+'-'+Routines_GetConditionalMessage(ShowIdleUsers, 'А', 'Н')+'-'+Routines_GetConditionalMessage(CreateDetailedReport, 'Р', 'С')+
    Routines_GetConditionalMessage(CreateDetailedReport and ShowSQLQueries, 'З', '')+'-'+Routines_GetConditionalMessage(CreateDetailedReport, DatesDiffChar, sReportSuffix);

  LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

  // создание строки прогесса в окне прогресса действий
  _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', 17);

  // подключение к MySQL-серверу, на котором находится таблица пользователей БД rne4
  _MySQL_OpenConnection(FConfiguration.RNE4Server, bError, sErrorMessage);
  StepProgressBar; // 1

  if not bError then
    begin
      // проверка наличия таблицы пользователей в базе данных
      _MySQL_CheckTableExistance(FConfiguration.RNE4Server, FConfiguration.RNE4Server.sMySQLDatabase, bError, sErrorMessage, '_usr');
      StepProgressBar; // 2

      if not bError then
        begin
          // проверка наличия таблицы событий в базе данных
          _MySQL_CheckTableExistance(FConfiguration.RNE4Server, FConfiguration.RNE4Server.sMySQLDatabase, bError, sErrorMessage, '_evn');
          StepProgressBar; // 3

          if not bError then
            begin
              slUserList:=TStringList.Create;
              try
                // формирование списка пользователей на основе значения входящих параметров
                if AllUsers then
                  begin
                    // блокирование таблиц
                    _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                    StepProgressBar; // 4

                    if not bError then
                      begin
                        // составление списка пользователей (уникальные элементы)
                        LogThis('>> Выполняется операция составления списка пользователей...', lmtDebug);
                        with FConfiguration.RNE4Server do
                          if not bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT DISTINCT usr_fullname ' //
                                    +'FROM '+sMySQLDatabase+'._usr ' //
                                    +'WHERE usr_erased="0" ' //
                                    +'ORDER BY usr_fullname;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(hConnection);
                                      if ResultSet=nil then
                                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                      Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server),
                                                        sErrorMessage, bError)
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
                        StepProgressBar; // 5

                        // разблокирование таблиц
                        if not bError then
                          begin
                            _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                            StepProgressBar; // 6
                          end;
                      end;
                  end
                else
                  begin
                    slUserList.AddStrings(SelectedUserList);
                    StepProgressBar; // 4
                    StepProgressBar; // 5
                    StepProgressBar; // 6
                  end;

                // начало формирования текста HTML-файла
                if not bError then
                  begin
                    sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+sLineBreak;
                    sHTML:=sHTML+'<HTML>'+sLineBreak;
                    sHTML:=sHTML+'  <HEAD>'+sLineBreak;
                    sHTML:=sHTML+'    <TITLE>Статистика по работе пользователей АРМ услуги Отдых и развлечения за '+sReportPeriod+'</TITLE>'+sLineBreak;
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
                    sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+sLineBreak;
                    sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+sLineBreak;
                    sHTML:=sHTML+'        <TR>'+sLineBreak;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '100', '196')+'px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '100', '115')+'px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '100', '115')+'px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '*', '115px')+'" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                    if not CreateDetailedReport then
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="115px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                    sHTML:=sHTML+'        </TR>'+sLineBreak;
                    sHTML:=sHTML+'        <TR>'+sLineBreak;
                    sHTML:=sHTML+
                      '          <TD COLSPAN="3" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                      +sReportCode+'</TD>'+sLineBreak;
                    sHTML:=sHTML+'          <TD '+Routines_GetConditionalMessage(CreateDetailedReport, '', 'COLSPAN="2" ')+
                      'STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 6pt; text-align: right;">'+
                      'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+sLineBreak;
                    sHTML:=sHTML+'        </TR>'+sLineBreak;
                    sHTML:=sHTML+'        <TR>'+sLineBreak;
                    sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
                      '" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">Статистика по работе пользователей<BR>АРМ услуги &laquo;Отдых и развлечения&raquo;<BR>за '+
                      sReportPeriod+'</TD>'+sLineBreak;
                    sHTML:=sHTML+'        </TR>'+sLineBreak;

                    if CreateDetailedReport then
                      begin
                        // блокирование таблиц
                        _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ, '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn READ');
                        StepProgressBar; // 7

                        if not bError then
                          begin
                            // Создание временной таблицы
                            q:='CREATE TEMPORARY TABLE '+FConfiguration.RNE4Server.sMySQLDatabase+'.tmp_04 (' //
                              +'PRIMARY KEY (evn_id), ' //
                              +'KEY evn_datetime (evn_datetime), ' //
                              +'KEY evn_type (evn_type), ' //
                              +'KEY evn_by_user_id (evn_by_user_id), ' //
                              +'KEY evn_object (evn_object), ' //
                              +'KEY evn_object_id (evn_object_id)' //
                              +') TYPE=MyISAM ' //
                              +'SELECT evn_id, evn_datetime, evn_type, evn_object, evn_object_id, evn_by_user_id, evn_details ' //
                              +'FROM '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn ' //
                              +'LEFT JOIN '+FConfiguration.RNE4Server.sMySQLDatabase+'._usr ' //
                              +'ON usr_id=evn_by_user_id ' //
                              +'WHERE DATE_FORMAT(evn_datetime,"%Y-%m-%d") ' //
                              +'BETWEEN "'+sSQLFormatStartDate+'" AND "'+sSQLFormatStopDate+'"'+' ' //
                              +'AND usr_fullname IN('; //
                            for iRoutineCounter:=0 to slUserList.Count-1 do
                              begin
                                q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                if iRoutineCounter<slUserList.Count-1 then
                                  q:=q+', ';
                              end;
                            q:=q+');';
                            _MySQL_CreateTable(FConfiguration.RNE4Server, bError, sErrorMessage, q);
                            StepProgressBar; // 8

                            if not bError then
                              begin
                                // разблокирование таблиц
                                _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                StepProgressBar; // 9

                                if not bError then
                                  begin
                                    // блокирование таблицы
                                    _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                                    StepProgressBar; // 10

                                    if not bError then
                                      begin
                                        // получение данных из временной таблицы и формирование отчёта
                                        for iRoutineCounter:=0 to slUserList.Count-1 do
                                          if bError then
                                            Break
                                          else
                                            begin
                                              LogThis('>> Выполняется операция получения подробных данных о действиях пользователя и формирование строк отчёта...', lmtDebug);
                                              with FConfiguration.RNE4Server do
                                                if not bConnected then
                                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if mysql_ping(hConnection)<>0 then
                                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                    else
                                                      begin
                                                        q:='SELECT DATE_FORMAT(evn_datetime,"%d.%m.%Y"), DATE_FORMAT(evn_datetime,"%T"), evn_type, evn_object, evn_object_id, evn_details ' //
                                                          +'FROM '+sMySQLDatabase+'.tmp_04 ' //
                                                          +'LEFT JOIN '+sMySQLDatabase+'._usr ' //
                                                          +'ON usr_id=evn_by_user_id ' //
                                                          +'WHERE usr_fullname="'+slUserList[iRoutineCounter]+'" ' //
                                                          +'AND DATE_FORMAT(evn_datetime,"%Y-%m-%d") ' //
                                                          +'BETWEEN "'+sSQLFormatStartDate+'" AND "'+sSQLFormatStopDate+'" ' //
                                                          +'ORDER BY evn_datetime;'; //
                                                        LogThis(q, lmtSQL);
                                                        if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                                            ResultSet:=mysql_store_result(hConnection);
                                                            if ResultSet=nil then
                                                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                                    if (iRowQuantity>0)or ShowIdleUsers then
                                                                      begin
                                                                        bAnyReportDataExists:=True;
                                                                        sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                        sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; font-weight: bold; font-size: 10pt; padding: 20px 0px 3px 0px;">' //
                                                                          +Trim(slUserList[iRoutineCounter])+':</TD>'+sLineBreak; //
                                                                        sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                      end;
                                                                    if iRowQuantity>0 then
                                                                      begin
                                                                        sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Дата</TD>'+sLineBreak;
                                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время</TD>'+sLineBreak;
                                                                        sHTML:=sHTML+'          <TD '+Routines_GetConditionalMessage(ShowSQLQueries, '', 'COLSPAN="2"')+
                                                                          'STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Действие</TD>'+sLineBreak;
                                                                        if ShowSQLQueries then
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Текст SQL-запроса</TD>'+sLineBreak;
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
                                                                                Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                s:=string(ResultRow[2]);
                                                                                if s='INS' then
                                                                                s:='Создание';
                                                                                if s='MOD' then
                                                                                s:='Испраление';
                                                                                if s='DEL' then
                                                                                s:='Удаление';
                                                                                if s='REC' then
                                                                                s:='Восстановление';
                                                                                s:=s+Routines_GetConditionalMessage(string(ResultRow[3])>'', ' ', '') //
                                                                                +Routines_GetConditionalMessage(StrToIntDef(string(ResultRow[4]), -1)=0, //
                                                                                Routines_GetConditionalMessage(string(ResultRow[3])='msr', ' группы мероприятий', ''), //
                                                                                Routines_GetConditionalMessage(string(ResultRow[3])='usr', ' пользователя', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='phn', ' телефона', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='msg', ' сообщения', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='org', ' организации', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='msr', ' мероприятия', '') //
                                                                                +Routines_GetConditionalMessage(StrToIntDef(string(ResultRow[4]), -1)>-1, ' ID #'+string(ResultRow[4]), '')); //
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[0])='', '-', string(ResultRow[0]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[1])='', '-', string(ResultRow[1]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD '+Routines_GetConditionalMessage(ShowSQLQueries, '', 'COLSPAN="2"')+'STYLE="text-align: center; border-width: 0px 2px '+
                                                                                Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(s='', '-', s)+
                                                                                '</TD>'+sLineBreak;
                                                                                if ShowSQLQueries then
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align:   left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[3])='', '-', string(ResultRow[5]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                end;
                                                                            end;
                                                                      end
                                                                    else
                                                                      if ShowIdleUsers then
                                                                        begin
                                                                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                          sHTML:=sHTML+
                                                                            '          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">Не найдено ни одного действия за данный период времени.</TD>'+sLineBreak;
                                                                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                        end;
                                                                  end;
                                                                mysql_free_result(ResultSet);
                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                              end;
                                                          end;
                                                      end;
                                                  end;
                                              LogThis('<< Выполнение операции получения подробных данных о действиях пользователя и формирование строк отчёта завершено.', lmtDebug);
                                            end;
                                        StepProgressBar; // 11

                                        // разблокирование таблиц
                                        if not bError then
                                          begin
                                            _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                            StepProgressBar; // 12
                                            StepProgressBar; // 13
                                            StepProgressBar; // 14
                                          end;
                                      end;
                                  end;
                              end;
                          end;
                      end
                    else // !!! если отчёт свёрнутый
                      begin
                        // Создание временной таблицы
                        _MySQL_CreateTable(FConfiguration.RNE4Server, bError, sErrorMessage, //
                          'CREATE TEMPORARY TABLE '+FConfiguration.RNE4Server.sMySQLDatabase+'.tmp_04 (' //
                          +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
                          +'username varchar(100) default NULL, ' //
                          +'period varchar(100) default NULL, ' //
                          +'event_type enum("INS","MOD","DEL","REC") default NULL, ' //
                          +'quantity decimal(20,0) default NULL, ' //
                          +'PRIMARY KEY (sort_id)' //
                          +') TYPE=MyISAM;'); //
                        StepProgressBar; // 7

                        if not bError then
                          begin
                            // блокирование таблицы
                            _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._evn READ, '+FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                            StepProgressBar; // 8

                            if not bError then
                              begin
                                // Создание временной таблицы на основе структуры таблицы _evn
                                q:='CREATE TEMPORARY TABLE '+FConfiguration.RNE4Server.sMySQLDatabase+'.tmp_04_1 (' //
                                  +'PRIMARY KEY (evn_id), ' //
                                  +'KEY evn_datetime (evn_datetime), ' //
                                  +'KEY evn_type (evn_type), ' //
                                  +'KEY evn_by_user_id (evn_by_user_id), ' //
                                  +'KEY evn_object (evn_object), ' //
                                  +'KEY evn_object_id (evn_object_id)' //
                                  +') TYPE=MyISAM ' //
                                  +'SELECT evn_id, evn_datetime, evn_type, evn_object, evn_object_id, evn_by_user_id, evn_details ' //
                                  +'FROM '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn ' //
                                  +'LEFT JOIN '+FConfiguration.RNE4Server.sMySQLDatabase+'._usr ' //
                                  +'ON usr_id=evn_by_user_id ' //
                                  +'WHERE DATE_FORMAT(evn_datetime,"%Y-%m-%d") ' //
                                  +'BETWEEN "'+sSQLFormatStartDate+'" AND "'+sSQLFormatStopDate+'"'+' ' //
                                  +'AND usr_fullname IN('; //
                                for iRoutineCounter:=0 to slUserList.Count-1 do
                                  begin
                                    q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                    if iRoutineCounter<slUserList.Count-1 then
                                      q:=q+', ';
                                  end;
                                q:=q+');';
                                _MySQL_CreateTable(FConfiguration.RNE4Server, bError, sErrorMessage, q);
                                StepProgressBar; // 9

                                if not bError then
                                  begin
                                    // разблокирование таблиц
                                    _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                    StepProgressBar; // 10

                                    // вставка данных во временную таблицу
                                    if not bError then
                                      begin
                                        if GroupByPeriod=gbpWeeks then
                                          begin
                                            // блокирование таблиц
                                            _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                                            StepProgressBar; // 11

                                            if not bError then
                                              begin
                                                // получение списка недель
                                                slWeeksList:=GetWeeksList(StartDate, StopDate, CalculateWeekFromMonday);
                                                if slWeeksList<>nil then
                                                  try
                                                    // циклическое получение данных по неделям
                                                    for iWeekCounter:=0 to slWeeksList.Count-1 do
                                                      if bError then
                                                        Break
                                                      else
                                                        begin
                                                          // Вставка данных в таблицу
                                                          q:='INSERT INTO '+FConfiguration.RNE4Server.sMySQLDatabase+'.tmp_04 ' //
                                                            +'SELECT "", usr_fullname, "'+slWeeksList[iWeekCounter]+'" AS period, evn_type, COUNT(*) ' //
                                                            +'FROM '+FConfiguration.RNE4Server.sMySQLDatabase+'.tmp_04_1 ' //
                                                            +'LEFT JOIN '+FConfiguration.RNE4Server.sMySQLDatabase+'._usr ' //
                                                            +'ON usr_id=evn_by_user_id ' //
                                                            +'WHERE DATE_FORMAT(evn_datetime,"%Y.%m.%d") ' //
                                                            +'BETWEEN'+' "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iWeekCounter], 0, 10)))+'" ' //
                                                            +'AND "'+FormatDateTime('yyyy.mm.dd', StrToDate(Copy(slWeeksList[iWeekCounter], 14, 10)))+'" ' //
                                                            +'AND usr_fullname IN('; //
                                                          for iRoutineCounter:=0 to slUserList.Count-1 do
                                                            begin
                                                              q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                                              if iRoutineCounter<slUserList.Count-1 then
                                                                q:=q+', ';
                                                            end;
                                                          q:=q+') GROUP BY usr_fullname, evn_type, period ORDER BY evn_datetime;';
                                                          _MySQL_InsertRecords(FConfiguration.RNE4Server, bError, sErrorMessage, q); //
                                                        end;
                                                  finally
                                                    slWeeksList.Free;
                                                  end
                                                else
                                                  Routines_GenerateError('Возникла ошибка при получении списка недель, входяших в выбранный период времени!', sErrorMessage, bError);
                                                StepProgressBar; // 12

                                                // разблокирование таблиц
                                                if not bError then
                                                  begin
                                                    _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                                    StepProgressBar; // 13
                                                  end;
                                              end;
                                          end
                                        else // !!! если группировка любая кроме недельной
                                          begin
                                            // блокирование таблиц
                                            _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ, '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn READ');
                                            StepProgressBar; // 11

                                            if not bError then
                                              begin
                                                // Вставка данных в таблицу
                                                q:='INSERT INTO '+FConfiguration.RNE4Server.sMySQLDatabase+'.tmp_04 ' //
                                                  +'SELECT "", usr_fullname, '+sPeriodColumnQuery+' AS period, evn_type, COUNT(*) ' //
                                                  +'FROM '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn ' //
                                                  +'LEFT JOIN '+FConfiguration.RNE4Server.sMySQLDatabase+'._usr ' //
                                                  +'ON usr_id=evn_by_user_id ' //
                                                  +'WHERE DATE_FORMAT(evn_datetime,"%Y-%m-%d") ' //
                                                  +'BETWEEN "'+sSQLFormatStartDate+'" AND "'+sSQLFormatStopDate+'"'+' ' //
                                                  +'AND usr_fullname IN('; //
                                                for iRoutineCounter:=0 to slUserList.Count-1 do
                                                  begin
                                                    q:=q+'"'+slUserList[iRoutineCounter]+'"';
                                                    if iRoutineCounter<slUserList.Count-1 then
                                                      q:=q+', ';
                                                  end;
                                                q:=q+') ' //
                                                  +'GROUP BY usr_fullname, evn_type, '+sGroupByQuery+' ' //
                                                  +'ORDER BY evn_datetime;'; //
                                                _MySQL_InsertRecords(FConfiguration.RNE4Server, bError, sErrorMessage, q);
                                                StepProgressBar; // 12

                                                // разблокирование таблиц
                                                if not bError then
                                                  begin
                                                    _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                                    StepProgressBar; // 13
                                                  end;
                                              end;
                                          end;

                                        // перебор всех ползователей
                                        if not bError then
                                          begin
                                            for iRoutineCounter:=0 to slUserList.Count-1 do
                                              if bError then
                                                Break
                                              else
                                                begin
                                                  iQuantityCreated_UserSummary:=0;
                                                  iQuantityModified_UserSummary:=0;
                                                  iQuantityDeleted_UserSummary:=0;
                                                  iQuantityRecoveried_UserSummary:=0;
                                                  slPeriodList:=TStringList.Create;
                                                  try
                                                    // получение списка уникальных элементов колонки "период" для очередного пользователя
                                                    LogThis('>> Выполняется операция составления списка уникальных элементов колонки периода времени для очередного пользователя...', lmtDebug);
                                                    with FConfiguration.RNE4Server do
                                                      if not bConnected then
                                                        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                      else
                                                        begin
                                                          if mysql_ping(hConnection)<>0 then
                                                            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                          else
                                                            begin
                                                              q:='SELECT DISTINCT period ' //
                                                                +'FROM '+sMySQLDatabase+'.tmp_04 ' //
                                                                +'WHERE username="'+slUserList[iRoutineCounter]+'" ' //
                                                                +'ORDER BY sort_id;'; //
                                                              LogThis(q, lmtSQL);
                                                              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                  ResultSet:=mysql_store_result(hConnection);
                                                                  if ResultSet=nil then
                                                                    Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                                                Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                slPeriodList.Add(string(ResultRow[0]));
                                                                                end;
                                                                              end;
                                                                        end;
                                                                      mysql_free_result(ResultSet);
                                                                      LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    LogThis('<< Выполнение операции составления списка уникальных элементов колонки периода времени для очередного пользователя завершено.', lmtDebug);

                                                    if not bError then
                                                      begin
                                                        if (slPeriodList.Count>0)or ShowIdleUsers then
                                                          begin
                                                            bAnyReportDataExists:=True;
                                                            sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: left; font-weight: bold; font-size: 10pt; padding: 20px 0px 3px 0px;">'+
                                                              Trim(slUserList[iRoutineCounter])+':</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                            if slPeriodList.Count>0 then
                                                              begin
                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Период'+sPeriodColumn+'</TD>'+sLineBreak;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Создано</TD>'+sLineBreak;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Исправлено</TD>'+sLineBreak;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Удалено</TD>'+sLineBreak;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Восстановлено</TD>'+sLineBreak;
                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                // перебор строк периода и получение количества дейтвий каждого типа за данный период
                                                                for iPeriodCounter:=0 to slPeriodList.Count-1 do
                                                                  if bError then
                                                                    Break
                                                                  else
                                                                    begin
                                                                      LogThis('>> Выполняется операция получения количества операций очередного пользователя...', lmtDebug);
                                                                      with FConfiguration.RNE4Server do
                                                                        if not bConnected then
                                                                          Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                        else
                                                                          begin
                                                                            if mysql_ping(hConnection)<>0 then
                                                                              Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                q:='SELECT username, period, event_type, quantity ' //
                                                                                +'FROM '+sMySQLDatabase+'.tmp_04 ' //
                                                                                +'WHERE username="'+slUserList[iRoutineCounter]+'" ' //
                                                                                +'AND period="'+slPeriodList[iPeriodCounter]+'" ' //
                                                                                +'ORDER BY event_type;'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server),
                                                                                sErrorMessage, bError)
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
                                                                                iQuantityCreated:=0;
                                                                                iQuantityModified:=0;
                                                                                iQuantityDeleted:=0;
                                                                                iQuantityRecoveried:=0;
                                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                                if bError then
                                                                                Break
                                                                                else
                                                                                begin
                                                                                LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                s:=string(ResultRow[2]);
                                                                                if s='INS' then
                                                                                iQuantityCreated:=StrToIntDef(string(ResultRow[3]), 0);
                                                                                if s='MOD' then
                                                                                iQuantityModified:=StrToIntDef(string(ResultRow[3]), 0);
                                                                                if s='DEL' then
                                                                                iQuantityDeleted:=StrToIntDef(string(ResultRow[3]), 0);
                                                                                if s='REC' then
                                                                                iQuantityRecoveried:=StrToIntDef(string(ResultRow[3]), 0);
                                                                                end;
                                                                                end;
                                                                                if not bError then
                                                                                begin
                                                                                // формирование строки
                                                                                iQuantityCreated_UserSummary:=iQuantityCreated_UserSummary+iQuantityCreated;
                                                                                iQuantityModified_UserSummary:=iQuantityModified_UserSummary+iQuantityModified;
                                                                                iQuantityDeleted_UserSummary:=iQuantityDeleted_UserSummary+iQuantityDeleted;
                                                                                iQuantityRecoveried_UserSummary:=iQuantityRecoveried_UserSummary+iQuantityRecoveried;
                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+slPeriodList[iPeriodCounter]+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityCreated=0, '-', IntToStr(iQuantityCreated))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityModified=0, '-', IntToStr(iQuantityModified))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityDeleted=0, '-', IntToStr(iQuantityDeleted))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityRecoveried=0, '-', IntToStr(iQuantityRecoveried))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                              end;
                                                                          end;
                                                                      LogThis('<< Выполнение операции получения количества операций очередного пользователя завершено.', lmtDebug);
                                                                    end;
                                                                // добавление итоговой строки
                                                                if not bError then
                                                                  begin
                                                                    sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; padding: 2px;">Итого:</TD>'+sLineBreak;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityCreated_UserSummary=0, '-', IntToStr(iQuantityCreated_UserSummary))+'</TD>'+sLineBreak;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityModified_UserSummary=0, '-', IntToStr(iQuantityModified_UserSummary))+'</TD>'+sLineBreak;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityDeleted_UserSummary=0, '-', IntToStr(iQuantityDeleted_UserSummary))+'</TD>'+sLineBreak;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityRecoveried_UserSummary=0, '-', IntToStr(iQuantityRecoveried_UserSummary))+'</TD>'+sLineBreak;
                                                                    sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                  end;
                                                              end
                                                            else
                                                              if ShowIdleUsers then
                                                                begin
                                                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                  sHTML:=sHTML+
                                                                    '          <TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">Не найдено ни одного действия за данный период времени.</TD>'+sLineBreak;
                                                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                end;
                                                          end;
                                                      end;
                                                  finally
                                                    slPeriodList.Free;
                                                  end;
                                                end;
                                            StepProgressBar; // 14
                                          end;
                                      end;
                                  end;
                              end;
                          end;

                      end;
                  end;
              finally
                slUserList.Free;
              end;
            end;
        end;

      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
      _MySQL_CloseConnection(FConfiguration.RNE4Server, bError, sErrorMessage);
      StepProgressBar; // 15

      if not bError then
        begin
          // если не было выведено никаких табличных данных - выводим строку об отсутствии данных в БД
          if not bAnyReportDataExists then
            begin
              sHTML:=sHTML+'        <TR>'+sLineBreak;
              sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
                '" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">Данные за указанный период времени отсутствуют.</TD>'+sLineBreak;
              sHTML:=sHTML+'        </TR>'+sLineBreak;
            end;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+'" STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+'" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">Исполнитель:<BR>'+
            Self.CurrentUser.sPosition+'<BR>'+Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
            '" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          dtNow:=Now;
          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
            '" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'+'Отчёт подготовлен '+
            IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow)+
            ' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;
          sHTML:=sHTML+'      </TBODY>'+sLineBreak;
          sHTML:=sHTML+'    </TABLE>'+sLineBreak;
          sHTML:=sHTML+'    </CENTER>'+sLineBreak;
          sHTML:=sHTML+'  </BODY>'+sLineBreak;
          sHTML:=sHTML+'</HTML>'+sLineBreak;
          // _LogThis(sHTML, lmtDebug);
          StepProgressBar; // 16

          if not bError then //
            begin
              Synchronize( //
                procedure //
              begin //
                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика по работе пользователей АРМ услуги Отдых и развлечения за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True) then //
                Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage, bError); //
              end //
                ); //
              StepProgressBar; // 17
            end;
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
