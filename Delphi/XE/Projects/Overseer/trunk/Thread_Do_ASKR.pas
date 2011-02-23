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
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �������� ��� ����');

  // ����� ������ ������� ���������� ���������
  EnableTimer:=True;

  // ������������� �������� ����������
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
  sLongStartDate:=IntToStr(wStartDay)+' '+saMonths2[wStartMonth]+' '+IntToStr(wStartYear)+' ����';
  sLongStopDate:=IntToStr(wStopDay)+' '+saMonths2[wStopMonth]+' '+IntToStr(wStopYear)+' ����';

  case DatesDiffChar of
    '�':
      sReportPeriod:=FormatDateTime('yyyy ���', StartDate);
    '�':
      sReportPeriod:=saQuarters[wStopMonth div 3]+' ������� '+IntToStr(wStartYear)+' ����';
    '�':
      sReportPeriod:=saMonths1[wStartMonth]+' '+IntToStr(wStartYear)+' ����';
    '�':
      sReportPeriod:='������ �'+Routines_GetConditionalMessage(wStartDay=2, '�', '')+' '+sLongStartDate+' �� '+sLongStopDate;
    '�':
      sReportPeriod:=sLongStartDate;
    '�':
      sReportPeriod:='������ �'+Routines_GetConditionalMessage(wStartDay=2, '�', '')+' '+sLongStartDate+' �� '+sLongStopDate;
  end;

  LogThis('������ ������������ ������ �������� ��� ���� �� '+sReportPeriod+'.', lmtInfo);

  // �������� ������ �������� � ���� ��������� ��������
  _CreateProgressBar(dtNow, '������������ ������ �������� ��� ���� �� '+sReportPeriod+'...', 6);

  // ������������/����� ������� ������� orda
  Synchronize( procedure begin //
    if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, True, False) then Routines_GenerateError('��������� ������ � �������� ���������� ������ ������ �������� �������!', sErrorMessage, bError); end); //
  StepProgressBar; // 1

  if not bError then
    begin
      // ����������� � MySQL-�������, �� ������� ��������� ������� irda
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2
    end;

  if not bError then
    begin
      // �������� ������� ������� � ���� ������
      _MySQL_CheckTableExistance(Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRDA_Location, bError, sErrorMessage, sTableName);
      StepProgressBar; // 3
    end;

  if not bError then
    begin
      // ������������ �������
      _MySQL_LockTables(Configuration.StatServer, bError, sErrorMessage, Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' READ');
      StepProgressBar; // 4
    end;

  if not bError then
    begin
      // ��������������� ������
      _MySQL_UnlockTables(Configuration.StatServer, bError, sErrorMessage);
      StepProgressBar; //
    end;

  // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
  _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
  StepProgressBar; //

  // ��������� ������ ������� ���������� ���������
  EnableTimer:=False;

  // Prefooter ���������
  PreFooter(bError, sErrorMessage);

  // Footer ���������
  ProcedureFooter;
end;

end.
