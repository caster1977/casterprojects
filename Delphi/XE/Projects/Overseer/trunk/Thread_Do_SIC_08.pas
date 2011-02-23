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
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-08-...');

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

  sReportCode:='���-08-'+DatesDiffChar;

  LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

  slIRDFullList:=TStringList.Create;
  try
    // �������� ������ ��� �������� ������ ������
    LogThis('>> ����������� �������� ����������� ������ ������ �������� �������...', lmtDebug);
    dtDate:=StartDate;
    repeat
      slIRDFullList.Add('ird_'+FormatDateTime('yyyymmdd', dtDate));
      dtDate:=IncDay(dtDate, 1);
    until dtDate>StopDate;
    LogThis('��������� ���������� ����� ������ ������ ������ ����� '+IntToStr(slIRDFullList.Count)+'.', lmtDebug);
    LogThis('<< ���������� �������� ����������� ������ ������ �������� ������� ���������.', lmtDebug);

    // �������� ������ �������� � ���� ��������� ��������
    _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', (slIRDFullList.Count*4)+5);

    // ����� ���� ������ ird
    Synchronize( procedure begin //
      if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, False, False) then Routines_GenerateError('��������� ������ � �������� ���������� ������ ������ �������� �������!', sErrorMessage, bError); end); //
    StepProgressBar; // 1

    with FConfiguration, FConfiguration.StatServer do
      if not bError then
        begin
          sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
          sHTML:=sHTML+'<HTML>'+#13#10;
          sHTML:=sHTML+'  <HEAD>'+#13#10;
          sHTML:=sHTML+'    <TITLE>���������� ������� �������������� �� ������ Content Provider �� '+sReportPeriod+'</TITLE>'+#13#10;
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
          sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
          sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
          sHTML:=sHTML+'        <TR>'+#13#10;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
          sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="164px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;
          sHTML:=sHTML+'        <TR>'+#13#10;
          sHTML:=sHTML+
            '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left; font-weight: bold;">����� � '+
            sReportCode+'</TD>'+#13#10;
          sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
            '���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;
          sHTML:=sHTML+'        <TR>'+#13#10;
          sHTML:=sHTML+
            '          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">���������� ������� ��������������<BR>�� ������ &laquo;Content Provider&raquo;<BR>�� '
            +sReportPeriod+'</TD>'+#13#10;
          sHTML:=sHTML+'        </TR>'+#13#10;

          // ������������ � MySQL-�������, �� ������� ��������� ������� ird
          _MySQL_OpenConnection(StatServer, bError, sErrorMessage);
          StepProgressBar; // 2

          if not bError then
            begin
              // >>> ���� �������� ������ ������ � ����������� ����� ������
              for iFullListCounter:=0 to slIRDFullList.Count-1 do
                if bError then
                  Break
                else
                  begin
                    // �������� ������� ��������� ������� � ������� � ���� ������
                    _MySQL_CheckTableExistance(StatServer, sMySQLDatabase_IRD_Location, bError, sErrorMessage, LowerCase(slIRDFullList[iFullListCounter]));
                    StepProgressBar; // 3-1

                    if not bError then
                      begin
                        // ������������ �������
                        _MySQL_LockTables(StatServer, bError, sErrorMessage, sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' READ');
                        StepProgressBar; // 3-2

                        // ��������� ������
                        if not bError then
                          begin
                            LogThis('>> ����������� �������� ��������� ������ �� ������� '+LowerCase(slIRDFullList[iFullListCounter])+'...', lmtDebug);
                            if not bConnected then
                              Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(hConnection)<>0 then
                                  Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
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
                                      Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('������ �������� �������.', lmtDebug);
                                        ResultSet:=mysql_store_result(hConnection);
                                        if ResultSet=nil then
                                          Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(StatServer), sErrorMessage, bError)
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
                                                    // ����� ������� ������� ������� ��������� ����� �������
                                                    if not bAnyReportDataExists then
                                                      begin
                                                        sHTML:=sHTML+'        <TR>'+#13#10;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">����� ��������</TD>'+#13#10;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">���� ������</TD>'+#13#10;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������</TD>'+#13#10;
                                                        sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������������ ������</TD>'+#13#10;
                                                        sHTML:=sHTML+'        </TR>'+#13#10;
                                                      end;
                                                    bAnyReportDataExists:=True;
                                                    for iRowCounter:=0 to iRowQuantity-1 do
                                                      if bError then
                                                        Break
                                                      else
                                                        begin
                                                          LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', lmtDebug);
                                                          ResultRow:=mysql_fetch_row(ResultSet);
                                                          if ResultRow=nil then
                                                            Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!'+Routines_GetMySQLErrorInfo(StatServer),
                                                              sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                              sHTML:=sHTML+'        <TR>'+#13#10;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 2px; border-color: black; padding: 1px 2px;">'+string(ResultRow[0])+'</TD>'+#13#10;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[1])+'</TD>'+#13#10;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[2])+'</TD>'+#13#10;
                                                              sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                'px 0px; border-color: black; padding: 1px 2px;">'+string(ResultRow[3])+'</TD>'+#13#10;
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
                              end;
                            LogThis('<< ���������� �������� ��������� ������ �� ������� '+LowerCase(slIRDFullList[iFullListCounter])+' ���������.', lmtDebug);
                            StepProgressBar; // 3-3

                            if not bError then
                              begin
                                // ��������������� ������
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
                      sHTML:=sHTML+'        <TR>'+#13#10;
                      sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">�� ������� ������ �� ��������� ������ �������.</TD>'+#13#10;
                      sHTML:=sHTML+'        </TR>'+#13#10;
                    end;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+#13#10;
                  sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;">'+'</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'          <TD COLSPAN="4" VALIGN="TOP" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;">�����������:<BR>'+Self.CurrentUser.sPosition+'<BR>'+Self.CurrentUser.sFullName+
                    '<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  sHTML:=sHTML+'           <TD COLSPAN="4" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'        <TR>'+#13#10;
                  dtNow:=Now;
                  sHTML:=sHTML+
                    '           <TD COLSPAN="4" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                    +'����� ����������� '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' ���� � '+FormatDateTime('hh:nn:ss', dtNow)+
                    ' ��� ������ ������������ ��������� &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
                  sHTML:=sHTML+'        </TR>'+#13#10;
                  sHTML:=sHTML+'      </TBODY>'+#13#10;
                  sHTML:=sHTML+'    </TABLE>'+#13#10;
                  sHTML:=sHTML+'    </CENTER>'+#13#10;
                  sHTML:=sHTML+'  </BODY>'+#13#10;
                  sHTML:=sHTML+'</HTML>'+#13#10;
                  // _LogThis(sHTML, lmtDebug);
                  StepProgressBar; // 4
                end;
            end;

          // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
          _MySQL_CloseConnection(StatServer, bError, sErrorMessage);
          StepProgressBar; // 5

          // �������� ������ ���������
          if not bError then //
            begin
              Synchronize( procedure begin //
                if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '���������� ������� �������������� �� ������ Content Provider �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True)
              then Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); end); //
              StepProgressBar; // 6
            end;

        end;
  finally
    slIRDFullList.Free;
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
