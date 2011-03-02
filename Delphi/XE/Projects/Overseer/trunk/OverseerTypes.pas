unit OverseerTypes;

interface

uses
  Classes,
  SysUtils,
  mysql,
  ComCtrls;

type
  tXRD=(XRDInput, XRDOutput);
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug); // ���� ��������� ������������ � ���
  TReportFolders=(rfTempFolder, rfApplicationFolder, rfCustomFolder);
  tTTI=(TTI_NONE, TTI_INFO, TTI_WARNING, TTI_ERROR);
  TGroupByPeriod=(gbpNone, gbpHours, gbpDays, gbpWeeks, gbpMonths, gbpQuarters, gbpYears);

  trService=record
    sNumber: string;
    sName: string;
    bAutoService: boolean;
    bUsedInReport_SIC_03: boolean;
  end;

  trNet=record
    sName: string;
    sHTMLMobileNetName: string;
    sHTMLAbonentsName: string;
    sQuery: string;
  end;

  trIRDTableRecord=record
    ani: string;
    ddi: string;
    datum: string;
    vrijeme: string;
    dur: string;
    rm: string;
    izg: string;
    izgnum: string;
    v_oper: string;
    v_mreza: string;
  end;

  TUserRec=record
    sID: string;
    sLogin: string;
    sPassword: string;
    sFullName: string;
    sPosition: string;
    sContactPhone: string;
    bIsAdmin: boolean;
    bLogged: boolean;
  end;

  TMySQLServerConnectionDetails=record
    bConnected: boolean;
    hConnection: PMYSQL;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
    sMySQLDatabase_IRD_Location, sMySQLDatabase_ORD_Location, sMySQLDatabase_IRDA_Location, sMySQLDatabase_ORDA_Location, sMySQLDatabase_PRIJAVE_Location, sMySQLDatabase_PRIJAVE_Q_Location, sMySQLDatabase_T_DAY_Location: string;
  end;

  TConfigurationRec=record
    OverseerServer, DBServer, StatServer, RNE4Server: TMySQLServerConnectionDetails;

    bAutoLogon, bStoreLastLogin, bStoreLastPassword: boolean;
    sLastLogin, sLastPassword: string;

    sLocalHost: string;
    iConfigurationFormPage: integer;

    bAlwaysShowTrayIcon: boolean; // ������ ���������� ������ � ����
    bShowQuitConfirmation: boolean;
    bUseExternalLog: boolean;
    sDefaultAction: string;
    bNoStatusBar: boolean;
    bScrollToLastLogMessage: boolean;
    bAutorun: boolean;
    bStartInTray: boolean;
    bPlaySoundAfterAction: boolean;
    bShowBaloonHintAfterAction: boolean;

    bKeepErrorLog: boolean; // ����� �� ����� ��� ��������� ���� error
    bKeepWarningLog: boolean; // ����� �� ����� ��� ��������� ���� warning
    bKeepInfoLog: boolean; // ����� �� ����� ��� ��������� ���� info
    bKeepSQLLog: boolean; // ����� �� ����� ��� �������� MySQL
    bKeepDebugLog: boolean; // ����� �� ����� ��� ���������� ����������
    bFlushLogOnExit: boolean; // ��������� �� ���������� ���� � ���� ��� ������ �� ���������
    iFlushLogOnStringsQuantity: integer; // ��� ����� ���������� ����� ���� ��������� �� � ����
    bFlushLogOnClearingLog: boolean; // ��������� �� ���������� ���� � ���� ��� ������� ����

    sApplicationFolder: string;
    sTempFolder: string;
    sCustomFolder: string;
    trfReportFolder: TReportFolders;
    bDontDemandOverwriteConfirmation: boolean;
    bAskForFileName: boolean;
  end;

type
  TThread_Do_SIC=class(TThread)
  private
    FttsActionStart: TTimeStamp;
    FlwTotalTime: LongWord;
    FStartDate, FStopDate: TDate;
    FOpenWithBrowser: boolean;
    FCurrentUser: TUserRec;
    FEnableTimer: boolean;
    FLogGroupGUID: string;
    procedure SetEnableTimer(const Value: boolean);
    procedure SetConfiguration(const Value: TConfigurationRec);
    function GetDatesDiff: char;
    procedure _StartTimer(const aLogGroupGUID: string);
    procedure _StopTimer(const aLogGroupGUID: string);
  protected
    FConfiguration: TConfigurationRec;
    procedure _MySQL_OpenConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure _MySQL_CloseConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure _MySQL_CreateTable(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
    procedure _MySQL_CheckTableExistance(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
    procedure _MySQL_LockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
    procedure _MySQL_UnlockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    function _MySQL_InsertRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
    function _MySQL_UpdateRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
    procedure ProcedureHeader(aTitle: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aError: boolean; const aErrorMessage: string);
    procedure _CreateProgressBar(const aTime: TDateTime; const aTitle: string; const aMax: integer);
    procedure StepProgressBar;
    procedure LogThis(aMessage: string; aMessageType: TLogMessagesType);
    function GetWeeksList(const aStartDate, aStopDate: TDate; const aCalculateWeekFromMonday: boolean): TStringList;
    procedure PlaySound;
    procedure ShowBaloonHint(const aBalloonTitle, aBalloonHint: string);

    property EnableTimer: boolean read FEnableTimer write SetEnableTimer default False;
    property LogGroupGUID: string read FLogGroupGUID write FLogGroupGUID;
    property StartDate: TDate read FStartDate write FStartDate;
    property StopDate: TDate read FStopDate write FStopDate;
    property CurrentUser: TUserRec read FCurrentUser write FCurrentUser;
    property OpenWithBrowser: boolean read FOpenWithBrowser write FOpenWithBrowser;
    property DatesDiffChar: char read GetDatesDiff;
  public
    _ProgressBar: TProgressBar;
    _ListItem: TListItem;
    property Configuration: TConfigurationRec read FConfiguration write SetConfiguration;
    constructor Create;
  end;

implementation

uses
  Windows,
  Messages,
  Controls,
  DateUtils,
  Main,
  OverseerConsts,
  OverseerRoutines,
  MMSystem,
  ExtCtrls;

function TThread_Do_SIC.GetDatesDiff: char;
var
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  bStartOfTheYear, bStartOfTheMonth, bEndOfTheYear, bEndOfTheMonth, bStartOfTheWeek, bEndOfTheWeek, bStartOfTheQuarter, bEndOfTheQuarter: boolean;
begin
  wStartDay:=DayOf(StartDate);
  wStartMonth:=MonthOf(StartDate);
  wStartYear:=YearOf(StartDate);
  wStopDay:=DayOf(StopDate);
  wStopMonth:=MonthOf(StopDate);
  wStopYear:=YearOf(StopDate);

  bStartOfTheYear:=SameDate(StartOfTheYear(StartDate), StartDate);
  bEndOfTheYear:=SameDate(EndOfTheYear(StopDate), StopDate);
  bStartOfTheMonth:=SameDate(StartOfTheMonth(StartDate), StartDate);
  bEndOfTheMonth:=SameDate(EndOfTheMonth(StopDate), StopDate);
  bStartOfTheQuarter:=(wStartMonth in [1, 4, 7, 10])and bStartOfTheMonth;
  bEndOfTheQuarter:=(wStopMonth in [3, 6, 9, 12])and bEndOfTheMonth;
  bStartOfTheWeek:=SameDate(StartOfTheWeek(StartDate), StartDate);
  bEndOfTheWeek:=SameDate(EndOfTheWeek(StopDate), StopDate);

  // ������������ ����� �������� ��� ������ ������
  // ���� ��������� ���� �������� ������� ���� � �������� �������� ������ ����
  if bStartOfTheYear and bEndOfTheYear and(wStartYear=wStopYear) then
    Result:='�'
  else
    // ���� ��������� ���� �������� ������� �������� � �������� �������� ������ ��������
    if bStartOfTheQuarter and bEndOfTheQuarter and(wStartYear=wStopYear)and(wStopMonth=wStartMonth+2) then
      Result:='�'
    else
      // ���� ��������� ���� �������� ������� ������ � �������� �������� ������ ������
      if bStartOfTheMonth and bEndOfTheMonth and(wStartYear=wStopYear)and(wStartMonth=wStopMonth) then
        Result:='�'
      else
        // ���� ��������� ���� �������� ������� ������ � �������� ���� �������� ������ ���� �� ������
        if bStartOfTheWeek and bEndOfTheWeek and SameDate(IncDay(StartDate, 6), StopDate) then
          Result:='�'
        else
          // ���� ��������� ���� � �������� ���������
          if (wStartYear=wStopYear)and(wStartMonth=wStopMonth)and(wStartDay=wStopDay) then
            Result:='�'
          else
            Result:='�';
end;

procedure TThread_Do_SIC._MySQL_OpenConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      LogThis('>> ����������� �������� ����������� � MySQL-������� '+sMySQLHost+'...', lmtDebug);
      if bConnected then
        Routines_GenerateError('���� ����������� ������� ����������� � ������������� � ��������� ������ ������� MySQL!', sErrorMessage, bError)
      else
        begin
          hConnection:=mysql_init(nil);
          if hConnection=nil then
            Routines_GenerateError('�������� ������ ��� ������������� ������� ���������� � �������� MySQL!', sErrorMessage, bError)
          else
            begin
              LogThis('������������� ������� ���������� � �������� MySQL ��������� �������.', lmtDebug);
              bConnected:=mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar('overseer'), PAnsiChar(''), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil, integer(bMySQLCompress)*CLIENT_COMPRESS)<>nil;
              if not bConnected then
                Routines_GenerateError('�������� ������ ��� ������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('����������� � ������� MySQL ��������� �������.', lmtDebug);
            end;
        end;
      LogThis('<< ���������� �������� ����������� � MySQL-������� '+sMySQLHost+' ���������.', lmtDebug);
    end;
end;

procedure TThread_Do_SIC._MySQL_CheckTableExistance(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
var
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  i: integer;
begin
  LogThis('>> ����������� �������� �������� ������� ������� ������ "'+aTableName+'" � ���� ������...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              q:='SHOW TABLES FROM '+aMySQLDatabase+' LIKE "'+LowerCase(aTableName)+'";';
              LogThis(q, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                begin
                  LogThis('������ �������� �������.', lmtDebug);
                  ResultSet:=mysql_store_result(hConnection);
                  if ResultSet=nil then
                    Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
                  else
                    begin
                      LogThis('�������������� ������� �������� �������.', lmtDebug);
                      i:=mysql_num_rows(ResultSet);
                      LogThis('���������� ����� ������� ����� '+IntToStr(i)+'.', lmtDebug);
                      if i<0 then
                        Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                      else
                        begin
                          if i<>1 then
                            Routines_GenerateError('���������� ����� ������� ('+IntToStr(i)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                          else
                            begin
                              LogThis('���������� ����� ������� ������������� ����������.', lmtDebug);
                              ResultRow:=mysql_fetch_row(ResultSet);
                              if ResultRow=nil then
                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
                              else
                                begin
                                  if LowerCase(string(ResultRow[0]))<>LowerCase(aTableName) then
                                    Routines_GenerateError('���������� ��� ������� ������ �� ������������� ����������!', sErrorMessage, bError)
                                  else
                                    LogThis('������� ������� ������ ��������� �������.', lmtDebug);
                                end;
                            end;
                        end;
                      mysql_free_result(ResultSet);
                      LogThis('������������ ��������, ������� ����������� �������, ���������.', lmtDebug);
                    end;
                end;
            end;
        end;
    end;
  LogThis('<< ���������� �������� �������� ������� ������� ������ "'+aTableName+'" � ���� ������ ���������.', lmtDebug);
end;

procedure TThread_Do_SIC._MySQL_CloseConnection(var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      if bConnected then
        begin
          LogThis('>> ����������� �������� ���������� �� MySQL-������� '+sMySQLHost+'...', lmtDebug);
          if hConnection<>nil then
            begin
              mysql_close(hConnection);
              hConnection:=nil;
            end;
          bConnected:=False;
          LogThis('���������� �� MySQL-������� ���������.', lmtDebug);
          LogThis('<< ���������� �������� ���������� �� MySQL-������� '+sMySQLHost+' ���������.', lmtDebug);
        end;
    end;
end;

procedure TThread_Do_SIC._MySQL_LockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
var
  q: string;
begin
  LogThis('>> ����������� �������� ���������� ������� ���� ������...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              q:='LOCK TABLE '+aTablesList+';';
              LogThis(q, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('������ �������� �������.', lmtDebug);
            end;
        end;
    end;
  LogThis('<< ���������� �������� ���������� ������� ���� ������ ���������.', lmtDebug);
end;

procedure TThread_Do_SIC._MySQL_UnlockTables(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
var
  q: string;
begin
  LogThis('>> ����������� �������� ��������������� ���� ����� ��������������� ������ ���� ������...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              q:='UNLOCK TABLES;';
              LogThis(q, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('������ �������� �������.', lmtDebug);
            end;
        end;
    end;
  LogThis('<< ���������� �������� ��������������� ������ ���� ������ ���������.', lmtDebug);
end;

function TThread_Do_SIC._MySQL_UpdateRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> ����������� �������� ���������� ������ �������...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              LogThis(aQuery, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                begin
                  LogThis('������ �������� �������.', lmtDebug);
                  Result:=mysql_affected_rows(hConnection);
                  LogThis('���������� ������������ ����� ����� '+IntToStr(Result)+'.', lmtDebug);
                  if Result<0 then
                    Routines_GenerateError('���������� ������������ ����� ('+IntToStr(Result)+') �� ������������� ���������� (>=0)!', sErrorMessage, bError)
                  else
                    LogThis('���������� ������ ��������� �������.', lmtDebug);
                end;
            end;
        end;
    end;
  LogThis('<< ���������� �������� ���������� ������ ������� ���������.', lmtDebug);
end;

procedure TThread_Do_SIC.ProcedureHeader(aTitle: string);
begin
  LogThis('['+aTitle+']', lmtDebug);
  LogThis('������ ���������...', lmtDebug);
  Synchronize( procedure begin MainForm.Inc_BusyState(LogGroupGUID); end);
end;

procedure TThread_Do_SIC.PreFooter(const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    begin
      Synchronize( //
        procedure //
      begin //
        _ListItem.ImageIndex:=2; //
        _ProgressBar.State:=pbsError; //
      end //
        ); //
      LogThis(aErrorMessage, lmtError);
    end
  else
    begin
      Synchronize( procedure begin _ListItem.ImageIndex:=1; end);
      LogThis('��������� ��������� ��� ������.', lmtDebug);
    end;
  PlaySound;
end;

procedure TThread_Do_SIC.ProcedureFooter;
begin
  Synchronize( procedure begin MainForm.Dec_BusyState(LogGroupGUID); end);
  LogThis('��������� ���������.', lmtDebug);
end;

procedure TThread_Do_SIC._MySQL_CreateTable(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
begin
  LogThis('>> ����������� �������� �� �������� ������� ������...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        if mysql_ping(hConnection)<>0 then
          Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
        else
          begin
            LogThis(aQuery, lmtSQL);
            if mysql_real_query(hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
              Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
            else
              LogThis('������ �������� �������.', lmtDebug);
          end;
    end;
  LogThis('<< ���������� �������� �� �������� ������� ������ ���������.', lmtDebug);
end;

function TThread_Do_SIC._MySQL_InsertRecords(const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> ����������� �������� ������� ������� � �������...', lmtDebug);
  with aTMySQLServerConnectionDetails do
    begin
      if not bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(hConnection)<>0 then
            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
          else
            begin
              LogThis(aQuery, lmtSQL);
              if mysql_real_query(hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                begin
                  LogThis('������ �������� �������.', lmtDebug);
                  Result:=mysql_affected_rows(hConnection);
                  LogThis('���������� ������������ ����� ����� '+IntToStr(Result)+'.', lmtDebug);
                  if Result<0 then
                    Routines_GenerateError('���������� ������������ ����� ('+IntToStr(Result)+') �� ������������� ���������� (>=0)!', sErrorMessage, bError)
                  else
                    LogThis('������� ������ ��������� �������.', lmtDebug);
                end;
            end;
        end;
    end;
  LogThis('<< ���������� �������� ������� ������� � ������� ���������.', lmtDebug);
end;

procedure TThread_Do_SIC.LogThis(aMessage: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_THREADLOG)+';'+s+';'+aMessage+';'+LogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TThread_Do_SIC.StepProgressBar;

  procedure p; //
  begin //
    _ProgressBar.Position:=_ProgressBar.Position+_ProgressBar.Step; //
  end; //

begin
  Synchronize(p); //
end;

procedure TThread_Do_SIC._CreateProgressBar(const aTime: TDateTime; const aTitle: string; const aMax: integer);
var
  ProgressBarRect: TRect;
begin
  Synchronize( //
    procedure begin //
    _ListItem:=MainForm.lvActionList.Items.Add; //
    _ListItem.SubItems.Add(''); //
    _ListItem.SubItems.Add(FormatDateTime('yyyy.mm.dd hh:nn:ss', aTime)); //
    _ListItem.SubItems.Add('�����������...'); //
    _ListItem.SubItems.Add(aTitle); //
    _ListItem.ImageIndex:=0; //

    ProgressBarRect:=_ListItem.DisplayRect(drBounds); //
    ProgressBarRect.Top:=ProgressBarRect.Top+1; //
    ProgressBarRect.Bottom:=ProgressBarRect.Bottom-2; //
    ProgressBarRect.Left:=ProgressBarRect.Left+MainForm.lvActionList.Columns[0].Width+1; //
    ProgressBarRect.Right:=ProgressBarRect.Left+MainForm.lvActionList.Columns[1].Width-1; //

    _ProgressBar:=TProgressBar.Create(MainForm.lvActionList); //
    _ProgressBar.Parent:=MainForm.lvActionList; //
    _ProgressBar.BoundsRect:=ProgressBarRect; //
    _ProgressBar.Cursor:=crHandPoint; _ProgressBar.Min:=0; //
    _ProgressBar.Max:=aMax; //
    _ProgressBar.Position:=_ProgressBar.Min; //
    _ProgressBar.Step:=1; //
    _ProgressBar.State:=pbsNormal; //
    _ProgressBar.TabStop:=False; //
    _ListItem.Data:=_ProgressBar; //
    _ProgressBar.OnMouseUp:=MainForm._ProgressBarMouseUp; //
  end //
    ); //
end;

procedure TThread_Do_SIC._StartTimer(const aLogGroupGUID: string);
begin
  // ����� ������ ������� ���������� ���������
  FttsActionStart:=DateTimeToTimeStamp(Now);
  LogThis('����� ������� ���������� �������� �����.', lmtDebug);
end;

procedure TThread_Do_SIC._StopTimer(const aLogGroupGUID: string);
begin
  // ��������� ������ ������� ���������� ���������
  FlwTotalTime:=DateTimeToTimeStamp(Now).Time-FttsActionStart.Time;
  Synchronize( procedure begin _ListItem.SubItems[2]:=IntToStr(integer(FlwTotalTime)); end);
  LogThis('����� ���������� �������� ��������� '+Format('%.3f', [integer(FlwTotalTime)/1000])+' ���.', lmtInfo);
end;

procedure TThread_Do_SIC.SetConfiguration(const Value: TConfigurationRec);
begin
  FConfiguration:=Value;
  with FConfiguration do
    begin
      OverseerServer.bConnected:=False;
      DBServer.bConnected:=False;
      StatServer.bConnected:=False;
      RNE4Server.bConnected:=False;
    end;
end;

procedure TThread_Do_SIC.SetEnableTimer(const Value: boolean);
begin
  if Value<>FEnableTimer then
    begin
      FEnableTimer:=Value;
      if FEnableTimer then
        _StartTimer(LogGroupGUID)
      else
        _StopTimer(LogGroupGUID);
      LogThis('������ ������ ������������ ���������� �������� '+Routines_GetConditionalMessage(FEnableTimer, '�', '��')+'������.', lmtDebug);
    end;
end;

function TThread_Do_SIC.GetWeeksList(const aStartDate, aStopDate: TDate; const aCalculateWeekFromMonday: boolean): TStringList;
var
  dtDate: TDate;
  slDatesFullList: TStringList;
  iRoutineCounter: integer;
  dtStartOfTheWeek, dtEndOfTheWeek: TDate;
begin
  dtDate:=aStartDate;
  Result:=TStringList.Create;
  try
    Result.Sorted:=False;
    Result.Duplicates:=dupIgnore;
    if aCalculateWeekFromMonday then
      begin
        slDatesFullList:=TStringList.Create;
        try
          slDatesFullList.Duplicates:=dupIgnore;
          slDatesFullList.Sorted:=False;
          repeat
            slDatesFullList.Add(FormatDateTime('dd.mm.yyyy', dtDate));
            dtDate:=IncDay(dtDate, 1);
          until dtDate>aStopDate;
          for iRoutineCounter:=0 to slDatesFullList.Count-1 do
            begin
              dtStartOfTheWeek:=StartOfTheWeek(StrToDate(slDatesFullList[iRoutineCounter]));
              if dtStartOfTheWeek<aStartDate then
                dtStartOfTheWeek:=aStartDate;
              dtEndOfTheWeek:=EndOfTheWeek(StrToDate(slDatesFullList[iRoutineCounter]));
              if dtEndOfTheWeek>aStopDate then
                dtEndOfTheWeek:=aStopDate;
              if Result.IndexOf(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek))=-1 then
                Result.Add(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek));
            end;
        finally
          slDatesFullList.Free;
        end;
      end
    else
      begin
        repeat
          dtStartOfTheWeek:=dtDate;
          dtEndOfTheWeek:=IncDay(dtDate, 6);
          if dtEndOfTheWeek>aStopDate then
            dtEndOfTheWeek:=aStopDate;
          dtDate:=IncDay(dtDate, 7);
          if Result.IndexOf(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek))=-1 then
            Result.Add(FormatDateTime('dd.mm.yyyy', dtStartOfTheWeek)+' - '+FormatDateTime('dd.mm.yyyy', dtEndOfTheWeek));
        until dtDate>aStopDate;
      end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

constructor TThread_Do_SIC.Create;
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
end;

procedure TThread_Do_SIC.ShowBaloonHint(const aBalloonTitle, aBalloonHint: string);
begin
  if Configuration.bShowBaloonHintAfterAction then
    begin
      Synchronize( procedure begin with MainForm.TrayIcon1 do begin BalloonHint:=aBalloonHint; BalloonTitle:=aBalloonTitle; BalloonFlags:=bfInfo; ShowBalloonHint; end; end);
    end;
end;

procedure TThread_Do_SIC.PlaySound;
begin
  if Configuration.bPlaySoundAfterAction then
    MMSystem.PlaySound('WAVE_0', HInstance, SND_RESOURCE or SND_ASYNC);
  // MMSystem.PlaySound(PWideChar('C:\Windows\Media\tada.wav'), 0, SND_FILENAME or SND_ASYNC);
end;

end.
