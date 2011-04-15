unit Thread_Do_SIC_06;

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
  mysql,
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
  // q: string;
   iRoutineCounter, iRowQuantity, iRowCounter: integer;
  // sPeriodColumnQuery, sGroupByQuery: string;
  // ResultSet: PMYSQL_RES;
  // ResultRow: PMYSQL_ROW;
  // slWeeksList: TStringList;
  sReportCode: string;
  sWherePartForService: string;
  bAnyReportDataExists: boolean;
begin
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-06-...');

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

  if aServices[ServiceIndex].sNumber='199' then
    sWherePartForService:='LEFT(ddi,4)="1111"'
  else
    if aServices[ServiceIndex].sNumber='9910911' then
      sWherePartForService:='LEFT(ddi,4)="2222"'
    else
      sWherePartForService:='LEFT(ddi,'+IntToStr(Length(aServices[ServiceIndex].sNumber))+')="'+aServices[ServiceIndex].sNumber+'"';

  sReportCode:='���-06-'+aServices[ServiceIndex].sNumber+'-'+DatesDiffChar;

  LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

  // �������� ������ �������� � ���� ��������� ��������
  _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', 100);

  // ������������/����� ������� ������� irda
  Synchronize( procedure begin //
    if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, True, False) then Routines_GenerateError('��������� ������ � �������� ���������� ������ ������ �������� �������!', sErrorMessage, bError); end); //
  StepProgressBar; // 1

  if not bError then
    begin
      // ������������ � MySQL-�������, �� ������� ��������� ������� irda
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2

      if not bError then
        begin
          // �������� ��������� �������
          _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
            'CREATE TABLE IF NOT EXISTS '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_1 (' //
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
              // �������� ��������� �������
              _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
                'CREATE TABLE IF NOT EXISTS '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_2 (' //
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
                  // �������� ��������� �������
                  _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, //
                    'CREATE TABLE IF NOT EXISTS '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_3 (' //
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

                      for iRoutineCounter:=0 to aRegions_Count-1 do
                        if not bError then
                          begin
                            // ������� ������ � �������
                            _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                              'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_1 ' //
                              +'SELECT' //
                              +' "",' //
                              +' "'+aRegions[iRoutineCounter].sName+'" AS a,' //
                              +' COUNT(*),' //
                              +' SUM(dur),' //
                              +' "",' //
                              +' "" ' //
                              +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' ' //
                              +'WHERE (' //
                              +'(ani LIKE "80'+aRegions[iRoutineCounter].sPrefix+'%") OR ' //
                              +'(ani LIKE "00'+aRegions[iRoutineCounter].sPrefix+'%") OR ' //
                              +'(ani LIKE "0'+aRegions[iRoutineCounter].sPrefix+'%") OR ' //
                              +'(ani LIKE "375'+aRegions[iRoutineCounter].sPrefix+'%")' //
                              +') AND '+sWherePartForService //
                              +' AND (srv=0 OR srv=1) ' //
                              +'GROUP BY a;'); //
                            StepProgressBar; //

                            if not bError then
                              begin
                                // ������� ������ � �������
                                _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                                  'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_06_2 ' //
                                  +'SELECT' //
                                  +' "",' //
                                  +' "'+aRegions[iRoutineCounter].sName+'" AS a,' //
                                  +' "",' //
                                  +' "",' //
                                  +' COUNT(*),' //
                                  +' SUM(dur) ' //
                                  +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' ' //
                                  +'WHERE (' //
                                  +'(ani LIKE "80'+aRegions[iRoutineCounter].sPrefix+'%") OR ' //
                                  +'(ani LIKE "00'+aRegions[iRoutineCounter].sPrefix+'%") OR ' //
                                  +'(ani LIKE "0'+aRegions[iRoutineCounter].sPrefix+'%") OR ' //
                                  +'(ani LIKE "375'+aRegions[iRoutineCounter].sPrefix+'%")' //
                                  +') AND '+sWherePartForService //
                                  +' AND srv='+Routines_GetConditionalMessage(aServices[ServiceIndex].bAutoService, '1', '0') //
                                  +' AND v_mreza>""' //
                                  +Routines_GetConditionalMessage(aServices[ServiceIndex].bAutoService, '', ' AND v_oper>""') //
                                  +Routines_GetConditionalMessage(aServices[ServiceIndex].bAutoService, '', ' AND rm>0') //
                                  +' AND dur>0 ' //
                                  +'GROUP BY a;'); //
                                StepProgressBar; //
                              end;
                          end;





                      (*
                        if not bError then
                        begin
                        // ������� ������ � �������
                        _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, //
                        'INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_05_3 ' //
                        +'SELECT' //
                        +' "",' //
                        +' a.period,' //
                        +' a.call_quantity,' //
                        +' a.call_sumtime,' //
                        +' a.call_sumtime/a.call_quantity,' //
                        +' b.allowed_call_quantity,' //
                        +' b.allowed_call_sumtime,' //
                        +' b.allowed_call_sumtime/b.allowed_call_quantity,' //
                        +' (1-(b.allowed_call_quantity/a.call_quantity))*100 ' //
                        +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_05_1 AS a ' //
                        +'LEFT JOIN '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_05_2 AS b ' //
                        +'ON b.period=a.period ' //
                        +'ORDER BY a.sort_id;');
                        StepProgressBar; // 8

                        if not bError then
                        begin
                        // ������ ������������ ������ HTML-�����
                        sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
                        sHTML:=sHTML+'<HTML>'+#13#10;
                        sHTML:=sHTML+'  <HEAD>'+#13#10;
                        sHTML:=sHTML+'    <TITLE>���������� �� ������ ��� "'+aServices[ServiceIndex].sNumber+'" �� '+sReportPeriod+'</TITLE>'+#13#10;
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
                        '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
                        sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="150px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="105px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="115px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="105px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="115px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="*" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                        sHTML:=sHTML+'        </TR>'+#13#10;
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+
                        '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">����� � '
                        +sReportCode+'</TD>'+#13#10;
                        sHTML:=sHTML+
                        '          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
                        '���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
                        sHTML:=sHTML+'        </TR>'+#13#10;
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+'          <TD COLSPAN="6" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">���������� �� ������ &laquo;'+
                        aServices[ServiceIndex].sNumber+'&raquo;<BR>�� '+sReportPeriod+'</TD>'+#13#10;
                        sHTML:=sHTML+'        </TR>'+#13#10;

                        // ��������� ������ ��� ����� ������
                        LogThis('>> ����������� �������� ��������� ������ ��� ����� ������...', lmtDebug);
                        if not FConfiguration.StatServer.bConnected then
                        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                        else
                        begin
                        if mysql_ping(FConfiguration.StatServer.hConnection)<>0 then
                        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                        else
                        begin
                        q:='SELECT' //
                        +' period,' //
                        +' call_quantity,' //
                        +' call_sumtime,' //
                        +' allowed_call_quantity,' //
                        +' allowed_call_sumtime,' //
                        +' nonallowed_call_percent ' //
                        +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_05_3 ' //
                        +'ORDER BY sort_id;'; //
                        LogThis(q, lmtSQL);
                        if mysql_real_query(FConfiguration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                        Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                        else
                        begin
                        LogThis('������ �������� �������.', lmtDebug);
                        ResultSet:=mysql_store_result(FConfiguration.StatServer.hConnection);
                        if ResultSet=nil then
                        Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
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
                        bAnyReportDataExists:=True;
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">������'+sPeriodColumn+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����������<BR>�����������<BR>�������</TD>'+#13#10;
                        sHTML:=sHTML+
                        '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�����<BR>������������<BR>�����������<BR>�������, ���.</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����������<BR>�����������<BR>�������</TD>'+#13#10;
                        sHTML:=sHTML+
                        '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�����<BR>������������<BR>�����������<BR>�������, ���.</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������<BR>��<BR>������,<BR>%</TD>'+#13#10;
                        sHTML:=sHTML+'        </TR>'+#13#10;
                        for iRowCounter:=0 to iRowQuantity-1 do
                        if bError then
                        Break
                        else
                        begin
                        LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow=nil then
                        Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                        else
                        begin
                        LogThis('������ ��������� ������ �������� �������.', lmtDebug);
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                        'px 2px; border-color: black; padding: 1px 2px;">' //
                        +Routines_GetConditionalMessage(string(ResultRow[0])<>'', string(ResultRow[0]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                        'px 0px; border-color: black; padding: 1px 2px;">' //
                        +Routines_GetConditionalMessage(string(ResultRow[1])<>'', string(ResultRow[1]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                        'px 0px; border-color: black; padding: 1px 2px;">' //
                        +Routines_GetConditionalMessage(string(ResultRow[2])<>'', string(ResultRow[2]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                        'px 0px; border-color: black; padding: 1px 2px;">' //
                        +Routines_GetConditionalMessage(string(ResultRow[3])<>'', string(ResultRow[3]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                        'px 0px; border-color: black; padding: 1px 2px;">' //
                        +Routines_GetConditionalMessage(string(ResultRow[4])<>'', string(ResultRow[4]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '0', '1')+
                        'px 0px; border-color: black; padding: 1px 2px;">' //
                        +Routines_GetConditionalMessage(string(ResultRow[5])<>'', string(ResultRow[5]), '0.00')+'</TD>'+#13#10;
                        sHTML:=sHTML+'        </TR>'+#13#10;
                        end;
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
                        StepProgressBar; // 9

                        // ��������� �������� ������
                        if not bError then
                        begin
                        if bAnyReportDataExists then
                        begin
                        LogThis('>> ����������� �������� ��������� ������ ��� �������� ������...', lmtDebug);
                        if not FConfiguration.StatServer.bConnected then
                        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                        else
                        begin
                        if mysql_ping(FConfiguration.StatServer.hConnection)<>0 then
                        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                        else
                        begin
                        q:='SELECT' //
                        +' SUM(call_quantity),' //
                        +' SUM(call_sumtime),' //
                        +' SUM(allowed_call_quantity),' //
                        +' SUM(allowed_call_sumtime),' //
                        +' 100-((SUM(allowed_call_quantity)/SUM(call_quantity))*100) ' //
                        +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_05_3 ' //
                        +'GROUP BY "";'; //
                        LogThis(q, lmtSQL);
                        if mysql_real_query(FConfiguration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                        Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                        else
                        begin
                        LogThis('������ �������� �������.', lmtDebug);
                        ResultSet:=mysql_store_result(FConfiguration.StatServer.hConnection);
                        if ResultSet=nil then
                        Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                        else
                        begin
                        LogThis('�������������� ������� �������� �������.', lmtDebug);
                        iRoutineCounter:=mysql_num_rows(ResultSet);
                        LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', lmtDebug);
                        if iRoutineCounter<0 then
                        Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                        else
                        begin
                        if iRoutineCounter<>1 then
                        Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                        else
                        begin
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow=nil then
                        Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer),
                        sErrorMessage, bError)
                        else
                        begin
                        LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                        LogThis('������ ��� �������� ������ �������� �������.', lmtDebug);
                        // �������� ������ ������
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">�����:</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                        Routines_GetConditionalMessage(string(ResultRow[0])<>'', string(ResultRow[0]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                        Routines_GetConditionalMessage(string(ResultRow[1])<>'', string(ResultRow[1]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                        Routines_GetConditionalMessage(string(ResultRow[2])<>'', string(ResultRow[2]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                        Routines_GetConditionalMessage(string(ResultRow[3])<>'', string(ResultRow[3]), '0')+'</TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">'+
                        Routines_GetConditionalMessage(string(ResultRow[4])<>'', string(ResultRow[4]), '0.00')+'</TD>'+#13#10;
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
                        LogThis('<< ���������� �������� ��������� ������ ��� �������� ������ ���������.', lmtDebug);
                        StepProgressBar; // 10
                        end;

                        if not bError then
                        begin
                        sHTML:=sHTML+'        <TR>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                        sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
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
                        StepProgressBar; // 11
                        end;
                        end;
                        end;
                        end;
                      *)
                      end;
                    end;
                end;
            end;

          // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
          _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
          StepProgressBar; //

          // �������� ������ ���������
          if not bError then //
            begin
              Synchronize( procedure begin //
                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '���������� ��� �� ������ '+aServices[ServiceIndex].sNumber+' �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True)
              then Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); end); //
              StepProgressBar; //
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
