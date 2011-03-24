unit LogProvider;

interface

uses
  Windows,
  Messages,
  Classes,
  Generics.Collections,
  Forms,
  LogKeeperData;

type

  TLogProvider=class;

  TLogFile=class(TPersistent)
  strict private
    FEnabled: boolean;
    FFileName: string;
    FFilePath: string;
    FOwner: TLogProvider;
    procedure SetEnabled(const Value: boolean);
    procedure SetFileName(const Value: string);
    procedure SetFilePath(const Value: string);
  private
    FLogKeeperData: IXMLLogkeeperdataType;
  protected
    function GetOwner: TPersistent; override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TLogProvider);
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    //procedure Append(const aXML: string);
  published
    property Enabled: boolean read FEnabled write SetEnabled default False;
    property FileName: string read FFileName write SetFileName;
    property FilePath: string read FFilePath write SetFilePath;
  end;

  TLogClient=class(TPersistent)
  strict private
    FEnabled: boolean;
    FOwner: TLogProvider;
    procedure SetEnabled(const Value: boolean);
  protected
    function GetOwner: TPersistent; override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TLogProvider);
    procedure Open;
    procedure Close;
  published
    property Enabled: boolean read FEnabled write SetEnabled default False;
  end;

  TLogThread=class(TThread)
  strict private
    FOwner: TLogProvider;
    // procedure OnTerminateProc(Sender: TObject);
  protected
    procedure Execute; override;
  public
    constructor Create(AOwner: TLogProvider);
  end;

  TLogProvider=class(TComponent)
  strict private
    FEnabled: boolean;
    FLogThread: TLogThread;
    FGUIDList: TList<string>;
    FUserName: string;
    FLogFile: TLogFile;
    FLogClient: TLogClient;
    FCount: longword;
    FBeforeSending: TNotifyEvent;
    FAfterSending: TNotifyEvent;
    procedure Send(const aString: string; const aMessageType: TLogMessagesType);
    procedure SetEnabled(const Value: Boolean);
    function Done: boolean;
    function GetLocalHostName: string;
    function GetApplicationHandle: HWnd;
    function GetApplicationFileName: string;
    function GetApplicationFilePath: string;
    function GetFormHandle: HWnd;
    function GetFormName: string;
    procedure RefreshConnections;
    property Count: longword read FCount;
  private
    FOwnerForm: TForm;
    XMLStringsList: TList<string>;
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
  Ole2,
  XMLDoc,
  WinSock,
  Controls,
  SysUtils;

procedure register;
begin
  RegisterComponents('MyComponents', [TLogProvider]);
end;

{ TLogFile }

procedure TLogFile.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TLogFile then
    begin
      FEnabled:=TLogFile(Source).FEnabled;
      FOwner:=TLogFile(Source).FOwner;
      FFileName:=TLogFile(Source).FFileName;
      FFilePath:=TLogFile(Source).FFilePath;
      FLogKeeperData:=TLogFile(Source).FLogKeeperData;
    end;
end;

procedure TLogFile.Close;
var
  DestinationFileName: string;
  XMLFile: TXMLDocument;
begin
  if Assigned(FLogKeeperData) then
    begin
      if FilePath='' then
        FilePath:=ExtractFilePath(Application.ExeName);
      DestinationFileName:=FilePath+FileName;

      XMLFile:=TXMLDocument.Create(nil);
      try
        XMLFile.LoadFromXML(FLogKeeperData.XML);
        XMLFile.SaveToFile(DestinationFileName);
      finally
        XMLFile.Free;
      end;
    end;
end;

constructor TLogFile.Create(AOwner: TLogProvider);
begin
  inherited Create;
  FEnabled:=False;
  FOwner:=AOwner;
  FFilePath:='';
  FFileName:='LogFile.xml';
end;

destructor TLogFile.Destroy;
begin
  Close;
  inherited;
end;

function TLogFile.GetOwner: TPersistent;
begin
  Result:=FOwner;
end;

procedure TLogFile.Open;
var
  SourceFileName: string;
begin
  if FilePath='' then
    FilePath:=ExtractFilePath(Application.ExeName);
  SourceFileName:=FilePath+FileName;

  if FileExists(SourceFileName) then
    FLogKeeperData:=LoadlogKeeperData(SourceFileName)
  else
    FLogKeeperData:=NewlogKeeperData;
end;

procedure TLogFile.SetEnabled(const Value: boolean);
begin
  // если компонент уже включён, нужно его выключить и опять включить, чтобы прошла инициализация новых настроек
  if FEnabled<>Value then
    if Assigned(FOwner) then
      if not((csLoading in FOwner.ComponentState)or(csDesigning in FOwner.ComponentState)) then
        if FOwner.Enabled then
          begin
            FOwner.Enabled:=False;
            FEnabled:=Value;
            FOwner.Enabled:=True;
          end
        else
          FEnabled:=Value
      else
        FEnabled:=Value
    else
      raise EInvalidPointer.Create('Компонент-хозяин лог-файла равен NULL!');
end;

procedure TLogFile.SetFileName(const Value: string);
begin
  FFileName:=Value;
end;

procedure TLogFile.SetFilePath(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if s<>'' then
    if s[Length(s)]<>PathDelim then
      s:=s+PathDelim;
  FFilePath:=s;
end;

{ TLogClient }

procedure TLogClient.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TLogClient then
    begin
      FEnabled:=TLogClient(Source).FEnabled;
      FOwner:=TLogClient(Source).FOwner;
    end;
end;

procedure TLogClient.Close;
begin

end;

constructor TLogClient.Create(AOwner: TLogProvider);
begin
  inherited Create;
  FEnabled:=False;
  FOwner:=AOwner;
end;

function TLogClient.GetOwner: TPersistent;
begin
  Result:=FOwner;
end;

procedure TLogClient.Open;
begin

end;

procedure TLogClient.SetEnabled(const Value: boolean);
begin
  // если компонент уже включён, нужно его выключить и опять включить, чтобы прошла инициализация новых настроек
  if FEnabled<>Value then
    if Assigned(FOwner) then
      if not((csLoading in FOwner.ComponentState)or(csDesigning in FOwner.ComponentState)) then
        if FOwner.Enabled then
          begin
            FOwner.Enabled:=False;
            FEnabled:=Value;
            FOwner.Enabled:=True;
          end
        else
          FEnabled:=Value
      else
        FEnabled:=Value
    else
      raise EInvalidPointer.Create('Компонент-хозяин лог-клиента равен NULL!');
end;

{ TLogThread }

constructor TLogThread.Create(AOwner: TLogProvider);
begin
  inherited Create(True);
  FOwner:=AOwner;
  Priority:=tpLower;
  FreeOnTerminate:=False;
  // OnTerminate:=OnTerminateProc;
  // procedure TLogThread.OnTerminateProc(Sender: TObject);
  // begin
  // if FOwner<>nil then
  // if FOwner.XMLStringsList.Count>0 then
  // FOwner.XMLStringsList.Clear;
  // end;
end;

procedure TLogThread.Execute;
var
  sXML: string;
  // aCopyData: TCopyDataStruct;
  b: boolean;
  LogData: IXMLLogkeeperdataType;
  XMLFile: TXMLDocument;
//  XMLMessage: IXMLMessageType;
begin
  CoInitialize(nil);
  inherited;
{$IFDEF DEBUG}
  if Assigned(FOwner) then
    if Assigned(FOwner.FOwnerForm) then
      NameThreadForDebugging(AnsiString('TLogThread_'+FOwner.FOwnerForm.Name));
{$ENDIF}
  try
    while not Terminated do
      begin
        repeat
          b:=True;
          if Assigned(FOwner) then
            if Assigned(FOwner.XMLStringsList) then
              if FOwner.XMLStringsList.Count>0 then
                begin
                  Synchronize(
                    procedure
                    begin
                      if Assigned(FOwner) then
                        if Assigned(FOwner.XMLStringsList) then
                          if FOwner.XMLStringsList.Count>0 then
                            begin
                              sXML:=FOwner.XMLStringsList.Items[0];
                              FOwner.XMLStringsList.Delete(0);
                            end;
                    end);

                  if Assigned(FOwner.LogFile) then
                    begin
                      if FOwner.LogFile.Enabled then
                        begin
                          XMLFile:=TXMLDocument.Create(nil);
                          try
                            XMLFile.LoadFromXML(sXML);
//                            LogData:=GetLogKeeperData(XMLFile);
//                            LogData.Clear;
//                            if LogData.Count>0 then
                              begin
//                                Synchronize(
//                                  procedure
//                                  begin
//                                    XMLMessage:=FOwner.LogFile.FLogKeeperData.Add;
//                                    .Add(LogData.Message[0])
//                                  end);
                              end;
                          finally
                            { TODO -cERROR : ошибка происходит здесь!!!! }
                            FreeAndNil(XMLFile);
                          end;
                        end;
                    end;

                  Application.ProcessMessages;
                  b:=FOwner.XMLStringsList.Count<1;
                end;
        until b;
        Sleep(0);
      end;
    // если что-то нуна сделать по принудительному окончанию работы потока, это нужно добавить ТУТ
  except
    Application.HandleException(Self);
  end;
  // s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  // with aCopyData do
  // begin
  // dwData:=0;
  // cbData:=Length(s)+1;
  // lpData:=PAnsiChar(AnsiString(s));
  // end;
  // SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
  CoUnInitialize;
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

  // если мы не в режиме дизайнера
  if not(csDesigning in ComponentState) then
    begin
      XMLStringsList:=TList<string>.Create;
      FGUIDList:=TList<string>.Create;
      // создание и запуск потока
      FLogThread:=TLogThread.Create(Self);
      try
        FLogThread.Start;
      except
        Application.HandleException(Self);
      end;
    end;
end;

destructor TLogProvider.Destroy;
begin
  if not(csDesigning in ComponentState) then
    begin
      if not Done then
        if Assigned(FLogThread) then
          if (not FLogThread.Terminated)and(not FLogThread.Finished) then
            FLogThread.Suspended:=False
          else
            if Assigned(XMLStringsList) then
              if XMLStringsList.Count>0 then
                XMLStringsList.Clear;
      while not Done do
        Application.ProcessMessages;
    end;
  FEnabled:=False;
  FreeAndNil(FLogThread);
  FreeAndNil(FLogFile);
  FreeAndNil(FLogClient);
  FreeAndNil(FGUIDList);
  FreeAndNil(XMLStringsList);
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
begin
  DoBeforeSending;

  // оформление передаваемого сообщения в виде XML-документа
  dtNow:=Now;
  DecodeDate(dtNow, wYear, wMonth, wDay);
  DecodeTime(dtNow, wHour, wMinute, wSecond, wMSecond);
  Application.ProcessMessages;

  lmd:=NewlogKeeperData;
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

      if Assigned(XMLStringsList)and Assigned(FLogThread) then
        begin
          XMLStringsList.Add(lmd.XML); // добавляем новую строку
          FCount:=FCount+1;
          FLogThread.Suspended:=False; // продолжаем выполнение потока
        end;
    end;

  DoAfterSending;
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
      // только после прогрузки, и только в случае, если программа запущена на выполнение, а не находится в состоянии разработки
      if not((csLoading in ComponentState)or(csDesigning in ComponentState)) then
        RefreshConnections;
    end;
end;

procedure TLogProvider.RefreshConnections;
begin
  // только в случае, если программа запущена на выполнение, а не находится в состоянии разработки
  if not(csDesigning in ComponentState) then
    begin
      if Enabled then
        begin
          try
            // включение функций ведения лога
            if FLogFile.Enabled then
              FLogFile.Open
            else
              FLogFile.Close;

            if FLogClient.Enabled then
              begin
                // поиск клиентов
                // включение передачи данных клиенту

              end;
          except
            Application.HandleException(Self);
          end;
        end
      else
        begin
          // отключение функций ведения лога
          FLogFile.Close;
          FLogClient.Close;
        end;
    end;
end;

procedure TLogProvider.EnterMethod(const aString, aGUID: string);
begin
  if Length(aGUID)=38 then
    FGUIDList.Add(aGUID)
  else
    raise Exception.Create('Не удалось добавить элемент в список GUID методов из-за некорректной длины строки!');
  Send('['+aString+']', lmtDebug);
  Send('Начало процедуры...', lmtDebug);
end;

procedure TLogProvider.ExitMethod;
begin
  Send('Окончание процедуры.', lmtDebug);
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

function TLogProvider.Done: boolean;
begin
  Result:=True;
  if not(csDesigning in ComponentState) then
    begin
      if Assigned(XMLStringsList) then
        Result:=XMLStringsList.Count<1;
    end;
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

//initialization
//  CoInitialize(nil);
//finalization
//  CoUnInitialize;
end.
