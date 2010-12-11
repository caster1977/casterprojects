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
  mysql;

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
  slUserList, slPeriodList: TStringList;
  q: string;
  s: string;
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
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-10-...');

  // ����� ������ ������� ���������� ���������
  EnableTimer:=True;

  // ������������� �������� ����������
  bError:=False;
  bAnyReportDataExists:=False; // ���� ���� �����-���� ������ ����� ��������� � �����, ���������� ���������� � true, ����� ������� ������, ��� ������ ������� �� ����

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

  case GroupByPeriod of
    gbpHours:
      Routines_GenerateError('�������� ������ ��� ��������� ���������� ����������� ������ ��� ������������ ������!', sErrorMessage, bError);
    gbpDays:
      begin
        sPeriodColumn:='<BR>(����, �����, ���)';
        sPeriodColumnQuery:='DATE_FORMAT(date, "%d.%m.%Y")';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpWeeks:
      begin
        sPeriodColumn:='<BR>(������, ����� ������)';
        if CalculateWeekFromMonday then
          sReportSuffix:=DatesDiffChar+'-��'
        else
          sReportSuffix:=DatesDiffChar+'-��';
      end;
    gbpMonths:
      begin
        sPeriodColumn:='<BR>(�����, ���)';
        sPeriodColumnQuery:='CONCAT(IF(DATE_FORMAT(date, "%m")=1, "������", IF(DATE_FORMAT(date, "%m")=2, "�������", IF(DATE_FORMAT(date, "%m")=3, "����", '+
          'IF(DATE_FORMAT(date, "%m")=4, "������", IF(DATE_FORMAT(date, "%m")=5, "���", IF(DATE_FORMAT(date, "%m")=6, "����", IF(DATE_FORMAT(date, "%m")=7, "����", '+
          'IF(DATE_FORMAT(date, "%m")=8, "������", IF(DATE_FORMAT(date, "%m")=9, "��������", IF(DATE_FORMAT(date, "%m")=10, "�������", '+
          'IF(DATE_FORMAT(date, "%m")=11, "������", IF(DATE_FORMAT(date, "%m")=12, "�������", "?"))))))))))))," ", DATE_FORMAT(date, "%Y"))';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpQuarters:
      begin
        sPeriodColumn:='<BR>(����� ��������, ���)';
        sPeriodColumnQuery:='CONCAT(IF(QUARTER(date)=1,"I",IF(QUARTER(date)=2,"II",IF(QUARTER(date)=3,"III",IF(QUARTER(date)=4,"IV","?")))), " ������� ", DATE_FORMAT(date, "%Y"))';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpYears:
      begin
        sPeriodColumn:='<BR>(���)';
        sPeriodColumnQuery:='DATE_FORMAT(date, "%Y")';
        sGroupByQuery:='period, name, sifra ';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
  end;

  case CCID of
    -1:
      begin
        sCCID:='';
        sCCIDPrefix:='0';
        sUserGroupName:='������������ ���, ������������ ���� � BackOffice';
      end;
    1:
      begin
        sCCID:=' ccid="1" AND';
        sCCIDPrefix:='1';
        sUserGroupName:='������������ ���';
      end;
    2:
      begin
        sCCID:=' ccid="2" AND';
        sCCIDPrefix:='2';
        sUserGroupName:='������������ ���� � BackOffice';
      end
  else
    Routines_GenerateError('�� ������� ���������������� ��������� ������ �������������!', sErrorMessage, bError);
  end;

  if not bError then
    begin
      sReportCode:='���-10-'+sCCIDPrefix+'-' // ����� CCID
        +Routines_GetConditionalMessage(AllUsers, '�', '�')+'-' // ��� ������������ �� ��������� ������ ��� ���
        +Routines_GetConditionalMessage(CreateDetailedReport, '�', '�')+'-' //
        +Routines_GetConditionalMessage(CreateDetailedReport, DatesDiffChar, sReportSuffix); // ��������� ������ ������� � ����������� � ������ ���� �� ��������� ����� � ������ ������ �������, � ������, ���� ���������

      LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

      // �������� ������ �������� � ���� ��������� ��������
      _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', 17);

      // ������������ ��������� ������� �� OVERSEERSERVER �� ������ ������� t_day, ����������� �� ������� DBSERVER
      if not bError then
        with FConfiguration do
          begin
            // ����������� � MySQL-�������, �� ������� ��������� ������� t_day
            _MySQL_OpenConnection(DBServer, bError, sErrorMessage);
            StepProgressBar; // 1

            if not bError then
              begin
                // �������� ������� ������� ������������� � ���� ������
                _MySQL_CheckTableExistance(DBServer, DBServer.sMySQLDatabase_T_DAY_Location, bError, sErrorMessage, 't_day');
                StepProgressBar; // 2

                if not bError then
                  begin
                    LogThis('>> ����������� �������� ��������� ������� �� �������� ��������� ������� ������...', lmtDebug);
                    if not DBServer.bConnected then
                      Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                    else
                      begin
                        if mysql_ping(DBServer.hConnection)<>0 then
                          Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                        else
                          begin
                            q:='SHOW CREATE TABLE '+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day;';
                            LogThis(q, lmtSQL);
                            if mysql_real_query(DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                              Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                            else
                              begin
                                LogThis('������ �������� �������.', lmtDebug);
                                ResultSet:=mysql_store_result(DBServer.hConnection);
                                if ResultSet=nil then
                                  Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                else
                                  begin
                                    LogThis('�������������� ������� �������� �������.', lmtDebug);
                                    iRoutineCounter:=mysql_num_rows(ResultSet);
                                    LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', lmtDebug);
                                    if iRoutineCounter<0 then
                                      Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                    else
                                      begin
                                        if iRoutineCounter>1 then
                                          Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                                        else
                                          begin
                                            ResultRow:=mysql_fetch_row(ResultSet);
                                            if ResultRow=nil then
                                              Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                            else
                                              if ResultRow[1]='' then
                                                Routines_GenerateError('�������� ������ ��� ��������� ������ ������� �� �������� ��������� ������� ������!', sErrorMessage, bError)
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
                                                  LogThis('������ �� �������� ��������� ������� ������ ������� �������.', lmtDebug);
                                                end;
                                          end;
                                      end;
                                  end;
                                mysql_free_result(ResultSet);
                                LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                              end;
                          end;
                      end;
                    LogThis('<< ���������� �������� ��������� ������� �� �������� ��������� ������� ������ ���������.', lmtDebug);
                    StepProgressBar; // 3

                    if not bError then
                      begin
                        // ����������� � MySQL-������� OVERSEERSERVER
                        _MySQL_OpenConnection(OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 4

                        if not bError then
                          begin
                            // �������� ��������� ������� OVERSEERSERVER
                            _MySQL_CreateTable(OverseerServer, bError, sErrorMessage, sCreateQuery); //
                            StepProgressBar; // 5

                            if not bError then
                              begin
                                // ������������ ������� �� DBSERVER �� ������
                                _MySQL_LockTables(DBServer, bError, sErrorMessage, DBServer.sMySQLDatabase_T_DAY_Location+'.t_day READ');
                                StepProgressBar; // 6

                                // ������� ������ �� ������� � DBSERVER �� ��������� ������� �� OVERSEERSERVER
                                if not bError then
                                  begin
                                    // ��������� ������ �� ������� �� DBSERVER
                                    LogThis('>> ����������� �������� ��������� ������� �� ��������� ������ ������� �� ������� ������ "'+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day"...', lmtDebug);
                                    if not DBServer.bConnected then
                                      Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(DBServer.hConnection)<>0 then
                                          Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
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
                                              Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('������ �������� �������.', lmtDebug);
                                                ResultSet:=mysql_store_result(DBServer.hConnection);
                                                if ResultSet=nil then
                                                  Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(DBServer), sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                    iRowCountSource:=mysql_num_rows(ResultSet);
                                                    LogThis('���������� ����� ������� ����� '+IntToStr(iRowCountSource)+'.', lmtDebug);
                                                    if iRowCountSource<0 then
                                                      Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        iLoopCounter:=0;
                                                        for iSourceRowCounter:=0 to iRowCountSource-1 do
                                                          if bError then
                                                            Break
                                                          else
                                                            begin
                                                              LogThis('��������� ��������� ������ ������� ('+IntToStr(iSourceRowCounter)+').', lmtDebug);
                                                              ResultRow:=mysql_fetch_row(ResultSet);
                                                              if ResultRow=nil then
                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iSourceRowCounter)+')!'+Routines_GetMySQLErrorInfo(DBServer),
                                                                  sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iSourceRowCounter)+') ������ �������.', lmtDebug);
                                                                  // ������� ����� � ����� � ���������� ������������ ���������� ������� ��� ������ �������
                                                                  // ���������� ��������� ������ � ������� � ������
                                                                  // ���� �� (��������� ������� � ������ ��� ��������� ����������� ������ ����� �������)
                                                                  // �������� �������� �������
                                                                  // ����� - �������� ����������� ����� �������
                                                                  { }
                                                                  // ������� �������
                                                                  if iLoopCounter=0 then
                                                                    q:='INSERT INTO '+OverseerServer.sMySQLDatabase+'.tmp_10_1 VALUES '; //
                                                                  // ��������� ������� �������
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
                                                                  if not((iSourceRowCounter=(iRowCountSource-1))or(iLoopCounter=299)) then // ���� ��������� ������� � ������ ��������� ��� ��������� ����������� ������ ����� �������
                                                                    begin
                                                                      q:=q+', '; // ������� ����� ��������
                                                                      iLoopCounter:=iLoopCounter+1; // ��������� �������� ��������� �������
                                                                    end
                                                                  else
                                                                    begin
                                                                      q:=q+';'; // ��������� ���������� �������
                                                                      iRoutineCounter:=_MySQL_InsertRecords(OverseerServer, bError, sErrorMessage, q);
                                                                      if iRoutineCounter<>(iLoopCounter+1) then
                                                                        Routines_GenerateError('���������� ������������ ����� ('+IntToStr(iLoopCounter+1)+') �� ������������� ���������� ('+IntToStr(iRoutineCounter)+')!', sErrorMessage, bError);
                                                                      iLoopCounter:=0; // ����� �������� ��������� �������
                                                                    end
                                                                  { }
                                                                  {
                                                                    // ������� ��������� ������ ������ �� ��������� ������� �� OVERSEERSERVER
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
                                                                    Routines_GenerateError('���������� ������������ ����� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError);
                                                                  }
                                                                end;
                                                            end;
                                                      end;
                                                    mysql_free_result(ResultSet);
                                                    LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                  end;
                                              end;
                                          end;
                                      end;
                                    LogThis('<< ���������� �������� ��������� ������� �� ��������� ������ ������� �� ������� ������ "'+DBServer.sMySQLDatabase_T_DAY_Location+'.t_day" ���������.', lmtDebug);
                                    StepProgressBar; // 7

                                    if not bError then
                                      begin
                                        // ��������������� ������
                                        _MySQL_UnlockTables(DBServer, bError, sErrorMessage);
                                        StepProgressBar; // 8

                                        if not bError then
                                          begin
                                            slUserList:=TStringList.Create;
                                            try
                                              // ������������ ������ ������������� �� ������ �������� �������� ����������
                                              if AllUsers then
                                                begin
                                                  // ����������� ������ ������������� (���������� ��������)
                                                  LogThis('>> ����������� �������� ����������� ������ �������������...', lmtDebug);
                                                  if not OverseerServer.bConnected then
                                                    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      if mysql_ping(OverseerServer.hConnection)<>0 then
                                                        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                      else
                                                        begin
                                                          q:='SELECT DISTINCT name ' //
                                                            +'FROM '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ' //
                                                            +'ORDER BY name;'; //
                                                          LogThis(q, lmtSQL);
                                                          if mysql_real_query(OverseerServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('������ �������� �������.', lmtDebug);
                                                              ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                              if ResultSet=nil then
                                                                Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                                  iRowQuantity:=mysql_num_rows(ResultSet);
                                                                  LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                  if iRowQuantity<0 then
                                                                    Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                                                                      for iRowCounter:=0 to iRowQuantity-1 do
                                                                        if bError then
                                                                          Break
                                                                        else
                                                                          begin
                                                                            LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                            ResultRow:=mysql_fetch_row(ResultSet);
                                                                            if ResultRow=nil then
                                                                              Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                                                slUserList.Add(Trim(string(ResultRow[0])));
                                                                              end;
                                                                          end;
                                                                    end;
                                                                  mysql_free_result(ResultSet);
                                                                  LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                  LogThis('<< ���������� �������� ����������� ������ ������������� ���������.', lmtDebug);
                                                  StepProgressBar; // 9
                                                end
                                              else
                                                begin
                                                  slUserList.AddStrings(SelectedUserList);
                                                  StepProgressBar; // 9
                                                end;

                                              if not bError then
                                                begin
                                                  // �������� ������� ������������� � ������
                                                  if slUserList.Count<1 then
                                                    Routines_GenerateError('�� ������� �� ������ ������������ ��� ������������ ������!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      // ������ ������������ ������ HTML-�����
                                                      sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
                                                      sHTML:=sHTML+'<HTML>'+#13#10;
                                                      sHTML:=sHTML+'  <HEAD>'+#13#10;
                                                      sHTML:=sHTML+'    <TITLE>���������� �� ������ '+sUserGroupName+' �� '+sReportPeriod+'</TITLE>'+#13#10;
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
                                                      sHTML:=sHTML+'    <CENTER>'+#13#10;
                                                      sHTML:=sHTML+
                                                        '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'
                                                        +#13#10;
                                                      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      if CreateDetailedReport then
                                                        begin
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="70px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="160px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="50px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="90px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="60px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                        end
                                                      else
                                                        begin
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="160px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="160px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="85px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                                        end;
                                                      sHTML:=sHTML+'        </TR>'+#13#10;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '8', '5') //
                                                        +'" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">'
                                                        +'����� � '+sReportCode+'</TD>'+#13#10;
                                                      //
                                                      sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '7', '5')+
                                                        '" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
                                                        '���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
                                                      sHTML:=sHTML+'        </TR>'+#13#10;
                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                      sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                        '" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">���������� �� ������ '+sUserGroupName+'<BR>�� '+sReportPeriod+
                                                        '</TD>'+#13#10;
                                                      sHTML:=sHTML+'        </TR>'+#13#10;

                                                      if CreateDetailedReport then
                                                        begin
                                                          LogThis('>> ����������� �������� ��������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                          if not OverseerServer.bConnected then
                                                            Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
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
                                                                    Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      LogThis('������ �������� �������.', lmtDebug);
                                                                      ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                      if ResultSet=nil then
                                                                        Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                                          iRowQuantity:=mysql_num_rows(ResultSet);
                                                                          LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                          if iRowQuantity<0 then
                                                                            Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                                                                              if iRowQuantity>0 then
                                                                                begin
                                                                                bAnyReportDataExists:=True;
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">����</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�.�.�.</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������ �����</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� �����</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ���������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ��������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">��������� �������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�� �������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� �� �������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� ������������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� ����� ������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� ����� ��������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                                if bError then
                                                                                Break
                                                                                else
                                                                                begin
                                                                                LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[10])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[11])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[12])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[13])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[14])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                      mysql_free_result(ResultSet);
                                                                      LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                    end;
                                                                end;
                                                            end;
                                                          LogThis('<< ���������� �������� ��������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ���������.', lmtDebug);
                                                          StepProgressBar; // 10

                                                          if (not bError)and bAnyReportDataExists then
                                                            begin
                                                              // ��������� ������ ��� �������� ������ � ����� � � �����
                                                              LogThis('>> ����������� �������� ��������� �������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                              if not OverseerServer.bConnected then
                                                                Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                    Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
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
                                                                        Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          LogThis('������ �������� �������.', lmtDebug);
                                                                          ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                          if ResultSet=nil then
                                                                            Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                                              iRowQuantity:=mysql_num_rows(ResultSet);
                                                                              LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                              if iRowQuantity<0 then
                                                                                Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRowQuantity)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(OverseerServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������� ��������� ������ ������ ������� ������ �������.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 1px 2px;">�����:</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[0])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[1])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[2])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[3])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[4])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[5])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[6])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                            end;
                                                                          mysql_free_result(ResultSet);
                                                                          LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                        end;
                                                                    end;
                                                                end;
                                                              LogThis('<< ���������� �������� ��������� �������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ���������.', lmtDebug);
                                                              StepProgressBar; // 11
                                                              StepProgressBar; // 12
                                                              StepProgressBar; // 13
                                                            end;
                                                        end
                                                      else // !!! ���� ����� ��������
                                                        begin
                                                          // �������� ��������� �������
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
                                                                      // ������� ������ � �������
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
                                                                  // ������� ������ � �������
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
                                                                  LogThis('>> ����������� �������� ��������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                                  if not OverseerServer.bConnected then
                                                                    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
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
                                                                            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('������ �������� �������.', lmtDebug);
                                                                              ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                              if ResultSet=nil then
                                                                                Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                                                iRowQuantity:=mysql_num_rows(ResultSet);
                                                                                LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                                if iRowQuantity<0 then
                                                                                Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                                                                                if iRowQuantity>0 then
                                                                                begin
                                                                                bAnyReportDataExists:=True;
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">������'+sPeriodColumn+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�.�.�.</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������ �����</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ��������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">��������� �������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�� �������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� �� �������</TD>'+#13#10;
                                                                                sHTML:=sHTML+
                                                                                '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� ������������</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                                if bError then
                                                                                Break
                                                                                else
                                                                                begin
                                                                                LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[4])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[5])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[6])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[7])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[8])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[9])+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                              mysql_free_result(ResultSet);
                                                                              LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                            end;
                                                                        end;
                                                                    end;
                                                                  LogThis('<< ���������� �������� ��������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ���������.', lmtDebug);
                                                                  StepProgressBar; // 12

                                                                  if (not bError)and bAnyReportDataExists then
                                                                    begin
                                                                      // ��������� ������ ��� �������� ������ � ����� � � �����
                                                                      LogThis('>> ����������� �������� ��������� �������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1...', lmtDebug);
                                                                      if not OverseerServer.bConnected then
                                                                        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          if mysql_ping(OverseerServer.hConnection)<>0 then
                                                                            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
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
                                                                                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('������ �������� �������.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(OverseerServer.hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(OverseerServer), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                                                iRowQuantity:=mysql_num_rows(ResultSet);
                                                                                LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                                                if iRowQuantity<0 then
                                                                                Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                                                                                if iRowQuantity>1 then
                                                                                Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRowQuantity)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(OverseerServer),
                                                                                sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������� ��������� ������ ������ ������� ������ �������.', lmtDebug);
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 1px 2px;">�����:</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">-</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[0])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[1])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[2])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[3])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[4])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[5])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;">'+string(ResultRow[6])+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                                end;
                                                                            end;
                                                                        end;
                                                                      LogThis('<< ���������� �������� ��������� �������� ������ �� ��������� ������� '+OverseerServer.sMySQLDatabase+'.tmp_10_1 ���������.', lmtDebug);
                                                                      StepProgressBar; // 13
                                                                    end;
                                                                end;
                                                            end;
                                                        end;

                                                      if not bError then
                                                        begin
                                                          // ���� �� ���� �������� ������� ��������� ������ - ������� ������ �� ���������� ������ � ��
                                                          if not bAnyReportDataExists then
                                                            begin
                                                              sHTML:=sHTML+'        <TR>'+#13#10;
                                                              sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                                '" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">������ �� ��������� ������ ������� �����������.</TD>'+#13#10;
                                                              sHTML:=sHTML+'        </TR>'+#13#10;
                                                            end;
                                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                                          sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                                          sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">�����������:<BR>'+Self.CurrentUser.sPosition+'<BR>'+Self.CurrentUser.sFullName+'<BR>'+
                                                            Self.CurrentUser.sContactPhone+'</TD>'+#13#10;
                                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                                          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                                          dtNow:=Now;
                                                          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '15', '10')+
                                                            '" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                                            +'����� ����������� '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' ���� � '+FormatDateTime('hh:nn:ss', dtNow)+
                                                            ' ��� ������ ������������ ��������� &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
                                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                                          sHTML:=sHTML+'      </TBODY>'+#13#10;
                                                          sHTML:=sHTML+'    </TABLE>'+#13#10;
                                                          sHTML:=sHTML+'    </CENTER>'+#13#10;
                                                          sHTML:=sHTML+'  </BODY>'+#13#10;
                                                          sHTML:=sHTML+'</HTML>'+#13#10;
                                                          // _LogThis(sHTML, lmtDebug);
                                                          StepProgressBar; // 14

                                                          // �������� ������ ���������
                                                          if not bError then //
                                                            begin
                                                              Synchronize( procedure begin //
                                                                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '���������� �� ������ '+sUserGroupName+' �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True)
                                                              then Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); end); //
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

                        // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                        _MySQL_CloseConnection(OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 16
                      end;
                  end;
              end;

            // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
            _MySQL_CloseConnection(DBServer, bError, sErrorMessage);
            StepProgressBar; // 17
          end;
    end;

  // ��������� ������ ������� ���������� ���������
  EnableTimer:=False;

  // Prefooter ���������
  PreFooter(bError, sErrorMessage);
  ShowBaloonHint('��������� ���������� ��������', '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...');

  // Footer ���������
  ProcedureFooter;
end;

end.
