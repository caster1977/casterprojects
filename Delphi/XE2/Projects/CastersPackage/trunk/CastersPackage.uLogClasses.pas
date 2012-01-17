unit CastersPackage.uLogClasses;

interface

uses
  Winapi.Windows,
  CastersPackage.uLogKeeperData,
  System.Classes,
  System.Generics.Collections;

type
  TLogDestination=class;
  TLogClient=class;
  TLogThread=class;
  TLogClientThread=class;

  TLogDestination=class(TPersistent)
  strict private
    FEnabled: boolean;
    procedure SetEnabled(const Value: boolean);
  private
    FConnected: boolean;
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
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure AppendToQueue(const Value: string);
    property Suspended: boolean read GetSuspended write SetSuspended stored False;
    procedure Refresh; virtual;
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
    FFileNameSuffix: string;
    FFilePath: string;
    FOpenedFileName: string;
    FFileExtension: string;
    procedure SetFileExtension(const Value: string);
    procedure SetFileNameSuffix(const Value: string);
    procedure SetFilePath(const Value: string);
    function GenerateNewFileName: string;
    function StoreFileExtension: Boolean;
    function StoreFileNameSuffix: Boolean;
  private
    FLogKeeperData: IXMLLogkeeperdataType;
    procedure Open; override;
    procedure Close; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled;
    property FilePath: string read FFilePath write SetFilePath;
    property FileExtension: string read FFileExtension write SetFileExtension stored StoreFileExtension;
    property FileNameSuffix: string read FFileNameSuffix write SetFileNameSuffix stored StoreFileNameSuffix;
  end;

  TLogThread=class(TThread)
  strict private
    procedure OnTerminateProc(Sender: TObject);
  private
    FOwner: TLogDestination;
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
  CastersPackage.uCOMInitClass,
  CastersPackage.uLogProvider,
  Xml.XMLDoc,
  Xml.XMLIntf,
  System.SysUtils,
  Vcl.Forms;

const
  DEFAULT_FILENAME_SUFFIX: string='';
  DEFAULT_FILE_EXTENSION: string='xml';

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
  inherited;
{$IFDEF DEBUG}
  if Assigned(FOwner) then
    NameThreadForDebugging(AnsiString(FOwner.FOwner.Owner.Name+'.'+GetOwner.GetNamePath+'.'+Self.ClassName));
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
      while (not Done)and Connected do
        Application.ProcessMessages;
    end;
  FreeAndNil(FThread);
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
var
  sXML: string;
  b: boolean;
begin
  inherited;
  try
    while not Terminated do
      begin
        repeat
          b:=True;
          sXML:='';
          if Assigned(FOwner) then
            if Assigned(FOwner.Queue) then
              if FOwner.Queue.Count>0 then
                begin
                  if FOwner.Connected then
                    begin
                      sXML:=FOwner.Queue.Items[0];
                      Synchronize( procedure begin FOwner.Queue.Delete(0); end);

                      { TODO : добавить код записи полученной строки в файл }

                    end;
                  b:=(FOwner.Queue.Count<1)or not FOwner.Connected;
                end;
        until b;
        Sleep(0);
      end;
    // если что-то нуна сделать по принудительному окончанию работы потока, это нужно добавить ТУТ
    Application.ProcessMessages;
  except
    Application.HandleException(Self);
  end;
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
  inherited;
end;

procedure TLogClient.Open;
begin
  // рассылка широковещательного пакета с целью поиска клиента на текущем компе
  // рассылка широковещательного пакета по протоколу UDP с целью поиска клиентов на всех компьютерах локальной сети
end;

{ TLogFile }

procedure TLogFile.Close;
var
  DestinationFileName: string;
  XMLFile: IXMLDocument;
begin
  if Assigned(FLogKeeperData) then
    begin
      if FLogKeeperData.Count>0 then
        begin
          if FOpenedFileName<>'' then
            DestinationFileName:=FOpenedFileName
          else
            DestinationFileName:=GenerateNewFileName;
          if Assigned(FOwner) then
            begin
              XMLFile:=TXMLDocument.Create(FOwner);
              try
                XMLFile.LoadFromXML(FLogKeeperData.XML);
                XMLFile.DOMDocument.insertBefore(XMLFile.DOMDocument.createProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"'), XMLFile.DOMDocument.childNodes[0]);
                XMLFile.SaveToFile(DestinationFileName);
              finally
                XMLFile:=nil;
              end;
            end;
        end;
      FOpenedFileName:='';
      FLogKeeperData:=nil;
      FConnected:=False;
    end;
end;

constructor TLogFile.Create(AOwner: TComponent);
begin
  inherited;
  FFilePath:='';
  FFileExtension:=DEFAULT_FILE_EXTENSION;
  FOpenedFileName:='';
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

function TLogFile.GenerateNewFileName: string;
begin
  if FilePath='' then
    FilePath:=ExtractFilePath(Application.ExeName);
  Result:=Result+'LogKeeperFile_'+FormatDateTime('yyyymmddhhnnsszzz', Now);
  if FileNameSuffix<>'' then
    Result:=Result+'_';
  Result:=Result+FileNameSuffix+'.'+FFileExtension;
end;

procedure TLogFile.Open;
var
  SourceFileName: string;
  Doc: IXMLDocument;
begin
  SourceFileName:=GenerateNewFileName;
  try
    if FileExists(SourceFileName) then
      FLogKeeperData:=LoadlogKeeperData(SourceFileName)
    else
      Doc:=TXMLDocument.Create(FOwner);
    try
      Doc.Active:=True;
      if Doc.Version<>'' then
        Doc.Version:='1.0';
      FLogKeeperData:=GetLogKeeperData(Doc);
    finally
      Doc:=nil;
    end;
  except
    Application.HandleException(Self);
  end;
  FConnected:=Assigned(FLogKeeperData);
  if FConnected then
    FOpenedFileName:=SourceFileName;
end;

procedure TLogFile.SetFileExtension(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FFileExtension<>s then
    if s<>'' then
      FFileExtension:=s
    else
      FFileExtension:=DEFAULT_FILE_EXTENSION;
end;

procedure TLogFile.SetFileNameSuffix(const Value: string);
begin
  if Trim(Value)<>FFileNameSuffix then
    FFileNameSuffix:=Trim(Value);
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

function TLogFile.StoreFileExtension: Boolean;
begin
  Result:=FileExtension<>DEFAULT_FILE_EXTENSION;
end;

function TLogFile.StoreFileNameSuffix: Boolean;
begin
  Result:=FileNameSuffix<>DEFAULT_FILENAME_SUFFIX;
end;

(*
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

  var
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
*)

{ TLogFileThread }

procedure TLogFileThread.Execute;
var
  sXML: string;
  b: boolean;
  XMLDocument: IXMLDocument;
  XMLLogkeeperdata: IXMLLogkeeperdataType;
  XMLMessageSource, XMLMessageDestination: IXMLMessageType;
begin
  NewCOMInitClass;
  inherited;
  try
    while not Terminated do
      begin
        repeat
          b:=True;
          sXML:='';
          if Assigned(FOwner) then
            if Assigned(FOwner.Queue) then
              if FOwner.Queue.Count>0 then
                begin
                  if FOwner.Connected then
                    begin
                      sXML:=FOwner.Queue.Items[0];
                      Synchronize( procedure begin FOwner.Queue.Delete(0); end);

                      if FOwner.Enabled then
                        begin
                          XMLDocument:=TXMLDocument.Create(FOwner.FOwner);
                          XMLDocument.LoadFromXML(sXML);
                          XMLLogkeeperdata:=GetLogKeeperData(XMLDocument as IXMLDocument);
                          if XMLLogkeeperdata.Count>0 then
                            begin
                              if FOwner is TLogFile then
                                if Assigned(TLogFile(FOwner).FLogKeeperData) then
                                  begin
                                    Synchronize( procedure begin XMLMessageSource:=XMLLogkeeperdata.Message[0]; XMLMessageDestination:=TLogFile(FOwner).FLogKeeperData.Add; XMLMessageDestination.Index:=XMLMessageSource.Index;
                                      XMLMessageDestination.Date.Day:=XMLMessageSource.Date.Day; XMLMessageDestination.Date.Month:=XMLMessageSource.Date.Month; XMLMessageDestination.Date.Year:=XMLMessageSource.Date.Year;
                                      XMLMessageDestination.Time.Hour:=XMLMessageSource.Time.Hour; XMLMessageDestination.Time.Minute:=XMLMessageSource.Time.Minute; XMLMessageDestination.Time.Second:=XMLMessageSource.Time.Second;
                                      XMLMessageDestination.Time.Msecond:=XMLMessageSource.Time.Msecond; XMLMessageDestination.Host:=XMLMessageSource.Host; XMLMessageDestination.Application.Handle:=XMLMessageSource.Application.Handle;
                                      XMLMessageDestination.Application.Filename:=XMLMessageSource.Application.Filename; XMLMessageDestination.Application.Filepath:=XMLMessageSource.Application.Filepath;
                                      XMLMessageDestination.Application.Form.Handle:=XMLMessageSource.Application.Form.Handle; XMLMessageDestination.Application.Form.Name:=XMLMessageSource.Application.Form.Name;
                                      XMLMessageDestination.Application.Method.Guid:=XMLMessageSource.Application.Method.Guid; XMLMessageDestination.Application.User:=XMLMessageSource.Application.User;
                                      XMLMessageDestination.MessageType:=XMLMessageSource.MessageType; XMLMessageDestination.Text:=XMLMessageSource.Text; end);
                                    XMLMessageSource:=nil;
                                    XMLMessageDestination:=nil;
                                  end;
                            end;
                          XMLLogkeeperdata:=nil;
                          XMLDocument:=nil;
                        end;

                    end;
                  b:=(FOwner.Queue.Count<1)or not FOwner.Connected;
                end;
        until b;
        Sleep(0);
      end;
  except
    Application.HandleException(Self);
  end;
end;

end.
