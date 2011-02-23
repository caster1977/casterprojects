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
  iRoutineCounter, iPhonesCounter: integer;
  iRowQuantity, iRowCounter: integer;
  slUserList, slPeriodList: TStringList;
  iPeriodCounter: integer;
  dtDate: TDate;
  iFullListCounter: integer;
  q: string;
  s: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  sServiceName: string;
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
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-04-...');

  // ����� ������ ������� ���������� ���������
  EnableTimer:=True;

  // ������������� �������� ����������
  bError:=False;
  sTableName:='';
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
      begin
        sPeriodColumn:='<BR>(���, ����, �����, ���)';
        sPeriodColumnQuery:='CONCAT(TIME_FORMAT(evn_datetime, "%H"),":00:00-",TIME_FORMAT(evn_datetime, "%H"),":59:59 ", DATE_FORMAT(evn_datetime, "%d.%m.%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpDays:
      begin
        sPeriodColumn:='<BR>(����, �����, ���)';
        sPeriodColumnQuery:='DATE_FORMAT(evn_datetime, "%d.%m.%Y")';
        sGroupByQuery:='period';
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
        sPeriodColumnQuery:='CONCAT(IF(DATE_FORMAT(evn_datetime, "%m")=1, "������", IF(DATE_FORMAT(evn_datetime, "%m")=2, "�������", IF(DATE_FORMAT(evn_datetime, "%m")=3, "����", '+
          'IF(DATE_FORMAT(evn_datetime, "%m")=4, "������", IF(DATE_FORMAT(evn_datetime, "%m")=5, "���", IF(DATE_FORMAT(evn_datetime, "%m")=6, "����", IF(DATE_FORMAT(evn_datetime, "%m")=7, "����", '+
          'IF(DATE_FORMAT(evn_datetime, "%m")=8, "������", IF(DATE_FORMAT(evn_datetime, "%m")=9, "��������", IF(DATE_FORMAT(evn_datetime, "%m")=10, "�������", '+
          'IF(DATE_FORMAT(evn_datetime, "%m")=11, "������", IF(DATE_FORMAT(evn_datetime, "%m")=12, "�������", "?"))))))))))))," ", DATE_FORMAT(evn_datetime, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpQuarters:
      begin
        sPeriodColumn:='<BR>(����� ��������, ���)';
        sPeriodColumnQuery:='CONCAT(IF(QUARTER(evn_datetime)=1,"I",IF(QUARTER(evn_datetime)=2,"II",IF(QUARTER(evn_datetime)=3,"III",IF(QUARTER(evn_datetime)=4,"IV","?")))), " ������� ", DATE_FORMAT(evn_datetime, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpYears:
      begin
        sPeriodColumn:='<BR>(���)';
        sPeriodColumnQuery:='DATE_FORMAT(evn_datetime, "%Y")';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
  end;

  sReportCode:='���-04-'+Routines_GetConditionalMessage(AllUsers, '�', '�')+'-'+Routines_GetConditionalMessage(ShowIdleUsers, '�', '�')+'-'+Routines_GetConditionalMessage(CreateDetailedReport, '�', '�')+
    Routines_GetConditionalMessage(CreateDetailedReport and ShowSQLQueries, '�', '')+'-'+Routines_GetConditionalMessage(CreateDetailedReport, DatesDiffChar, sReportSuffix);

  LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

  // �������� ������ �������� � ���� ��������� ��������
  _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', 17);

  // ����������� � MySQL-�������, �� ������� ��������� ������� ������������� �� rne4
  _MySQL_OpenConnection(FConfiguration.RNE4Server, bError, sErrorMessage);
  StepProgressBar; // 1

  if not bError then
    begin
      // �������� ������� ������� ������������� � ���� ������
      _MySQL_CheckTableExistance(FConfiguration.RNE4Server, FConfiguration.RNE4Server.sMySQLDatabase, bError, sErrorMessage, '_usr');
      StepProgressBar; // 2

      if not bError then
        begin
          // �������� ������� ������� ������� � ���� ������
          _MySQL_CheckTableExistance(FConfiguration.RNE4Server, FConfiguration.RNE4Server.sMySQLDatabase, bError, sErrorMessage, '_evn');
          StepProgressBar; // 3

          if not bError then
            begin
              slUserList:=TStringList.Create;
              try
                // ������������ ������ ������������� �� ������ �������� �������� ����������
                if AllUsers then
                  begin
                    // ������������ ������
                    _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                    StepProgressBar; // 4

                    if not bError then
                      begin
                        // ����������� ������ ������������� (���������� ��������)
                        LogThis('>> ����������� �������� ����������� ������ �������������...', lmtDebug);
                        with FConfiguration.RNE4Server do
                          if not bConnected then
                            Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                          else
                            begin
                              if mysql_ping(hConnection)<>0 then
                                Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                              else
                                begin
                                  q:='SELECT DISTINCT usr_fullname ' //
                                    +'FROM '+sMySQLDatabase+'._usr ' //
                                    +'WHERE usr_erased="0" ' //
                                    +'ORDER BY usr_fullname;'; //
                                  LogThis(q, lmtSQL);
                                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                    Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('������ �������� �������.', lmtDebug);
                                      ResultSet:=mysql_store_result(hConnection);
                                      if ResultSet=nil then
                                        Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                      Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server),
                                                        sErrorMessage, bError)
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
                        StepProgressBar; // 5

                        // ��������������� ������
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

                // ������ ������������ ������ HTML-�����
                if not bError then
                  begin
                    sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
                    sHTML:=sHTML+'<HTML>'+#13#10;
                    sHTML:=sHTML+'  <HEAD>'+#13#10;
                    sHTML:=sHTML+'    <TITLE>���������� �� ������ ������������� ��� ������ ����� � ����������� �� '+sReportPeriod+'</TITLE>'+#13#10;
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
                    sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                    sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                    sHTML:=sHTML+'        <TR>'+#13#10;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '100', '196')+'px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '100', '115')+'px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '100', '115')+'px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                    sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="'+Routines_GetConditionalMessage(CreateDetailedReport, '*', '115px')+'" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                    if not CreateDetailedReport then
                      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="115px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                    sHTML:=sHTML+'        </TR>'+#13#10;
                    sHTML:=sHTML+'        <TR>'+#13#10;
                    sHTML:=sHTML+
                      '          <TD COLSPAN="3" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">����� � '
                      +sReportCode+'</TD>'+#13#10;
                    sHTML:=sHTML+'          <TD '+Routines_GetConditionalMessage(CreateDetailedReport, '', 'COLSPAN="2" ')+
                      'STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 6pt; text-align: right;">'+
                      '���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
                    sHTML:=sHTML+'        </TR>'+#13#10;
                    sHTML:=sHTML+'        <TR>'+#13#10;
                    sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
                      '" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">���������� �� ������ �������������<BR>��� ������ &laquo;����� � �����������&raquo;<BR>�� '+
                      sReportPeriod+'</TD>'+#13#10;
                    sHTML:=sHTML+'        </TR>'+#13#10;

                    if CreateDetailedReport then
                      begin
                        // ������������ ������
                        _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ, '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn READ');
                        StepProgressBar; // 7

                        if not bError then
                          begin
                            // �������� ��������� �������
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
                                // ��������������� ������
                                _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                StepProgressBar; // 9

                                if not bError then
                                  begin
                                    // ������������ �������
                                    _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                                    StepProgressBar; // 10

                                    if not bError then
                                      begin
                                        // ��������� ������ �� ��������� ������� � ������������ ������
                                        for iRoutineCounter:=0 to slUserList.Count-1 do
                                          if bError then
                                            Break
                                          else
                                            begin
                                              LogThis('>> ����������� �������� ��������� ��������� ������ � ��������� ������������ � ������������ ����� ������...', lmtDebug);
                                              with FConfiguration.RNE4Server do
                                                if not bConnected then
                                                  Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if mysql_ping(hConnection)<>0 then
                                                      Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                          Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('������ �������� �������.', lmtDebug);
                                                            ResultSet:=mysql_store_result(hConnection);
                                                            if ResultSet=nil then
                                                              Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                                    if (iRowQuantity>0)or ShowIdleUsers then
                                                                      begin
                                                                        bAnyReportDataExists:=True;
                                                                        sHTML:=sHTML+'        <TR>'+#13#10;
                                                                        sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; font-weight: bold; font-size: 10pt; padding: 20px 0px 3px 0px;">' //
                                                                          +Trim(slUserList[iRoutineCounter])+':</TD>'+#13#10; //
                                                                        sHTML:=sHTML+'        </TR>'+#13#10;
                                                                      end;
                                                                    if iRowQuantity>0 then
                                                                      begin
                                                                        sHTML:=sHTML+'        <TR>'+#13#10;
                                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">����</TD>'+#13#10;
                                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�����</TD>'+#13#10;
                                                                        sHTML:=sHTML+'          <TD '+Routines_GetConditionalMessage(ShowSQLQueries, '', 'COLSPAN="2"')+
                                                                          'STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">��������</TD>'+#13#10;
                                                                        if ShowSQLQueries then
                                                                          sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� SQL-�������</TD>'+#13#10;
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
                                                                                Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                                                s:=string(ResultRow[2]);
                                                                                if s='INS' then
                                                                                s:='��������';
                                                                                if s='MOD' then
                                                                                s:='����������';
                                                                                if s='DEL' then
                                                                                s:='��������';
                                                                                if s='REC' then
                                                                                s:='��������������';
                                                                                s:=s+Routines_GetConditionalMessage(string(ResultRow[3])>'', ' ', '') //
                                                                                +Routines_GetConditionalMessage(StrToIntDef(string(ResultRow[4]), -1)=0, //
                                                                                Routines_GetConditionalMessage(string(ResultRow[3])='msr', ' ������ �����������', ''), //
                                                                                Routines_GetConditionalMessage(string(ResultRow[3])='usr', ' ������������', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='phn', ' ��������', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='msg', ' ���������', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='org', ' �����������', '') //
                                                                                +Routines_GetConditionalMessage(string(ResultRow[3])='msr', ' �����������', '') //
                                                                                +Routines_GetConditionalMessage(StrToIntDef(string(ResultRow[4]), -1)>-1, ' ID #'+string(ResultRow[4]), '')); //
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[0])='', '-', string(ResultRow[0]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[1])='', '-', string(ResultRow[1]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD '+Routines_GetConditionalMessage(ShowSQLQueries, '', 'COLSPAN="2"')+'STYLE="text-align: center; border-width: 0px 2px '+
                                                                                Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(s='', '-', s)+
                                                                                '</TD>'+#13#10;
                                                                                if ShowSQLQueries then
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align:   left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[3])='', '-', string(ResultRow[5]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                end;
                                                                            end;
                                                                      end
                                                                    else
                                                                      if ShowIdleUsers then
                                                                        begin
                                                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                                                          sHTML:=sHTML+
                                                                            '          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">�� ������� �� ������ �������� �� ������ ������ �������.</TD>'+#13#10;
                                                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                                                        end;
                                                                  end;
                                                                mysql_free_result(ResultSet);
                                                                LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                              end;
                                                          end;
                                                      end;
                                                  end;
                                              LogThis('<< ���������� �������� ��������� ��������� ������ � ��������� ������������ � ������������ ����� ������ ���������.', lmtDebug);
                                            end;
                                        StepProgressBar; // 11

                                        // ��������������� ������
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
                    else // !!! ���� ����� ��������
                      begin
                        // �������� ��������� �������
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
                            // ������������ �������
                            _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._evn READ, '+FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                            StepProgressBar; // 8

                            if not bError then
                              begin
                                // �������� ��������� ������� �� ������ ��������� ������� _evn
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
                                    // ��������������� ������
                                    _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                    StepProgressBar; // 10

                                    // ������� ������ �� ��������� �������
                                    if not bError then
                                      begin
                                        if GroupByPeriod=gbpWeeks then
                                          begin
                                            // ������������ ������
                                            _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ');
                                            StepProgressBar; // 11

                                            if not bError then
                                              begin
                                                // ��������� ������ ������
                                                slWeeksList:=GetWeeksList(StartDate, StopDate, CalculateWeekFromMonday);
                                                if slWeeksList<>nil then
                                                  try
                                                    // ����������� ��������� ������ �� �������
                                                    for iWeekCounter:=0 to slWeeksList.Count-1 do
                                                      if bError then
                                                        Break
                                                      else
                                                        begin
                                                          // ������� ������ � �������
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
                                                  Routines_GenerateError('�������� ������ ��� ��������� ������ ������, �������� � ��������� ������ �������!', sErrorMessage, bError);
                                                StepProgressBar; // 12

                                                // ��������������� ������
                                                if not bError then
                                                  begin
                                                    _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                                    StepProgressBar; // 13
                                                  end;
                                              end;
                                          end
                                        else // !!! ���� ����������� ����� ����� ���������
                                          begin
                                            // ������������ ������
                                            _MySQL_LockTables(FConfiguration.RNE4Server, bError, sErrorMessage, FConfiguration.RNE4Server.sMySQLDatabase+'._usr READ, '+FConfiguration.RNE4Server.sMySQLDatabase+'._evn READ');
                                            StepProgressBar; // 11

                                            if not bError then
                                              begin
                                                // ������� ������ � �������
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

                                                // ��������������� ������
                                                if not bError then
                                                  begin
                                                    _MySQL_UnlockTables(FConfiguration.RNE4Server, bError, sErrorMessage);
                                                    StepProgressBar; // 13
                                                  end;
                                              end;
                                          end;

                                        // ������� ���� ������������
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
                                                    // ��������� ������ ���������� ��������� ������� "������" ��� ���������� ������������
                                                    LogThis('>> ����������� �������� ����������� ������ ���������� ��������� ������� ������� ������� ��� ���������� ������������...', lmtDebug);
                                                    with FConfiguration.RNE4Server do
                                                      if not bConnected then
                                                        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                      else
                                                        begin
                                                          if mysql_ping(hConnection)<>0 then
                                                            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                          else
                                                            begin
                                                              q:='SELECT DISTINCT period ' //
                                                                +'FROM '+sMySQLDatabase+'.tmp_04 ' //
                                                                +'WHERE username="'+slUserList[iRoutineCounter]+'" ' //
                                                                +'ORDER BY sort_id;'; //
                                                              LogThis(q, lmtSQL);
                                                              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('������ �������� �������.', lmtDebug);
                                                                  ResultSet:=mysql_store_result(hConnection);
                                                                  if ResultSet=nil then
                                                                    Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
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
                                                                                Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                                                slPeriodList.Add(string(ResultRow[0]));
                                                                                end;
                                                                              end;
                                                                        end;
                                                                      mysql_free_result(ResultSet);
                                                                      LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    LogThis('<< ���������� �������� ����������� ������ ���������� ��������� ������� ������� ������� ��� ���������� ������������ ���������.', lmtDebug);

                                                    if not bError then
                                                      begin
                                                        if (slPeriodList.Count>0)or ShowIdleUsers then
                                                          begin
                                                            bAnyReportDataExists:=True;
                                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                                            sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: left; font-weight: bold; font-size: 10pt; padding: 20px 0px 3px 0px;">'+
                                                              Trim(slUserList[iRoutineCounter])+':</TD>'+#13#10;
                                                            sHTML:=sHTML+'        </TR>'+#13#10;
                                                            if slPeriodList.Count>0 then
                                                              begin
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">������'+sPeriodColumn+'</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�������</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����������</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�������</TD>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�������������</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                // ������� ����� ������� � ��������� ���������� ������� ������� ���� �� ������ ������
                                                                for iPeriodCounter:=0 to slPeriodList.Count-1 do
                                                                  if bError then
                                                                    Break
                                                                  else
                                                                    begin
                                                                      LogThis('>> ����������� �������� ��������� ���������� �������� ���������� ������������...', lmtDebug);
                                                                      with FConfiguration.RNE4Server do
                                                                        if not bConnected then
                                                                          Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                                        else
                                                                          begin
                                                                            if mysql_ping(hConnection)<>0 then
                                                                              Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                q:='SELECT username, period, event_type, quantity ' //
                                                                                +'FROM '+sMySQLDatabase+'.tmp_04 ' //
                                                                                +'WHERE username="'+slUserList[iRoutineCounter]+'" ' //
                                                                                +'AND period="'+slPeriodList[iPeriodCounter]+'" ' //
                                                                                +'ORDER BY event_type;'; //
                                                                                LogThis(q, lmtSQL);
                                                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('������ �������� �������.', lmtDebug);
                                                                                ResultSet:=mysql_store_result(hConnection);
                                                                                if ResultSet=nil then
                                                                                Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server),
                                                                                sErrorMessage, bError)
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
                                                                                iQuantityCreated:=0;
                                                                                iQuantityModified:=0;
                                                                                iQuantityDeleted:=0;
                                                                                iQuantityRecoveried:=0;
                                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                                if bError then
                                                                                Break
                                                                                else
                                                                                begin
                                                                                LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                                                if ResultRow=nil then
                                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!'+
                                                                                Routines_GetMySQLErrorInfo(FConfiguration.RNE4Server), sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
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
                                                                                // ������������ ������
                                                                                iQuantityCreated_UserSummary:=iQuantityCreated_UserSummary+iQuantityCreated;
                                                                                iQuantityModified_UserSummary:=iQuantityModified_UserSummary+iQuantityModified;
                                                                                iQuantityDeleted_UserSummary:=iQuantityDeleted_UserSummary+iQuantityDeleted;
                                                                                iQuantityRecoveried_UserSummary:=iQuantityRecoveried_UserSummary+iQuantityRecoveried;
                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+slPeriodList[iPeriodCounter]+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityCreated=0, '-', IntToStr(iQuantityCreated))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityModified=0, '-', IntToStr(iQuantityModified))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityDeleted=0, '-', IntToStr(iQuantityDeleted))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iPeriodCounter=(slPeriodList.Count-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(iQuantityRecoveried=0, '-', IntToStr(iQuantityRecoveried))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                                end;
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet);
                                                                                LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                                                end;
                                                                                end;
                                                                              end;
                                                                          end;
                                                                      LogThis('<< ���������� �������� ��������� ���������� �������� ���������� ������������ ���������.', lmtDebug);
                                                                    end;
                                                                // ���������� �������� ������
                                                                if not bError then
                                                                  begin
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; padding: 2px;">�����:</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityCreated_UserSummary=0, '-', IntToStr(iQuantityCreated_UserSummary))+'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityModified_UserSummary=0, '-', IntToStr(iQuantityModified_UserSummary))+'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityDeleted_UserSummary=0, '-', IntToStr(iQuantityDeleted_UserSummary))+'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+
                                                                      Routines_GetConditionalMessage(iQuantityRecoveried_UserSummary=0, '-', IntToStr(iQuantityRecoveried_UserSummary))+'</TD>'+#13#10;
                                                                    sHTML:=sHTML+'        </TR>'+#13#10;
                                                                  end;
                                                              end
                                                            else
                                                              if ShowIdleUsers then
                                                                begin
                                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                                  sHTML:=sHTML+
                                                                    '          <TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">�� ������� �� ������ �������� �� ������ ������ �������.</TD>'+#13#10;
                                                                  sHTML:=sHTML+'        </TR>'+#13#10;
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

      // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
      _MySQL_CloseConnection(FConfiguration.RNE4Server, bError, sErrorMessage);
      StepProgressBar; // 15

      if not bError then
        begin
          // ���� �� ���� �������� ������� ��������� ������ - ������� ������ �� ���������� ������ � ��
          if not bAnyReportDataExists then
            begin
              sHTML:=sHTML+'        <TR>'+#13#10;
              sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
                '" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">������ �� ��������� ������ ������� �����������.</TD>'+#13#10;
              sHTML:=sHTML+'        </TR>'+#13#10;
            end;
          sHTML:=sHTML+'        <TR>'+#13#10;
          sHTML:=sHTML+'          <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+'" STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;
          sHTML:=sHTML+'        <TR>'+#13#10;
          sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+'" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">�����������:<BR>'+
            Self.CurrentUser.sPosition+'<BR>'+Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;
          sHTML:=sHTML+'        <TR>'+#13#10;
          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
            '" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;
          sHTML:=sHTML+'        <TR>'+#13#10;
          dtNow:=Now;
          sHTML:=sHTML+'           <TD COLSPAN="'+Routines_GetConditionalMessage(CreateDetailedReport, '4', '5')+
            '" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'+'����� ����������� '+
            IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' ���� � '+FormatDateTime('hh:nn:ss', dtNow)+
            ' ��� ������ ������������ ��������� &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;
          sHTML:=sHTML+'      </TBODY>'+#13#10;
          sHTML:=sHTML+'    </TABLE>'+#13#10;
          sHTML:=sHTML+'    </CENTER>'+#13#10;
          sHTML:=sHTML+'  </BODY>'+#13#10;
          sHTML:=sHTML+'</HTML>'+#13#10;
          // _LogThis(sHTML, lmtDebug);
          StepProgressBar; // 16

          if not bError then //
            begin
              Synchronize( //
                procedure //
              begin //
                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '���������� �� ������ ������������� ��� ������ ����� � ����������� �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True) then //
                Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); //
              end //
                ); //
              StepProgressBar; // 17
            end;
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
