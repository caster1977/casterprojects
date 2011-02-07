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
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-07-...');

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

  case GroupByPeriod of
    gbpHours:
      begin
        sPeriodColumn:='<BR>(���, ����, �����, ���)';
        sPeriodColumnQuery:='CONCAT(TIME_FORMAT(vrijeme, "%H"),":00:00-",TIME_FORMAT(vrijeme, "%H"),":59:59 ", DATE_FORMAT(datum, "%d.%m.%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpDays:
      begin
        sPeriodColumn:='<BR>(����, �����, ���)';
        sPeriodColumnQuery:='DATE_FORMAT(datum, "%d.%m.%Y")';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpWeeks:
      begin
        sPeriodColumn:='<BR>(������, ����� ������)';
        sPeriodColumnQuery:='CONCAT(DATE_FORMAT(MIN(datum), "%d.%m.%Y")," - ",DATE_FORMAT(MAX(datum), "%d.%m.%Y"))';
        sGroupByQuery:='CONCAT(DATE_FORMAT(datum, "%Y"),"-", WEEK('+Routines_GetConditionalMessage(CalculateWeekFromMonday, 'datum', 'SUBDATE(datum, INTERVAL WEEKDAY("'+FormatDateTime('yyyymmdd', StartDate)+'") DAY)')+',1))';
        if CalculateWeekFromMonday then
          sReportSuffix:=DatesDiffChar+'-��'
        else
          sReportSuffix:=DatesDiffChar+'-��';
      end;
    gbpMonths:
      begin
        sPeriodColumn:='<BR>(�����, ���)';
        sPeriodColumnQuery:='CONCAT(IF(DATE_FORMAT(datum, "%m")=1, "������", IF(DATE_FORMAT(datum, "%m")=2, "�������", IF(DATE_FORMAT(datum, "%m")=3, "����", '+
          'IF(DATE_FORMAT(datum, "%m")=4, "������", IF(DATE_FORMAT(datum, "%m")=5, "���", IF(DATE_FORMAT(datum, "%m")=6, "����", IF(DATE_FORMAT(datum, "%m")=7, "����", '+
          'IF(DATE_FORMAT(datum, "%m")=8, "������", IF(DATE_FORMAT(datum, "%m")=9, "��������", IF(DATE_FORMAT(datum, "%m")=10, "�������", '+
          'IF(DATE_FORMAT(datum, "%m")=11, "������", IF(DATE_FORMAT(datum, "%m")=12, "�������", "?"))))))))))))," ", DATE_FORMAT(datum, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpQuarters:
      begin
        sPeriodColumn:='<BR>(����� ��������, ���)';
        sPeriodColumnQuery:='CONCAT(IF(QUARTER(datum)=1,"I",IF(QUARTER(datum)=2,"II",IF(QUARTER(datum)=3,"III",IF(QUARTER(datum)=4,"IV","?")))), " ������� ", DATE_FORMAT(datum, "%Y"))';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
    gbpYears:
      begin
        sPeriodColumn:='<BR>(���)';
        sPeriodColumnQuery:='DATE_FORMAT(datum, "%Y")';
        sGroupByQuery:='period';
        sReportSuffix:=DatesDiffChar+'-�';
      end;
  end;

  sReportCode:='���-07-'+sReportSuffix;

  LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

  // �������� ������ �������� � ���� ��������� ��������
  _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', 14);

  // ������������/����� ������� ������� orda
  Synchronize( procedure begin //
    if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDOutput, sTableName, False, True, False) then Routines_GenerateError('��������� ������ � �������� ���������� ������ ������ ��������� �������!', sErrorMessage, bError); end); //
  StepProgressBar; // 1

  if not bError then
    begin
      // ������������ � MySQL-�������, �� ������� ��������� ������� orda
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2

      if not bError then
        begin
          // �������� ��������� �������
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
              // �������� ��������� �������
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
                  // �������� ��������� �������
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
                      // ������������ ������� (��������� ������)
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
                                  // ������� ������ � �������
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
                                    // ������� ������ � �������
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
                              // ������� ������ � �������
                              _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_1 ' //
                                +'SELECT "", '+sPeriodColumnQuery+' AS period, COUNT(*) ' //
                                +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.'+sTableName+' ' //
                                +'GROUP BY '+sGroupByQuery+' ' //
                                +'ORDER BY datum, vrijeme;'); //
                              StepProgressBar; // 7

                              if not bError then
                                begin
                                  // ������� ������ � �������
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
                              // ��������������� ������
                              _MySQL_UnlockTables(FConfiguration.StatServer, bError, sErrorMessage);
                              StepProgressBar; // 9

                              if not bError then
                                begin
                                  // ������� ������ � �������
                                  _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                    'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_3 ' //
                                    +'SELECT "", a.period, a.initiated_connections_quantity, b.confirmed_connections_quantity, '+
                                    'b.confirmed_connections_duration_in_seconds, confirmed_connections_duration_in_minutes, confirmed_connections_duration_in_minutes_rounded ' //
                                    +'FROM '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_1 AS a ' //
                                    +'LEFT JOIN '+FConfiguration.StatServer.sMySQLDatabase_ORDA_Location+'.tmp_07_2 AS b ON b.period=a.period ' //
                                    +'ORDER BY a.sort_id;'); //
                                  StepProgressBar; // 10

                                  // ������ ������������ ������ HTML-�����
                                  if not bError then
                                    begin
                                      sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
                                      sHTML:=sHTML+'<HTML>'+#13#10;
                                      sHTML:=sHTML+'  <HEAD>'+#13#10;
                                      sHTML:=sHTML+'    <TITLE>���������� �� ����������� �������� A � ������� ������� B (�� ��������� �������) �� '+sReportPeriod+'</TITLE>'+#13#10;
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
                                        '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">����� � '
                                        +sReportCode+'</TD>'+#13#10;
                                      sHTML:=sHTML+
                                        '          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'
                                        +'���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
                                      sHTML:=sHTML+'        </TR>'+#13#10;
                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                      sHTML:=sHTML+
                                        '          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">���������� �� ����������� �������� A � ������� ������� B<BR>(�� ��������� �������)<BR>�� '
                                        +sReportPeriod+'</TD>'+#13#10;
                                      sHTML:=sHTML+'        </TR>'+#13#10;

                                      iResultRow1Summary:=0;
                                      iResultRow2Summary:=0;
                                      iResultRow3Summary:=0;
                                      iResultRow4Summary:=0;
                                      iResultRow5Summary:=0;

                                      // ��������� ������ ��� ����� ������
                                      LogThis('>> ����������� �������� ��������� ������ ��� ����� ������...', lmtDebug);
                                      with FConfiguration.StatServer do
                                        if not bConnected then
                                          Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                        else
                                          begin
                                            if mysql_ping(hConnection)<>0 then
                                              Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                            else
                                              begin
                                                q:='SELECT period, initiated_connections_quantity, confirmed_connections_quantity, confirmed_connections_duration_in_seconds, ' //
                                                  +'confirmed_connections_duration_in_minutes, confirmed_connections_duration_in_minutes_rounded ' //
                                                  +'FROM '+sMySQLDatabase_ORDA_Location+'.tmp_07_3 ' //
                                                  +'ORDER BY sort_id;'; //
                                                LogThis(q, lmtSQL);
                                                if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                  Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('������ �������� �������.', lmtDebug);
                                                    ResultSet:=mysql_store_result(hConnection);
                                                    if ResultSet=nil then
                                                      Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('�������������� ������� �������� �������.', lmtDebug);
                                                        iRowQuantity:=mysql_num_rows(ResultSet);
                                                        LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', lmtDebug);
                                                        if iRowQuantity<0 then
                                                          Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            if iRowQuantity>0 then
                                                              begin
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">������'+sPeriodColumn+'</TD>'+#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����������<BR>������-<BR>��������<BR>����������</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����������<BR>�������-<BR>������<BR>����������</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� �������������<BR>�������-<BR>������<BR>����������, ������</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� �������������<BR>�������-<BR>������<BR>���������� ����������<BR>�� ����� (�������/60), �����</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+
                                                                  '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ����������<BR>�� ����� �������������<BR>�������-<BR>������<BR>����������, �����</TD>'
                                                                  +#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                for iRowCounter:=0 to iRowQuantity-1 do
                                                                  if bError then
                                                                    Break
                                                                  else
                                                                    begin
                                                                      LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                                      ResultRow:=mysql_fetch_row(ResultSet);
                                                                      if ResultRow=nil then
                                                                        Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                                                                          sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          LogThis('������ ��������� ������ �������� �������.', lmtDebug);
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
                                                                // ����� �������� ������
                                                                if not bError then
                                                                  begin
                                                                    sHTML:=sHTML+'        <TR>'+#13#10;
                                                                    sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">�����:</TD>'+#13#10;
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
                                                            else // ���� ������ �� ���� �������
                                                              begin
                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0px; text-align: left; font-size: 10pt; padding: 20px 0px 3px 0px;">'+
                                                                  '������ �� ��������� ������ ������� �����������.</TD>'+#13#10;
                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                              end;
                                                          end;
                                                        mysql_free_result(ResultSet);
                                                        LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                      end;
                                                  end;
                                              end;
                                          end;
                                      LogThis('<< ���������� �������� ��������� ������ ��� ����� ������ ���������.', lmtDebug);
                                      StepProgressBar; // 11

                                      // ���������� �������� HTML-�����
                                      if not bError then
                                        begin
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="6" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">�����������:<BR>'+Self.CurrentUser.sPosition+'<BR>'+
                                            Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          sHTML:=sHTML+'           <TD COLSPAN="6" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                                          sHTML:=sHTML+'        </TR>'+#13#10;
                                          sHTML:=sHTML+'        <TR>'+#13#10;
                                          dtNow:=Now;
                                          sHTML:=sHTML+
                                            '           <TD COLSPAN="6" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                            +'����� ����������� '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' ���� � '+FormatDateTime('hh:nn:ss', dtNow)+
                                            ' ��� ������ ������������ ��������� &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
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

      // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
      _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 13

      // �������� ������ ���������
      if not bError then //
        begin
          Synchronize( procedure begin //
            if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '���������� �� ����������� �������� A � ������� ������� B (�� ��������� �������) �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True)
          then Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); end); //
          StepProgressBar; // 14
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
