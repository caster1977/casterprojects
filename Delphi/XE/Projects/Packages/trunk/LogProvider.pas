unit LogProvider;

interface

uses
  Windows,
  Messages,
  Classes,
  Generics.Collections,
  Forms,
  uLogClasses,
  LogKeeperData;

type
  TLogProvider=class(TComponent)
  strict private
    FEnabled: boolean;
    FGUIDList: TList<string>;
    FUserName: string;
    FLogFile: TLogFile;
    FLogClient: TLogClient;
    FCount: longword;
    FBeforeSending: TNotifyEvent;
    FAfterSending: TNotifyEvent;
    procedure Send(const aString: string; const aMessageType: TLogMessagesType);
    procedure SetEnabled(const Value: Boolean);
    function GetLocalHostName: string;
    function GetApplicationHandle: HWnd;
    function GetApplicationFileName: string;
    function GetApplicationFilePath: string;
    function GetFormHandle: HWnd;
    function GetFormName: string;
    property Count: longword read FCount;
    procedure RefreshConnections;
  private
    FOwnerForm: TForm;
  strict protected
    procedure DoBeforeSending; virtual;
    procedure DoAfterSending; virtual;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure EnterMethod(const aString, aGUID: string);
    procedure ExitMethod;
    procedure SendError(const aString: string);
    procedure SendWarning(const aString: string);
    procedure SendInfo(const aString: string);
    procedure SendDebug(const aString: string);
    procedure SendSQL(const aString: string);

    property UserName: string read FUserName write FUserName;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property LogFile: TLogFile read FLogFile write FLogFile;
    property LogClient: TLogClient read FLogClient write FLogClient;
    property BeforeSending: TNotifyEvent read FBeforeSending write FBeforeSending;
    property AfterSending: TNotifyEvent read FAfterSending write FAfterSending;
  end;

procedure register;

implementation

uses
  XMLIntf,
  XMLDoc,
  WinSock,
  Controls,
  SysUtils;

procedure register;
begin
  RegisterComponents('MyComponents', [TLogProvider]);
end;

{ TLogProvider }

constructor TLogProvider.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled:=False;
  FUserName:='';
  if AOwner is TForm then
    FOwnerForm:=TForm(AOwner);
  FLogFile:=TLogFile.Create(Self);
  FLogClient:=TLogClient.Create(Self);
  if not(csDesigning in ComponentState) then
    FGUIDList:=TList<string>.Create;
end;

destructor TLogProvider.Destroy;
begin
  FEnabled:=False;
  FreeAndNil(FLogFile);
  FreeAndNil(FLogClient);
  FreeAndNil(FGUIDList);
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
          if Assigned(P) then
            Result:=string(iNet_ntoa(PInAddr(p^.h_addr_list^)^));
        end;
      WSACleanup;
    end;
end;

procedure TLogProvider.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
    RefreshConnections;
end;

procedure TLogProvider.Send(const aString: string; const aMessageType: TLogMessagesType);
var
  lmd: IXMLLogkeeperdataType;
  lm: IXMLMessageType;
  dtNow: TDateTime;
  wYear, wMonth, wDay, wHour, wMinute, wSecond, wMSecond: word;
  bNeedToSend: boolean;
begin
  // если компонент включен
  if Enabled then
    begin
      bNeedToSend:=False;
      if Assigned(FLogFile) then
        if FLogFile.Enabled then
          bNeedToSend:=True;
      if Assigned(FLogClient) then
        if FLogClient.Enabled then
          bNeedToSend:=True;
      if bNeedToSend then
        begin
          DoBeforeSending;

          dtNow:=Now;
          DecodeDate(dtNow, wYear, wMonth, wDay);
          DecodeTime(dtNow, wHour, wMinute, wSecond, wMSecond);
          Application.ProcessMessages;

          // оформление передаваемого сообщени€ в виде XML-документа
          lmd:=NewlogKeeperData;
          if Assigned(lmd) then
            begin
              lm:=lmd.Add;
              if Assigned(lm) then
                with lm do
                  begin
                    Index:=Count;
                    with Date do
                      begin
                        Year:=wYear;
                        Month:=wMonth;
                        Day:=wDay;
                      end;
                    with Time do
                      begin
                        Hour:=wHour;
                        Minute:=wHour;
                        Second:=wSecond;
                        MSecond:=wMSecond;
                      end;
                    Host:=GetLocalHostName;
                    with lm.Application do
                      begin
                        Handle:=GetApplicationHandle;
                        FileName:=GetApplicationFileName;
                        FilePath:=GetApplicationFilePath;
                        with Form do
                          begin
                            Handle:=GetFormHandle;
                            name:=GetFormName;
                          end;
                        if FGUIDList.Count>0 then
                          Method.Guid:=FGUIDList.Last
                        else
                          raise Exception.Create('—пиоок GUID методов пуст!');
                        User:=UserName;
                      end;
                    MessageType:=aMessageType;
                    Text:=aString;
                  end;

              // если включена отправка в файл
              if Assigned(FLogFile) then
                with FLogFile do
                  if Enabled then
                    begin
                      AppendToQueue(lmd.XML);
                      Suspended:=False;
                    end;

              // если включена отправка в клиента
              if Assigned(FLogClient) then
                with FLogClient do
                  if Enabled then
                    begin
                      AppendToQueue(lmd.XML);
                      Suspended:=False;
                    end;
            end;
          FCount:=FCount+1;
          DoAfterSending;
        end;
    end;
end;

procedure TLogProvider.SendDebug(const aString: string);
begin
  Send(aString, lmtDebug);
end;

procedure TLogProvider.SendError(const aString: string);
begin
  Send(aString, lmtError);
end;

procedure TLogProvider.SendInfo(const aString: string);
begin
  Send(aString, lmtInfo);
end;

procedure TLogProvider.SendSQL(const aString: string);
begin
  Send(aString, lmtSQL);
end;

procedure TLogProvider.SendWarning(const aString: string);
begin
  Send(aString, lmtWarning);
end;

procedure TLogProvider.SetEnabled(const Value: Boolean);
begin
  if FEnabled<>Value then
    begin
      FEnabled:=Value;
      // только после прогрузки, и только в случае, если программа запущена на выполнение, а не находитс€ в состо€нии разработки
      if not((csLoading in ComponentState)or(csDesigning in ComponentState)) then
        RefreshConnections;
    end;
end;

procedure TLogProvider.RefreshConnections;
begin
  // только в случае, если программа запущена на выполнение, а не находитс€ в состо€нии разработки
  if not(csDesigning in ComponentState) then
    if Enabled then
      begin
        FLogClient.Refresh;
        FLogFile.Refresh;
      end;
end;

procedure TLogProvider.EnterMethod(const aString, aGUID: string);
begin
  if Length(aGUID)=38 then
    FGUIDList.Add(aGUID)
  else
    raise Exception.Create('Ќе удалось добавить элемент в список GUID методов из-за некорректной длины строки!');
  Send('['+aString+']', lmtDebug);
  Send('Ќачало процедуры...', lmtDebug);
end;

procedure TLogProvider.ExitMethod;
begin
  Send('ќкончание процедуры.', lmtDebug);
  if FGUIDList.Count>0 then
    FGUIDList.Delete(FGUIDList.Count-1)
  else
    raise Exception.Create('Ќе удалось удалить последний элемент списка GUID методов, т.к. список пуст!');
end;

function TLogProvider.GetApplicationHandle: HWnd;
begin
  Result:=Application.Handle;
end;

procedure TLogProvider.DoAfterSending;
begin
  if Assigned(FAfterSending) then
    FAfterSending(Self);
end;

procedure TLogProvider.DoBeforeSending;
begin
  if Assigned(FBeforeSending) then
    FBeforeSending(Self);
end;

function TLogProvider.GetApplicationFileName: string;
begin
  Result:=ExtractFileName(Application.ExeName);
end;

function TLogProvider.GetApplicationFilePath: string;
begin
  Result:=ExtractFilePath(Application.ExeName);
end;

function TLogProvider.GetFormHandle: HWnd;
begin
  if Assigned(FOwnerForm) then
    Result:=FOwnerForm.Handle
  else
    raise Exception.Create('Ќе удалось получить handle родительской формы, поскольку указатель на родительскую форму пуст!');
end;

function TLogProvider.GetFormName: string;
begin
  if Assigned(FOwnerForm) then
    Result:=FOwnerForm.Caption
  else
    raise Exception.Create('Ќе удалось получить заголовок родительской формы, поскольку указатель на родительскую форму пуст!');
end;

(*
  procedure LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
  { TODO : ”брать ремарки }
  var
  i: integer;
  ListItem: TListItem;
  s: string;
  m: AnsiString;
  aCopyData: TCopyDataStruct;
  begin
  { TODO : ”брать ремарки }
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
  s+#09+ // тип сообщени€
  StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+
  // дата и врем€ сообщени€
  aLogGroupGIUD+#09+StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+
  // пор€дковый номер сообщени€
  aMessage); // текст сообщени€
  // проверка наличи€ LogKeeper и его запуск в случае отсутстви€
  if IsWindow(hLogKeeper) then
  begin // если LogKeeper запущен
  with aCopyData do
  begin
  dwData:=0;
  cbData:=Length(m)+1;
  lpData:=PAnsiChar(m);
  end;
  SendMessage(hLogKeeper, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
  // LogThis('ѕроизведена отправка программе лог-клиента строки данных: ['+m+']', LogGroupGUID, lmtDebug);
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
  ListItem.ImageIndex:=i; // тип сообщени€
  ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now); // дата и врем€ сообщени€
  ListItem.SubItems.Add(aLogGroupGIUD);
  ListItem.SubItems.Add(StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])); // пор€дковый номер сообщени€
  ListItem.SubItems.Add(CurrentUser.sLogin); // текущий залогированный пользователь
  ListItem.SubItems.Add(aMessage); // текст сообщени€
  if (Configuration.iFlushLogOnStringsQuantity>0)and(lvLog.Items.Count=Configuration.iFlushLogOnStringsQuantity) then
  Do_FlushLogToFile;
  if Configuration.bScrollToLastLogMessage then
  SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
  end;
  end;
  end;
*)

(*
   ак послать широковещательный UDP пакет
  procedure TMainForm.FormCreate(Sender: TObject);
  var
  Init: TWSAData;
  SockOpt: BOOL;
  Sock: TSocket;
  Target: TSockAddrIn;
  begin
  WSAStartup($101,Init);
  Sock:=Socket(PF_INET,SOCK_DGRAM,IPPROTO_UDP);
  SockOpt:=TRUE;
  SetSockOpt(Sock,SOL_SOCKET,SO_BROADCAST, PChar(@SockOpt),SizeOf(SockOpt)) ;
  Target.sin_port:=htons(8167); //номер порта
  Target.sin_addr.S_addr:=INADDR_BROADCAST;
  Target.sa_family:=AF_INET;
  SendTo(Sock,Data,DataBytes,0,Target,SizeOf(Target));
  WSACleanup;
  end;
*)

end.
