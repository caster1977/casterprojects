unit Thread_Do_SIC_08;

interface

uses
  Classes,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_08=class(TThread_Do_SIC)
  protected
    procedure Execute; override;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec);
  end;

implementation

uses
  Main,
  OverseerRoutines,
  DateUtils,
  SysUtils,
  mysql;

constructor TThread_Do_SIC_08.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec);
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
    end;
end;

procedure TThread_Do_SIC_08.Execute;
const
  LogGroupGUID: string='{A09517BA-BFD7-447D-9BD1-F5F990A57B80}';
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sReportPeriod: string;
  slIRDFullList: TStringList;
  dtDate: TDate;
  iFullListCounter: integer;
  q: string;
  iRowQuantity, iRowCounter: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  sTableName: string;
  sReportCode: string;
  bAnyReportDataExists: boolean;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-08-...');

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

  sReportCode:='СИЦ-08-'+DatesDiffChar;

  LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

  slIRDFullList:=TStringList.Create;
  try
    // создание списка имён исходных таблиц данных
    LogThis('>> Выполняется операция составления списка таблиц входящих звонков...', lmtDebug);
    dtDate:=StartDate;
    repeat
      slIRDFullList.Add('ird_'+FormatDateTime('yyyymmdd', dtDate));
      dtDate:=IncDay(dtDate, 1);
    until dtDate>StopDate;
    LogThis('Финальное количество строк списка таблиц данных равно '+IntToStr(slIRDFullList.Count)+'.', lmtDebug);
    LogThis('<< Выполнение операции составления списка таблиц входящих звонков завершено.', lmtDebug);

    // создание строки прогесса в окне прогресса действий
    _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', (slIRDFullList.Count*4)+5);

    // поиск всех таблиц ird
    Synchronize( procedure begin //
      if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, False, False) then Routines_GenerateError('Произошла ошибка в процессе подготовки таблиц данных входящих звонков!', sErrorMessage, bError); end); //
    StepProgressBar; // 1

    with FConfiguration, FConfiguration.StatServer do
      if not bError then
        begin
          sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+sLineBreak;
          sHTML:=sHTML+'<HTML>'+sLineBreak;
          sHTML:=sHTML+'  <HEAD>'+sLineBreak;
          sHTML:=sHTML+'    <TITLE>Статистика звонков Гидрометцентра на услугу Content Provider за '+sReportPeriod+'</TITLE>'+sLineBreak;
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
          sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+sLineBreak;
          sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+sLineBreak;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          sHTML:=sHTML+
            '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left; font-weight: bold;">Форма № '+
            sReportCode+'</TD>'+sLineBreak;
          sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
            'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;
          sHTML:=sHTML+'        <TR>'+sLineBreak;
          sHTML:=sHTML+
            '          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">Статистика звонков Гидрометцентра<BR>на услугу &laquo;Content Provider&raquo;<BR>за '
            +sReportPeriod+'</TD>'+sLineBreak;
          sHTML:=sHTML+'        </TR>'+sLineBreak;

          // подключаемся к MySQL-серверу, на котором находятся таблицы ird
          _MySQL_OpenConnection(StatServer, bError, sErrorMessage);
          StepProgressBar; // 2

          if not bError then
            begin
              // >>> цикл перебора таблиц данных и составление строк отчёта
              for iFullListCounter:=0 to slIRDFullList.Count-1 do
                if bError then
                  Break
                else
                  begin
                    // проверка наличия очередной таблицы с данными в базе данных
                    _MySQL_CheckTableExistance(StatServer, sMySQLDatabase_IRD_Location, bError, sErrorMessage, LowerCase(slIRDFullList[iFullListCounter]));
                    StepProgressBar; // 3-1

                    if not bError then
                      begin
                        // блокирование таблицы
                        _MySQL_LockTables(StatServer, bError, sErrorMessage, sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' READ');
                        StepProgressBar; // 3-2

                        // получение данных
                        if not bError then
                          begin
                            LogThis('>> Выполняется операция получения данных из таблицы '+LowerCase(slIRDFullList[iFullListCounter])+'...', lmtDebug);
                            if not bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                else
                                  begin
                                    q:='SELECT ani, datum, vrijeme, SEC_TO_TIME(dur) ' //
                                      +'FROM '+sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' ' //
                                      +'WHERE dur>1 ' //
                                      +'AND (ddi LIKE "%2339535" OR ddi="198" OR ddi="001798") ' //
                                      +'AND (ani LIKE "%2370654") ' //
                                      +'ORDER BY datum, vrijeme;'; //
                                    LogThis(q, lmtSQL);
                                    if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtDebug);
                                        ResultSet:=mysql_store_result(hConnection);
                                        if ResultSet=nil then
                                          Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
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
                                                    // перед первыми данными таблицы вставляем шапку таблицы
                                                    if not bAnyReportDataExists then
                                                      begin
                                                        sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер телефона</TD>'+sLineBreak;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Дата звонка</TD>'+sLineBreak;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время звонка</TD>'+sLineBreak;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонка</TD>'+sLineBreak;
                                                        sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                      end;
                                                    bAnyReportDataExists:=True;
                                                    for iRowCounter:=0 to iRowQuantity-1 do
                                                      if bError then
                                                        Break
                                                      else
                                                        begin
                                                          LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                          ResultRow:=mysql_fetch_row(ResultSet);
                                                          if ResultRow=nil then
                                                            Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(StatServer),
                                                              sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                              sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 2px; border-color: black; padding: 1px 2px;">'+string(ResultRow[0])+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[1])+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[2])+'</TD>'+sLineBreak;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[3])+'</TD>'+sLineBreak;
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
                              end;
                            LogThis('<< Выполнение операции получения данных из таблицы '+LowerCase(slIRDFullList[iFullListCounter])+' завершено.', lmtDebug);
                            StepProgressBar; // 3-3

                            if not bError then
                              begin
                                // разблокирование таблиц
                                _MySQL_UnlockTables(StatServer, bError, sErrorMessage);
                                StepProgressBar; // 3-4
                              end;
                          end;
                      end;
                  end;
              if not bError then
                begin
                  if not bAnyReportDataExists then
                    begin
                      sHTML:=sHTML+'        <TR>'+sLineBreak;
                      sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">Не найдено данных за указанный период времени.</TD>'+sLineBreak;
                      sHTML:=sHTML+'        </TR>'+sLineBreak;
                    end;
                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+sLineBreak;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+sLineBreak;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+sLineBreak;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+sLineBreak;
                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                  sHTML:=sHTML+'          <TD COLSPAN="4" VALIGN="TOP" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;">Исполнитель:<BR>'+Self.CurrentUser.sPosition+'<BR>'+Self.CurrentUser.sFullName+
                    '<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+sLineBreak;
                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                  sHTML:=sHTML+'           <TD COLSPAN="4" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+sLineBreak;
                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                  dtNow:=Now;
                  sHTML:=sHTML+
                    '           <TD COLSPAN="4" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                    +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow)+
                    ' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+sLineBreak;
                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                  sHTML:=sHTML+'      </TBODY>'+sLineBreak;
                  sHTML:=sHTML+'    </TABLE>'+sLineBreak;
                  sHTML:=sHTML+'    </CENTER>'+sLineBreak;
                  sHTML:=sHTML+'  </BODY>'+sLineBreak;
                  sHTML:=sHTML+'</HTML>'+sLineBreak;
                  // _LogThis(sHTML, lmtDebug);
                  StepProgressBar; // 4
                end;
            end;

          // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
          _MySQL_CloseConnection(StatServer, bError, sErrorMessage);
          StepProgressBar; // 5

          // открытие отчёта браузером
          if not bError then //
            begin
              Synchronize( procedure begin //
                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика звонков Гидрометцентра на услугу Content Provider за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True)
              then Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage, bError); end); //
              StepProgressBar; // 6
            end;

        end;
  finally
    slIRDFullList.Free;
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
