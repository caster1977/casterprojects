unit uLogClasses;

interface

uses
  Classes,
  Generics.Collections;

type
  TLogDestination=class;
  TLogClient=class;
  TLogThread=class;
  TLogClientThread=class;

  TLogDestination=class(TPersistent)
  strict private
    FEnabled: boolean;
    FConnected: boolean;
    procedure SetEnabled(const Value: boolean);
  private
    FThread: TLogThread;
    FOwner: TComponent;
    function Done: boolean;
    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    function GetSuspended: boolean;
    procedure SetSuspended(const Value: boolean);
  protected
    Queue: TList<string>;
    function GetOwner: TPersistent; override;
    property Connected: boolean read FConnected;
    property Enabled: boolean read FEnabled write SetEnabled default False;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure AppendToQueue(const Value: string);
    property Suspended: boolean read GetSuspended write SetSuspended stored False;
    procedure Refresh;
  end;

  TLogClient=class(TLogDestination)
  private
    procedure Open; override;
    procedure Close; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled;
  end;

  TLogFile=class(TLogDestination)
  strict private
    FFileName: string;
    FFilePath: string;
    procedure SetFileName(const Value: string);
    procedure SetFilePath(const Value: string);
  private
    procedure Open; override;
    procedure Close; override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled;
    property FileName: string read FFileName write SetFileName;
    property FilePath: string read FFilePath write SetFilePath;
  end;

  TLogThread=class(TThread)
  strict private
    FOwner: TLogDestination;
    procedure OnTerminateProc(Sender: TObject);
  protected
    function GetOwner: TPersistent; virtual;
    procedure Execute; override;
  public
    constructor Create(AOwner: TLogDestination); virtual;
  end;

  TLogClientThread=class(TLogThread)
  protected
    procedure Execute; override;
  end;

  TLogFileThread=class(TLogThread)
  protected
    procedure Execute; override;
  end;

implementation

uses
  uCOMInit,
  SysUtils,
  Forms;

{ TLogThread }

constructor TLogThread.Create(AOwner: TLogDestination);
begin
  inherited Create(True);
  FOwner:=AOwner;
  Priority:=tpLower;
  FreeOnTerminate:=False;
  OnTerminate:=OnTerminateProc;
end;

procedure TLogThread.Execute;
begin
  NewCOMInitClass;
  inherited;
{$IFDEF DEBUG}
  if Assigned(FOwner) then
    NameThreadForDebugging(AnsiString(Self.ClassName+'_'+FOwner.ClassName));
{$ENDIF}
end;

function TLogThread.GetOwner: TPersistent;
begin
  Result:=FOwner;
end;

procedure TLogThread.OnTerminateProc(Sender: TObject);
begin
  if Assigned(FOwner) then
    if FOwner is TLogDestination then
      with FOwner as TLogDestination do
        if Assigned(Queue) then
          if Queue.Count>0 then
            Queue.Clear;
end;

{ TLogDestination }

procedure TLogDestination.AppendToQueue(const Value: string);
begin
  if Assigned(Queue) then
    Queue.Add(Value)
  else
    raise EInvalidPointer.Create('Объект списка очереди сообщений равен NULL!');
end;

procedure TLogDestination.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TLogDestination then
    begin
      FEnabled:=TLogDestination(Source).FEnabled;
      FOwner:=TLogDestination(Source).FOwner;
      Queue:=TLogDestination(Source).Queue;
      if TLogDestination(Source).FConnected then
        Open;
    end;
end;

constructor TLogDestination.Create(AOwner: TComponent);
begin
  inherited Create;
  if Assigned(AOWner) then
    begin
      FEnabled:=False;
      FConnected:=False;
      FOwner:=AOwner;
      if not(csDesigning in FOwner.ComponentState) then
        Queue:=TList<string>.Create;
    end
  else
    raise EInvalidPointer.Create('Компонент-владелец класса равен NULL!');
end;

destructor TLogDestination.Destroy;
begin
  Enabled:=False;
  FreeAndNil(Queue);
  inherited;
end;

function TLogDestination.Done: boolean;
begin
  Result:=True;
  if not(csDesigning in FOwner.ComponentState) then
    begin
      if Assigned(Queue) then
        Result:=Queue.Count<1;
    end;
end;

function TLogDestination.GetOwner: TPersistent;
begin
  Result:=FOwner;
end;

function TLogDestination.GetSuspended: boolean;
begin
  if Assigned(FThread) then
    Result:=FThread.Suspended
  else
    raise EInvalidPointer.Create('Поток отсутствует!');
end;

procedure TLogDestination.Refresh;
begin
  if FEnabled then
    begin
      if not FConnected then
        Open;
    end
  else
    if FConnected then
      Close;
end;

procedure TLogDestination.SetEnabled(const Value: boolean);
begin
  if FEnabled<>Value then
    begin
      FEnabled:=Value;
      if Assigned(FOwner) then
        begin
          if not((csLoading in FOwner.ComponentState)or(csDesigning in FOwner.ComponentState)) then
            Refresh;
        end
      else
        raise EInvalidPointer.Create('Компонент-владелец класса равен NULL!');
    end;
end;

procedure TLogDestination.SetSuspended(const Value: boolean);
begin
  if Assigned(FThread) then
    begin
      if FThread.Suspended<>Value then
        FThread.Suspended:=Value;
    end
  else
    raise EInvalidPointer.Create('Поток отсутствует!');
end;

{ TLogClientThread }

procedure TLogClientThread.Execute;
begin
  inherited;
end;

{ TLogClient }

procedure TLogClient.Close;
begin

end;

constructor TLogClient.Create(AOwner: TComponent);
begin
  inherited;
  if not(csDesigning in AOwner.ComponentState) then
    begin
      FThread:=TLogClientThread.Create(Self);
      try
        FThread.Start;
      except
        Application.HandleException(Self);
      end;
    end;
end;

destructor TLogClient.Destroy;
begin
  if not(csDesigning in FOwner.ComponentState) then
    begin
      if not Done then
        if Assigned(FThread) then
          if (not FThread.Terminated)and(not FThread.Finished) then
            Suspended:=False
          else
            if Assigned(Queue) then
              if Queue.Count>0 then
                Queue.Clear;
      while not Done do
        Application.ProcessMessages;
    end;
  FreeAndNil(FThread);
  inherited;
end;

procedure TLogClient.Open;
begin
  // рассылка широковещательного пакета с целью поиска клиента на текущем компе
  // рассылка широковещательного пакета по протоколу UDP с целью поиска клиентов на всех компьютерах локальной сети
end;

{ TLogFile }

procedure TLogFile.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TLogFile then
    begin
      FFileName:=TLogFile(Source).FFileName;
      FFilePath:=TLogFile(Source).FFilePath;
    end;
end;

procedure TLogFile.Close;
begin

end;

constructor TLogFile.Create(AOwner: TComponent);
begin
  inherited;
  FFilePath:='';
  FFileName:='LogFile.xml';
  if not(csDesigning in AOwner.ComponentState) then
    begin
      FThread:=TLogFileThread.Create(Self);
      try
        FThread.Start;
      except
        Application.HandleException(Self);
      end;
    end;
end;

destructor TLogFile.Destroy;
begin

  inherited;
end;

procedure TLogFile.Open;
begin

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

(*
  procedure TLogFile.SetActive(const Value: boolean);
  // var
  // SourceFileName: string;
  // DestinationFileName: string;
  // XMLFile: TXMLDocument;
  begin
  if Enabled then
  if FActive<>Value then
  begin
  if Value then
  begin
  // подключаемся к файлу лога
  // if FilePath='' then
  // FilePath:=ExtractFilePath(Application.ExeName);
  // SourceFileName:=FilePath+FileName;
  // if FileExists(SourceFileName) then
  // FLogKeeperData:=LoadlogKeeperData(SourceFileName)
  // else
  // FLogKeeperData:=NewlogKeeperData;
  end
  else
  begin
  // if Assigned(FLogKeeperData) then
  // begin
  // if FilePath='' then
  // FilePath:=ExtractFilePath(Application.ExeName);
  // DestinationFileName:=FilePath+FileName;
  //
  // //? if Assigned(FOwner) then
  // XMLFile:=TXMLDocument.Create(FOwner);
  // try
  // XMLFile.LoadFromXML(FLogKeeperData.XML);
  // XMLFile.SaveToFile(DestinationFileName);
  // finally
  // XMLFile.Free;
  // end;
  // end;
  end;
  FActive:=Value;
  end;
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

*)

(*
  procedure TLogThread.Execute;
  var
  sXML: string;
  b: boolean;
  // XMLDocument: TXMLDocument;
  // XMLLogkeeperdata: IXMLLogkeeperdataType;
  // XMLMessage: IXMLMessageType;
  // aCopyData: TCopyDataStruct;
  begin
  try
  while not Terminated do
  begin
  repeat
  b:=True;
  if Assigned(FOwner) then
  if Assigned(FOwner.XMLStringsList) then
  if FOwner.XMLStringsList.Count>0 then
  begin
  if Assigned(FOwner) then
  if Assigned(FOwner.XMLStringsList) then
  if FOwner.XMLStringsList.Count>0 then
  begin
  sXML:=FOwner.XMLStringsList.Items[0];
  Synchronize( procedure begin FOwner.XMLStringsList.Delete(0); end);
  end;

  if Assigned(FOwner.LogFile) then
  begin
  if FOwner.LogFile.Enabled then
  begin
  XMLDocument:=TXMLDocument.Create(FOwner);
  XMLDocument.LoadFromXML(sXML);
  XMLLogkeeperdata:=GetLogKeeperData(XMLDocument as IXMLDocument); { TODO -cERROR : вот это действие вызывает ошибку!!!! }
  if XMLLogkeeperdata.Count>0 then
  begin
  // Synchronize(
  // procedure
  // begin
  // XMLMessage:=FOwner.LogFile.FLogKeeperData.Add;
  // .Add(LogData.Message[0])
  // end);
  end;
  FreeAndNil(XMLDocument); { TODO -cERROR : ошибка происходит здесь!!!! }
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
  end;
*)

{ TLogFileThread }

procedure TLogFileThread.Execute;
begin
  inherited;
end;

end.
