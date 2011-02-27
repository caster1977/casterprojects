unit LogProvider;

interface

uses
  Classes,
  Forms;

type
  TLogProvider=class(TComponent)
  strict private
    FEnabled: boolean;
    FForm: TForm;
    FApplication: TApplication;
    FUserName: string;
    FCounter: longword;
    function GetHost: string;
    function GetApplicationName: string;
    function GetFormName: string;
  public
    procedure SendError(const AString: string);
    procedure SendWarning(const AString: string);
    procedure SendInfo(const AString: string);
    procedure SendDebug(const AString: string);
    procedure SendSQL(const AString: string);
    procedure Send(const AString: string);
    procedure EnterMethod(const AString, AGUID: string);
    procedure ExitMethod;
    constructor Create(AOwner: TComponent); override;
    property Counter: longword read FCounter;
    property ApplicationName: string read GetApplicationName;
    property UserName: string read FUserName write FUserName;
  published
    property Enabled: Boolean read FEnabled write FEnabled default true;
    property HostName: string read GetHost;
    property FormName: string read GetFormName;
  end;

procedure register;

implementation

uses
  WinSock,
  Controls;

procedure register;
begin
  RegisterComponents('MyComponents', [TLogProvider]);
end;

constructor TLogProvider.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FApplication:=nil;
  FForm:=nil;
  FCounter:=0;
  FEnabled:=True;
  if AOwner is TForm then
    begin
      FForm:=TForm(AOwner);
      if TForm(AOwner).Owner is TApplication then
        FApplication:=TApplication(AOwner.Owner);
    end;
end;

function TLogProvider.GetHost: string;
const
  WSVer=$101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result:='';
  if WSAStartup(WSVer, wsaData)=0 then
    begin
      if GetHostName(@Buf, 128)=0 then
        begin
          P:=GetHostByName(@Buf);
          if P<>nil then
            Result:=string(iNet_ntoa(PInAddr(p^.h_addr_list^)^));
        end;
      WSACleanup;
    end;
end;

procedure TLogProvider.Send(const AString: string);
begin

end;

procedure TLogProvider.SendDebug(const AString: string);
begin

end;

procedure TLogProvider.SendError(const AString: string);
begin

end;

procedure TLogProvider.SendInfo(const AString: string);
begin

end;

procedure TLogProvider.SendSQL(const AString: string);
begin

end;

procedure TLogProvider.SendWarning(const AString: string);
begin

end;

procedure TLogProvider.EnterMethod(const AString, AGUID: string);
begin

end;

procedure TLogProvider.ExitMethod;
begin

end;

function TLogProvider.GetApplicationName: string;
begin
  if FApplication<>nil then
    Result:=FApplication.ExeName;
end;

function TLogProvider.GetFormName: string;
begin
  if FForm<>nil then
    Result:=FForm.Caption;
end;

(*
  procedure LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
  { TODO : Убрать ремарки }
  var
  i: integer;
  ListItem: TListItem;
  s: string;
  m: AnsiString;
  aCopyData: TCopyDataStruct;
  begin
  { TODO : Убрать ремарки }
  i:=-1;
  SessionLogEventCount:=SessionLogEventCount+1;

  if Configuration.bUseExternalLog then
  begin
  case aMessageType of
  lmtError:
  s:='ERROR  ';
  lmtWarning:
  s:='WARNING';
  lmtInfo:
  s:='INFO   ';
  lmtSQL:
  s:='SQL    ';
  lmtDebug:
  s:='DEBUG  ';
  end;
  m:=AnsiString(Application.ExeName+#09+CurrentUser.sLogin+#09+ // текущий залогированный пользователь
  s+#09+ // тип сообщения
  StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+
  // дата и время сообщения
  aLogGroupGIUD+#09+StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+
  // порядковый номер сообщения
  aMessage); // текст сообщения
  // проверка наличия LogKeeper и его запуск в случае отсутствия
  if IsWindow(hLogKeeper) then
  begin // если LogKeeper запущен
  with aCopyData do
  begin
  dwData:=0;
  cbData:=Length(m)+1;
  lpData:=PAnsiChar(m);
  end;
  SendMessage(hLogKeeper, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
  // LogThis('Произведена отправка программе лог-клиента строки данных: ['+m+']', LogGroupGUID, lmtDebug);
  end
  else
  begin
  Configuration.bUseExternalLog:=False;
  pnlLog.Visible:=not Configuration.bUseExternalLog;
  Height:=600-152*integer(Configuration.bUseExternalLog);
  Timer1.Enabled:=Configuration.bUseExternalLog;
  end;
  end;
  if not Configuration.bUseExternalLog then
  begin
  if (((Configuration.bKeepErrorLog)and(aMessageType=lmtError))or((Configuration.bKeepWarningLog)and(aMessageType=lmtWarning))or((Configuration.bKeepInfoLog)and(aMessageType=lmtInfo))or((Configuration.bKeepSQLLog)and(aMessageType=lmtSQL))or
  ((Configuration.bKeepDebugLog)and(aMessageType=lmtDebug))) then
  begin
  case aMessageType of
  lmtError:
  i:=ICON_ERROR;
  lmtWarning:
  i:=ICON_WARNING;
  lmtInfo:
  i:=ICON_INFO;
  lmtSQL:
  i:=ICON_SQL;
  lmtDebug:
  i:=ICON_DEBUG;
  end;
  ListItem:=lvLog.Items.Add;
  ListItem.ImageIndex:=i; // тип сообщения
  ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now); // дата и время сообщения
  ListItem.SubItems.Add(aLogGroupGIUD);
  ListItem.SubItems.Add(StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])); // порядковый номер сообщения
  ListItem.SubItems.Add(CurrentUser.sLogin); // текущий залогированный пользователь
  ListItem.SubItems.Add(aMessage); // текст сообщения
  if (Configuration.iFlushLogOnStringsQuantity>0)and(lvLog.Items.Count=Configuration.iFlushLogOnStringsQuantity) then
  Do_FlushLogToFile;
  if Configuration.bScrollToLastLogMessage then
  SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
  end;
  end;
  end;
*)

end.
