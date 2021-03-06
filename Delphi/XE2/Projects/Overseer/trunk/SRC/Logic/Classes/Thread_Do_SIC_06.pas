﻿unit Thread_Do_SIC_06;

interface

uses
  Classes,
  SysUtils,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_06=class(TThread_Do_SIC)
  private
    FServiceIndex: integer;
  protected
    procedure Execute; override;
    property ServiceIndex: integer read FServiceIndex write FServiceIndex default -1;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aServiceIndex: integer);
  end;

implementation

uses
  Main,
  DateUtils,
  CastersPackage.uMysql,
  OverseerRoutines;

constructor TThread_Do_SIC_06.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aServiceIndex: integer);
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
      ServiceIndex:=aServiceIndex;
    end;
end;

procedure TThread_Do_SIC_06.Execute;
const
  LogGroupGUID: string='{76EF14A3-6A2B-493C-97A5-5A08F779E4D4}';
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  // sPeriodColumn: string;
  sReportPeriod: string;
  // sReportSuffix: string;
  sTableName: string;
  q: string;
  iRoutineCounter, iRowQuantity, iRowCounter: integer;
  // sPeriodColumnQuery, sGroupByQuery: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  // slWeeksList: TStringList;
  sReportCode: string;
  sWherePartForService: string;
  bAnyReportDataExists: boolean;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-06-...');

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

  if aServices[ServiceIndex].sNumber='199' then
    sWherePartForService:='((ddi LIKE "1111%" OR ddi LIKE "199%") AND srv=0)'
  else
    if aServices[ServiceIndex].sNumber='9910911' then
      sWherePartForService:='((ddi LIKE "2222%" OR ddi LIKE "9910911%") AND srv=0)'
    else
      begin
        sWherePartForService:='(ddi LIKE "'+aServices[ServiceIndex].sNumber+'%" AND srv=';
        for iRoutineCounter:=0 to aServices_Count-1 do
          if aServices[iRoutineCounter].sNumber=aServices[ServiceIndex].sNumber then
            begin
              sWherePartForService:=sWherePartForService+Routines_GetConditionalMessage(aServices[iRoutineCounter].bAutoService, '1', '0');
              Break;
            end;
        if (aServices[ServiceIndex].sNumber='130')or(aServices[ServiceIndex].sNumber='2003498') then
          sWherePartForService:=sWherePartForService+' AND ((((vrijeme BETWEEN "08:30:00" AND "19:59:59") AND WEEKDAY(datum) IN(0,1,2,3,4)) OR ((vrijeme BETWEEN "09:00:00" AND "14:59:59") AND WEEKDAY(datum)=5)))';
        sWherePartForService:=sWherePartForService+')';
      end;

  sReportCode:='СИЦ-06-'+aServices[ServiceIndex].sNumber+'-'+DatesDiffChar;

  LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

  // создание строки прогесса в окне прогресса действий
  _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', 11+(aNets_Count-2)*2);

  // формирование/поиск сводной таблицы irda
  Synchronize( procedure begin //
    if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, True, False) then Routines_GenerateError('Произошла ошибка в процессе подготовки таблиц данных входящих звонков!', sErrorMessage, bError); end); //
  StepProgressBar; // 1

  if not bError then
    begin
      // подключаемся к MySQL-серверу, на котором находятся таблицы irda
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2

      if not bError then
        begin
          // Создание временной таблицы
          _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
            'CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_1 (' //
            +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
            +'region varchar(255) NOT NULL default "", ' //
            +'call_quantity decimal(20,0) default NULL, ' //
            +'call_sumtime decimal(20,0) default NULL, ' //
            +'allowed_call_quantity decimal(20,0) default NULL, ' //
            +'allowed_call_sumtime decimal(20,0) default NULL, ' //
            +'PRIMARY KEY (sort_id)' //
            +') TYPE=MyISAM;'); //
          StepProgressBar; // 3

          if not bError then
            begin
              // Создание временной таблицы
              _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
                'CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_2 (' //
                +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
                +'region varchar(255) NOT NULL default "", ' //
                +'call_quantity decimal(20,0) default NULL, ' //
                +'call_sumtime decimal(20,0) default NULL, ' //
                +'allowed_call_quantity decimal(20,0) default NULL, ' //
                +'allowed_call_sumtime decimal(20,0) default NULL, ' //
                +'PRIMARY KEY (sort_id)' //
                +') TYPE=MyISAM;'); //
              StepProgressBar; // 4

              if not bError then
                begin
                  // Создание временной таблицы
                  _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
                    'CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_3 (' //
                    +'sort_id int(10) unsigned NOT NULL auto_increment, ' //
                    +'region varchar(255) NOT NULL default "", ' //
                    +'call_quantity decimal(20,0) default NULL, ' //
                    +'call_sumtime decimal(20,0) default NULL, ' //
                    +'call_middletime decimal(20,2) default NULL, ' //
                    +'allowed_call_quantity decimal(20,0) default NULL, ' //
                    +'allowed_call_sumtime decimal(20,0) default NULL, ' //
                    +'allowed_call_middletime decimal(20,2) default NULL, ' //
                    +'nonallowed_call_percent decimal(10,2) default NULL, ' //
                    +'PRIMARY KEY (sort_id)' //
                    +') TYPE=MyISAM;'); //
                  StepProgressBar; // 5

                  if not bError then
                    begin

                      for iRoutineCounter:=1 to aNets_Count-1 do
                        if not bError then
                          begin
                            // Вставка данных в таблицу
                            q:='INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_1 ' //
                              +'SELECT' //
                              +' "",' //
                              +' "'+aNets[iRoutineCounter].sName+'" AS a,' //
                              +' COUNT(*),' //
                              +' SUM(dur),' //
                              +' "",' //
                              +' "" ' //
                              +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' ' //
                              +'WHERE' //
                              +' '+aNets[iRoutineCounter].sQuery
                              +' AND '+sWherePartForService+' ' //
                              +'GROUP BY a;';
                            _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, q); //
                            StepProgressBar; // 6

                            if not bError then
                              begin
                                // Вставка данных в таблицу
                                q:='INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_2 ' //
                                  +'SELECT' //
                                  +' "",' //
                                  +' "'+aNets[iRoutineCounter].sName+'" AS a,' //
                                  +' "",' //
                                  +' "",' //
                                  +' COUNT(*),' //
                                  +' SUM(dur) ' //
                                  +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' ' //
                                  +'WHERE' //
                                  +' '+aNets[iRoutineCounter].sQuery
                                  +' AND '+sWherePartForService //
                                  +' AND v_mreza>""' //
                                  +Routines_GetConditionalMessage(aServices[ServiceIndex].bAutoService, '', ' AND v_oper>""') //
                                  +Routines_GetConditionalMessage(aServices[ServiceIndex].bAutoService, '', ' AND rm>0') //
                                  +' AND dur>0 ' //
                                  +'GROUP BY a;';
                                _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, q); //
                                StepProgressBar; // 27
                              end;
                          end;
                      if not bError then
                        begin
                          // Вставка данных в таблицу
                          _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                            'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_3 ' //
                            +'SELECT' //
                            +' "",' //
                            +' a.region,' //
                            +' a.call_quantity,' //
                            +' a.call_sumtime,' //
                            +' a.call_sumtime/a.call_quantity,' //
                            +' b.allowed_call_quantity,' //
                            +' b.allowed_call_sumtime,' //
                            +' b.allowed_call_sumtime/b.allowed_call_quantity,' //
                            +' (1-(b.allowed_call_quantity/a.call_quantity))*100 ' //
                            +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_1 AS a ' //
                            +'LEFT JOIN '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_2 AS b ' //
                            +'ON b.region=a.region ' //
                            +'ORDER BY a.sort_id;');
                          StepProgressBar; // 28
                        end;

                      if not bError then
                        begin
                          // начало формирования текста HTML-файла
                          sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+sLineBreak;
                          sHTML:=sHTML+'<HTML>'+sLineBreak;
                          sHTML:=sHTML+'  <HEAD>'+sLineBreak;
                          sHTML:=sHTML+'    <TITLE>Статистика звонков на услугу СИЦ "'+aServices[ServiceIndex].sNumber+'" за '+sReportPeriod+'</TITLE>'+sLineBreak;
                          sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="pragma">'+sLineBreak;
                          sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">'+sLineBreak;
                          sHTML:=sHTML+'    <META CONTENT="Dynamic" NAME="Document-state">'+sLineBreak;
                          sHTML:=sHTML+'    <META content="text/html; charset=Windows-1251" http-equiv="Content-Type">'+sLineBreak;
                          sHTML:=sHTML+'    <STYLE MEDIA="screen, print" TYPE="text/css">'+sLineBreak;
                          sHTML:=sHTML+'      * {'+sLineBreak;
                          sHTML:=sHTML+'        font-family: Verdana, Arial, Helvetica, sans-serif;'+sLineBreak;
                          sHTML:=sHTML+'        font-size: 8pt;'+sLineBreak;
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
                            '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+sLineBreak;
                          sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+sLineBreak;
                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="105px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="115px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="105px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="115px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="*" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                          sHTML:=sHTML+
                            '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                            +sReportCode+'</TD>'+sLineBreak;
                          sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
                            'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+sLineBreak;
                          sHTML:=sHTML+'        </TR>'+sLineBreak;
                          sHTML:=sHTML+'        <TR>'+sLineBreak;
                          sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">Статистика звонков на услугу &laquo;'+
                            aServices[ServiceIndex].sNumber+'&raquo;<BR>за '+sReportPeriod+'</TD>'+sLineBreak;
                          sHTML:=sHTML+'        </TR>'+sLineBreak;

                          // получение данных для строк отчёта
                          LogThis('>> Выполняется операция получения данных для строк отчёта...', lmtDebug);
                          if not FConfiguration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(FConfiguration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' region,' //
                                    +' call_quantity,' //
                                    +' allowed_call_quantity,' //
                                    +' allowed_call_sumtime,' //
                                    +' allowed_call_middletime,' //
                                    +' nonallowed_call_percent ' //
                                    +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_3 ' //
                                    +'ORDER BY sort_id;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(FConfiguration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(FConfiguration.StatServer.hConnection);
                                      if ResultSet=nil then
                                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
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
                                                  bAnyReportDataExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Телефонная сеть</TD>'+sLineBreak;
                                                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Пришло на<BR>СТ-платформу<BR>звонков,<BR>штук</TD>'+sLineBreak;
                                                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Обслужено<BR>звонков,<BR>штук</TD>'+sLineBreak;
                                                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Общая<BR>длительность<BR>обслуженных<BR>звонков, сек.</TD>'+sLineBreak;
                                                  sHTML:=sHTML+
                                                    '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя<BR>длительность<BR>обслуженных<BR>звонков, сек.</TD>'+sLineBreak;
                                                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Отказы<BR>по<BR>услуге,<BR>%</TD>'+sLineBreak;
                                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                  for iRowCounter:=0 to iRowQuantity-1 do
                                                    if bError then
                                                      Break
                                                    else
                                                      begin
                                                        LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Данные очередной строки получены успешно.', lmtDebug);
                                                            sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                              'px 2px; border-color: black; padding: 1px 2px;">' //
                                                              +Routines_GetConditionalMessage(string(ResultRow[0])<>'', string(ResultRow[0]), '0')+'</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                              'px 0px; border-color: black; padding: 1px 2px;">' //
                                                              +Routines_GetConditionalMessage(string(ResultRow[1])<>'', string(ResultRow[1]), '0')+'</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                              'px 0px; border-color: black; padding: 1px 2px;">' //
                                                              +Routines_GetConditionalMessage(string(ResultRow[2])<>'', string(ResultRow[2]), '0')+'</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                              'px 0px; border-color: black; padding: 1px 2px;">' //
                                                              +Routines_GetConditionalMessage(string(ResultRow[3])<>'', string(ResultRow[3]), '0')+'</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                              'px 0px; border-color: black; padding: 1px 2px;">' //
                                                              +Routines_GetConditionalMessage(string(ResultRow[4])<>'', string(ResultRow[4]), '0')+'</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                                                              'px 0px; border-color: black; padding: 1px 2px;">' //
                                                              +Routines_GetConditionalMessage(string(ResultRow[5])<>'', string(ResultRow[5]), '0.00')+'</TD>'+sLineBreak;
                                                            sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                          end;
                                                      end;
                                                end
                                              else // если данных не было найдено
                                                begin
                                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                  sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">'+
                                                    'Данные за указанный период времени отсутствуют.</TD>'+sLineBreak;
                                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                end;
                                            end;
                                          mysql_free_result(ResultSet);
                                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                        end;
                                    end;
                                end;
                            end;
                          LogThis('<< Выполнение операция получения данных для строк отчёта завершено.', lmtDebug);
                          StepProgressBar; // 29

                          // получение итоговых данных
                          if not bError then
                            begin
                              if bAnyReportDataExists then
                                begin
                                  LogThis('>> Выполняется операция получения данных для итоговой строки...', lmtDebug);
                                  if not FConfiguration.StatServer.bConnected then
                                    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                  else
                                    begin
                                      if mysql_ping(FConfiguration.StatServer.hConnection)<>0 then
                                        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                      else
                                        begin
                                          q:='SELECT' //
                                            +' SUM(call_quantity),' //
                                            +' SUM(allowed_call_quantity),' //
                                            +' SUM(allowed_call_sumtime),' //
                                            +' SUM(allowed_call_sumtime)/SUM(allowed_call_quantity),' //
                                            +' 100-((SUM(allowed_call_quantity)/SUM(call_quantity))*100) ' //
                                            +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_3 ' //
                                            +'GROUP BY "";'; //
                                          LogThis(q, lmtSQL);
                                          if mysql_real_query(FConfiguration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                          else
                                            begin
                                              LogThis('Запрос выполнен успешно.', lmtDebug);
                                              ResultSet:=mysql_store_result(FConfiguration.StatServer.hConnection);
                                              if ResultSet=nil then
                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                              else
                                                begin
                                                  LogThis('Результирующая выборка получена успешно.', lmtDebug);
                                                  iRoutineCounter:=mysql_num_rows(ResultSet);
                                                  LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', lmtDebug);
                                                  if iRoutineCounter<0 then
                                                    Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      if iRoutineCounter<>1 then
                                                        Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                      else
                                                        begin
                                                          ResultRow:=mysql_fetch_row(ResultSet);
                                                          if ResultRow=nil then
                                                            Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                              LogThis('Данные для итоговой строки получены успешно.', lmtDebug);
                                                              // итоговая строка отчёта
                                                              sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Итого:</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                                Routines_GetConditionalMessage(string(ResultRow[0])<>'', string(ResultRow[0]), '0')+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                                Routines_GetConditionalMessage(string(ResultRow[1])<>'', string(ResultRow[1]), '0')+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                                Routines_GetConditionalMessage(string(ResultRow[2])<>'', string(ResultRow[2]), '0')+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                                Routines_GetConditionalMessage(string(ResultRow[3])<>'', string(ResultRow[3]), '0')+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                                Routines_GetConditionalMessage(string(ResultRow[4])<>'', string(ResultRow[4]), '0.00')+'</TD>'+sLineBreak;
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
                                  LogThis('<< Выполнение операция получения данных для итоговой строки завершено.', lmtDebug);
                                  StepProgressBar; // 30
                                end;

                              if not bError then
                                begin
                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                  sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="6" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">Исполнитель:<BR>'+Self.CurrentUser.sPosition+'<BR>'+
                                    Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+sLineBreak;
                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                  sHTML:=sHTML+'           <TD COLSPAN="6" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+sLineBreak;
                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                  dtNow:=Now;
                                  sHTML:=sHTML+
                                    '           <TD COLSPAN="6" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                    +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow)+
                                    ' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+sLineBreak;
                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                  sHTML:=sHTML+'      </TBODY>'+sLineBreak;
                                  sHTML:=sHTML+'    </TABLE>'+sLineBreak;
                                  sHTML:=sHTML+'    </CENTER>'+sLineBreak;
                                  sHTML:=sHTML+'  </BODY>'+sLineBreak;
                                  sHTML:=sHTML+'</HTML>'+sLineBreak;
                                  // _LogThis(sHTML, lmtDebug);
                                  StepProgressBar; // 31
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
      _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 32

      // открытие отчёта браузером
      if not bError then //
        begin
          Synchronize( procedure begin //
            if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика звонков на услугу СИЦ '+aServices[ServiceIndex].sNumber+' за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True)
          then Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage, bError); end); //
          StepProgressBar; // 33
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
