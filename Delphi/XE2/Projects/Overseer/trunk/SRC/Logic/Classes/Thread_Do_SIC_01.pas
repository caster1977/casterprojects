unit Thread_Do_SIC_01;

interface

uses
  Classes,
  SysUtils,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_01=class(TThread_Do_SIC)
  private
    FPhonesList: TStringList;
    FShowUnserved: boolean;
  protected
    property ShowUnserved: boolean read FShowUnserved write FShowUnserved;
    property PhonesList: TStringList read FPhonesList write FPhonesList;
    procedure Execute; override;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aShowUnserved: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aPhonesList: TStringList);
    destructor Destroy; override;
  end;

implementation

uses
  Main,
  DateUtils,
  CastersPackage.uMysql,
  OverseerRoutines;

constructor TThread_Do_SIC_01.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aShowUnserved: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aPhonesList: TStringList);
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
      ShowUnserved:=aShowUnserved;

      PhonesList:=TStringList.Create;
      PhonesList.Sorted:=False;
      PhonesList.Assign(aPhonesList);
    end;
end;

destructor TThread_Do_SIC_01.Destroy;
begin
  PhonesList.Free;
  inherited;
end;

procedure TThread_Do_SIC_01.Execute;
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sReportPeriod: string;
  sTableName: string;
  iRoutineCounter, iPhonesCounter: integer;
  iRowQuantity, iRowCounter: integer;
  slIRDFullList: TStringList;
  dtDate: TDate;
  iFullListCounter: integer;
  q: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  sServiceName: string;
  sReportCode: string;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-01-...');

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

  sReportCode:='СИЦ-01-'+Routines_GetConditionalMessage(ShowUnserved, 'О', 'Н')+'-'+DatesDiffChar;

  LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

  // создание строки прогесса в окне прогресса действий
  _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', 11);

  if not bError then
    begin
      if PhonesList.Count<=0 then
        Routines_GenerateError('Не задано ни одного абонентского номера телефона для формирования отчёта!', sErrorMessage, bError);

      if not bError then
        begin
          // формирование/поиск сводной таблицы irda
          Synchronize( procedure begin //
            if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, False, False) then Routines_GenerateError('Произошла ошибка в процессе подготовки таблиц данных входящих звонков!', sErrorMessage, bError); end); //
          StepProgressBar; // 1

          if not bError then
            begin
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

                // подключение к MySQL-серверу, на котором находятся таблицы ird
                _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
                StepProgressBar; // 2

                if not bError then
                  begin
                    // Создание временной таблицы
                    _MySQL_CreateTable(Self.Configuration.StatServer, bError, sErrorMessage, //
                      'CREATE TEMPORARY TABLE '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 (' //
                      +'KEY ani (ani), ' //
                      +'KEY ddi (ddi), ' //
                      +'KEY datum (datum)) ' //
                      +'SELECT * FROM '+Self.Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[0])+' ' //
                      +'WHERE 1=0;'); //
                    StepProgressBar; // 3

                    if not bError then
                      begin
                        for iFullListCounter:=0 to slIRDFullList.Count-1 do
                          if bError then
                            Break
                          else
                            begin
                              // проверка наличия очередной таблицы с данными в базе данных
                              _MySQL_CheckTableExistance(Self.Configuration.StatServer, Self.Configuration.StatServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, LowerCase(slIRDFullList[iFullListCounter]));

                              if not bError then
                                begin
                                  // блокирование таблицы
                                  _MySQL_LockTables(Self.Configuration.StatServer, bError, sErrorMessage, Self.Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' READ');

                                  if not bError then
                                    begin
                                      // Вставка данных в таблицу
                                      q:='INSERT INTO '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                        +'SELECT * FROM '+Self.Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter]); //
                                      for iPhonesCounter:=0 to PhonesList.Count-1 do
                                        begin
                                          if iPhonesCounter=0 then
                                            q:=q+' WHERE '
                                          else
                                            q:=q+' OR ';
                                          q:=q+'ani LIKE "%'+PhonesList[iPhonesCounter]+'"';
                                        end;
                                      q:=q+';';
                                      _MySQL_InsertRecords(Self.Configuration.StatServer, bError, sErrorMessage, q);

                                      // разблокирование таблиц
                                      if not bError then
                                        _MySQL_UnlockTables(Self.Configuration.StatServer, bError, sErrorMessage);
                                    end;
                                end;
                            end;
                        StepProgressBar; // 4

                        if not bError then
                          begin
                            // фикс данных поля ddi в таблице
                            for iRoutineCounter:=0 to aServices_Count-1 do
                              if bError then
                                Break
                              else
                                begin
                                  _MySQL_UpdateRecords(Self.Configuration.StatServer, bError, sErrorMessage, //
                                    'UPDATE '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                    +'SET ddi="'+aServices[iRoutineCounter].sNumber+'" ' //
                                    +'WHERE LEFT(ddi,'+IntToStr(Length(aServices[iRoutineCounter].sNumber))+')="'+aServices[iRoutineCounter].sNumber+'";'); //
                                end;
                            StepProgressBar; // 5

                            if not bError then
                              begin
                                // фикс данных поля ddi в таблице
                                _MySQL_UpdateRecords(Self.Configuration.StatServer, bError, sErrorMessage, //
                                  'UPDATE '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                  +'SET ddi="199" ' //
                                  +'WHERE LEFT(ddi,4)="1111";'); //
                                StepProgressBar; // 6

                                if not bError then
                                  begin
                                    // фикс данных поля ddi в таблице
                                    _MySQL_UpdateRecords(Self.Configuration.StatServer, bError, sErrorMessage, //
                                      'UPDATE '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                      +'SET ddi="9910911" ' //
                                      +'WHERE LEFT(ddi,4)="2222";'); //
                                    StepProgressBar; // 7

                                    if not bError then
                                      begin
                                        // начало формирования текста HTML-файла
                                        sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+sLineBreak;
                                        sHTML:=sHTML+'<HTML>'+sLineBreak;
                                        sHTML:=sHTML+'  <HEAD>'+sLineBreak;
                                        sHTML:=sHTML+'    <TITLE>Статистика звонков с указанных абонентских номеров на предоставляемые СИЦ услуги за '+sReportPeriod+'</TITLE>'+sLineBreak;
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
                                          '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'
                                          +sLineBreak;
                                        sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+sLineBreak;
                                        sHTML:=sHTML+'        <TR>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="100px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="*" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+sLineBreak;
                                        sHTML:=sHTML+'        </TR>'+sLineBreak;
                                        sHTML:=sHTML+'        <TR>'+sLineBreak;
                                        sHTML:=sHTML+
                                          '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                                          +sReportCode+'</TD>'+sLineBreak;
                                        sHTML:=sHTML+
                                          '          <TD COLSPAN="5" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'
                                          +'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+sLineBreak;
                                        sHTML:=sHTML+'        </TR>'+sLineBreak;
                                        sHTML:=sHTML+'        <TR>'+sLineBreak;
                                        sHTML:=sHTML+
                                          '          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">Статистика звонков с указанных абонентских номеров<BR>на предоставляемые СИЦ услуги<BR>за '
                                          +sReportPeriod+'</TD>'+sLineBreak;
                                        sHTML:=sHTML+'        </TR>'+sLineBreak;

                                        // Получение данных по каждому отдельному телефону из временной таблицы и формирование строки отчёта
                                        for iPhonesCounter:=0 to PhonesList.Count-1 do
                                          if bError then
                                            Break
                                          else
                                            begin
                                              LogThis('>> Выполняется операция получения данных по звонкам с номера телефона "'+PhonesList[iPhonesCounter]+'" из временной таблицы...', lmtDebug);
                                              if not Self.Configuration.StatServer.bConnected then
                                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                              else
                                                begin
                                                  if mysql_ping(Self.Configuration.StatServer.hConnection)<>0 then
                                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
                                                  else
                                                    begin
                                                      q:='SELECT ani, ddi, datum, vrijeme, v_mreza, dur ' //
                                                        +'FROM '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                                        +'WHERE ani LIKE "%'+PhonesList[iPhonesCounter]+'" '+Routines_GetConditionalMessage(ShowUnserved, '', 'AND v_mreza>"" ') //
                                                        +'ORDER BY datum, vrijeme;'; //
                                                      LogThis(q, lmtSQL);
                                                      if mysql_real_query(Self.Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                        Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
                                                      else
                                                        begin
                                                          LogThis('Запрос выполнен успешно.', lmtDebug);
                                                          ResultSet:=mysql_store_result(Self.Configuration.StatServer.hConnection);
                                                          if ResultSet=nil then
                                                            Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
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
                                                                  sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                  sHTML:=sHTML+'          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: left; font-weight: bold; padding: 20px 0px 3px 0px;">'+IntToStr(iPhonesCounter+1)+
                                                                    '. Статистика звонков с номера телефона '+Trim(PhonesList[iPhonesCounter])+':</TD>'+sLineBreak;
                                                                  sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                  if iRowQuantity>0 then
                                                                    begin
                                                                      sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                      sHTML:=sHTML+
                                                                        '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер телефона<BR>абонента</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Наименование услуги</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Дата звонка</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время звонка</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Время ответа<BR>платформы</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+
                                                                        '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность<BR>соединения, сек.</TD>'+sLineBreak;
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
                                                                                Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                                sServiceName:=string(ResultRow[1]);
                                                                                for iRoutineCounter:=0 to aServices_Count-1 do
                                                                                if sServiceName=aServices[iRoutineCounter].sNumber then
                                                                                begin
                                                                                sServiceName:=aServices[iRoutineCounter].sName;
                                                                                Break;
                                                                                end;

                                                                                sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[0])='', '-', string(ResultRow[0]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[1])='', '-', string(ResultRow[1]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(sServiceName=string(ResultRow[1]), 'Технологический номер СИЦ', sServiceName)+
                                                                                '</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[2])='', '-', string(ResultRow[2]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[3])='', '-', string(ResultRow[3]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[4])='', '-', string(ResultRow[4]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[5])='', '-', string(ResultRow[5]))+'</TD>'+sLineBreak;
                                                                                sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                              end;
                                                                          end;
                                                                    end
                                                                  else
                                                                    begin
                                                                      sHTML:=sHTML+'        <TR>'+sLineBreak;
                                                                      sHTML:=sHTML+
                                                                        '          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">Не найдено ни одного звонка за данный период времени.</TD>'+sLineBreak;
                                                                      sHTML:=sHTML+'        </TR>'+sLineBreak;
                                                                    end;
                                                                end;
                                                              mysql_free_result(ResultSet);
                                                              LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                              LogThis('<< Выполнение операции получения данных по звонкам с номера телефона "'+PhonesList[iPhonesCounter]+'" из временной таблицы завершено.', lmtDebug);
                                            end;
                                        StepProgressBar; // 8

                                        if not bError then
                                          begin
                                            sHTML:=sHTML+'        <TR>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'        </TR>'+sLineBreak;
                                            sHTML:=sHTML+'        <TR>'+sLineBreak;
                                            sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="7" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">Исполнитель:<BR>'+Self.CurrentUser.sPosition+'<BR>'+
                                              Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+sLineBreak;
                                            sHTML:=sHTML+'        </TR>'+sLineBreak;
                                            sHTML:=sHTML+'        <TR>'+sLineBreak;
                                            sHTML:=sHTML+'           <TD COLSPAN="7" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+sLineBreak;
                                            sHTML:=sHTML+'        </TR>'+sLineBreak;
                                            sHTML:=sHTML+'        <TR>'+sLineBreak;
                                            dtNow:=Now;
                                            sHTML:=sHTML+
                                              '           <TD COLSPAN="7" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                              +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow)+
                                              ' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+sLineBreak;
                                            sHTML:=sHTML+'        </TR>'+sLineBreak;
                                            sHTML:=sHTML+'      </TBODY>'+sLineBreak;
                                            sHTML:=sHTML+'    </TABLE>'+sLineBreak;
                                            sHTML:=sHTML+'    </CENTER>'+sLineBreak;
                                            sHTML:=sHTML+'  </BODY>'+sLineBreak;
                                            sHTML:=sHTML+'</HTML>'+sLineBreak;
                                            // _LogThis(sHTML, lmtDebug);
                                            StepProgressBar; // 9
                                          end;
                                      end;
                                  end;
                              end;
                          end;
                      end;
                  end;

                // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
                StepProgressBar; // 10

                if not bError then //
                  begin
                    Synchronize( procedure begin //
                      if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика звонков с указанных абонентских номеров на предоставляемые СИЦ услуги за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True) then //
                      Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage, bError); end); //
                    StepProgressBar; // 11
                  end;
              finally
                slIRDFullList.Free;
              end;
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
