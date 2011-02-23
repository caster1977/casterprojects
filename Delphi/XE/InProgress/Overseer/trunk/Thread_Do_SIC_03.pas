unit Thread_Do_SIC_03;

interface

uses
  SysUtils,
  OverseerTypes,
  OverseerConsts,
  Windows,
  ComCtrls;

type
  TThread_Do_SIC_03=class(TThread_Do_SIC)
  private
    FNetIndex: integer;
  protected
    procedure Execute; override;
    property NetIndex: integer read FNetIndex write FNetIndex default -1;
  public
    constructor Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aNetIndex: integer);
  end;

implementation

uses
  Main,
  DateUtils,
  mysql,
  OverseerRoutines;

constructor TThread_Do_SIC_03.Create(const aLogGroupGUID: string; aStartDate, aStopDate: TDate; aOpenWithBrowser: boolean; aCurrentUser: TUserRec; aConfiguration: TConfigurationRec; aNetIndex: integer);
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
      NetIndex:=aNetIndex;
    end;
end;

procedure TThread_Do_SIC_03.Execute;
const
  LogGroupGUID: string='{F3595DC2-F8E9-476D-BBAD-54FEF2EBD937}';
var
  q, s, sErrorMessage: string;
  bError: boolean;
  i, j: integer;
  iRoutineCounter: integer;
  iRowCounter: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  sShortStartDate, sShortStopDate, sSQLFormatStartDate, sSQLFormatStopDate, sLongStartDate, sLongStopDate: string;
  iYear: integer;
  sHTML, sNet: string;
  sAbonentType: string;
  sReportPeriod: string;
  sReportCode: string;
  dtNow: TDateTime;
  sTableName: string;
  iNetIndex_In_aNets: integer;
  StatServer: TMySQLServerConnectionDetails;

  i109_DayCalls, i109_NightCalls, i188_Calls, i192_Calls, i195_Calls, i175_Calls, i175_Minutes, i190_Calls, i190_Minutes: integer;
  i191_Calls, i191_Minutes, i193_Calls, i193_Minutes, i194_Calls, i194_Minutes, i196_Calls, i196_Minutes, i197_Calls, i197_Minutes: integer;
  f109_DayTarif, f109_NightTarif, f188_Tarif, f192_Tarif, f195_Tarif, f175_Tarif, f190_Tarif, f191_Tarif, f193_Tarif, f194_Tarif, f196_Tarif, f197_Tarif: double;
begin
  // Header ���������
  ProcedureHeader('��������� ������������ ������ �� ����� � ���-03-...');

  // ����� ������ ������� ���������� ���������
  EnableTimer:=True;

  // ������������� �������� ����������
  bError:=False;
  sTableName:='';
  iNetIndex_In_aNets:=-1; // ���������� ����� (������) ��������� ���� � ������� �����
  i109_DayCalls:=0;
  f109_DayTarif:=-1;
  i109_NightCalls:=0;
  f109_NightTarif:=-1;
  i188_Calls:=0;
  f188_Tarif:=-1;
  i192_Calls:=0;
  f192_Tarif:=-1;
  i195_Calls:=0;
  f195_Tarif:=-1;
  i175_Calls:=0;
  i175_Minutes:=0;
  f175_Tarif:=-1;
  i190_Calls:=0;
  i190_Minutes:=0;
  f190_Tarif:=-1;
  i191_Calls:=0;
  i191_Minutes:=0;
  f191_Tarif:=-1;
  i193_Calls:=0;
  i193_Minutes:=0;
  f193_Tarif:=-1;
  i194_Calls:=0;
  i194_Minutes:=0;
  f194_Tarif:=-1;
  i196_Calls:=0;
  i196_Minutes:=0;
  f196_Tarif:=-1;
  i197_Calls:=0;
  i197_Minutes:=0;
  f197_Tarif:=-1;

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

  case NetIndex of
    0:
      begin
        sAbonentType:='���';
        f109_DayTarif:=USD_TARIF_MCS_109_DAY;
        f109_NightTarif:=USD_TARIF_MCS_109_NIGHT;
        f188_Tarif:=USD_TARIF_MCS_188;
        f192_Tarif:=USD_TARIF_MCS_192;
        f195_Tarif:=USD_TARIF_MCS_195;
        f175_Tarif:=USD_TARIF_MCS_175;
        f190_Tarif:=USD_TARIF_MCS_190;
        f191_Tarif:=USD_TARIF_MCS_191;
        f193_Tarif:=USD_TARIF_MCS_193;
        f194_Tarif:=USD_TARIF_MCS_194;
        f196_Tarif:=USD_TARIF_MCS_196;
        f197_Tarif:=USD_TARIF_MCS_197;
      end;
    1:
      begin
        sAbonentType:='���';
        f109_DayTarif:=USD_TARIF_MTS_109_DAY;
        f109_NightTarif:=USD_TARIF_MTS_109_NIGHT;
        f188_Tarif:=USD_TARIF_MTS_188;
        f192_Tarif:=USD_TARIF_MTS_192;
        f195_Tarif:=USD_TARIF_MTS_195;
        f175_Tarif:=USD_TARIF_MTS_175;
        f190_Tarif:=USD_TARIF_MTS_190;
        f191_Tarif:=USD_TARIF_MTS_191;
        f193_Tarif:=USD_TARIF_MTS_193;
        f194_Tarif:=USD_TARIF_MTS_194;
        f196_Tarif:=USD_TARIF_MTS_196;
        f197_Tarif:=USD_TARIF_MTS_197;
      end;
    2:
      begin
        sAbonentType:='����';
        f109_DayTarif:=USD_TARIF_BEST_109_DAY;
        f109_NightTarif:=USD_TARIF_BEST_109_NIGHT;
        f188_Tarif:=USD_TARIF_BEST_188;
        f192_Tarif:=USD_TARIF_BEST_192;
        f195_Tarif:=USD_TARIF_BEST_195;
        f175_Tarif:=USD_TARIF_BEST_175;
        f190_Tarif:=USD_TARIF_BEST_190;
        f191_Tarif:=USD_TARIF_BEST_191;
        f193_Tarif:=USD_TARIF_BEST_193;
        f194_Tarif:=USD_TARIF_BEST_194;
        f196_Tarif:=USD_TARIF_BEST_196;
        f197_Tarif:=USD_TARIF_BEST_197;
      end;
    3:
      begin
        sAbonentType:='������';
        f109_DayTarif:=USD_TARIF_BELSEL_109_DAY;
        f109_NightTarif:=USD_TARIF_BELSEL_109_NIGHT;
        f188_Tarif:=USD_TARIF_BELSEL_188;
        f192_Tarif:=USD_TARIF_BELSEL_192;
        f195_Tarif:=USD_TARIF_BELSEL_195;
        f175_Tarif:=USD_TARIF_BELSEL_175;
        f190_Tarif:=USD_TARIF_BELSEL_190;
        f191_Tarif:=USD_TARIF_BELSEL_191;
        f193_Tarif:=USD_TARIF_BELSEL_193;
        f194_Tarif:=USD_TARIF_BELSEL_194;
        f196_Tarif:=USD_TARIF_BELSEL_196;
        f197_Tarif:=USD_TARIF_BELSEL_197;
      end
  else
    Routines_GenerateError('��� ������������ ������ ������� ������������� ���������� ����!', sErrorMessage, bError);
  end;

  if not bError then
    begin
      sReportCode:='���-03-'+UpperCase(sAbonentType)+'-'+DatesDiffChar;

      LogThis('������ ������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'.', lmtInfo);

      // �������� ������ �������� � ���� ��������� ��������
      _CreateProgressBar(dtNow, '������������ ������ �� ����� � '+sReportCode+' �� '+sReportPeriod+'...', 14);
    end;

  // ���������� ��������������� ��������� ����������� ���� ������ � ������� �������� �����
  if not bError then
    begin
      for iRoutineCounter:=0 to aNets_Count-1 do
        begin
          if sAbonentType=aNets[iRoutineCounter].sName then
            begin
              iNetIndex_In_aNets:=iRoutineCounter;
              Break;
            end;
        end;
      if iNetIndex_In_aNets=-1 then
        Routines_GenerateError('�� ������ ����������� ��������� ���������� ���� �� ��������� �� ������� ���������� �����!', sErrorMessage, bError);
    end;

  if not bError then
    begin
      // ������������/����� ������� ������� irda
      Synchronize( procedure begin //
        if not MainForm.Do_CreateXRDA(StartDate, StopDate, True, XRDInput, sTableName, False, True, False) then //
        Routines_GenerateError('��������� ������ � �������� ���������� ������ ������ �������� �������!', sErrorMessage, bError); end); //
      StepProgressBar; // 1
    end;

  if not bError then
    begin
      // ����������� � MySQL-�������
      _MySQL_OpenConnection(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 2
    end;

  if not bError then
    begin
      // �������� ������� ������� � ���� ������
      _MySQL_CheckTableExistance(FConfiguration.StatServer, FConfiguration.StatServer.sMySQLDatabase_IRDA_Location, bError, sErrorMessage, sTableName);
      StepProgressBar; // 3
    end;

  if not bError then
    begin
      // ������������ �������
      _MySQL_LockTables(FConfiguration.StatServer, bError, sErrorMessage, FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' READ');
      StepProgressBar; // 4
    end;

  if not bError then
    begin
      // �������� ��������� �������
      q:='CREATE TEMPORARY TABLE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_03_1 (' //
      // +'ani char(32) NOT NULL default "",' //
        +' ddi char(32) NOT NULL default "",' //
      // +' datum date default NULL,' //
        +' vrijeme time default NULL,' //
        +' dur decimal(11,0) NOT NULL default "0",' //
      // +' srv decimal(3,0) NOT NULL default "0",' //
      // +' rm decimal(3,0) NOT NULL default "0",' //
      // +' izg decimal(3,0) NOT NULL default "0",' //
      // +' izgnum char(32) NOT NULL default "",' //
      // +' v_oper char(8) default NULL,' //
      // +' v_mreza char(8) default NULL,' //
      // +' KEY ani (ani),' //
      // +' KEY datum (datum),' //
        +' KEY ddi (ddi),' //
        +' KEY vrijeme (vrijeme)' //
        +') TYPE=MyISAM;'; //
      _MySQL_CreateTable(FConfiguration.StatServer, bError, sErrorMessage, q);
      StepProgressBar; // 5
    end;

  if not bError then
    begin
      // ������� ������ � �������
      q:='INSERT INTO '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
        +'SELECT' //
      // +' ani,' //
        +' ddi,' //
      // +' datum,' //
        +' vrijeme,' //
        +' dur ' //
      // +' srv,' //
      // +' rm,' //
      // +' izg,' //
      // +' izgnum,' //
      // +' v_oper,' //
      // +' v_mreza ' //
        +'FROM '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.'+sTableName+' ' //
        +'WHERE' //
        +' v_mreza>""' //
        +Routines_GetConditionalMessage(aNets[iNetIndex_In_aNets].sQuery>'', ' AND '+aNets[iNetIndex_In_aNets].sQuery, '');
      s:='';
      for iRoutineCounter:=0 to aServices_Count-1 do
        if aServices[iRoutineCounter].bUsedInReport_SIC_03 then
          begin
            if s>'' then
              s:=s+' OR ';
            if aServices[iRoutineCounter].sNumber='199' then
              s:=s+'(ddi LIKE "1111%" OR ddi LIKE "199'
            else
              if aServices[iRoutineCounter].sNumber='9910911' then
                s:=s+'(ddi LIKE "2222%" OR ddi LIKE "9910911'
              else
                s:=s+'(ddi LIKE "'+aServices[iRoutineCounter].sNumber;
            s:=s+'%" AND srv='+Routines_GetConditionalMessage(aServices[iRoutineCounter].bAutoService, '1', '0');
            if (aServices[iRoutineCounter].sNumber='130')or(aServices[iRoutineCounter].sNumber='2003498') then
              s:=s+' AND ((((vrijeme BETWEEN "08:30:00" AND "19:59:59") AND WEEKDAY(datum) IN(0,1,2,3,4)) OR ((vrijeme BETWEEN "09:00:00" AND "14:59:59") AND WEEKDAY(datum)=5)))';
            s:=s+')';
          end;
      if s>'' then
        s:=' AND ('+s+')';
      q:=q+s+';';
      _MySQL_InsertRecords(FConfiguration.StatServer, bError, sErrorMessage, q);
      StepProgressBar; // 6
    end;

  if not bError then
    begin
      // ��������������� ������
      _MySQL_UnlockTables(FConfiguration.StatServer, bError, sErrorMessage);
      StepProgressBar; // 7
    end;

  if not bError then
    begin
      // ���� ������ ���� ddi � �������
      for iRoutineCounter:=0 to aServices_Count-1 do
        if bError then
          Break
        else
          begin
            _MySQL_UpdateRecords(FConfiguration.StatServer, bError, sErrorMessage, //
              'UPDATE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
              +'SET ddi="'+aServices[iRoutineCounter].sNumber+'" ' //
              +'WHERE LEFT(ddi,'+IntToStr(Length(aServices[iRoutineCounter].sNumber))+')="'+aServices[iRoutineCounter].sNumber+'";'); //
          end;
      StepProgressBar; // 8
    end;

  if not bError then
    begin
      // ���� ������ ���� ddi � �������
      _MySQL_UpdateRecords(FConfiguration.StatServer, bError, sErrorMessage, //
        'UPDATE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
        +'SET ddi="199" ' //
        +'WHERE LEFT(ddi,4)="1111";'); //
      StepProgressBar; // 9
    end;

  if not bError then
    begin
      // ���� ������ ���� ddi � �������
      _MySQL_UpdateRecords(FConfiguration.StatServer, bError, sErrorMessage, //
        'UPDATE '+FConfiguration.StatServer.sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
        +'SET ddi="9910911" ' //
        +'WHERE LEFT(ddi,4)="2222";'); //
      StepProgressBar; // 10
    end;

  // ��������� ������ �� ��
  if not bError then
    with FConfiguration.StatServer do
      begin
        LogThis('>> ����������� �������� ��������� ������ �� ������� ���� ������...', lmtDebug);
        if not bConnected then
          Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
        else
          begin
            if mysql_ping(hConnection)<>0 then
              Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
            else
              begin
                q:='SELECT' //
                  +' "109d" AS ddi,' // ������� ������ 109
                  +' COUNT(*),' //
                // +' SUM(CEILING(dur/60)),' //
                  +' CEILING(SUM(dur)/60) ' //
                  +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
                  +'WHERE' //
                  +' ddi="109" AND' //
                  +' vrijeme BETWEEN "06:00:00" AND "21:59:59" ' //
                  +'GROUP BY "" ' //
                  +'UNION ' //

                  +'SELECT' //
                  +' "109n" AS ddi,' // ������ ������ 109
                  +' COUNT(*),' //
                // +' SUM(CEILING(dur/60)),' //
                  +' CEILING(SUM(dur)/60) ' //
                  +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
                  +'WHERE' //
                  +' ddi="109" AND' //
                  +' ((vrijeme BETWEEN "22:00:00" AND "23:59:59") OR (vrijeme BETWEEN "00:00:00" AND "05:59:59")) ' //
                  +'GROUP BY "" ' //
                  +'UNION ' //

                  +'SELECT' //
                  +' ddi,' // ��� ���������� ������ ��� ����� ������� �����
                  +' COUNT(*),' //
                // +' SUM(CEILING(dur/60)),' //
                  +' CEILING(SUM(dur)/60) ' //
                  +'FROM '+sMySQLDatabase_IRDA_Location+'.tmp_03_1 ' //
                  +'WHERE' //
                  +' ddi IN("188","192","195","175","190","191","193","194","196","197") ' //
                  +'GROUP BY ddi ' //
                  +'ORDER BY ddi;'; //
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
                        iRowCounter:=mysql_num_rows(ResultSet);
                        LogThis('���������� ����� ������� ����� '+IntToStr(iRowCounter)+'.', lmtDebug);
                        if iRowCounter<0 then
                          Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                        else
                          begin
                            for j:=0 to iRowCounter-1 do
                              if bError then
                                Break
                              else
                                begin
                                  LogThis('��������� ��������� ������ ������� ('+IntToStr(j)+').', lmtDebug);
                                  ResultRow:=mysql_fetch_row(ResultSet);
                                  if ResultRow=nil then
                                    Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(j)+')!'+Routines_GetMySQLErrorInfo(FConfiguration.StatServer), sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(j)+') ������ �������.', lmtDebug);
                                      if string(ResultRow[0])='109d' then
                                        i109_DayCalls:=StrToIntDef(string(ResultRow[1]), -1);
                                      if string(ResultRow[0])='109n' then
                                        i109_NightCalls:=StrToIntDef(string(ResultRow[1]), -1);
                                      if string(ResultRow[0])='188' then
                                        i188_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                      if string(ResultRow[0])='192' then
                                        i192_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                      if string(ResultRow[0])='195' then
                                        i195_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                      if string(ResultRow[0])='175' then
                                        begin
                                          i175_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i175_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
                                        end;
                                      if string(ResultRow[0])='190' then
                                        begin
                                          i190_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i190_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
                                        end;
                                      if string(ResultRow[0])='191' then
                                        begin
                                          i191_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i191_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
                                        end;
                                      if string(ResultRow[0])='193' then
                                        begin
                                          i193_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i193_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
                                        end;
                                      if string(ResultRow[0])='194' then
                                        begin
                                          i194_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i194_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
                                        end;
                                      if string(ResultRow[0])='196' then
                                        begin
                                          i196_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i196_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
                                        end;
                                      if string(ResultRow[0])='197' then
                                        begin
                                          i197_Calls:=StrToIntDef(string(ResultRow[1]), -1);
                                          i197_Minutes:=StrToIntDef(string(ResultRow[2]), -1);
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
        LogThis('<< ���������� �������� ��������� ������ ������� ���� ������ ���������.', lmtDebug);
        StepProgressBar; // 11
      end;

  // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
  _MySQL_CloseConnection(FConfiguration.StatServer, bError, sErrorMessage);
  StepProgressBar; // 12

  if not bError then
    begin
      // ������������ ������ HTML-�����
      sHTML:=sHTML+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'+#13#10;
      sHTML:=sHTML+'<HTML>'+#13#10;
      sHTML:=sHTML+'  <HEAD>'+#13#10;
      sHTML:=sHTML+'    <TITLE>�������� � �������� ������� � ���� ��� "����������" �� ������� ���������� ������ �� ���� '+
        StringReplace(StringReplace(StringReplace(aNets[iNetIndex_In_aNets].sHTMLMobileNetName, '&laquo;', '"', [rfReplaceAll]), '&raquo;', '"', [rfReplaceAll]), '&nbsp;', ' ', [rfReplaceAll])+' �� '+sReportPeriod+' [����� � '+sReportCode+
        ']</TITLE>'+#13#10;
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
      sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
      // border-spacing: 0px;
      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="95px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="135px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="135px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="135px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="135px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="135px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="135px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="95px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+
        '          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; font-weight: bold; border-width: 0px 0px 1px 0px; font-size: 10pt; text-align: left;">����� � '+
        sReportCode+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">'+
        '���������-�������������� ���<BR>������� &laquo;������� ��������� ���������� ����&raquo;<BR>��� &laquo;����������&raquo;</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="8" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 0px 0px;">'+
        '��������&nbsp;�&nbsp;��������&nbsp;������� �&nbsp;����&nbsp;���&nbsp;&laquo;����������&raquo; ��&nbsp;�������&nbsp;����������&nbsp;������ ��&nbsp;����&nbsp;'+aNets[iNetIndex_In_aNets].sHTMLMobileNetName+
        '&nbsp;��&nbsp;������&nbsp;���&nbsp;��&nbsp;'+sReportPeriod+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="8" STYLE="border-color: white; border-width: 0; text-align: left; font-size: 9pt; font-weight: bold; padding: 20px 0px 10px 0px;">1. ������ �� �������� �������������� �� ���� �����������</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD ROWSPAN="2" STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">������</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 1px 0px; border-color: black; font-weight: bold; padding: 2px;">���������� ����������</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 2px 2px 1px 0px; border-color: black; font-weight: bold; padding: 2px;">�����, ������� ���</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="3" STYLE="text-align: center; border-width: 2px 2px 1px 0px; border-color: black; font-weight: bold; padding: 2px;">�����, ������� ���</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� �����*</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������ �����**</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� �����*</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������ �����**</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������� �����*</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">������ �����**</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�����</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">I</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">II</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">III</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">IV</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">V</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">VI<BR><FONT STYLE="font-size: 6pt; font-weight: normal;">(��. II * ��. IV)</FONT></TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">VII<BR><FONT STYLE="font-size: 6pt; font-weight: normal;">(��. III * ��. V)</FONT></TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">VIII<BR><FONT STYLE="font-size: 6pt; font-weight: normal;">(��. VI + ��. VII)</FONT></TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">109</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i109_DayCalls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i109_NightCalls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f109_DayTarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f109_NightTarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i109_DayCalls*f109_DayTarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 1px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i109_NightCalls*f109_NightTarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i109_DayCalls*f109_DayTarif+i109_NightCalls*f109_NightTarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">188</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i188_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f188_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 1px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i188_Calls*f188_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i188_Calls*f188_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">192</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i192_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f192_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 1px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i192_Calls*f192_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i192_Calls*f192_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; padding: 2px;">195</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+IntToStr(i195_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f195_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="2" STYLE="text-align: center; border-width: 0px 1px 2px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i195_Calls*f195_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i195_Calls*f195_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'      </TBODY>'+#13#10;
      sHTML:=sHTML+'    </TABLE>'+#13#10;

      sHTML:=sHTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="1000" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
      // border-spacing: 0px;
      sHTML:=sHTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="200px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="200px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="200px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="200px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'          <TD HEIGHT="1px" WIDTH="200px" STYLE="border-color: white; border-width: 0;"></TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: left; font-size: 9pt; font-weight: bold; padding: 20px 0px 10px 0px;">2. ������ �� �������� �������������� �� ������</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">������</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">���������� ����������</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">����������������� ����������, �����</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�����, �������� ���</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">�����, ������� ���</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;">I</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">II</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">III</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">IV</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;">V<BR><FONT STYLE="font-size: 6pt; font-weight: normal;">(��. III * ��. IV)</FONT></TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">175</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i175_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i175_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f175_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i175_Minutes*f175_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">190</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i190_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i190_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f190_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i190_Minutes*f190_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">191</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i191_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i191_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f191_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i191_Minutes*f191_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">193</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i193_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i193_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f193_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i193_Minutes*f193_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">194</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i194_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i194_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f194_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i194_Minutes*f194_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 2px; border-color: black; padding: 2px;">196</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i196_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+IntToStr(i196_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f196_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 1px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i196_Minutes*f196_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; padding: 2px;">197</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+IntToStr(i197_Calls)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+IntToStr(i197_Minutes)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', f197_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 2px;">'+FormatFloat('#0.##########', i197_Minutes*f197_Tarif)+'</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; font-size: 9pt; font-weight: bold; padding: 20px 0px 0px 0px;">����� � ������ ��� &laquo;����������&raquo;:</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="border-color: white; border-width: 0; text-align: right; font-size: 9pt; font-weight: bold; padding: 20px 0px 0px 0px;">'+
        FormatFloat('#0.##########', i109_DayCalls*f109_DayTarif+i109_NightCalls*f109_NightTarif+i188_Calls*f188_Tarif+i192_Calls*f192_Tarif+i195_Calls*f195_Tarif+i175_Minutes*f175_Tarif+i190_Minutes*f190_Tarif+i191_Minutes*f191_Tarif+i193_Minutes*
        f193_Tarif+i194_Minutes*f194_Tarif+i196_Minutes*f196_Tarif+i197_Minutes*f197_Tarif)+' ����. ���</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; font-size: 9pt; padding: 0px;">���� ������� ��� �� '+sLongStopDate+':</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="border-color: white; border-width: 0; text-align: right; font-size: 9pt; padding: 0px;">���. ���.</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: left; font-size: 9pt; padding: 0px;">���������� � ����������� ������:</TD>'+#13#10;
      sHTML:=sHTML+'          <TD STYLE="border-color: white; border-width: 0; text-align: right; font-size: 9pt; padding: 0px;">���. ���.</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      sHTML:=sHTML+'          <TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: left; font-size: 7pt; font-style: italic; padding: 20px 0px 10px 0px;">'+
        '����������:<BR>*: ���������� �������� ����� � 06<SUP>00</SUP> �� 21<SUP>59</SUP> (������ ��� ���������-�������������� ������ &laquo;109&raquo;)'+
        '<BR>**: ���������� �������� ����� � 21<SUP>00</SUP> �� 05<SUP>59</SUP> (������ ��� ���������-�������������� ������ &laquo;109&raquo;)</TD>'+#13#10;
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'        <TR>'+#13#10;
      dtNow:=Now;
      sHTML:=sHTML+'           <TD COLSPAN="5" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; ' //
        +'border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">' //
        +'����� ����������� '+IntToStr(DayOf(dtNow))+' '+saMonths2[MonthOf(dtNow)]+' '+IntToStr(YearOf(dtNow))+' ���� � '+FormatDateTime('hh:nn:ss', dtNow) //
        +' ��� ������ ������������ ��������� &laquo;OVERSEER&raquo;, &copy;&nbsp;2009-2010&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10; //
      sHTML:=sHTML+'        </TR>'+#13#10;
      sHTML:=sHTML+'      </TBODY>'+#13#10;
      sHTML:=sHTML+'    </TABLE>'+#13#10;
      sHTML:=sHTML+'    </CENTER>'+#13#10;
      sHTML:=sHTML+'  </BODY>'+#13#10;
      sHTML:=sHTML+'</HTML>'+#13#10;
      // _LogThis(sHTML, lmtDebug);
      StepProgressBar; // 13
    end;

  if not bError then //
    begin
      Synchronize( procedure begin //
        if not MainForm.Do_SaveReportAsHTMLAndOpen(sHTML, '�������� � �������� ������� � ���� ��� ���������� �� ������� ���������� ������ �� ���� '+StringReplace(StringReplace(StringReplace(sNet, '&laquo;', '', [rfReplaceAll]), '&raquo;', '',
        [rfReplaceAll]), '&nbsp;', ' ', [rfReplaceAll])+' �� '+sReportPeriod+' [����� � '+sReportCode+'].htm', OpenWithBrowser, True) then //
        Routines_GenerateError('��������� ������ �� ��������� ������� ���������� � �������� ������!', sErrorMessage, bError); end); //
      StepProgressBar; // 14
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
