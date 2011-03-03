unit LogProvider;

interface

uses
  Windows,
  Classes,
  Generics.Collections,
  Forms;

type

  TLogProvider=class;

{$M+}
  TLogFile=class
  strict private
    FEnabled: boolean;
    FName: string;
    FPath: string;
  public
    constructor Create;
  published
    property Enabled: boolean read FEnabled write FEnabled default False;
    property Name: string read FName write FName;
    property Path: string read FPath write FPath;
  end;

  TLogClient=class
  strict private
    FEnabled: boolean;
  public
    constructor Create;
  published
    property Enabled: boolean read FEnabled write FEnabled default False;
  end;
{$M-}

  TLogThread=class(TThread)
  strict private
    FOwner: TLogProvider;
  protected
    procedure Execute; override;
  public
    constructor Create(Value: TLogProvider);
  end;

  TLogProvider=class(TComponent)
  strict private
    FLogThread: TLogThread;
    FEnabled: boolean;
    FForm: TForm;
    FApplication: TApplication;
    FUserName: string;
    FCount: longword;
    FLogFile: TLogFile;
    FLogClient: TLogClient;
  private
    XMLStringsList: TList<string>;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function GetLocalHostName: string;
    function GetApplicationHandle: HWnd;
    function GetApplicationFileName: string;
    function GetApplicationFilePath: string;
    function GetFormHandle: HWnd;
    function GetFormName: string;

    procedure SendError(const AString: string);
    procedure SendWarning(const AString: string);
    procedure SendInfo(const AString: string);
    procedure SendDebug(const AString: string);
    procedure SendSQL(const AString: string);
    procedure Send(const AString: string);

    procedure EnterMethod(const AString, AGUID: string);
    procedure ExitMethod;

    property Count: longword read FCount;
    property UserName: string read FUserName write FUserName;
  published
    property Enabled: Boolean read FEnabled write FEnabled default true;
    property LogFile: TLogFile read FLogFile write FLogFile;
    property LogClient: TLogClient read FLogClient write FLogClient;
  end;

procedure register;

implementation

uses
  WinSock,
  Controls,
  SysUtils,
  log_message;

procedure register;
begin
  RegisterComponents('MyComponents', [TLogProvider]);
end;

{ TLogFile }

constructor TLogFile.Create;
begin
  inherited;
end;

{ TLogClient }

constructor TLogClient.Create;
begin
  inherited;
end;

{ TLogThread }

constructor TLogThread.Create(Value: TLogProvider);
begin
  inherited Create(True);
  FOwner:=Value;

  Priority:=tpLower;
  FreeOnTerminate:=False;
end;

procedure TLogThread.Execute;
begin
  inherited;
  while not Terminated do
    begin
    { TODO : Реализовать передачу строк цели. }
    end;
end;

{ TLogProvider }

constructor TLogProvider.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FApplication:=nil;
  FForm:=nil;
  FCount:=0;
  FEnabled:=True;
  if AOwner is TForm then
    begin
      FForm:=TForm(AOwner);
      if TForm(AOwner).Owner is TApplication then
        FApplication:=TApplication(AOwner.Owner);
    end;
  FLogFile:=TLogFile.Create;
  FLogClient:=TLogClient.Create;
  // если мы не в редиме дизайнера, создаём поток для обработки сообщений протокола
  if not (csDesigning in ComponentState) then
    begin
      XMLStringsList:=TList<string>.Create;
      FLogThread:=TLogThread.Create(Self);
      try
        FLogThread.Start; // запускаем выполнение потока
      except
        on E: Exception do raise;
      end;
    end;
end;

destructor TLogProvider.Destroy;
begin
  if FLogThread<>nil then
    FLogThread.Free;
  if XMLStringsList<>nil then
    XMLStringsList.Free;
  if FLogClient<>nil then
    FLogClient.Free;
  if FLogFile<>nil then
    FLogFile.Free;
  inherited;
end;

function TLogProvider.GetLocalHostName: string;
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
//var
// s: string;
// aCopyData: TCopyDataStruct;
begin
  // s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  // with aCopyData do
  // begin
  // dwData:=0;
  // cbData:=Length(s)+1;
  // lpData:=PAnsiChar(AnsiString(s));
  // end;
  // SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TLogProvider.SendDebug(const AString: string);
var
  lm: IXMLLog_messageType;
  dt: TDateTime;
  Year, Month, Day: word;
  Hour, Minute, Second, MSecond: word;
begin
  // оформление передаваемого сообщения в виде XML-документа
  dt:=Now;
  DecodeDate(dt, Year, Month, Day);
  DecodeTime(dt, Hour, Minute, Second, MSecond);

  lm:=Newlog_message;

  lm.Host:=GetLocalHostName;

  lm.Application.Handle:=GetApplicationHandle;
  lm.Application.FileName:=GetApplicationFileName;
  lm.Application.FilePath:=GetApplicationFilePath;

  lm.Message.Index:=Count;

  lm.Message.Date.Year:=Year;
  lm.Message.Date.Month:=Month;
  lm.Message.Date.Day:=Day;

  lm.Message.Time.Hour:=Hour;
  lm.Message.Time.Minute:=Hour;
  lm.Message.Time.Second:=Second;
  lm.Message.Time.MSecond:=MSecond;

  lm.Message.MessageType:=lmtDebug;

  lm.Message.Text:=AString;

  if (XMLStringsList<>nil) and (FLogThread<>nil) then
    begin
      XMLStringsList.Add(lm.XML);
    end;
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

function TLogProvider.GetApplicationHandle: HWnd;
begin
  if FApplication<>nil then
    Result:=FApplication.Handle
  else Result:=0;
end;

function TLogProvider.GetApplicationFileName: string;
begin
  if FApplication<>nil then
    Result:=ExtractFileName(FApplication.ExeName);
end;

function TLogProvider.GetApplicationFilePath: string;
begin
  if FApplication<>nil then
    Result:=ExtractFilePath(FApplication.ExeName);
end;

function TLogProvider.GetFormHandle: HWnd;
begin
  if FForm<>nil then
    Result:=FForm.Handle
  else Result:=0;
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
