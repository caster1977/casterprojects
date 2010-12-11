unit Thread_Do_ASKR;

interface

uses
  Classes,
  SysUtils,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_ASKR=class(TThread_Do_SIC)
  protected
    procedure Execute; override;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec);
    // destructor Destroy; override;
  end;

implementation

uses
  Main,
  DateUtils,
  mysql,
  OverseerRoutines;

constructor TThread_Do_ASKR.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec);
begin
  inherited Create;
  with Self do
    begin
      LogGroupGUID:=aLogGroupGUID;
      StartDate:=aStartDate;
      StopDate:=aStopDate;
      CurrentUser:=aCurrentUser;
      Configuration:=aConfiguration;
    end;
end;

procedure TThread_Do_ASKR.Execute;
var
  sErrorMessage: string;
  bError: boolean;
  // sHTML: string;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  dtNow: TDateTime;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  sReportPeriod: string;
  sTableName: string;
  // iRoutineCounter, iPhonesCounter: integer;
  // iRowQuantity, iRowCounter: integer;
  // slIRDFullList: TStringList;
  // dtDate: TDate;
  // iFullListCounter: integer;
  // q: string;
  // ResultSet: PMYSQL_RES;
  // ResultRow: PMYSQL_ROW;
  // sServiceName: string;
  // sReportCode: string;
begin
  // Header процедуры
  ProcedureHeader('Процедура формирования файлов выгрузки для АСКР');

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

  LogThis('Начато формирование файлов выгрузки для АСКР за '+sReportPeriod+'.', lmtInfo);

  // создание строки прогесса в окне прогресса действий
  _CreateProgressBar(dtNow, 'Формирование файлов выгрузки для АСКР за '+sReportPeriod+'...', 6);

  // формирование/поиск сводной таблицы orda
  Synchronize( procedure begin //
    if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, True, False) then Routines_GenerateError('Произошла ошибка в процессе подготовки таблиц данных входящих звонков!', sErrorMessage, bError); end); //
  StepProgressBar; // 1

  if not bError then
    begin
      // подключение к MySQL-серверу, на котором находятся таблицы irda
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2
    end;

  if not bError then
    begin
      // проверка наличия таблицы в базе данных
      _MySQL_CheckTableExistance(Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRDA_Location, bError, sErrorMessage, sTableName);
      StepProgressBar; // 3
    end;

  if not bError then
    begin
      // блокирование таблицы
      _MySQL_LockTables(Configuration.StatServer, bError, sErrorMessage, Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' READ');
      StepProgressBar; // 4
    end;

  if not bError then
    begin
      // разблокирование таблиц
      _MySQL_UnlockTables(Configuration.StatServer, bError, sErrorMessage);
      StepProgressBar; //
    end;

  // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
  _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
  StepProgressBar; //

  // окончание замера времени выполнения процедуры
  EnableTimer:=False;

  // Prefooter процедуры
  PreFooter(bError, sErrorMessage);

  // Footer процедуры
  ProcedureFooter;
end;

end.
