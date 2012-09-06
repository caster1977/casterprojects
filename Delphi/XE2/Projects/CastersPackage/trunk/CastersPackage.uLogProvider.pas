unit CastersPackage.uLogProvider;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  System.Generics.Collections,
  Vcl.Forms,
  CastersPackage.uLogClasses,
  CastersPackage.uLogKeeperData;

type
  TLogProvider=class(TComponent)
  strict private
    dwRecipients: DWORD;
    msgLogKeeperClientQuery, msgLogKeeperClientAnswer: cardinal;
    FEnabled: boolean;
    FGUIDList: TList<string>;
    FUserName: string;
    FLogFile: TLogFile;
    FLogClient: TLogClient;
    FCount: longword;
    FBeforeSending: TNotifyEvent;
    FAfterSending: TNotifyEvent;
    FAllowedTypes: TLogMessagesTypes;
    prOldWndProc: TWndMethod;
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
    procedure NewWindowProc(var Msg: TMessage);
  strict protected
    procedure DoBeforeSending; virtual;
    procedure DoAfterSending; virtual;
  protected
    procedure Loaded; override;
  public
    FOwnerForm: TForm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SendError(const aString: string);
    procedure SendWarning(const aString: string);
    procedure SendInfo(const aString: string);
    procedure SendDebug(const aString: string);
    procedure SendSQL(const aString: string);

    procedure EnterMethod(const aString, aGUID: string);
    procedure ExitMethod;

    property UserName: string read FUserName write FUserName;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property LogFile: TLogFile read FLogFile write FLogFile;
    property LogClient: TLogClient read FLogClient write FLogClient;
    property BeforeSending: TNotifyEvent read FBeforeSending write FBeforeSending;
    property AfterSending: TNotifyEvent read FAfterSending write FAfterSending;
    property AllowedTypes: TLogMessagesTypes read FAllowedTypes write FAllowedTypes default [lmtError, lmtWarning, lmtInfo, lmtSQL];
  end;

procedure register;

implementation

uses
  Xml.XMLDoc,
  Xml.XMLIntf,
  Winapi.WinSock,
  Vcl.Controls,
  System.SysUtils;

procedure register;
begin
  RegisterComponents('CasterComponents', [TLogProvider]);
end;

{ TLogProvider }

constructor TLogProvider.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled:=False;
  FUserName:='';
  FAllowedTypes:=[lmtError, lmtWarning, lmtInfo, lmtSQL];
  if AOwner is TForm then
    FOwnerForm:=TForm(AOwner);
  FLogFile:=TLogFile.Create(Self);
  FLogClient:=TLogClient.Create(Self);
  if not(csDesigning in ComponentState) then
    begin
      FGUIDList:=TList<string>.Create;

      // перехват обработчика сообщений
      prOldWndProc:=FOwnerForm.WindowProc;
      FOwnerForm.WindowProc:=NewWindowProc;

      // регистрация глобальных переменных
      msgLogKeeperClientQuery:=RegisterWindowMessage('msgLogKeeperClientQuery');
      msgLogKeeperClientAnswer:=RegisterWindowMessage('msgLogKeeperClientAnswer');

      // отправка широковещательного сообщения клиентам на локальном компе
      dwRecipients:=BSM_APPLICATIONS;
      if Assigned(FOwnerForm) then
        BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @dwRecipients, msgLogKeeperClientQuery, FOwnerForm.Handle, 0);
    end;
end;

destructor TLogProvider.Destroy;
begin
  if not(csDesigning in ComponentState) then
    begin
      if Assigned(FOwnerForm) then
        FOwnerForm.WindowProc:=prOldWndProc;
    end;
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

procedure TLogProvider.NewWindowProc(var Msg: TMessage);
begin
  if Msg.Msg=msgLogKeeperClientAnswer then
    begin
      // if Msg.WParam=FOwnerForm.Handle then
      MessageBox(FOwnerForm.Handle, PWideChar('Получено сообщение msgLogKeeperClientAnswer в форму '+FOwnerForm.Name+'!'), PWideChar('OA5 - Информация!'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
      // if Msg.lParam=1 then
      // hBaseInfo:=Msg.wParam; // обновляем хэндл окна-приёмника
      // Handled:=True;
    end;
  prOldWndProc(Msg);
end;

procedure TLogProvider.Send(const aString: string; const aMessageType: TLogMessagesType);
var
  lmd: IXMLLogkeeperdataType;
  lm: IXMLMessageType;
  dtNow: TDateTime;
  Doc: IXMLDocument;
  wYear, wMonth, wDay, wHour, wMinute, wSecond, wMSecond: word;
  bNeedToSend: boolean;
begin
  // если компонент включен
  if Enabled then
    begin
      try
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

            // оформление передаваемого сообщения в виде XML-документа
            Doc:=TXMLDocument.Create(Self);
            Doc.Active:=True;
            if Doc.Version<>'' then
              Doc.Version:='1.0';
            lmd:=GetLogKeeperData(Doc);

            if Assigned(lmd) then
              begin
                lm:=lmd.Add;
                if Assigned(lm) then
                  with lm do
                    begin
                      index:=Count;
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
                            raise Exception.Create('Спиоок GUID методов пуст!');
                          User:=UserName;
                        end;
                      MessageType:=aMessageType;
                      Text:=aString;
                    end;

                if Assigned(FLogFile) then
                  with FLogFile do
                    if Enabled then
                      begin
                        AppendToQueue(lmd.XML);
                        Suspended:=False;
                      end;

                if Assigned(FLogClient) then
                  with FLogClient do
                    if Enabled then
                      begin
                        AppendToQueue(lmd.XML);
                        Suspended:=False;
                      end;
                lm:=nil;
              end;

            lmd:=nil;
            Doc:=nil;
            FCount:=FCount+1;
            DoAfterSending;
          end;
      except
        Application.HandleException(Self);
      end;
      Application.ProcessMessages;
    end;
end;

procedure TLogProvider.SendDebug(const aString: string);
begin
  if lmtDebug in AllowedTypes then
    Send(aString, lmtDebug);
end;

procedure TLogProvider.SendError(const aString: string);
begin
  if lmtError in AllowedTypes then
    Send(aString, lmtError);
end;

procedure TLogProvider.SendInfo(const aString: string);
begin
  if lmtInfo in AllowedTypes then
    Send(aString, lmtInfo);
end;

procedure TLogProvider.SendSQL(const aString: string);
begin
  if lmtSQL in AllowedTypes then
    Send(aString, lmtSQL);
end;

procedure TLogProvider.SendWarning(const aString: string);
begin
  if lmtWarning in AllowedTypes then
    Send(aString, lmtWarning);
end;

procedure TLogProvider.SetEnabled(const Value: Boolean);
begin
  if FEnabled<>Value then
    begin
      FEnabled:=Value;
      // только после прогрузки, и только в случае, если программа запущена на выполнение, а не находится в состоянии разработки
      if not((csLoading in ComponentState)or(csDesigning in ComponentState)) then
        RefreshConnections;
    end;
end;

procedure TLogProvider.RefreshConnections;
begin
  // только в случае, если программа запущена на выполнение, а не находится в состоянии разработки
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
    raise Exception.Create('Не удалось добавить элемент в список GUID методов из-за некорректной длины строки!');
  SendDebug('['+aString+']');
  SendDebug('Начало процедуры...');
end;

procedure TLogProvider.ExitMethod;
begin
  SendDebug('Окончание процедуры.');
  if FGUIDList.Count>0 then
    FGUIDList.Delete(FGUIDList.Count-1)
  else
    raise Exception.Create('Не удалось удалить последний элемент списка GUID методов, т.к. список пуст!');
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
    raise Exception.Create('Не удалось получить handle родительской формы, поскольку указатель на родительскую форму пуст!');
end;

function TLogProvider.GetFormName: string;
begin
  if Assigned(FOwnerForm) then
    Result:=FOwnerForm.Caption
  else
    raise Exception.Create('Не удалось получить заголовок родительской формы, поскольку указатель на родительскую форму пуст!');
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

(*
  Как послать широковещательный UDP пакет
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
