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
  mysql,
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
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-01-...');

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

  sReportCode:='���-01-'+Routines_GetConditionalMessage(ShowUnserved, '�', '�')+'-'+DatesDiffChar;

  LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

  // �������� ������ �������� � ���� ��������� ��������
  _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', 11);

  if not bError then
    begin
      if PhonesList.Count<=0 then
        Routines_GenerateError('�� ������ �� ������ ������������ ������ �������� ��� ������������ ������!', sErrorMessage, bError);

      if not bError then
        begin
          // ������������/����� ������� ������� irda
          Synchronize( procedure begin //
            if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, False, False) then Routines_GenerateError('��������� ������ � �������� ���������� ������ ������ �������� �������!', sErrorMessage, bError); end); //
          StepProgressBar; // 1

          if not bError then
            begin
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

                // ����������� � MySQL-�������, �� ������� ��������� ������� ird
                _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
                StepProgressBar; // 2

                if not bError then
                  begin
                    // �������� ��������� �������
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
                              // �������� ������� ��������� ������� � ������� � ���� ������
                              _MySQL_CheckTableExistance(Self.Configuration.StatServer, Self.Configuration.StatServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, LowerCase(slIRDFullList[iFullListCounter]));

                              if not bError then
                                begin
                                  // ������������ �������
                                  _MySQL_LockTables(Self.Configuration.StatServer, bError, sErrorMessage, Self.Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' READ');

                                  if not bError then
                                    begin
                                      // ������� ������ � �������
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

                                      // ��������������� ������
                                      if not bError then
                                        _MySQL_UnlockTables(Self.Configuration.StatServer, bError, sErrorMessage);
                                    end;
                                end;
                            end;
                        StepProgressBar; // 4

                        if not bError then
                          begin
                            // ���� ������ ���� ddi � �������
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
                                // ���� ������ ���� ddi � �������
                                _MySQL_UpdateRecords(Self.Configuration.StatServer, bError, sErrorMessage, //
                                  'UPDATE '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                  +'SET ddi="199" ' //
                                  +'WHERE LEFT(ddi,4)="1111";'); //
                                StepProgressBar; // 6

                                if not bError then
                                  begin
                                    // ���� ������ ���� ddi � �������
                                    _MySQL_UpdateRecords(Self.Configuration.StatServer, bError, sErrorMessage, //
                                      'UPDATE '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                      +'SET ddi="9910911" ' //
                                      +'WHERE LEFT(ddi,4)="2222";'); //
                                    StepProgressBar; // 7

                                    if not bError then
                                      begin
                                        // ������ ������������ ������ HTML-�����
                                        sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
                                        sHTML:=sHTML+'<HTML>'+#13#10;
                                        sHTML:=sHTML+'  <HEAD>'+#13#10;
                                        sHTML:=sHTML+'    <TITLE>���������� ������� � ��������� ����������� ������� �� ��������������� ��� ������ �� '+sReportPeriod+'</TITLE>'+#13#10;
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
                                          '    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'
                                          +#13#10;
                                        sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
                                        sHTML:=sHTML+'        <TR>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="100px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="*" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="80px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
                                        sHTML:=sHTML+'        </TR>'+#13#10;
                                        sHTML:=sHTML+'        <TR>'+#13#10;
                                        sHTML:=sHTML+
                                          '          <TD COLSPAN="2" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; font-weight: bold; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">����� � '
                                          +sReportCode+'</TD>'+#13#10;
                                        sHTML:=sHTML+
                                          '          <TD COLSPAN="5" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'
                                          +'���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
                                        sHTML:=sHTML+'        </TR>'+#13#10;
                                        sHTML:=sHTML+'        <TR>'+#13#10;
                                        sHTML:=sHTML+
                                          '          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">���������� ������� � ��������� ����������� �������<BR>�� ��������������� ��� ������<BR>�� '
                                          +sReportPeriod+'</TD>'+#13#10;
                                        sHTML:=sHTML+'        </TR>'+#13#10;

                                        // ��������� ������ �� ������� ���������� �������� �� ��������� ������� � ������������ ������ ������
                                        for iPhonesCounter:=0 to PhonesList.Count-1 do
                                          if bError then
                                            Break
                                          else
                                            begin
                                              LogThis('>> ����������� �������� ��������� ������ �� ������� � ������ �������� "'+PhonesList[iPhonesCounter]+'" �� ��������� �������...', lmtDebug);
                                              if not Self.Configuration.StatServer.bConnected then
                                                Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                              else
                                                begin
                                                  if mysql_ping(Self.Configuration.StatServer.hConnection)<>0 then
                                                    Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
                                                  else
                                                    begin
                                                      q:='SELECT ani, ddi, datum, vrijeme, v_mreza, dur ' //
                                                        +'FROM '+Self.Configuration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_01 ' //
                                                        +'WHERE ani LIKE "%'+PhonesList[iPhonesCounter]+'" '+Routines_GetConditionalMessage(ShowUnserved, '', 'AND v_mreza>"" ') //
                                                        +'ORDER BY datum, vrijeme;'; //
                                                      LogThis(q, lmtSQL);
                                                      if mysql_real_query(Self.Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                        Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
                                                      else
                                                        begin
                                                          LogThis('������ �������� �������.', lmtDebug);
                                                          ResultSet:=mysql_store_result(Self.Configuration.StatServer.hConnection);
                                                          if ResultSet=nil then
                                                            Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
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
                                                                  sHTML:=sHTML+'        <TR>'+#13#10;
                                                                  sHTML:=sHTML+'          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: left; font-weight: bold; padding: 20px 0px 3px 0px;">'+IntToStr(iPhonesCounter+1)+
                                                                    '. ���������� ������� � ������ �������� '+Trim(PhonesList[iPhonesCounter])+':</TD>'+#13#10;
                                                                  sHTML:=sHTML+'        </TR>'+#13#10;
                                                                  if iRowQuantity>0 then
                                                                    begin
                                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                                      sHTML:=sHTML+
                                                                        '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">����� ��������<BR>��������</TD>'+#13#10;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������</TD>'+#13#10;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������������ ������</TD>'+#13#10;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">���� ������</TD>'+#13#10;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������</TD>'+#13#10;
                                                                      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����� ������<BR>���������</TD>'+#13#10;
                                                                      sHTML:=sHTML+
                                                                        '          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������������<BR>����������, ���.</TD>'+#13#10;
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
                                                                                Routines_GetMySQLErrorInfo(Self.Configuration.StatServer), sErrorMessage, bError)
                                                                            else
                                                                              begin
                                                                                LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', lmtDebug);
                                                                                sServiceName:=string(ResultRow[1]);
                                                                                for iRoutineCounter:=0 to aServices_Count-1 do
                                                                                if sServiceName=aServices[iRoutineCounter].sNumber then
                                                                                begin
                                                                                sServiceName:=aServices[iRoutineCounter].sName;
                                                                                Break;
                                                                                end;

                                                                                sHTML:=sHTML+'        <TR>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 2px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[0])='', '-', string(ResultRow[0]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[1])='', '-', string(ResultRow[1]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(sServiceName=string(ResultRow[1]), '��������������� ����� ���', sServiceName)+
                                                                                '</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[2])='', '-', string(ResultRow[2]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[3])='', '-', string(ResultRow[3]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[4])='', '-', string(ResultRow[4]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+Routines_GetConditionalMessage(iRowCounter=(iRowQuantity-1), '2', '1')+
                                                                                'px 0px; border-color: black; padding: 1px 2px;">'+Routines_GetConditionalMessage(string(ResultRow[5])='', '-', string(ResultRow[5]))+'</TD>'+#13#10;
                                                                                sHTML:=sHTML+'        </TR>'+#13#10;
                                                                              end;
                                                                          end;
                                                                    end
                                                                  else
                                                                    begin
                                                                      sHTML:=sHTML+'        <TR>'+#13#10;
                                                                      sHTML:=sHTML+
                                                                        '          <TD COLSPAN="7" STYLE="border-color: white; border-width: 0; text-align: left; padding: 0px;">�� ������� �� ������ ������ �� ������ ������ �������.</TD>'+#13#10;
                                                                      sHTML:=sHTML+'        </TR>'+#13#10;
                                                                    end;
                                                                end;
                                                              mysql_free_result(ResultSet);
                                                              LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                              LogThis('<< ���������� �������� ��������� ������ �� ������� � ������ �������� "'+PhonesList[iPhonesCounter]+'" �� ��������� ������� ���������.', lmtDebug);
                                            end;
                                        StepProgressBar; // 8

                                        if not bError then
                                          begin
                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'          <TD STYLE="text-align:  right; border-width: 0px; border-color: white; padding: 1px 2px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'        </TR>'+#13#10;
                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                            sHTML:=sHTML+'          <TD VALIGN="TOP" COLSPAN="7" STYLE="text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;">�����������:<BR>'+Self.CurrentUser.sPosition+'<BR>'+
                                              Self.CurrentUser.sFullName+'<BR>'+Self.CurrentUser.sContactPhone+'</TD>'+#13#10;
                                            sHTML:=sHTML+'        </TR>'+#13#10;
                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                            sHTML:=sHTML+'           <TD COLSPAN="7" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                                            sHTML:=sHTML+'        </TR>'+#13#10;
                                            sHTML:=sHTML+'        <TR>'+#13#10;
                                            dtNow:=Now;
                                            sHTML:=sHTML+
                                              '           <TD COLSPAN="7" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">'
                                              +'����� ����������� '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' ���� � '+FormatDateTime('hh:nn:ss', dtNow)+
                                              ' ��� ������ ������������ ��������� &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
                                            sHTML:=sHTML+'        </TR>'+#13#10;
                                            sHTML:=sHTML+'      </TBODY>'+#13#10;
                                            sHTML:=sHTML+'    </TABLE>'+#13#10;
                                            sHTML:=sHTML+'    </CENTER>'+#13#10;
                                            sHTML:=sHTML+'  </BODY>'+#13#10;
                                            sHTML:=sHTML+'</HTML>'+#13#10;
                                            // _LogThis(sHTML, lmtDebug);
                                            StepProgressBar; // 9
                                          end;
                                      end;
                                  end;
                              end;
                          end;
                      end;
                  end;

                // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
                StepProgressBar; // 10

                if not bError then //
                  begin
                    Synchronize( procedure begin //
                      if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '���������� ������� � ��������� ����������� ������� �� ��������������� ��� ������ �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True) then //
                      Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); end); //
                    StepProgressBar; // 11
                  end;
              finally
                slIRDFullList.Free;
              end;
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
