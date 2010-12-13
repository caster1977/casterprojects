unit SendDataToMySQLServer;

interface

uses
  Classes,
  LogKeeperTypes;

type
  TSendDataToMySQLServerThread = class(TThread)
  private
    FLogGroupGUID: string;
    FConfiguration: TConfigurationRec;
    procedure LogThis(aMessage: string; aMessageType: TLogMessagesType);
  protected
    procedure ProcedureHeader(const aTitle: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aError: boolean; const aErrorMessage: string);
    procedure ShowBaloonHint(const aBalloonTitle, aBalloonHint: string);
    procedure Execute; override;
    property LogGroupGUID: string read FLogGroupGUID write FLogGroupGUID;
  public
    property Configuration: TConfigurationRec read FConfiguration write FConfiguration;
    constructor Create(const aLogGroupGUID: string; aConfiguration: TConfigurationRec);
  end;

implementation

uses
  Main,
  mysql,
  Windows,
  SysUtils,
  ExtCtrls,
  Messages,
  LogKeeperConsts,
  LogKeeperRoutines;

constructor TSendDataToMySQLServerThread.Create(const aLogGroupGUID: string; aConfiguration: TConfigurationRec);
begin
  inherited Create(True);
  with Self do
    begin
      Priority:=tpLower;
      FreeOnTerminate:=True;
      Configuration:=aConfiguration;
      LogGroupGUID:=aLogGroupGUID;
    end;
end;

procedure TSendDataToMySQLServerThread.ShowBaloonHint(const aBalloonTitle, aBalloonHint: string);
begin
  Synchronize(
    procedure
    begin
      if MainForm.Configuration.bShowBaloonHintAfterAction then
        with MainForm.TrayIcon1 do
          begin
            BalloonHint:=aBalloonHint;
            BalloonTitle:=aBalloonTitle;
            BalloonFlags:=bfInfo;
            ShowBalloonHint;
          end
    end
  );
end;

procedure TSendDataToMySQLServerThread.LogThis(aMessage: string; aMessageType: TLogMessagesType);
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

procedure TSendDataToMySQLServerThread.ProcedureHeader(const aTitle: string);
begin
  LogThis('['+aTitle+']', lmtDebug);
  LogThis('������ ���������...', lmtDebug);
  Synchronize( procedure begin MainForm.Inc_BusyState(LogGroupGUID); end);
end;

procedure TSendDataToMySQLServerThread.ProcedureFooter;
begin
  Synchronize(
    procedure
    begin
      MainForm.Dec_BusyState(LogGroupGUID);
    end
  );
  LogThis('��������� ���������.', lmtDebug);
end;

procedure TSendDataToMySQLServerThread.PreFooter(const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    begin
//      Synchronize( //
//        procedure //
//        begin //
//          _ListItem.ImageIndex:=2; //
//          _ProgressBar.State:=pbsError; //
//        end //
//      ); //
      LogThis(aErrorMessage, lmtError);
    end
  else
    begin
//      Synchronize( procedure begin _ListItem.ImageIndex:=1; end);
      LogThis('��������� ��������� ��� ������.', lmtDebug);
    end;
//  PlaySound;
end;

procedure TSendDataToMySQLServerThread.Execute;
const
  LogGroupGUID: string='{1BCA8A3E-8671-438D-98DB-D94194F6AF05}';
var
  sErrorMessage: string;
  bError: boolean;
begin
  ProcedureHeader('��������� ����������� ��������� � MySQL-�������');
  bError:=False;

  with FConfiguration, LogServer do
    begin
      LogThis('>> ����������� �������� ����������� � MySQL-������� '+sMySQLHost+'...', lmtDebug);
      if bConnected then
        Routines_GenerateError('���� ����������� ������� ����������� � ������������� � ��������� ������ MySQL-�������!', sErrorMessage, bError)
      else
        begin
          hConnection:=mysql_init(nil);
          if hConnection=nil then
            Routines_GenerateError('�������� ������ ��� ������������� ������� ���������� � �������� MySQL!', sErrorMessage, bError)
          else
            begin
              LogThis('������������� ������� ���������� � �������� MySQL ��������� �������.', lmtDebug);
              bConnected:=mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar(sMySQLUser), PAnsiChar(sMySQLPassword), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil, integer(bMySQLCompress)*CLIENT_COMPRESS)<>nil;
              if not bConnected then
                Routines_GenerateError('�������� ������ ��� ������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(LogServer), sErrorMessage, bError)
              else
                LogThis('����������� � MySQL-������� '+sMySQLHost+' ��������� �������.', lmtInfo);
            end;
        end;
      LogThis('<< ���������� �������� ����������� � MySQL-������� '+sMySQLHost+' ���������.', lmtDebug);
    end;

  Synchronize(
    procedure
    begin
      MainForm.Configuration:=Self.Configuration;
      MainForm.Update_ConnectionAction;
      if bError then
        MainForm.ApplicationEvents1.OnIdle:=MainForm.ApplicationEvents1Idle;
    end
  );

  PreFooter(bError,sErrorMessage);
  ProcedureFooter;
end;

end.
