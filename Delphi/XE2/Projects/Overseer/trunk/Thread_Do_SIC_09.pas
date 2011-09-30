unit Thread_Do_SIC_09;

interface

uses
  Classes,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_09=class(TThread_Do_SIC)
  private
    FNetIndex: integer;
    FSummaryReport: boolean;
    FOldReport: boolean;
    FSelectedServicesList: TStringList;
  protected
    procedure Execute; override;
    property NetIndex: integer read FNetIndex write FNetIndex default -1;
    property SelectedServicesList: TStringList read FSelectedServicesList write FSelectedServicesList;
    property SummaryReport: boolean read FSummaryReport write FSummaryReport;
    property OldReport: boolean read FOldReport write FOldReport;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aSummaryReport, aOldReport: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aNetIndex: integer; //
      aSelectedServicesList: TStringList);
    destructor Destroy; override;
  end;

implementation

uses
  Main,
  SysUtils,
  OverseerRoutines,
  DateUtils,
  mysql;

constructor TThread_Do_SIC_09.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser, aSummaryReport, aOldReport: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aNetIndex: integer;
  aSelectedServicesList: TStringList);
begin
  inherited Create;
  with Self do
    begin
      LogGroupGUID:=aLogGroupGUID;
      StartDate:=aStartDate;
      StopDate:=aStopDate;
      OpenWithBrowser:=aOpenWithBrowser;
      SummaryReport:=aSummaryReport;
      OldReport:=aOldReport;
      CurrentUser:=aCurrentUser;
      Configuration:=aConfiguration;
      NetIndex:=aNetIndex;

      SelectedServicesList:=TStringList.Create;
      SelectedServicesList.Sorted:=False;
      SelectedServicesList.Assign(aSelectedServicesList);
    end;
end;

destructor TThread_Do_SIC_09.Destroy;
begin
  SelectedServicesList.Free;
  inherited;
end;

procedure TThread_Do_SIC_09.Execute;
const
  LogGroupGUID: string='{CB06281F-6A71-4553-B711-CD4C02E82D5E}';
var
  sErrorMessage: string;
  bError: boolean;
  sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sReportPeriod: string;
  q: string;
  iRowQuantity: integer;
  iRowCounter: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  sTableName: string;
  i, iRoutineCounter: integer;
  sReportCode: string;
  is_autoservice, call_quantity, call_sumtime_in_sec, call_sumtime_in_min_div_60, call_sumtime_in_min_each, call_average_time: string;
  call_quantity_part3, call_percent_part3, call_quantity_part4, call_percent_part4, call_quantity_part5, call_percent_part5: string;
  iSubtablesCounter: integer;
  bBlockDataExists, bVoiceBlockExists, bAutoBlockExists: boolean;

  ibVoiceBlockSummary_call_quantity, iAutoBlockSummary_call_quantity, ibVoiceBlockSummary_call_sumtime_in_sec, iAutoBlockSummary_call_sumtime_in_sec, ibVoiceBlockSummary_call_sumtime_in_min_div_60, iAutoBlockSummary_call_sumtime_in_min_div_60,
    ibVoiceBlockSummary_call_sumtime_in_min_each, iAutoBlockSummary_call_sumtime_in_min_each: integer;

  rSummary_call_average_time: real;
begin
  ProcedureHeader('Процедура формирования отчёта по форме № СИЦ-09-...');

  // старт замера времени выполнения процедуры
  EnableTimer:=True;

  // инициализация значений переменных
  bError:=False;
  sTableName:='';

  ibVoiceBlockSummary_call_quantity:=0;
  iAutoBlockSummary_call_quantity:=0;
  ibVoiceBlockSummary_call_sumtime_in_sec:=0;
  iAutoBlockSummary_call_sumtime_in_sec:=0;
  ibVoiceBlockSummary_call_sumtime_in_min_div_60:=0;
  iAutoBlockSummary_call_sumtime_in_min_div_60:=0;
  ibVoiceBlockSummary_call_sumtime_in_min_each:=0;
  iAutoBlockSummary_call_sumtime_in_min_each:=0;

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

  if SelectedServicesList.Count<=0 then
    Routines_GenerateError('Не задано ни одной услуги для формирования отчёта!', sErrorMessage, bError);

  if not bError then
    if not(NetIndex in [0..aNets_Count-1]) then
      Routines_GenerateError('Для формирования отчёта выбрана неопределённая телефонная сеть!', sErrorMessage, bError);

  if not bError then
    begin
      sReportCode:='СИЦ-09-'+Routines_GetConditionalMessage(OldReport, 'У', Routines_GetConditionalMessage(SummaryReport, 'К', 'П'))+Routines_GetConditionalMessage(aNets[NetIndex].sName<>'', '-'+aNets[NetIndex].sName, '')+'-'+DatesDiffChar;

      LogThis('Начато формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'.', lmtInfo);

      // создание строки прогесса в окне прогресса действий
      _CreateProgressBar(dtNow, 'Формирование отчёта по форме № '+sReportCode+' за '+sReportPeriod+'...', 110);

      // формирование/поиск сводной таблицы orda
      Synchronize( procedure begin //
        if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, True, False) then Routines_GenerateError('Произошла ошибка в процессе подготовки таблиц данных входящих звонков!', sErrorMessage, bError); end); //
      StepProgressBar; // 1

      if not bError then
        begin
          // подключение к MySQL-серверу, на котором находятся таблицы irda
          _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
          StepProgressBar; // 2

          if not bError then
            begin
              // проверка наличия таблицы в базе данных
              _MySQL_CheckTableExistance(Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRDA_Location, bError, sErrorMessage, sTableName);
              StepProgressBar; // 3

              if not bError then
                begin
                  // блокирование таблицы
                  _MySQL_LockTables(Configuration.StatServer, bError, sErrorMessage, Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' READ');
                  StepProgressBar; // 4

                  if not bError then
                    begin
                      with Configuration, Configuration.StatServer do
                        begin
                          // Создание временной таблицы
                          q:='CREATE TEMPORARY TABLE '+sMySQLDatabase_IRDA_Location+'.tmp_09_1 (' //
                            +'KEY ani (ani), ' //
                            +'KEY ddi (ddi), ' //
                            +'KEY datum (datum)' //
                            +') TYPE=MyISAM ' //
                            +'SELECT * ' //
                            +'FROM '+sMySQLDatabase_IRDA_Location+'.'+sTableName+' ' //
                            +'WHERE '; //
                          q:=q+Routines_GetConditionalMessage(aNets[NetIndex].sQuery>'', aNets[NetIndex].sQuery+' AND (', '');
                          for iRoutineCounter:=0 to SelectedServicesList.Count-1 do
                            begin
                              if SelectedServicesList[iRoutineCounter]='199' then
                                q:=q+'((ddi LIKE "1111%" OR ddi LIKE "199%") AND srv=0)'
                              else
                                if SelectedServicesList[iRoutineCounter]='9910911' then
                                  q:=q+'((ddi LIKE "2222%" OR ddi LIKE "9910911%") AND srv=0)'
                                else
                                  begin
                                    q:=q+'(ddi LIKE "'+SelectedServicesList[iRoutineCounter]+'%" AND srv=';
                                    for i:=0 to aServices_Count-1 do
                                      if aServices[i].sNumber=SelectedServicesList[iRoutineCounter] then
                                        begin
                                          q:=q+Routines_GetConditionalMessage(aServices[i].bAutoService, '1', '0');
                                          Break;
                                        end;
                                    if (SelectedServicesList[iRoutineCounter]='130')or(SelectedServicesList[iRoutineCounter]='2003498') then
                                      q:=q+' AND ((((vrijeme BETWEEN "08:30:00" AND "19:59:59") AND WEEKDAY(datum) IN(0,1,2,3,4)) OR ((vrijeme BETWEEN "09:00:00" AND "14:59:59") AND WEEKDAY(datum)=5)))';
                                    q:=q+')';
                                  end;
                              if iRoutineCounter<SelectedServicesList.Count-1 then
                                q:=q+' OR ';
                            end;
                          q:=q+Routines_GetConditionalMessage(aNets[NetIndex].sQuery>'', ')', '')+';';
                          _MySQL_CreateTable(StatServer, bError, sErrorMessage, q);
                        end;
                      StepProgressBar; // 5

                      if not bError then
                        begin
                          // разблокирование таблиц
                          _MySQL_UnlockTables(Configuration.StatServer, bError, sErrorMessage);
                          StepProgressBar; // 6

                          if not bError then
                            begin
                              // фикс данных поля ddi в таблице
                              for iRoutineCounter:=0 to aServices_Count-1 do
                                if bError then
                                  Break
                                else
                                  _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                    'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_1 ' //
                                    +'SET ddi="'+aServices[iRoutineCounter].sNumber+'" ' //
                                    +'WHERE LEFT(ddi,'+IntToStr(Length(aServices[iRoutineCounter].sNumber))+')="'+aServices[iRoutineCounter].sNumber+'";'); //
                              StepProgressBar; // 7

                              if not bError then
                                begin
                                  // фикс данных поля ddi в таблице
                                  _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                    'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_1 ' //
                                    +'SET ddi="199" ' //
                                    +'WHERE LEFT(ddi,4)="1111";'); //
                                  StepProgressBar; // 8

                                  if not bError then
                                    begin
                                      // фикс данных поля ddi в таблице
                                      _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                        'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_1 ' //
                                        +'SET ddi="9910911" ' //
                                        +'WHERE LEFT(ddi,4)="2222";'); //
                                      StepProgressBar; // 9

                                      if not bError then
                                        begin
                                          // Создание временной таблицы
                                          q:='CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                            +'(KEY ani (ani), KEY ddi (ddi), KEY datum (datum)) TYPE=MyISAM ' //
                                            +'SELECT * ' //
                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_1 ' //
                                            +'WHERE ddi IN(';
                                          for iRoutineCounter:=0 to SelectedServicesList.Count-1 do
                                            begin
                                              q:=q+'"'+SelectedServicesList[iRoutineCounter]+'"';
                                              if iRoutineCounter<SelectedServicesList.Count-1 then
                                                q:=q+', ';
                                            end;
                                          q:=q+');';
                                          _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, q);
                                          StepProgressBar; // 10

                                          // пришло на СТ-платформу
                                          if not bError then
                                            begin
                                              // Создание временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_1 (' //
                                                +'service char(32) NOT NULL default "", ' //
                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                +'call_quantity int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_sec int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_div_60 int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_each int(13) unsigned default NULL, ' //
                                                +'call_average_time float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 11

                                              if not bError then
                                                begin
                                                  // голосовые - подробно
                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_1 ' //
                                                    +'SELECT' //
                                                    +' ddi,' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' COUNT(*),' //
                                                    +' SUM(dur),' //
                                                    +' CEILING(SUM(dur)/60),' //
                                                    +' SUM(CEILING(dur/60)),' //
                                                    +' SUM(dur)/COUNT(*) ' //
                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                    +'WHERE ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911") ' //
                                                    +'GROUP BY ddi ' //
                                                    +'ORDER BY ddi;'); //
                                                  StepProgressBar; // 12

                                                  if not bError then
                                                    begin
                                                      // голосовые - итог
                                                      _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                        'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_1 ' //
                                                        +'SELECT' //
                                                        +' "Итого:",' //
                                                        +' "0",' //
                                                        +' "1",' //
                                                        +' "0",' //
                                                        +' COUNT(*),' //
                                                        +' SUM(dur),' //
                                                        +' CEILING(SUM(dur)/60),' //
                                                        +' SUM(CEILING(dur/60)),' //
                                                        +' SUM(dur)/COUNT(*) ' //
                                                        +'FROM irda.tmp_09_2 ' //
                                                        +'WHERE ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911") ' //
                                                        +'GROUP BY "";'); //
                                                      StepProgressBar; // 13

                                                      if not bError then
                                                        begin
                                                          // автоинформатор - подробно
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_1 ' //
                                                            +'SELECT' //
                                                            +' ddi,' //
                                                            +' "1",' //
                                                            +' "0",' //
                                                            +' "0",' //
                                                            +' COUNT(*),' //
                                                            +' SUM(dur),' //
                                                            +' CEILING(SUM(dur)/60),' //
                                                            +' SUM(CEILING(dur/60)),' //
                                                            +' SUM(dur)/COUNT(*) ' //
                                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                            +'WHERE ddi IN("175", "188", "191", "192", "194", "195", "196", "197", "99175", "99188", "99191", "99192", "99194", "99195", "99196", "99197") ' //
                                                            +'GROUP BY ddi ' //
                                                            +'ORDER BY ddi;'); //
                                                          StepProgressBar; // 14

                                                          if not bError then
                                                            begin
                                                              // автоинформатор - итог
                                                              _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_1 ' //
                                                                +'SELECT' //
                                                                +' "Итого:",' //
                                                                +' "1",' //
                                                                +' "1",' //
                                                                +' "0",' //
                                                                +' COUNT(*),' //
                                                                +' SUM(dur),' //
                                                                +' CEILING(SUM(dur)/60),' //
                                                                +' SUM(CEILING(dur/60)),' //
                                                                +' SUM(dur)/COUNT(*) ' //
                                                                +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                                +'WHERE ddi IN("175", "188", "191", "192", "194", "195", "196", "197", "99175", "99188", "99191", "99192", "99194", "99195", "99196", "99197") ' //
                                                                +'GROUP BY "";'); //
                                                              StepProgressBar; // 15

                                                              if not bError then
                                                                begin
                                                                  // общий итог
                                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_1 ' //
                                                                    +'SELECT' //
                                                                    +' "Всего:",' //
                                                                    +' "0",' //
                                                                    +' "0",' //
                                                                    +' "1",' //
                                                                    +' COUNT(*),' //
                                                                    +' SUM(dur),' //
                                                                    +' CEILING(SUM(dur)/60),' //
                                                                    +' SUM(CEILING(dur/60)),' //
                                                                    +' SUM(dur)/COUNT(*) ' //
                                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                                    +'GROUP BY "";'); //
                                                                  StepProgressBar; // 16
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          // принято СТ-платформой
                                          if not bError then
                                            begin
                                              // Создание временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_2 (' //
                                                +'service char(32) NOT NULL default "", ' //
                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                +'call_quantity int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_sec int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_div_60 int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_each int(13) unsigned default NULL, ' //
                                                +'call_average_time float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 17

                                              if not bError then
                                                begin
                                                  // голосовые - подробно
                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_2 ' //
                                                    +'SELECT' //
                                                    +' ddi,' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' COUNT(*),' //
                                                    +' SUM(dur),' //
                                                    +' CEILING(SUM(dur)/60),' //
                                                    +' SUM(CEILING(dur/60)),' //
                                                    +' SUM(dur)/COUNT(*) ' //
                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                    +'WHERE' //
                                                    +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                    +' AND v_mreza>"" ' //
                                                    +'GROUP BY ddi ' //
                                                    +'ORDER BY ddi;'); //
                                                  StepProgressBar; // 18

                                                  if not bError then
                                                    begin
                                                      // голосовые - итог
                                                      _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                        'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_2 ' //
                                                        +'SELECT' //
                                                        +' "Итого:",' //
                                                        +' "0",' //
                                                        +' "1",' //
                                                        +' "0",' //
                                                        +' COUNT(*),' //
                                                        +' SUM(dur),' //
                                                        +' CEILING(SUM(dur)/60),' //
                                                        +' SUM(CEILING(dur/60)),' //
                                                        +' SUM(dur)/COUNT(*) ' //
                                                        +'FROM irda.tmp_09_2 ' //
                                                        +'WHERE' //
                                                        +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                        +' AND v_mreza>"" ' //
                                                        +'GROUP BY "";'); //
                                                      StepProgressBar; // 19

                                                      if not bError then
                                                        begin
                                                          // автоинформатор - подробно
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_2 ' //
                                                            +'SELECT' //
                                                            +' ddi,' //
                                                            +' "1",' //
                                                            +' "0",' //
                                                            +' "0",' //
                                                            +' COUNT(*),' //
                                                            +' SUM(dur),' //
                                                            +' CEILING(SUM(dur)/60),' //
                                                            +' SUM(CEILING(dur/60)),' //
                                                            +' SUM(dur)/COUNT(*) ' //
                                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                            +'WHERE' //
                                                            +' ddi IN("175", "188", "191", "192", "194", "195", "196", "197", "99175", "99188", "99191", "99192", "99194", "99195", "99196", "99197")' //
                                                            +' AND v_mreza>"" ' //
                                                            +'GROUP BY ddi ' //
                                                            +'ORDER BY ddi;'); //
                                                          StepProgressBar; // 20

                                                          if not bError then
                                                            begin
                                                              // автоинформатор - итог
                                                              _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_2 ' //
                                                                +'SELECT' //
                                                                +' "Итого:",' //
                                                                +' "1",' //
                                                                +' "1",' //
                                                                +' "0",' //
                                                                +' COUNT(*),' //
                                                                +' SUM(dur),' //
                                                                +' CEILING(SUM(dur)/60),' //
                                                                +' SUM(CEILING(dur/60)),' //
                                                                +' SUM(dur)/COUNT(*) ' //
                                                                +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                                +'WHERE' //
                                                                +' ddi IN("175", "188", "191", "192", "194", "195", "196", "197", "99175", "99188", "99191", "99192", "99194", "99195", "99196", "99197")' //
                                                                +' AND v_mreza>"" ' //
                                                                +'GROUP BY "";'); //
                                                              StepProgressBar; // 21

                                                              if not bError then
                                                                begin
                                                                  // общий итог
                                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_2 ' //
                                                                    +'SELECT' //
                                                                    +' "Всего:",' //
                                                                    +' "0",' //
                                                                    +' "0",' //
                                                                    +' "1",' //
                                                                    +' COUNT(*),' //
                                                                    +' SUM(dur),' //
                                                                    +' CEILING(SUM(dur)/60),' //
                                                                    +' SUM(CEILING(dur/60)),' //
                                                                    +' SUM(dur)/COUNT(*) ' //
                                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                                    +'WHERE v_mreza>"" ' //
                                                                    +'GROUP BY "";'); //
                                                                  StepProgressBar; // 22
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          // получили ответ автоинформатора
                                          if not bError then
                                            begin
                                              // Создание временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_3 (' //
                                                +'service char(32) NOT NULL default "", ' //
                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                +'call_quantity int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_sec int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_div_60 int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_each int(13) unsigned default NULL, ' //
                                                +'call_average_time float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 23

                                              if not bError then
                                                begin
                                                  // голосовые - подробно
                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_3 ' //
                                                    +'SELECT' //
                                                    +' ddi,' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' COUNT(*),' //
                                                    +' SUM(dur),' //
                                                    +' CEILING(SUM(dur)/60),' //
                                                    +' SUM(CEILING(dur/60)),' //
                                                    +' SUM(dur)/COUNT(*) ' //
                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                    +'WHERE' //
                                                    +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                    +' AND v_mreza>""' //
                                                    +' AND dur>0 ' //
                                                    +'GROUP BY ddi ' //
                                                    +'ORDER BY ddi;'); //
                                                  StepProgressBar; // 24

                                                  if not bError then
                                                    begin
                                                      // голосовые - итог
                                                      _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                        'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_3 ' //
                                                        +'SELECT' //
                                                        +' "Итого:",' //
                                                        +' "0",' //
                                                        +' "1",' //
                                                        +' "0",' //
                                                        +' COUNT(*),' //
                                                        +' SUM(dur),' //
                                                        +' CEILING(SUM(dur)/60),' //
                                                        +' SUM(CEILING(dur/60)),' //
                                                        +' SUM(dur)/COUNT(*) ' //
                                                        +'FROM irda.tmp_09_2 ' //
                                                        +'WHERE' //
                                                        +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                        +' AND v_mreza>""' //
                                                        +' AND dur>0 ' //
                                                        +'GROUP BY "";'); //
                                                      StepProgressBar; // 25

                                                      if not bError then
                                                        begin
                                                          // автоинформатор - подробно
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_3 ' //
                                                            +'SELECT' //
                                                            +' ddi,' //
                                                            +' "1",' //
                                                            +' "0",' //
                                                            +' "0",' //
                                                            +' COUNT(*),' //
                                                            +' SUM(dur),' //
                                                            +' CEILING(SUM(dur)/60),' //
                                                            +' SUM(CEILING(dur/60)),' //
                                                            +' SUM(dur)/COUNT(*) ' //
                                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                            +'WHERE' //
                                                            +' ddi IN('+'"175", "188", "191", "192", "194", "195", ' //
                                                            +'"196", "197", "99175", "99188", "99191", ' //
                                                            +'"99192", "99194", "99195", "99196", "99197"' //
                                                            +')' //
                                                            +' AND v_mreza>""' //
                                                            +' AND dur>0 ' //
                                                            +'GROUP BY ddi ' //
                                                            +'ORDER BY ddi;'); //
                                                          StepProgressBar; // 26

                                                          if not bError then
                                                            begin
                                                              // автоинформатор - итог
                                                              _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_3 ' //
                                                                +'SELECT' //
                                                                +' "Итого:",' //
                                                                +' "1",' //
                                                                +' "1",' //
                                                                +' "0",' //
                                                                +' COUNT(*),' //
                                                                +' SUM(dur),' //
                                                                +' CEILING(SUM(dur)/60),' //
                                                                +' SUM(CEILING(dur/60)),' //
                                                                +' SUM(dur)/COUNT(*) ' //
                                                                +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                                +'WHERE' //
                                                                +' ddi IN('+'"175", "188", "191", "192", "194", "195", ' //
                                                                +'"196", "197", "99175", "99188", "99191", ' //
                                                                +'"99192", "99194", "99195", "99196", "99197"' //
                                                                +')' //
                                                                +' AND v_mreza>""' //
                                                                +' AND dur>0 ' //
                                                                +'GROUP BY "";'); //
                                                              StepProgressBar; // 27

                                                              if not bError then
                                                                begin
                                                                  // общий итог
                                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_3 ' //
                                                                    +'SELECT' //
                                                                    +' "Всего:",' //
                                                                    +' "0",' //
                                                                    +' "0",' //
                                                                    +' "1",' //
                                                                    +' COUNT(*),' //
                                                                    +' SUM(dur),' //
                                                                    +' CEILING(SUM(dur)/60),' //
                                                                    +' SUM(CEILING(dur/60)),' //
                                                                    +' SUM(dur)/COUNT(*) ' //
                                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                                    +'WHERE' //
                                                                    +' v_mreza>""' //
                                                                    +' AND dur>0 ' //
                                                                    +'GROUP BY "";'); //
                                                                  StepProgressBar; // 28
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          // распределены на рабочее место
                                          if not bError then
                                            begin
                                              // Создание временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_4 (' //
                                                +'service char(32) NOT NULL default "", ' //
                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                +'call_quantity int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_sec int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_div_60 int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_each int(13) unsigned default NULL, ' //
                                                +'call_average_time float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 29

                                              if not bError then
                                                begin
                                                  // голосовые - подробно
                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_4 ' //
                                                    +'SELECT' //
                                                    +' ddi,' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' COUNT(*),' //
                                                    +' SUM(dur),' //
                                                    +' CEILING(SUM(dur)/60),' //
                                                    +' SUM(CEILING(dur/60)),' //
                                                    +' SUM(dur)/COUNT(*) ' //
                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                    +'WHERE' //
                                                    +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                    +' AND v_mreza>""' //
                                                    +' AND dur>0' //
                                                    +' AND rm>0 ' //
                                                    +'GROUP BY ddi ' //
                                                    +'ORDER BY ddi;'); //
                                                  StepProgressBar; // 30

                                                  if not bError then
                                                    begin
                                                      // голосовые - итог
                                                      _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                        'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_4 ' //
                                                        +'SELECT' //
                                                        +' "Итого:",' //
                                                        +' "0",' //
                                                        +' "1",' //
                                                        +' "0",' //
                                                        +' COUNT(*),' //
                                                        +' SUM(dur),' //
                                                        +' CEILING(SUM(dur)/60),' //
                                                        +' SUM(CEILING(dur/60)),' //
                                                        +' SUM(dur)/COUNT(*) ' //
                                                        +'FROM irda.tmp_09_2 ' //
                                                        +'WHERE' //
                                                        +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                        +' AND v_mreza>""' //
                                                        +' AND dur>0' //
                                                        +' AND rm>0 ' //
                                                        +'GROUP BY "";'); //
                                                      StepProgressBar; // 31

                                                      if not bError then
                                                        begin
                                                          // общий итог
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_4 ' //
                                                            +'SELECT' //
                                                            +' "Всего:",' //
                                                            +' "0",' //
                                                            +' "0",' //
                                                            +' "1",' //
                                                            +' COUNT(*),' //
                                                            +' SUM(dur),' //
                                                            +' CEILING(SUM(dur)/60),' //
                                                            +' SUM(CEILING(dur/60)),' //
                                                            +' SUM(dur)/COUNT(*) ' //
                                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                            +'WHERE' //
                                                            +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                            +' AND v_mreza>""' //
                                                            +' AND dur>0' //
                                                            +' AND rm>0 ' //
                                                            +'GROUP BY "";'); //
                                                          StepProgressBar; // 32
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          // получившие ответ оператора
                                          if not bError then
                                            begin
                                              // Создание временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_5 (' //
                                                +'service char(32) NOT NULL default "", ' //
                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                +'call_quantity int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_sec int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_div_60 int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_each int(13) unsigned default NULL, ' //
                                                +'call_average_time float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 33

                                              if not bError then
                                                begin
                                                  // голосовые - подробно
                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_5 ' //
                                                    +'SELECT' //
                                                    +' ddi,' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' COUNT(*),' //
                                                    +' SUM(dur),' //
                                                    +' CEILING(SUM(dur)/60),' //
                                                    +' SUM(CEILING(dur/60)),' //
                                                    +' SUM(dur)/COUNT(*) ' //
                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                    +'WHERE' //
                                                    +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                    +' AND v_mreza>""' //
                                                    +' AND dur>0' //
                                                    +' AND rm>0' //
                                                    +' AND v_oper>"" ' //
                                                    +'GROUP BY ddi ' //
                                                    +'ORDER BY ddi;'); //
                                                  StepProgressBar; // 34

                                                  if not bError then
                                                    begin
                                                      // голосовые - итог
                                                      _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                        'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_5 ' //
                                                        +'SELECT' //
                                                        +' "Итого:",' //
                                                        +' "0",' //
                                                        +' "1",' //
                                                        +' "0",' //
                                                        +' COUNT(*),' //
                                                        +' SUM(dur),' //
                                                        +' CEILING(SUM(dur)/60),' //
                                                        +' SUM(CEILING(dur/60)),' //
                                                        +' SUM(dur)/COUNT(*) ' //
                                                        +'FROM irda.tmp_09_2 ' //
                                                        +'WHERE' //
                                                        +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                        +' AND v_mreza>""' //
                                                        +' AND dur>0' //
                                                        +' AND rm>0' //
                                                        +' AND v_oper>"" ' //
                                                        +'GROUP BY "";'); //
                                                      StepProgressBar; // 35

                                                      if not bError then
                                                        begin
                                                          // общий итог
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_5 ' //
                                                            +'SELECT' //
                                                            +' "Всего:",' //
                                                            +' "0",' //
                                                            +' "0",' //
                                                            +' "1",' //
                                                            +' COUNT(*),' //
                                                            +' SUM(dur),' //
                                                            +' CEILING(SUM(dur)/60),' //
                                                            +' SUM(CEILING(dur/60)),' //
                                                            +' SUM(dur)/COUNT(*) ' //
                                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                            +'WHERE' //
                                                            +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                            +' AND v_mreza>""' //
                                                            +' AND dur>0' //
                                                            +' AND rm>0' //
                                                            +' AND v_oper>"" ' //
                                                            +'GROUP BY "";'); //
                                                          StepProgressBar; // 36
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          // с длительностью от 3 секунд или был выдан номер телефона
                                          if not bError then
                                            begin
                                              // Создание временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_6 (' //
                                                +'service char(32) NOT NULL default "", ' //
                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                +'call_quantity int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_sec int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_div_60 int(13) unsigned default NULL, ' //
                                                +'call_sumtime_in_min_each int(13) unsigned default NULL, ' //
                                                +'call_average_time float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 37

                                              if not bError then
                                                begin
                                                  // голосовые - подробно
                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_6 ' //
                                                    +'SELECT' //
                                                    +' ddi,' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' "0",' //
                                                    +' COUNT(*),' //
                                                    +' SUM(dur),' //
                                                    +' CEILING(SUM(dur)/60),' //
                                                    +' SUM(CEILING(dur/60)),' //
                                                    +' SUM(dur)/COUNT(*) ' //
                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                    +'WHERE' //
                                                    +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                    +' AND v_mreza>""' //
                                                    +' AND (dur>2 OR izgnum>"")' //
                                                    +' AND rm>0' //
                                                    +' AND v_oper>"" ' //
                                                    +'GROUP BY ddi ' //
                                                    +'ORDER BY ddi;'); //
                                                  StepProgressBar; // 38

                                                  if not bError then
                                                    begin
                                                      // голосовые - итог
                                                      _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                        'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_6 ' //
                                                        +'SELECT' //
                                                        +' "Итого:",' //
                                                        +' "0",' //
                                                        +' "1",' //
                                                        +' "0",' //
                                                        +' COUNT(*),' //
                                                        +' SUM(dur),' //
                                                        +' CEILING(SUM(dur)/60),' //
                                                        +' SUM(CEILING(dur/60)),' //
                                                        +' SUM(dur)/COUNT(*) ' //
                                                        +'FROM irda.tmp_09_2 ' //
                                                        +'WHERE' //
                                                        +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                        +' AND v_mreza>""' //
                                                        +' AND (dur>2 OR izgnum>"")' //
                                                        +' AND rm>0' //
                                                        +' AND v_oper>"" ' //
                                                        +'GROUP BY "";'); //
                                                      StepProgressBar; // 39

                                                      if not bError then
                                                        begin
                                                          // общий итог
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_6 ' //
                                                            +'SELECT' //
                                                            +' "Всего:",' //
                                                            +' "0",' //
                                                            +' "0",' //
                                                            +' "1",' //
                                                            +' COUNT(*),' //
                                                            +' SUM(dur),' //
                                                            +' CEILING(SUM(dur)/60),' //
                                                            +' SUM(CEILING(dur/60)),' //
                                                            +' SUM(dur)/COUNT(*) ' //
                                                            +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_2 ' //
                                                            +'WHERE' //
                                                            +' ddi IN("109", "130", "190", "193", "199", "2003498", "9910911", "99190", "99193", "9919911")' //
                                                            +' AND v_mreza>""' //
                                                            +' AND (dur>2 OR izgnum>"")' //
                                                            +' AND rm>0' //
                                                            +' AND v_oper>"" ' //
                                                            +'GROUP BY "";'); //
                                                          StepProgressBar; // 40
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          if not bError then
                                            begin
                                              // Создание сводной временной таблицы
                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 (' //
                                                +'service char(32) NOT NULL default "",' //
                                                +'is_autoservice enum("0","1") default NULL,' //
                                                +'is_summaryrow enum("0","1") default NULL,' //
                                                +'is_globalsummaryrow enum("0","1") default NULL,' //

                                                +'call_quantity_part1 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_sec_part1 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_div_60_part1 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_each_part1 int(13) unsigned default NULL,' //
                                                +'call_average_time_part1 float(13,2) unsigned default NULL,' //

                                                +'call_quantity_part2 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_sec_part2 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_div_60_part2 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_each_part2 int(13) unsigned default NULL,' //
                                                +'call_average_time_part2 float(13,2) unsigned default NULL,' //

                                                +'call_quantity_part3 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_sec_part3 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_div_60_part3 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_each_part3 int(13) unsigned default NULL,' //
                                                +'call_average_time_part3 float(13,2) unsigned default NULL,' //

                                                +'call_quantity_part4 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_sec_part4 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_div_60_part4 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_each_part4 int(13) unsigned default NULL,' //
                                                +'call_average_time_part4 float(13,2) unsigned default NULL,' //

                                                +'call_quantity_part5 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_sec_part5 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_div_60_part5 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_each_part5 int(13) unsigned default NULL,' //
                                                +'call_average_time_part5 float(13,2) unsigned default NULL,' //

                                                +'call_quantity_part6 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_sec_part6 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_div_60_part6 int(13) unsigned default NULL,' //
                                                +'call_sumtime_in_min_each_part6 int(13) unsigned default NULL,' //
                                                +'call_average_time_part6 float(13,2) unsigned default NULL' //
                                                +') TYPE=MyISAM;'); //
                                              StepProgressBar; // 41

                                              if not bError then
                                                begin
                                                  // перебираем все выделенные услуги, выбираем данные по очередной услуге из таблиц и сносим их в всводную таблицу
                                                  for iRoutineCounter:=0 to SelectedServicesList.Count-1 do
                                                    if bError then
                                                      Break
                                                    else
                                                      begin
                                                        is_autoservice:='';
                                                        for i:=0 to aServices_Count-1 do
                                                          if aServices[i].sNumber=SelectedServicesList[iRoutineCounter] then
                                                            begin
                                                              is_autoservice:=Routines_GetConditionalMessage(aServices[i].bAutoService, '1', '0');
                                                              Break;
                                                            end;
                                                        if is_autoservice='' then
                                                          Routines_GenerateError('Не удалось идентифицировать тип услуги!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            // вставляем в сводную таблицу строку с номером услуги
                                                            _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                              'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4' //
                                                              +' (service, is_autoservice, is_summaryrow, is_globalsummaryrow) ' //
                                                              +'VALUES ("'+SelectedServicesList[iRoutineCounter]+'", "'+is_autoservice+'", "0", "0");'); //

                                                            if not bError then
                                                              begin
                                                                for iSubtablesCounter:=1 to 6 do
                                                                  if bError then
                                                                    Break
                                                                  else
                                                                    begin
                                                                      // получение данных для вставки в сводную таблицу
                                                                      LogThis('>> Выполняется операция получения данных о звонках...', lmtDebug);
                                                                      with Configuration, Configuration.StatServer do
                                                                        begin
                                                                          if not bConnected then
                                                                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              if mysql_ping(hConnection)<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                q:='SELECT' //
                                                                                +' call_quantity,' //
                                                                                +' call_sumtime_in_sec,' //
                                                                                +' call_sumtime_in_min_div_60,' //
                                                                                +' call_sumtime_in_min_each,' //
                                                                                +' call_average_time ' //
                                                                                +'FROM ' //
                                                                                +sMySQLDatabase_IRDA_Location+'.tmp_09_3_'+IntToStr(iSubtablesCounter)+' ' //
                                                                                +'WHERE service="'+SelectedServicesList[iRoutineCounter]+'";'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
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
                                                                                case iRowQuantity of
                                                                                0:
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому (0).', lmtDebug);
                                                                                call_quantity:='0';
                                                                                call_sumtime_in_sec:='0';
                                                                                call_sumtime_in_min_div_60:='0';
                                                                                call_sumtime_in_min_each:='0';
                                                                                call_average_time:='0';
                                                                                end;
                                                                                1:
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому (1).', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                call_quantity:=string(ResultRow[0]);
                                                                                call_sumtime_in_sec:=string(ResultRow[1]);
                                                                                call_sumtime_in_min_div_60:=string(ResultRow[2]);
                                                                                call_sumtime_in_min_each:=string(ResultRow[3]);
                                                                                call_average_time:=string(ResultRow[4]);
                                                                                LogThis('Получение данных выполнено успешно.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                                else
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (0, 1)!', sErrorMessage, bError)
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                      LogThis('<< Выполнение операции получения данных о звонках завершено.', lmtDebug);

                                                                      if not bError then
                                                                        begin
                                                                          // фикс данных полей в таблице
                                                                          _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                            'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                                                            +'SET' //
                                                                            +' call_quantity_part'+IntToStr(iSubtablesCounter)+'="'+call_quantity+'",' //
                                                                            +' call_sumtime_in_sec_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_sec+'",' //
                                                                            +' call_sumtime_in_min_div_60_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_min_div_60+'",' //
                                                                            +' call_sumtime_in_min_each_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_min_each+'",' //
                                                                            +' call_average_time_part'+IntToStr(iSubtablesCounter)+'="'+call_average_time+'" ' //
                                                                            +'WHERE' //
                                                                            +' service="'+SelectedServicesList[iRoutineCounter]+'";'); //
                                                                        end;
                                                                    end;
                                                              end;
                                                          end;
                                                      end;
                                                  StepProgressBar; // 42

                                                  if not bError then
                                                    begin
                                                      // вставка строк с итоговыми результатами по группе услуг
                                                      for i:=0 to 1 do
                                                        if bError then
                                                          Break
                                                        else
                                                          begin
                                                            _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                              'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4' //
                                                              +' (service, is_autoservice, is_summaryrow, is_globalsummaryrow) ' //
                                                              +'VALUES ("Итого:", "'+IntToStr(i)+'", "1", "0");'); //
                                                            StepProgressBar; // 43 56

                                                            if not bError then
                                                              begin
                                                                for iSubtablesCounter:=1 to 6 do
                                                                  if bError then
                                                                    Break
                                                                  else
                                                                    begin
                                                                      // получение данных для вставки в сводную таблицу
                                                                      LogThis('>> Выполняется операция получения данных о звонках...', lmtDebug);
                                                                      if not Configuration.StatServer.bConnected then
                                                                        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                                                            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              q:='SELECT' //
                                                                                +' call_quantity,' //
                                                                                +' call_sumtime_in_sec,' //
                                                                                +' call_sumtime_in_min_div_60,' //
                                                                                +' call_sumtime_in_min_each,' //
                                                                                +' call_average_time ' //
                                                                                +'FROM ' //
                                                                                +Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_3_'+IntToStr(iSubtablesCounter)+' ' //
                                                                                +'WHERE is_summaryrow="1" AND is_autoservice="'+IntToStr(i)+'";'; //
                                                                              LogThis(q, lmtSQL);
                                                                              if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
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
                                                                                case iRowQuantity of
                                                                                0:
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому (0).', lmtDebug);
                                                                                call_quantity:='0';
                                                                                call_sumtime_in_sec:='0';
                                                                                call_sumtime_in_min_div_60:='0';
                                                                                call_sumtime_in_min_each:='0';
                                                                                call_average_time:='0';
                                                                                end;
                                                                                1:
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому (1).', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                call_quantity:=string(ResultRow[0]);
                                                                                call_sumtime_in_sec:=string(ResultRow[1]);
                                                                                call_sumtime_in_min_div_60:=string(ResultRow[2]);
                                                                                call_sumtime_in_min_each:=string(ResultRow[3]);
                                                                                call_average_time:=string(ResultRow[4]);
                                                                                LogThis('Получение данных выполнено успешно.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                                else
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (0, 1)!', sErrorMessage, bError)
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                      LogThis('<< Выполнение операции получения данных о звонках завершено.', lmtDebug);
                                                                      StepProgressBar; // 44 46 48 50 52 54 57 59 61 63 65 67

                                                                      if not bError then
                                                                        begin
                                                                          // фикс данных полей в таблице
                                                                          _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                            'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                                                            +'SET' //
                                                                            +' call_quantity_part'+IntToStr(iSubtablesCounter)+'="'+call_quantity+'",' //
                                                                            +' call_sumtime_in_sec_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_sec+'",' //
                                                                            +' call_sumtime_in_min_div_60_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_min_div_60+'",' //
                                                                            +' call_sumtime_in_min_each_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_min_each+'",' //
                                                                            +' call_average_time_part'+IntToStr(iSubtablesCounter)+'="'+call_average_time+'" ' //
                                                                            +'WHERE is_summaryrow="1" AND is_autoservice="'+IntToStr(i)+'";'); //
                                                                          StepProgressBar; // 45 47 49 51 53 55 58 60 62 64 66 68
                                                                        end;
                                                                    end;
                                                              end;
                                                          end;

                                                      if not bError then
                                                        begin
                                                          // вставка итоговых данных
                                                          _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                            'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4' //
                                                            +' (service, is_autoservice, is_summaryrow, is_globalsummaryrow) ' //
                                                            +'VALUES ("Всего:", "0", "0", "1");'); //
                                                          StepProgressBar; // 69

                                                          if not bError then
                                                            begin
                                                              for iSubtablesCounter:=1 to 6 do
                                                                if bError then
                                                                  Break
                                                                else
                                                                  begin
                                                                    // получение данных для вставки в сводную таблицу
                                                                    LogThis('>> Выполняется операция получения данных о звонках...', lmtDebug);
                                                                    with Configuration, Configuration.StatServer do
                                                                      begin
                                                                        if not bConnected then
                                                                          Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                        else
                                                                          begin
                                                                            if mysql_ping(hConnection)<>0 then
                                                                              Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                q:='SELECT' //
                                                                                +' call_quantity,' //
                                                                                +' call_sumtime_in_sec,' //
                                                                                +' call_sumtime_in_min_div_60,' //
                                                                                +' call_sumtime_in_min_each,' //
                                                                                +' call_average_time ' //
                                                                                +'FROM ' //
                                                                                +sMySQLDatabase_IRDA_Location+'.tmp_09_3_'+IntToStr(iSubtablesCounter)+' ' //
                                                                                +'WHERE is_globalsummaryrow="1";'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
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
                                                                                case iRowQuantity of
                                                                                0:
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому (0).', lmtDebug);
                                                                                call_quantity:='0';
                                                                                call_sumtime_in_sec:='0';
                                                                                call_sumtime_in_min_div_60:='0';
                                                                                call_sumtime_in_min_each:='0';
                                                                                call_average_time:='0';
                                                                                end;
                                                                                1:
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому (1).', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                call_quantity:=string(ResultRow[0]);
                                                                                call_sumtime_in_sec:=string(ResultRow[1]);
                                                                                call_sumtime_in_min_div_60:=string(ResultRow[2]);
                                                                                call_sumtime_in_min_each:=string(ResultRow[3]);
                                                                                call_average_time:=string(ResultRow[4]);
                                                                                LogThis('Получение данных выполнено успешно.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                                else
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (0, 1)!', sErrorMessage, bError)
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                              end;
                                                                          end;
                                                                      end;
                                                                    LogThis('<< Выполнение операции получения данных о звонках завершено.', lmtDebug);
                                                                    StepProgressBar; // 70 72 74 76 78 80

                                                                    if not bError then
                                                                      begin
                                                                        // фикс данных полей в таблице
                                                                        _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                          'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                                                          +'SET' //
                                                                          +' call_quantity_part'+IntToStr(iSubtablesCounter)+'="'+call_quantity+'",' //
                                                                          +' call_sumtime_in_sec_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_sec+'",' //
                                                                          +' call_sumtime_in_min_div_60_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_min_div_60+'",' //
                                                                          +' call_sumtime_in_min_each_part'+IntToStr(iSubtablesCounter)+'="'+call_sumtime_in_min_each+'",' //
                                                                          +' call_average_time_part'+IntToStr(iSubtablesCounter)+'="'+call_average_time+'" ' //
                                                                          +'WHERE is_globalsummaryrow="1";'); //
                                                                        StepProgressBar; // 71 73 75 77 79 81
                                                                      end;
                                                                  end;
                                                            end;

                                                          if not bError then
                                                            begin
                                                              // Создание временной таблицы по отказам
                                                              _MySQL_CreateTable(Configuration.StatServer, bError, sErrorMessage, //
                                                                'CREATE TEMPORARY TABLE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 (' //
                                                                +'service char(32) NOT NULL default "", ' //
                                                                +'is_autoservice enum("0","1") default NULL, ' //
                                                                +'is_summaryrow enum("0","1") default NULL, ' //
                                                                +'is_globalsummaryrow enum("0","1") default NULL, ' //
                                                                +'call_quantity_part1 int(13) unsigned default NULL, ' //
                                                                +'call_percent_part1 float(13,2) unsigned default NULL, ' //
                                                                +'call_quantity_part2 int(13) unsigned default NULL, ' //
                                                                +'call_percent_part2 float(13,2) unsigned default NULL, ' //
                                                                +'call_quantity_part3 int(13) unsigned default NULL, ' //
                                                                +'call_percent_part3 float(13,2) unsigned default NULL, ' //
                                                                +'call_quantity_part4 int(13) unsigned default NULL, ' //
                                                                +'call_percent_part4 float(13,2) unsigned default NULL, ' //
                                                                +'call_quantity_part5 int(13) unsigned default NULL, ' //
                                                                +'call_percent_part5 float(13,2) unsigned default NULL' //
                                                                +') TYPE=MyISAM;'); //
                                                              StepProgressBar; // 82

                                                              if not bError then
                                                                begin
                                                                  // вставка данных по отказам
                                                                  _MySQL_InsertRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                    'INSERT INTO '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                                                    +'SELECT' //
                                                                    +' service AS "Номер услуги",' //
                                                                    +' is_autoservice,' //
                                                                    +' is_summaryrow,' //
                                                                    +' is_globalsummaryrow,' //
                                                                    // Количество отказов на этапе получения ответа СТ-платформы
                                                                    +' call_quantity_part1-call_quantity_part2 AS "Количество отказов на этапе получения ответа СТ-платформы",' //
                                                                    // Процент отказов на этапе получения ответа СТ-платформы
                                                                    +' IF(call_quantity_part1>0, (100*(1-(call_quantity_part2/call_quantity_part1))), "0.00") AS "Процент отказов на этапе получения ответа СТ-платформы",' //
                                                                    // Количество отказов на этапе запуска автоинформатора
                                                                    +' call_quantity_part2-call_quantity_part3 AS "Количество отказов на этапе запуска автоинформатора",' //
                                                                    // Процент отказов на этапе запуска автоинформатора
                                                                    +' IF(call_quantity_part1>0, (100*(1-(call_quantity_part3/call_quantity_part1)))-(100*(1-(call_quantity_part2/call_quantity_part1))), "0.00") AS "Процент отказов на этапе запуска автоинформатора",'
                                                                    //
                                                                    // Количество отказов на этапе распределения на рабочее место
                                                                    +' IF(is_autoservice="0", IF(is_globalsummaryrow="1", "+", call_quantity_part3-call_quantity_part4), "-") AS "Количество отказов на этапе распределения на рабочее место",' //
                                                                    // Процент отказов на этапе распределения на рабочее место
                                                                    +' IF(is_globalsummaryrow="1", "+", IF(is_autoservice="0", IF(call_quantity_part1>0, ((100*(1-(call_quantity_part4/call_quantity_part1))))-((100*(1-(call_quantity_part3/call_quantity_part1)))-'
                                                                    //
                                                                    +'(100*(1-(call_quantity_part2/call_quantity_part1))))-((100*(1-(call_quantity_part2/call_quantity_part1)))), "-"), "0.00")) AS "Процент отказов на этапе распределения на рабочее место",'
                                                                    //
                                                                    // Количество отказов на этапе подтверждения соединения
                                                                    +' IF(is_autoservice="0", IF(is_globalsummaryrow="1", "+", call_quantity_part4-call_quantity_part5), "-") AS "Количество отказов на этапе подтверждения соединения",' //
                                                                    // Процент отказов на этапе подтверждения соединения
                                                                    +' IF(is_globalsummaryrow="1", "+", IF(is_autoservice="0", IF(call_quantity_part1>0, ((100*(1-(call_quantity_part5/call_quantity_part1))))-' //
                                                                    +'(((100*(1-(call_quantity_part4/call_quantity_part1))))-((100*(1-(call_quantity_part3/call_quantity_part1)))-(100*(1-(call_quantity_part2/call_quantity_part1))))-' //
                                                                    +'((100*(1-(call_quantity_part2/call_quantity_part1)))))-((100*(1-(call_quantity_part3/call_quantity_part1)))-' //
                                                                    +'(100*(1-(call_quantity_part2/call_quantity_part1))))-((100*(1-(call_quantity_part2/call_quantity_part1)))), "0.00"), "-")) AS "Процент отказов на этапе подтверждения соединения",'
                                                                    //
                                                                    // Итоговое количество отказов
                                                                    +' IF(is_globalsummaryrow="1", "+", IF(is_autoservice="0", call_quantity_part1-call_quantity_part5, call_quantity_part1-call_quantity_part3)) AS "Итоговое количество отказов",' //
                                                                    // Итоговый процент отказов
                                                                    +' IF(is_globalsummaryrow="1", "+", IF(call_quantity_part1>0, IF(is_autoservice="0",' //
                                                                    // голосовые
                                                                    +' (100*(1-(call_quantity_part5/call_quantity_part1))),' //
                                                                    // автоинформаторы
                                                                    +' (100*(1-(call_quantity_part3/call_quantity_part1)))), "0.00")) AS "Итоговый процент отказов" ' //
                                                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                                                    +'ORDER BY' //
                                                                    +' is_globalsummaryrow,' //
                                                                    +' is_autoservice,' //
                                                                    +' is_summaryrow,' //
                                                                    +' service;'); //
                                                                  StepProgressBar; // 83

                                                                  if not bError then
                                                                    begin
                                                                      // получение данных и заполнение списка
                                                                      LogThis('>> Выполняется операция получения данных для итоговой строки отказов...', lmtDebug);
                                                                      with Configuration, Configuration.StatServer do
                                                                        begin
                                                                          if not bConnected then
                                                                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              if mysql_ping(hConnection)<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                q:='SELECT' //
                                                                                +' call_quantity_part3,' //
                                                                                +' call_percent_part3,' //
                                                                                +' call_quantity_part4,' //
                                                                                +' call_percent_part4 ' //
                                                                                +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                                                                +'WHERE is_summaryrow="1" AND is_autoservice="0" AND is_globalsummaryrow="0";'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
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
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                                call_quantity_part3:=string(ResultRow[0]);
                                                                                call_percent_part3:=string(ResultRow[1]);
                                                                                call_quantity_part4:=string(ResultRow[2]);
                                                                                call_percent_part4:=string(ResultRow[3]);
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
                                                                      LogThis('<< Выполнение операции получения данных для итоговой строки отказов завершено.', lmtDebug);
                                                                      StepProgressBar; // 84

                                                                      if not bError then
                                                                        begin
                                                                          // получение данных и заполнение списка
                                                                          LogThis('>> Выполняется операция получения данных для итоговой строки отказов...', lmtDebug);
                                                                          with Configuration, Configuration.StatServer do
                                                                            begin
                                                                              if not bConnected then
                                                                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                if mysql_ping(hConnection)<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                q:='SELECT' //
                                                                                +' SUM(call_quantity_part5) ' //
                                                                                +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                                                                +'WHERE is_summaryrow="1" AND is_globalsummaryrow="0";'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
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
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                                call_quantity_part5:=string(ResultRow[0]);
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
                                                                          LogThis('<< Выполнение операции получения данных для итоговой строки отказов завершено.', lmtDebug);
                                                                          StepProgressBar; // 85

                                                                          if not bError then
                                                                            begin
                                                                              // фикс данных полей в таблице
                                                                              _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                                'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                                                                +'SET' //
                                                                                +' call_quantity_part3="'+call_quantity_part3+'",' //
                                                                                +' call_percent_part3="'+call_percent_part3+'",' //
                                                                                +' call_quantity_part4="'+call_quantity_part4+'",' //
                                                                                +' call_percent_part4="'+call_percent_part4+'",' //
                                                                                +' call_quantity_part5="'+call_quantity_part5+'" ' //
                                                                                +'WHERE' //
                                                                                +' is_summaryrow="0" AND' //
                                                                                +' is_autoservice="0" AND' //
                                                                                +' is_globalsummaryrow="1";'); //
                                                                              StepProgressBar; // 86

                                                                              if not bError then
                                                                                begin
                                                                                // получение данных и заполнение списка
                                                                                LogThis('>> Выполняется операция получения данных для итоговой строки отказов...', lmtDebug);
                                                                                with Configuration, Configuration.StatServer do
                                                                                begin
                                                                                if not bConnected then
                                                                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                if mysql_ping(hConnection)<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                q:='SELECT' //
                                                                                +' IF(a.call_quantity_part1>0, (100*(b.call_quantity_part5/a.call_quantity_part1)), "0.00") ' //
                                                                                +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 a ' //
                                                                                +'LEFT JOIN irda.tmp_09_5 b' //
                                                                                +' ON b.service=a.service AND b.is_summaryrow=a.is_summaryrow AND b.is_autoservice=a.is_autoservice AND b.is_globalsummaryrow=a.is_globalsummaryrow ' //
                                                                                +'WHERE a.is_globalsummaryrow="1";'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Запрос выполнен успешно.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
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
                                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                                call_percent_part5:=string(ResultRow[0]);
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
                                                                                LogThis('<< Выполнение операции получения данных для итоговой строки отказов завершено.', lmtDebug);
                                                                                StepProgressBar; // 87

                                                                                if not bError then
                                                                                begin
                                                                                // фикс данных полей в таблице
                                                                                _MySQL_UpdateRecords(Configuration.StatServer, bError, sErrorMessage, //
                                                                                'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                                                                +'SET' //
                                                                                +' call_percent_part5="'+call_percent_part5+'" ' //
                                                                                +'WHERE' //
                                                                                +' is_summaryrow="0" AND' //
                                                                                +' is_autoservice="0" AND' //
                                                                                +' is_globalsummaryrow="1";' //
                                                                                ); //
                                                                                StepProgressBar; // 88
                                                                                end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

          // начало формирования текста HTML-файла
          if not bError then
            begin
              bVoiceBlockExists:=False;
              bAutoBlockExists:=False;

              sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
              sHTML:=sHTML+'<HTML>'+#13#10;
              sHTML:=sHTML+'  <HEAD>'+#13#10;
              sHTML:=sHTML+'    <TITLE>Статистика звонков'+StringReplace(StringReplace(StringReplace(aNets[NetIndex].sHTMLAbonentsName, '&laquo;', '', [rfReplaceAll]), '&raquo;', '', [rfReplaceAll]), '&nbsp;', ' ', [rfReplaceAll])+
                ' на услуги СИЦ за '+sReportPeriod+' [форма № '+sReportCode+']</TITLE>'+#13#10;
              sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="pragma">'+#13#10;
              sHTML:=sHTML+'    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">'+#13#10;
              sHTML:=sHTML+'    <META CONTENT="Dynamic" NAME="Document-state">'+#13#10;
              sHTML:=sHTML+'    <META content="text/html; charset=Windows-1251" http-equiv="Content-Type">'+#13#10;
              sHTML:=sHTML+'    <STYLE MEDIA="screen, print" TYPE="text/css">'+#13#10;
              sHTML:=sHTML+'      * {'+#13#10;
              sHTML:=sHTML+'        font-family: Verdana, Arial, Helvetica, sans-serif;'+#13#10;
              sHTML:=sHTML+'        font-size: 7pt;'+#13#10;
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

              if OldReport then
                begin // начало формирования упрощённого отчёта
                  sHTML:=sHTML+'    <CENTER>'+#13#10;

                  sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                  // border-spacing: 0px;
                  sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="52px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="171px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="171px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="111px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="111px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="111px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="111px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="111px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="51px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;

                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+
                    '          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                    +sReportCode+'</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">' //
                    +'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD COLSPAN="9" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 10pt; font-weight: bold; padding: 20px 0px 3px 0px;">' //
                    +'Статистика&nbsp;звонков'+aNets[NetIndex].sHTMLAbonentsName+'&nbsp;на&nbsp;услуги&nbsp;СИЦ<BR>за&nbsp;'+sReportPeriod+'</TD>'+#13#10; //
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD ROWSPAN="3" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Пришло на СТ-платформу</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Принято СТ-платформой</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Обслужено*</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD ROWSPAN="3" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент отказов, %</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD COLSPAN="3" ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут***</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;

                  // блок голосовых услуг
                  if not bError then
                    begin
                      bBlockDataExists:=False;
                      with Configuration, Configuration.StatServer do
                        begin
                          LogThis('>> Выполняется операция получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                          if not bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' a.service,' //
                                    +' a.call_quantity_part1,' //
                                    +' a.call_quantity_part2,' //
                                    +' a.call_quantity_part5,' //
                                    +' a.call_sumtime_in_sec_part5,' //
                                    +' a.call_sumtime_in_min_div_60_part5,' //
                                    +' a.call_sumtime_in_min_each_part5,' //
                                    +' a.call_average_time_part5,' //
                                    +' b.call_percent_part5 ' //
                                    +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 a ' //
                                    +'LEFT JOIN '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 b ON' //
                                    +' b.service=a.service AND' //
                                    +' b.is_summaryrow=a.is_summaryrow AND' //
                                    +' b.is_autoservice=a.is_autoservice AND' //
                                    +' b.is_globalsummaryrow=a.is_globalsummaryrow ' //
                                    +'WHERE' //
                                    +' a.is_summaryrow="0" AND' //
                                    +' a.is_autoservice="0" AND' //
                                    +' a.is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' a.service;'; //
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
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bVoiceBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="9" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые телефонистами</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                        end;
                      StepProgressBar; // 89

                      if not bError then
                        if bBlockDataExists then // проверка наличия шапки блока
                          begin
                            with Configuration, Configuration.StatServer do
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                                if not bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' a.call_quantity_part1,' //
                                          +' a.call_quantity_part2,' //
                                          +' a.call_quantity_part5,' //
                                          +' a.call_sumtime_in_sec_part5,' //
                                          +' a.call_sumtime_in_min_div_60_part5,' //
                                          +' a.call_sumtime_in_min_each_part5,' //
                                          +' a.call_average_time_part5,' //
                                          +' b.call_percent_part5 ' //
                                          +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 a ' //
                                          +'LEFT JOIN '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 b ON' //
                                          +' b.service=a.service AND' //
                                          +' b.is_summaryrow=a.is_summaryrow AND' //
                                          +' b.is_autoservice=a.is_autoservice AND' //
                                          +' b.is_globalsummaryrow=a.is_globalsummaryrow ' //
                                          +'WHERE' //
                                          +' a.is_summaryrow="1" AND' //
                                          +' a.is_autoservice="0" AND' //
                                          +' a.is_globalsummaryrow="0";'; //
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
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);

                                                                ibVoiceBlockSummary_call_quantity:=StrToIntDef(string(ResultRow[2]), -1);
                                                                ibVoiceBlockSummary_call_sumtime_in_sec:=StrToIntDef(string(ResultRow[3]), -1);
                                                                ibVoiceBlockSummary_call_sumtime_in_min_div_60:=StrToIntDef(string(ResultRow[4]), -1);
                                                                ibVoiceBlockSummary_call_sumtime_in_min_each:=StrToIntDef(string(ResultRow[5]), -1);

                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                              end;
                            StepProgressBar; // 90
                          end
                        else
                          StepProgressBar; // 90
                    end; // конец блока голосовых услуг

                  // блок автоинформаторов
                  if not bError then
                    begin
                      bBlockDataExists:=False;
                      with Configuration, Configuration.StatServer do
                        begin
                          LogThis('>> Выполняется операция получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                          if not bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' a.service,' //
                                    +' a.call_quantity_part1,' //
                                    +' a.call_quantity_part2,' //
                                    +' a.call_quantity_part3,' //
                                    +' a.call_sumtime_in_sec_part3,' //
                                    +' a.call_sumtime_in_min_div_60_part3,' //
                                    +' a.call_sumtime_in_min_each_part3,' //
                                    +' a.call_average_time_part3,' //
                                    +' b.call_percent_part5 ' //
                                    +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 a ' //
                                    +'LEFT JOIN '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 b ON' //
                                    +' b.service=a.service AND' //
                                    +' b.is_summaryrow=a.is_summaryrow AND' //
                                    +' b.is_autoservice=a.is_autoservice AND' //
                                    +' b.is_globalsummaryrow=a.is_globalsummaryrow ' //
                                    +'WHERE' //
                                    +' a.is_summaryrow="0" AND' //
                                    +' a.is_autoservice="1" AND' //
                                    +' a.is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' a.service;'; //
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
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bAutoBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="9" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые автоинформатором</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                        end;
                      StepProgressBar; // 91

                      if not bError then
                        if bBlockDataExists then // проверка наличия шапки блока
                          begin
                            with Configuration, Configuration.StatServer do
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                                if not bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' a.call_quantity_part1,' //
                                          +' a.call_quantity_part2,' //
                                          +' a.call_quantity_part3,' //
                                          +' a.call_sumtime_in_sec_part3,' //
                                          +' a.call_sumtime_in_min_div_60_part3,' //
                                          +' a.call_sumtime_in_min_each_part3,' //
                                          +' a.call_average_time_part3,' //
                                          +' b.call_percent_part5 ' //
                                          +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 a ' //
                                          +'LEFT JOIN '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 b ON' //
                                          +' b.service=a.service AND' //
                                          +' b.is_summaryrow=a.is_summaryrow AND' //
                                          +' b.is_autoservice=a.is_autoservice AND' //
                                          +' b.is_globalsummaryrow=a.is_globalsummaryrow ' //
                                          +'WHERE' //
                                          +' a.is_summaryrow="1" AND' //
                                          +' a.is_autoservice="1" AND' //
                                          +' a.is_globalsummaryrow="0";'; //
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
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);

                                                                iAutoBlockSummary_call_quantity:=StrToIntDef(string(ResultRow[2]), -1);
                                                                iAutoBlockSummary_call_sumtime_in_sec:=StrToIntDef(string(ResultRow[3]), -1);
                                                                iAutoBlockSummary_call_sumtime_in_min_div_60:=StrToIntDef(string(ResultRow[4]), -1);
                                                                iAutoBlockSummary_call_sumtime_in_min_each:=StrToIntDef(string(ResultRow[5]), -1);

                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                              end;
                            StepProgressBar; // 92
                          end
                        else
                          StepProgressBar; // 92
                    end; // конец блока автоинформаторов

                  // итоговая строка для обоих типов услуг
                  if not bError then
                    if bVoiceBlockExists and bAutoBlockExists then
                      begin
                        with Configuration, Configuration.StatServer do
                          begin
                            LogThis('>> Выполняется операция получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                            if not bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                else
                                  begin
                                    q:='SELECT' //
                                      +' a.call_quantity_part1,' //
                                      +' a.call_quantity_part2,' //
                                    // +' a.call_quantity_part3,' //
                                    // +' a.call_sumtime_in_sec_part3,' //
                                    // +' a.call_sumtime_in_min_div_60_part3,' //
                                    // +' a.call_sumtime_in_min_each_part3,' //
                                    // +' a.call_average_time_part3,' //
                                      +' b.call_percent_part5 ' //
                                      +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 a ' //
                                      +'LEFT JOIN '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 b ON' //
                                      +' b.service=a.service AND' //
                                      +' b.is_summaryrow=a.is_summaryrow AND' //
                                      +' b.is_autoservice=a.is_autoservice AND' //
                                      +' b.is_globalsummaryrow=a.is_globalsummaryrow ' //
                                      +'WHERE' //
                                      +' a.is_globalsummaryrow="1";'; //
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
                                                    if iRowQuantity>1 then
                                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Всего:</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;

                                                            sHTML:=sHTML+'          <TD STYLE="text-align: '+Routines_GetConditionalMessage((ibVoiceBlockSummary_call_quantity<>-1)and(iAutoBlockSummary_call_quantity<>-1), 'right', 'center')+
                                                              '; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                              Routines_GetConditionalMessage((ibVoiceBlockSummary_call_quantity<>-1)and(iAutoBlockSummary_call_quantity<>-1), IntToStr(ibVoiceBlockSummary_call_quantity+iAutoBlockSummary_call_quantity),
                                                              '-')+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: '+Routines_GetConditionalMessage((ibVoiceBlockSummary_call_sumtime_in_sec<>-1)and(iAutoBlockSummary_call_sumtime_in_sec<>-1), 'right',
                                                              'center')+'; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                              Routines_GetConditionalMessage((ibVoiceBlockSummary_call_sumtime_in_sec<>-1)and(iAutoBlockSummary_call_sumtime_in_sec<>-1),
                                                              IntToStr(ibVoiceBlockSummary_call_sumtime_in_sec+iAutoBlockSummary_call_sumtime_in_sec), '-')+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: '+Routines_GetConditionalMessage((ibVoiceBlockSummary_call_sumtime_in_min_div_60<>-1)and(iAutoBlockSummary_call_sumtime_in_min_div_60<>-1),
                                                              'right', 'center')+'; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                              Routines_GetConditionalMessage((ibVoiceBlockSummary_call_sumtime_in_min_div_60<>-1)and(iAutoBlockSummary_call_sumtime_in_min_div_60<>-1),
                                                              IntToStr(ibVoiceBlockSummary_call_sumtime_in_min_div_60+iAutoBlockSummary_call_sumtime_in_min_div_60), '-')+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: '+Routines_GetConditionalMessage((ibVoiceBlockSummary_call_sumtime_in_min_each<>-1)and(iAutoBlockSummary_call_sumtime_in_min_each<>-1),
                                                              'right', 'center')+'; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                                                              Routines_GetConditionalMessage((ibVoiceBlockSummary_call_sumtime_in_min_each<>-1)and(iAutoBlockSummary_call_sumtime_in_min_each<>-1),
                                                              IntToStr(ibVoiceBlockSummary_call_sumtime_in_min_each+iAutoBlockSummary_call_sumtime_in_min_each), '-')+'</TD>'+#13#10;

                                                            if ((ibVoiceBlockSummary_call_quantity<>-1)and(iAutoBlockSummary_call_quantity<>-1)and(ibVoiceBlockSummary_call_sumtime_in_sec<>-1)and(iAutoBlockSummary_call_sumtime_in_sec<>-1)) then
                                                              begin
                                                                rSummary_call_average_time:=(ibVoiceBlockSummary_call_sumtime_in_sec+iAutoBlockSummary_call_sumtime_in_sec)/(ibVoiceBlockSummary_call_quantity+iAutoBlockSummary_call_quantity);
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+Format('%8.2f', [rSummary_call_average_time]
                                                                  )+'</TD>'+#13#10;
                                                              end
                                                            else
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">-</TD>'+#13#10;

                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                            LogThis('<< Выполнение операции получения данных из временных таблиц '+sMySQLDatabase_IRDA_Location+'.tmp_09_4, '+sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                          end;
                        StepProgressBar; // 93
                      end // конец итоговой строки
                    else
                      StepProgressBar; // 93

                  if not bError then
                    begin
                      sHTML:=sHTML+'        <TR VALIGN="BOTTOM" STYLE="height: 1.2cm;">'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="9" STYLE="padding: 0px; text-align: left; font-size: 6pt; border-color: #FFFFFF; border-style: solid; border-width: 0px;">'+
                        '<I>Примечания:</I><BR>*: получило ответ автоинформатора (для услуг, обслуживаемых автоинформатором) либо получило ответ телефониста (для услуг, обслуживаемых телефонистами)'+
                        '<BR>**: общая длительность звонков в секундах, делённая на 60<BR>***: сумма длительностей звонков, округлённых до полных минут</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="9" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 30px;">'+'Исполнитель:<BR>'+CurrentUser.sPosition+'<BR>'+CurrentUser.sFullName+'<BR>'+
                        CurrentUser.sContactPhone+'</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="9" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      dtNow:=Now;
                      sHTML:=sHTML+'           <TD COLSPAN="9" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; ' //
                        +'border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">' //
                        +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow) //
                        +' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10; //
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'      </TBODY>'+#13#10;
                      sHTML:=sHTML+'    </TABLE>'+#13#10;
                      sHTML:=sHTML+'    </CENTER>'+#13#10;

                      StepProgressBar; // 94
                      StepProgressBar; // 95
                      StepProgressBar; // 96
                      StepProgressBar; // 97
                      StepProgressBar; // 98
                      StepProgressBar; // 99
                      StepProgressBar; // 100
                      StepProgressBar; // 101
                      StepProgressBar; // 102
                      StepProgressBar; // 103
                      StepProgressBar; // 104
                      StepProgressBar; // 105
                      StepProgressBar; // 106
                      StepProgressBar; // 107
                      StepProgressBar; // 108
                    end;
                end
              else
                begin
                  if SummaryReport then
                    begin // начало формирования краткого отчёта
                      sHTML:=sHTML+'    <CENTER>'+#13#10;

                      sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                      // border-spacing: 0px;
                      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="100px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+
                        '          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                        +sReportCode+'</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">' //
                        +'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 10pt; font-weight: bold; padding: 20px 0px 3px 0px;">' //
                        +'Статистика&nbsp;звонков'+aNets[NetIndex].sHTMLAbonentsName+'&nbsp;на&nbsp;услуги&nbsp;СИЦ<BR>за&nbsp;'+sReportPeriod+'</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Пришло на СТ-платформу</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Принято СТ-платформой</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Получило ответ автоинформатора (обслужено автоинформатором)</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Распределено на рабочее место</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Получило ответ оператора (обслужено телефонистами)</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">С длительностью от трёх секунд или выдан номер</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество, штук</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;

                      // блок голосовых услуг
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          with Configuration.StatServer do
                            begin
                              LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                              if not bConnected then
                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                              else
                                begin
                                  if mysql_ping(hConnection)<>0 then
                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      q:='SELECT' //
                                        +' service,' //
                                        +' call_quantity_part1,' //
                                        +' call_quantity_part2,' //
                                        +' call_quantity_part3,' //
                                        +' call_quantity_part4,' //
                                        +' call_quantity_part5,' //
                                        +' call_quantity_part6 ' //
                                        +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                        +'WHERE' //
                                        +' is_summaryrow="0" AND' //
                                        +' is_autoservice="0" AND' //
                                        +' is_globalsummaryrow="0" ' //
                                        +'ORDER BY' //
                                        +' service;'; //
                                      LogThis(q, lmtSQL);
                                      if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                        Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                      else
                                        begin
                                          LogThis('Запрос выполнен успешно.', lmtDebug);
                                          ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                  LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                  if iRowQuantity>0 then
                                                    begin
                                                      // шапка блока
                                                      bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                      bVoiceBlockExists:=True;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      sHTML:=sHTML+
                                                        '          <TD COLSPAN="7" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые телефонистами</TD>'
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
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                // тело блока
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                              LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                            end;
                          StepProgressBar; // 89

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                with Configuration.StatServer do
                                  begin
                                    LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                    if not bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            q:='SELECT' //
                                              +' call_quantity_part1,' //
                                              +' call_quantity_part2,' //
                                              +' call_quantity_part3,' //
                                              +' call_quantity_part4,' //
                                              +' call_quantity_part5,' //
                                              +' call_quantity_part6 ' //
                                              +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                              +'WHERE' //
                                              +' is_summaryrow="1" AND' //
                                              +' is_autoservice="0" AND' //
                                              +' is_globalsummaryrow="0";'; //
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
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        if iRowQuantity>0 then
                                                          begin
                                                            if iRowQuantity>1 then
                                                              Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                if ResultRow=nil then
                                                                  Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                    sErrorMessage, bError)
                                                                else
                                                                  begin
                                                                    LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'        </TR>'+#13#10;
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
                                    LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                  end;
                                StepProgressBar; // 90
                              end
                            else
                              StepProgressBar; // 90
                        end; // конец блока голосовых услуг

                      // блок автоинформаторов
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          with Configuration.StatServer do
                            begin
                              LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                              if not bConnected then
                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                              else
                                begin
                                  if mysql_ping(hConnection)<>0 then
                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      q:='SELECT' //
                                        +' service,' //
                                        +' call_quantity_part1,' //
                                        +' call_quantity_part2,' //
                                        +' call_quantity_part3 ' //
                                        +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                        +'WHERE' //
                                        +' is_summaryrow="0" AND' //
                                        +' is_autoservice="1" AND' //
                                        +' is_globalsummaryrow="0" ' //
                                        +'ORDER BY' //
                                        +' service;'; //
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
                                                  LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                  if iRowQuantity>0 then
                                                    begin
                                                      // шапка блока
                                                      bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                      bAutoBlockExists:=True;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      sHTML:=sHTML+
                                                        '          <TD COLSPAN="7" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые автоинформатором</TD>'
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
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                // тело блока
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                              LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                            end;
                          StepProgressBar; // 91

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                with Configuration.StatServer do
                                  begin
                                    LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                    if not bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            q:='SELECT' //
                                              +' call_quantity_part1,' //
                                              +' call_quantity_part2,' //
                                              +' call_quantity_part3 ' //
                                              +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                              +'WHERE' //
                                              +' is_summaryrow="1" AND' //
                                              +' is_autoservice="1" AND' //
                                              +' is_globalsummaryrow="0";'; //
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
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        if iRowQuantity>0 then
                                                          begin
                                                            if iRowQuantity>1 then
                                                              Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                if ResultRow=nil then
                                                                  Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                    sErrorMessage, bError)
                                                                else
                                                                  begin
                                                                    LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                    sHTML:=sHTML+'        </TR>'+#13#10;
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
                                    LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                  end;
                                StepProgressBar; // 92
                              end
                            else
                              StepProgressBar; // 92
                        end; // конец блока автоинформаторов

                      // итоговая строка для обоих типов услуг
                      if not bError then
                        if bVoiceBlockExists and bAutoBlockExists then
                          begin
                            with Configuration.StatServer do
                              begin
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                if not bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part1,' //
                                          +' call_quantity_part2,' //
                                          +' call_quantity_part3,' //
                                          +' call_quantity_part4,' //
                                          +' call_quantity_part5,' //
                                          +' call_quantity_part6 ' //
                                          +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                          +'WHERE' //
                                          +' is_globalsummaryrow="1";'; //
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Всего:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                              end;
                            StepProgressBar; // 93
                          end // конец итоговой строки
                        else
                          StepProgressBar; // 93

                      if not bError then
                        begin
                          sHTML:=sHTML+'        <TR STYLE="height: 20px;">'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="7" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 0px; padding: 0px;"></TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                          sHTML:=sHTML+'    </TABLE>'+#13#10;

                          sHTML:=sHTML+'    </CENTER>'+#13#10;

                          StepProgressBar; // 94
                          StepProgressBar; // 95
                          StepProgressBar; // 96
                          StepProgressBar; // 97
                          StepProgressBar; // 98
                          StepProgressBar; // 99
                          StepProgressBar; // 100
                          StepProgressBar; // 101
                          StepProgressBar; // 102
                          StepProgressBar; // 103
                        end;
                    end // конец формирования краткого отчёта
                  else
                    begin // начало формирования полного отчёта
                      sHTML:=sHTML+'    <CENTER>'+#13#10;
                      sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                      // border-spacing: 0px;
                      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="70px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="86px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="136px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="86px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="136px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+
                        '          <TD COLSPAN="6" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">Форма № '
                        +sReportCode+'</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">' //
                        +'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 10pt; font-weight: bold; padding: 20px 0px 3px 0px;">' //
                        +'Статистика&nbsp;звонков'+aNets[NetIndex].sHTMLAbonentsName+'&nbsp;на&nbsp;услуги&nbsp;СИЦ<BR>за&nbsp;'+sReportPeriod+'&nbsp;(лист&nbsp;№&nbsp;1&nbsp;из&nbsp;3)</TD>'+#13#10; //
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="3" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Пришло на СТ-платформу</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Принято СТ-платформой</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут*</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут*</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;

                      // первый блок голосовых услуг
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          with Configuration.StatServer do
                            begin
                              LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                              if not bConnected then
                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                              else
                                begin
                                  if mysql_ping(hConnection)<>0 then
                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      q:='SELECT' //
                                        +' service,' //
                                        +' call_quantity_part1,' //
                                        +' call_sumtime_in_sec_part1,' //
                                        +' call_sumtime_in_min_div_60_part1,' //
                                        +' call_sumtime_in_min_each_part1,' //
                                        +' call_average_time_part1,' //
                                        +' call_quantity_part2,' //
                                        +' call_sumtime_in_sec_part2,' //
                                        +' call_sumtime_in_min_div_60_part2,' //
                                        +' call_sumtime_in_min_each_part2,' //
                                        +' call_average_time_part2 ' //
                                        +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                        +'WHERE' //
                                        +' is_summaryrow="0" AND' //
                                        +' is_autoservice="0" AND' //
                                        +' is_globalsummaryrow="0" ' //
                                        +'ORDER BY' //
                                        +' service;'; //
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
                                                  LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                  if iRowQuantity>0 then
                                                    begin
                                                      // шапка блока
                                                      bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                      bVoiceBlockExists:=True;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      sHTML:=sHTML+
                                                        '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые телефонистами</TD>'
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
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                // тело блока
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[10])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                              LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                            end;
                          StepProgressBar; // 89

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                with Configuration.StatServer do
                                  begin
                                    LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                    if not bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            q:='SELECT' //
                                              +' call_quantity_part1,' //
                                              +' call_sumtime_in_sec_part1,' //
                                              +' call_sumtime_in_min_div_60_part1,' //
                                              +' call_sumtime_in_min_each_part1,' //
                                              +' call_average_time_part1,' //
                                              +' call_quantity_part2,' //
                                              +' call_sumtime_in_sec_part2,' //
                                              +' call_sumtime_in_min_div_60_part2,' //
                                              +' call_sumtime_in_min_each_part2,' //
                                              +' call_average_time_part2 ' //
                                              +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                              +'WHERE' //
                                              +' is_summaryrow="1" AND' //
                                              +' is_autoservice="0" AND' //
                                              +' is_globalsummaryrow="0";'; //
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
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        if iRowQuantity>0 then
                                                          begin
                                                            if iRowQuantity>1 then
                                                              Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                if ResultRow=nil then
                                                                  Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                    sErrorMessage, bError)
                                                                else
                                                                  begin
                                                                    LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[8])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[9])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'        </TR>'+#13#10;
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
                                    LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                  end;
                                StepProgressBar; // 90
                              end
                            else
                              StepProgressBar; // 90
                        end; // конец первого блока голосовых услуг

                      // первый блок автоинформаторов
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          with Configuration.StatServer do
                            begin
                              LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                              if not bConnected then
                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                              else
                                begin
                                  if mysql_ping(hConnection)<>0 then
                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      q:='SELECT' //
                                        +' service,' //
                                        +' call_quantity_part1,' //
                                        +' call_sumtime_in_sec_part1,' //
                                        +' call_sumtime_in_min_div_60_part1,' //
                                        +' call_sumtime_in_min_each_part1,' //
                                        +' call_average_time_part1,' //
                                        +' call_quantity_part2,' //
                                        +' call_sumtime_in_sec_part2,' //
                                        +' call_sumtime_in_min_div_60_part2,' //
                                        +' call_sumtime_in_min_each_part2,' //
                                        +' call_average_time_part2 ' //
                                        +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                        +'WHERE' //
                                        +' is_summaryrow="0" AND' //
                                        +' is_autoservice="1" AND' //
                                        +' is_globalsummaryrow="0" ' //
                                        +'ORDER BY' //
                                        +' service;'; //
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
                                                  LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                  if iRowQuantity>0 then
                                                    begin
                                                      // шапка блока
                                                      bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                      bAutoBlockExists:=True;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      sHTML:=sHTML+
                                                        '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые автоинформатором</TD>'
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
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+
                                                                Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                                // тело блока
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                  'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[10])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                              LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                            end;
                          StepProgressBar; // 91

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                with Configuration.StatServer do
                                  begin
                                    LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                    if not bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            q:='SELECT' //
                                              +' call_quantity_part1,' //
                                              +' call_sumtime_in_sec_part1,' //
                                              +' call_sumtime_in_min_div_60_part1,' //
                                              +' call_sumtime_in_min_each_part1,' //
                                              +' call_average_time_part1,' //
                                              +' call_quantity_part2,' //
                                              +' call_sumtime_in_sec_part2,' //
                                              +' call_sumtime_in_min_div_60_part2,' //
                                              +' call_sumtime_in_min_each_part2,' //
                                              +' call_average_time_part2 ' //
                                              +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                              +'WHERE' //
                                              +' is_summaryrow="1" AND' //
                                              +' is_autoservice="1" AND' //
                                              +' is_globalsummaryrow="0";'; //
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
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        if iRowQuantity>0 then
                                                          begin
                                                            if iRowQuantity>1 then
                                                              Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                if ResultRow=nil then
                                                                  Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                    sErrorMessage, bError)
                                                                else
                                                                  begin
                                                                    LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[8])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[9])
                                                                      +'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'        </TR>'+#13#10;
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
                                    LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                  end;
                                StepProgressBar; // 92
                              end
                            else
                              StepProgressBar; // 92
                        end; // конец первого блока автоинформаторов

                      // первая итоговая строка для обоих типов услуг
                      if not bError then
                        if bVoiceBlockExists and bAutoBlockExists then
                          begin
                            with Configuration.StatServer do
                              begin
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                if not bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part1,' //
                                          +' call_sumtime_in_sec_part1,' //
                                          +' call_sumtime_in_min_div_60_part1,' //
                                          +' call_sumtime_in_min_each_part1,' //
                                          +' call_average_time_part1,' //
                                          +' call_quantity_part2,' //
                                          +' call_sumtime_in_sec_part2,' //
                                          +' call_sumtime_in_min_div_60_part2,' //
                                          +' call_sumtime_in_min_each_part2,' //
                                          +' call_average_time_part2 ' //
                                          +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                          +'WHERE' //
                                          +' is_globalsummaryrow="1";'; //
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Всего:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                              end;
                            StepProgressBar; // 93
                          end // конец первой итоговой строки
                        else
                          StepProgressBar; // 93

                      if not bError then
                        begin
                          sHTML:=sHTML+'        <TR VALIGN="BOTTOM" STYLE="height: 1.2cm;">'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="padding: 0px; text-align: left; font-size: 6pt; border-color: #FFFFFF; border-style: solid; border-width: 0px;">'+
                            '<I>Примечания:</I><BR>*: общая длительность звонков в секундах, делённая на 60'+'<BR>**: сумма длительностей звонков, округлённых до полных минут</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                          sHTML:=sHTML+'    </TABLE>'+#13#10;
                          sHTML:=sHTML+'    </CENTER>'+#13#10;
                        end;

                      // второй блок голосовых услуг
                      if not bError then
                        begin
                          sHTML:=sHTML+'    <CENTER STYLE="page-break-before: always;">'+#13#10;
                          sHTML:=sHTML+
                            '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                          // border-spacing: 0px;
                          sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="70px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="86px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="136px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="86px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="136px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 10pt; font-weight: bold; padding: 66px 0px 3px 0px;">' //
                            +'Статистика&nbsp;звонков'+aNets[NetIndex].sHTMLAbonentsName+'&nbsp;на&nbsp;услуги&nbsp;СИЦ<BR>за&nbsp;'+sReportPeriod+'&nbsp;(лист&nbsp;№&nbsp;2&nbsp;из&nbsp;3)</TD>'+#13#10; //
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="3" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+#13#10;
                          sHTML:=sHTML+
                            '          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Получило ответ автоинформатора (обслужено автоинформатором)</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Распределено на рабочее место</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут*</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут*</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;

                          bBlockDataExists:=False;
                          LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                          if not Configuration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' service,' //
                                    +' call_quantity_part3,' //
                                    +' call_sumtime_in_sec_part3,' //
                                    +' call_sumtime_in_min_div_60_part3,' //
                                    +' call_sumtime_in_min_each_part3,' //
                                    +' call_average_time_part3,' //
                                    +' call_quantity_part4,' //
                                    +' call_sumtime_in_sec_part4,' //
                                    +' call_sumtime_in_min_div_60_part4,' //
                                    +' call_sumtime_in_min_each_part4,' //
                                    +' call_average_time_part4 ' //
                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                    +'WHERE' //
                                    +' is_summaryrow="0" AND' //
                                    +' is_autoservice="0" AND' //
                                    +' is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' service;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                              if iRowQuantity>0 then
                                                begin
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bVoiceBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые телефонистами</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[10])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                          StepProgressBar; // 94

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part3,' //
                                          +' call_sumtime_in_sec_part3,' //
                                          +' call_sumtime_in_min_div_60_part3,' //
                                          +' call_sumtime_in_min_each_part3,' //
                                          +' call_average_time_part3,' //
                                          +' call_quantity_part4,' //
                                          +' call_sumtime_in_sec_part4,' //
                                          +' call_sumtime_in_min_div_60_part4,' //
                                          +' call_sumtime_in_min_each_part4,' //
                                          +' call_average_time_part4 ' //
                                          +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                          +'WHERE' //
                                          +' is_summaryrow="1" AND' //
                                          +' is_autoservice="0" AND' //
                                          +' is_globalsummaryrow="0";'; //
                                        LogThis(q, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                StepProgressBar; // 95
                              end
                            else
                              StepProgressBar; // 95
                        end; // конец второго блока голосовых услуг

                      // второй блок автоинформаторов
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                          if not Configuration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' service,' //
                                    +' call_quantity_part3,' //
                                    +' call_sumtime_in_sec_part3,' //
                                    +' call_sumtime_in_min_div_60_part3,' //
                                    +' call_sumtime_in_min_each_part3,' //
                                    +' call_average_time_part3 ' //
                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                    +'WHERE' //
                                    +' is_summaryrow="0" AND' //
                                    +' is_autoservice="1" AND' //
                                    +' is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' service;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                              if iRowQuantity>0 then
                                                begin
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bAutoBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые автоинформатором</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                          StepProgressBar; // 96

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part3,' //
                                          +' call_sumtime_in_sec_part3,' //
                                          +' call_sumtime_in_min_div_60_part3,' //
                                          +' call_sumtime_in_min_each_part3,' //
                                          +' call_average_time_part3 ' //
                                          +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                          +'WHERE' //
                                          +' is_summaryrow="1" AND' //
                                          +' is_autoservice="1" AND' //
                                          +' is_globalsummaryrow="0";'; //
                                        LogThis(q, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                StepProgressBar; // 97
                              end
                            else
                              StepProgressBar; // 97
                        end; // конец второго блока автоинформаторов

                      // вторая итоговая строка для обоих типов услуг
                      if not bError then
                        if bVoiceBlockExists and bAutoBlockExists then
                          begin
                            LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                            if not Configuration.StatServer.bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                else
                                  begin
                                    q:='SELECT' //
                                      +' call_quantity_part3,' //
                                      +' call_sumtime_in_sec_part3,' //
                                      +' call_sumtime_in_min_div_60_part3,' //
                                      +' call_sumtime_in_min_each_part3,' //
                                      +' call_average_time_part3,' //
                                      +' call_quantity_part4,' //
                                      +' call_sumtime_in_sec_part4,' //
                                      +' call_sumtime_in_min_div_60_part4,' //
                                      +' call_sumtime_in_min_each_part4,' //
                                      +' call_average_time_part4 ' //
                                      +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                      +'WHERE' //
                                      +' is_globalsummaryrow="1";'; //
                                    LogThis(q, lmtSQL);
                                    if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtDebug);
                                        ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                if iRowQuantity>0 then
                                                  begin
                                                    if iRowQuantity>1 then
                                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Всего:</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                            LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                            StepProgressBar; // 98
                          end // конец второй итоговой строки
                        else
                          StepProgressBar; // 98

                      if not bError then
                        begin
                          sHTML:=sHTML+'        <TR VALIGN="BOTTOM" STYLE="height: 1.2cm;">'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="padding: 0px; text-align: left; font-size: 6pt; border-color: #FFFFFF; border-style: solid; border-width: 0px;">'+
                            '<I>Примечания:</I><BR>*: общая длительность звонков в секундах, делённая на 60'+'<BR>**: сумма длительностей звонков, округлённых до полных минут</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                          sHTML:=sHTML+'    </TABLE>'+#13#10;
                          sHTML:=sHTML+'    </CENTER>'+#13#10;
                        end;

                      // третий блок голосовых услуг
                      if not bError then
                        begin
                          sHTML:=sHTML+'    <CENTER STYLE="page-break-before: always;">'+#13#10;
                          sHTML:=sHTML+
                            '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                          // border-spacing: 0px;
                          sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="70px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="86px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="136px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="86px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="81px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="136px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 10pt; font-weight: bold; padding: 66px 0px 3px 0px;">' //
                            +'Статистика&nbsp;звонков'+aNets[NetIndex].sHTMLAbonentsName+'&nbsp;на&nbsp;услуги&nbsp;СИЦ<BR>за&nbsp;'+sReportPeriod+'&nbsp;(лист&nbsp;№&nbsp;3&nbsp;из&nbsp;3)</TD>'+#13#10; //
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="3" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Получило ответ оператора (обслужено телефонистами)</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">С длительностью от трёх секунд или выдан номер</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество звонков, штук</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Длительность звонков</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Средняя длительность звонка, секунд</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут*</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">секунд</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут*</TD>'+#13#10;
                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">минут**</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;

                          bBlockDataExists:=False;
                          LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                          if not Configuration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' service,' //
                                    +' call_quantity_part5,' //
                                    +' call_sumtime_in_sec_part5,' //
                                    +' call_sumtime_in_min_div_60_part5,' //
                                    +' call_sumtime_in_min_each_part5,' //
                                    +' call_average_time_part5,' //
                                    +' call_quantity_part6,' //
                                    +' call_sumtime_in_sec_part6,' //
                                    +' call_sumtime_in_min_div_60_part6,' //
                                    +' call_sumtime_in_min_each_part6,' //
                                    +' call_average_time_part6 ' //
                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                    +'WHERE' //
                                    +' is_summaryrow="0" AND' //
                                    +' is_autoservice="0" AND' //
                                    +' is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' service;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                              if iRowQuantity>0 then
                                                begin
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bVoiceBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые телефонистами</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[10])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                          StepProgressBar; // 99

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part5,' //
                                          +' call_sumtime_in_sec_part5,' //
                                          +' call_sumtime_in_min_div_60_part5,' //
                                          +' call_sumtime_in_min_each_part5,' //
                                          +' call_average_time_part5,' //
                                          +' call_quantity_part6,' //
                                          +' call_sumtime_in_sec_part6,' //
                                          +' call_sumtime_in_min_div_60_part6,' //
                                          +' call_sumtime_in_min_each_part6,' //
                                          +' call_average_time_part6 ' //
                                          +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                          +'WHERE' //
                                          +' is_summaryrow="1" AND' //
                                          +' is_autoservice="0" AND' //
                                          +' is_globalsummaryrow="0";'; //
                                        LogThis(q, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                StepProgressBar; // 100
                              end
                            else
                              StepProgressBar; // 100
                        end; // конец третьего блока голосовых услуг

                      // третий блок автоинформаторов
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                          if not Configuration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' service,' //
                                    +' call_quantity_part5,' //
                                    +' call_sumtime_in_sec_part5,' //
                                    +' call_sumtime_in_min_div_60_part5,' //
                                    +' call_sumtime_in_min_each_part5,' //
                                    +' call_average_time_part5,' //
                                    +' call_quantity_part6,' //
                                    +' call_sumtime_in_sec_part6,' //
                                    +' call_sumtime_in_min_div_60_part6,' //
                                    +' call_sumtime_in_min_each_part6,' //
                                    +' call_average_time_part6 ' //
                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                    +'WHERE' //
                                    +' is_summaryrow="0" AND' //
                                    +' is_autoservice="1" AND' //
                                    +' is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' service;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                              if iRowQuantity>0 then
                                                begin
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bAutoBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые автоинформатором</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                          StepProgressBar; // 101

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part5,' //
                                          +' call_sumtime_in_sec_part5,' //
                                          +' call_sumtime_in_min_div_60_part5,' //
                                          +' call_sumtime_in_min_each_part5,' //
                                          +' call_average_time_part5,' //
                                          +' call_quantity_part6,' //
                                          +' call_sumtime_in_sec_part6,' //
                                          +' call_sumtime_in_min_div_60_part6,' //
                                          +' call_sumtime_in_min_each_part6,' //
                                          +' call_average_time_part6 ' //
                                          +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                          +'WHERE' //
                                          +' is_summaryrow="1" AND' //
                                          +' is_autoservice="1" AND' //
                                          +' is_globalsummaryrow="0";'; //
                                        LogThis(q, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                                StepProgressBar; // 102
                              end
                            else
                              StepProgressBar; // 102
                        end; // конец третьего блока автоинформаторов

                      // третья итоговая строка для обоих типов услуг
                      if not bError then
                        if bVoiceBlockExists and bAutoBlockExists then
                          begin
                            LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4...', lmtDebug);
                            if not Configuration.StatServer.bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                else
                                  begin
                                    q:='SELECT' //
                                      +' call_quantity_part5,' //
                                      +' call_sumtime_in_sec_part5,' //
                                      +' call_sumtime_in_min_div_60_part5,' //
                                      +' call_sumtime_in_min_each_part5,' //
                                      +' call_average_time_part5,' //
                                      +' call_quantity_part6,' //
                                      +' call_sumtime_in_sec_part6,' //
                                      +' call_sumtime_in_min_div_60_part6,' //
                                      +' call_sumtime_in_min_each_part6,' //
                                      +' call_average_time_part6 ' //
                                      +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 ' //
                                      +'WHERE' //
                                      +' is_globalsummaryrow="1";'; //
                                    LogThis(q, lmtSQL);
                                    if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtDebug);
                                        ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                if iRowQuantity>0 then
                                                  begin
                                                    if iRowQuantity>1 then
                                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Всего:</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                            LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_4 завершено.', lmtDebug);
                            StepProgressBar; // 103
                          end // конец третьей итоговой строки
                        else
                          StepProgressBar; // 103

                      if not bError then
                        begin
                          sHTML:=sHTML+'        <TR VALIGN="BOTTOM" STYLE="height: 1.2cm;">'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="padding: 0px; text-align: left; font-size: 6pt; border-color: #FFFFFF; border-style: solid; border-width: 0px;">'+
                            '<I>Примечания:</I><BR>*: общая длительность звонков в секундах, делённая на 60'+'<BR>**: сумма длительностей звонков, округлённых до полных минут</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                          sHTML:=sHTML+'    </TABLE>'+#13#10;
                          sHTML:=sHTML+'    </CENTER>'+#13#10;
                        end;
                    end; // конец формирования полного отчёта

                  if not bError then
                    begin // начало формирования отчёта по отказам
                      sHTML:=sHTML+'    <CENTER STYLE="page-break-before: always;">'+#13#10;
                      sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                      // border-spacing: 0px;
                      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="90px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="91px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 10pt; font-weight: bold; padding: 20px 0px 3px 0px;">' //
                        +'Статистика&nbsp;отказов&nbsp;по&nbsp;звонкам'+aNets[NetIndex].sHTMLAbonentsName+'&nbsp;на&nbsp;услуги&nbsp;СИЦ<BR>за&nbsp;'+sReportPeriod+'</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Номер услуги</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Этап получения ответа СТ-платформы</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Этап запуска автоинформатора</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Этап распределения на рабочее место</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Этап подтверждения соединения</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Количество</TD>'+#13#10;
                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">Процент</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;

                      // блок голосовых услуг
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                          if not Configuration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' service,' //
                                    +' call_quantity_part1,' //
                                    +' call_percent_part1,' //
                                    +' call_quantity_part2,' //
                                    +' call_percent_part2,' //
                                    +' call_quantity_part3,' //
                                    +' call_percent_part3,' //
                                    +' call_quantity_part4,' //
                                    +' call_percent_part4,' //
                                    +' call_quantity_part5,' //
                                    +' call_percent_part5 ' //
                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                    +'WHERE' //
                                    +' is_summaryrow="0" AND' //
                                    +' is_autoservice="0" AND' //
                                    +' is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' service;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                              if iRowQuantity>0 then
                                                begin
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bVoiceBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые телефонистами</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[10])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                          StepProgressBar; // 104

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part1,' //
                                          +' call_percent_part1,' //
                                          +' call_quantity_part2,' //
                                          +' call_percent_part2,' //
                                          +' call_quantity_part3,' //
                                          +' call_percent_part3,' //
                                          +' call_quantity_part4,' //
                                          +' call_percent_part4,' //
                                          +' call_quantity_part5,' //
                                          +' call_percent_part5 ' //
                                          +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                          +'WHERE' //
                                          +' is_summaryrow="1" AND' //
                                          +' is_autoservice="0" AND' //
                                          +' is_globalsummaryrow="0";'; //
                                        LogThis(q, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                                StepProgressBar; // 105
                              end
                            else
                              StepProgressBar; // 105
                        end; // конец блока голосовых услуг

                      // блок автоинформаторов
                      if not bError then
                        begin
                          bBlockDataExists:=False;
                          LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                          if not Configuration.StatServer.bConnected then
                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT' //
                                    +' service,' //
                                    +' call_quantity_part1,' //
                                    +' call_percent_part1,' //
                                    +' call_quantity_part2,' //
                                    +' call_percent_part2,' //
                                    +' call_quantity_part5,' //
                                    +' call_percent_part5 ' //
                                    +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                    +'WHERE' //
                                    +' is_summaryrow="0" AND' //
                                    +' is_autoservice="1" AND' //
                                    +' is_globalsummaryrow="0" ' //
                                    +'ORDER BY' //
                                    +' service;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtDebug);
                                      ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                              LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                              if iRowQuantity>0 then
                                                begin
                                                  // шапка блока
                                                  bBlockDataExists:=True; // флаг для вывода итоговых данных текущего блока услуг
                                                  bAutoBlockExists:=True;
                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                  sHTML:=sHTML+
                                                    '          <TD COLSPAN="11" STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Обслуживаемые автоинформатором</TD>'
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
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                            sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', lmtDebug);
                                                            // тело блока
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 2px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">-</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                              'px 0px; border-color: black; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                          LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                          StepProgressBar; // 106

                          if not bError then
                            if bBlockDataExists then // проверка наличия шапки блока
                              begin
                                // вывод итоговой строки блока услуг
                                LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT' //
                                          +' call_quantity_part1,' //
                                          +' call_percent_part1,' //
                                          +' call_quantity_part2,' //
                                          +' call_percent_part2,' //
                                          +' call_quantity_part5,' //
                                          +' call_percent_part5 ' //
                                          +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                          +'WHERE' //
                                          +' is_summaryrow="1" AND' //
                                          +' is_autoservice="1" AND' //
                                          +' is_globalsummaryrow="0";'; //
                                        LogThis(q, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                    LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                    if iRowQuantity>0 then
                                                      begin
                                                        if iRowQuantity>1 then
                                                          Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                            if ResultRow=nil then
                                                              Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">Итого:</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">-</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-style: italic; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+
                                                                  '</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
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
                                LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                                StepProgressBar; // 107
                              end
                            else
                              StepProgressBar; // 107
                        end; // конец блока автоинформаторов

                      // итоговая строка для обоих типов услуг
                      if not bError then
                        if bVoiceBlockExists and bAutoBlockExists then
                          begin
                            LogThis('>> Выполняется операция получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5...', lmtDebug);
                            if not Configuration.StatServer.bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                else
                                  begin
                                    q:='SELECT' //
                                      +' call_quantity_part1,' //
                                      +' call_percent_part1,' //
                                      +' call_quantity_part2,' //
                                      +' call_percent_part2,' //
                                      +' call_quantity_part3,' //
                                      +' call_percent_part3,' //
                                      +' call_quantity_part4,' //
                                      +' call_percent_part4,' //
                                      +' call_quantity_part5,' //
                                      +' call_percent_part5 ' //
                                      +'FROM '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 ' //
                                      +'WHERE' //
                                      +' is_globalsummaryrow="1";'; //
                                    LogThis(q, lmtSQL);
                                    if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtDebug);
                                        ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
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
                                                LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                if iRowQuantity>0 then
                                                  begin
                                                    if iRowQuantity>1 then
                                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(iRowQuantity)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Количество строк выборки соответствует требуемому.', lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения данных строки выборки прошла успешно.', lmtDebug);
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">Всего:</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'          <TD STYLE="text-align: right; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
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
                            LogThis('<< Выполнение операции получения данных из временной таблицы '+Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_09_5 завершено.', lmtDebug);
                            StepProgressBar; // 108
                          end // конец итоговой строки
                        else
                          StepProgressBar; // 108

                      if not bError then
                        begin
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 30px;">'+'Исполнитель:<BR>'+CurrentUser.sPosition+'<BR>'+CurrentUser.sFullName+'<BR>'+
                            CurrentUser.sContactPhone+'</TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          sHTML:=sHTML+'          <TD COLSPAN="11" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'        <TR>'+#13#10;
                          dtNow:=Now;
                          sHTML:=sHTML+'           <TD COLSPAN="11" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; ' //
                            +'border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">' //
                            +'Отчёт подготовлен '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' года в '+FormatDateTime('hh:nn:ss', dtNow) //
                            +' при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10; //
                          sHTML:=sHTML+'        </TR>'+#13#10;
                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                          sHTML:=sHTML+'    </TABLE>'+#13#10;
                          sHTML:=sHTML+'    </CENTER>'+#13#10;
                        end;
                    end; // конец формирования отчёта по отказам
                end;

              if not bError then
                begin
                  sHTML:=sHTML+'  </BODY>'+#13#10;
                  sHTML:=sHTML+'</HTML>'+#13#10;
                  // _LogThis(sHTML, lmtDebug);
                end;

            end; // конец формирования текста HTML-файла

          // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
          _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
          StepProgressBar; // 109

          // открытие отчёта браузером
          if not bError then //
            begin
              Synchronize( procedure begin //
                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, 'Статистика звонков'+StringReplace(StringReplace(StringReplace(aNets[NetIndex].sHTMLAbonentsName, '&laquo;', '', [rfReplaceAll]), '&raquo;', '', [rfReplaceAll]), '&nbsp;', ' ',
                [rfReplaceAll])+' на услуги СИЦ за '+sReportPeriod+' [форма № '+sReportCode+'].htm', OpenWithBrowser, True) then Routines_GenerateError('Произошла ошибка во вложенной функции сохранения и открытия отчёта!', sErrorMessage,
                bError); end); //
              StepProgressBar; // 110
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
