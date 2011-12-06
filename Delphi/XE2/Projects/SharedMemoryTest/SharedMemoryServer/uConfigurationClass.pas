/// <summary>
/// Модуль-обёртка класса TConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uConfigurationClass;

interface

uses
  uCommon;

type
  TConfigurationClass=class
  strict private
    FIniFileName: string;
    FSharedMemSize: cardinal;
    FSharedMemoryName: WideString;
    FKeepLogTypes: TLogMessagesTypes;
    FShowStatusbar: boolean;
    FScrollLogToBottom: boolean;
    FShowSplashAtStart: boolean;
    FRetranslatorPause: integer;
    FDestinationFolder: string;
    procedure SetSharedMemSize(const Value: cardinal);
    procedure SetSharedMemoryName(const Value: WideString);
    procedure SetRetranslatorPause(const Value: integer);
    function GetDestinationFolder: string;
    procedure SetDestinationFolder(const Value: string);
    procedure SetScrollLogToBottom(const Value: boolean);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    procedure SetShowStatusbar(const Value: boolean);
    procedure SetShowSplashAtStart(const Value: boolean);
  public
    constructor Create(const IniFileName: string='');
    procedure Load;
    procedure Save;
    property SharedMemSize: cardinal read FSharedMemSize write SetSharedMemSize default CONST_DEFAULTVALUE_SHAREDMEMSIZE;
    property SharedMemoryName: WideString read FSharedMemoryName write SetSharedMemoryName stored False;
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError, lmtWarning, lmtInfo];
    property ShowStatusbar: boolean read FShowStatusbar write SetShowStatusbar default True;
    property ScrollLogToBottom: boolean read FScrollLogToBottom write SetScrollLogToBottom stored False;
    property ShowSplashAtStart: boolean read FShowSplashAtStart write SetShowSplashAtStart default True;
    property RetranslatorPause: integer read FRetranslatorPause write SetRetranslatorPause default CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
    property DestinationFolder: string read GetDestinationFolder write SetDestinationFolder stored False;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  System.IniFiles;

resourcestring
  TEXT_WRONGSHAREDMEMORYNAME='Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE='Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGINIFILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME='Имя каталога для сохранения переданных файлов не должно быть пустым!';
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='Каталог для сохранения переданных файлов не существует!';

constructor TConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create;
  if Trim(IniFileName)='' then
    FIniFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase])
  else
    FIniFileName:=Trim(IniFileName);
  FSharedMemSize:=CONST_DEFAULTVALUE_SHAREDMEMSIZE;
  FRetranslatorPause:=CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
  FSharedMemoryName:='';
  FKeepLogTypes:=CONST_DEFAULTVALUE_KEEPLOGTYPES;
  FShowStatusbar:=CONST_DEFAULTVALUE_SHOWSTATUSBAR;
  FDestinationFolder:=CONST_DEFAULTVALUE_DESTINATIONFOLDER;
  FScrollLogToBottom:=False;
end;

procedure TConfigurationClass.Load;
begin
  if FIniFileName>'' then
    with TIniFile.Create(FIniFileName) do
      try
        SharedMemSize:=cardinal(ReadInteger('Общие', 'iSharedMemSize', CONST_DEFAULTVALUE_SHAREDMEMSIZE));
        ScrollLogToBottom:=ReadBool('Интерфейс', 'bScrollLogToBottom', CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM);
        ShowStatusbar:=ReadBool('Интерфейс', 'bShowStatusbar', CONST_DEFAULTVALUE_SHOWSTATUSBAR);
        ShowSplashAtStart:=ReadBool('Интерфейс', 'bShowSplashAtStart', CONST_DEFAULTVALUE_SHOWSPLASHATSTART);
        if ReadBool('Протоколирование', 'bKeepErrorLog', lmtError in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
          KeepLogTypes:=KeepLogTypes+[lmtError]
        else
          KeepLogTypes:=KeepLogTypes-[lmtError];
        if ReadBool('Протоколирование', 'bKeepWarningLog', lmtWarning in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
          KeepLogTypes:=KeepLogTypes+[lmtWarning]
        else
          KeepLogTypes:=KeepLogTypes-[lmtWarning];
        if ReadBool('Протоколирование', 'bKeepInfoLog', lmtInfo in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
          KeepLogTypes:=KeepLogTypes+[lmtInfo]
        else
          KeepLogTypes:=KeepLogTypes-[lmtInfo];
        if ReadBool('Протоколирование', 'bKeepDebugLog', lmtDebug in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
          KeepLogTypes:=KeepLogTypes+[lmtDebug]
        else
          KeepLogTypes:=KeepLogTypes-[lmtDebug];
        RetranslatorPause:=ReadInteger('Общие', 'iRetranslatorPause', CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
        DestinationFolder:=ReadString('Общие', 'sDestinationFolder', CONST_DEFAULTVALUE_DESTINATIONFOLDER);
      finally
        Free;
      end
  else
    raise Exception.Create(TEXT_WRONGINIFILENAME);
end;

procedure TConfigurationClass.Save;
begin
  if FIniFileName>'' then
    with TIniFile.Create(FIniFileName) do
      try
        try
          WriteInteger('Общие', 'iSharedMemSize', SharedMemSize);
          WriteBool('Интерфейс', 'bScrollLogToBottom', ScrollLogToBottom);
          WriteBool('Интерфейс', 'bShowStatusbar', ShowStatusbar);
          WriteBool('Интерфейс', 'bShowSplashAtStart', ShowSplashAtStart);
          WriteBool('Протоколирование', 'bKeepErrorLog', lmtError in KeepLogTypes);
          WriteBool('Протоколирование', 'bKeepWarningLog', lmtWarning in KeepLogTypes);
          WriteBool('Протоколирование', 'bKeepInfoLog', lmtInfo in KeepLogTypes);
          WriteBool('Протоколирование', 'bKeepDebugLog', lmtDebug in KeepLogTypes);
          WriteInteger('Общие', 'iRetranslatorPause', RetranslatorPause);
          WriteString('Общие', 'sDestinationFolder', DestinationFolder);
        except
          on EIniFileException do
            raise EIniFileException.Create(TEXT_INIFILESAVEERROR);
        end;
      finally
        Free;
      end
  else
    raise Exception.Create(TEXT_WRONGINIFILENAME);
end;

procedure TConfigurationClass.SetSharedMemSize(const Value: cardinal);
begin
  if Value<=0 then
    raise Exception.Create(TEXT_WRONGBUFFERSIZE)
  else
    if FSharedMemSize<>Value then
      FSharedMemSize:=Value;
end;

function TConfigurationClass.GetDestinationFolder: string;
begin
  if FDestinationFolder<>'' then
    Result:=FDestinationFolder
  else
    Result:=ExtractFilePath(ExpandFileName(Application.ExeName));
end;

procedure TConfigurationClass.SetDestinationFolder(const Value: string);
begin
  if FDestinationFolder<>Value then
    if Trim(Value)<>'' then
      if DirectoryExists(Trim(Value)) then
        begin
          FDestinationFolder:=Trim(Value);
          if FDestinationFolder[Length(FDestinationFolder)]<>'\' then
            FDestinationFolder:=FDestinationFolder+'\';
        end
      else
        raise Exception.Create(TEXT_WRONGDESTINATIONFOLDER_NONEXISTS)
    else
      raise Exception.Create(TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME);
end;

procedure TConfigurationClass.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes:=Value;
end;

{
  procedure TConfigurationClass.SetIniFileName(const Value: string);
  begin
  if FIniFileName<>Value then
  if Trim(Value)<>'' then
  FIniFileName:=Trim(Value)
  else
  raise Exception.Create(TEXT_WRONGINIFILENAME);
  end;
}

procedure TConfigurationClass.SetRetranslatorPause(const Value: integer);
begin
  if Value<0 then
    raise Exception.Create(TEXT_WRONGRETRANSLATORPAUSE)
  else
    if FRetranslatorPause<>Value then
      FRetranslatorPause:=Value;
end;

procedure TConfigurationClass.SetScrollLogToBottom(const Value: boolean);
begin
  if FScrollLogToBottom<>Value then
    FScrollLogToBottom:=Value;
end;

procedure TConfigurationClass.SetSharedMemoryName(const Value: WideString);
begin
  if FSharedMemoryName<>Value then
    if Trim(Value)<>'' then
      FSharedMemoryName:=Trim(Value)
    else
      raise Exception.Create(TEXT_WRONGSHAREDMEMORYNAME);
end;

procedure TConfigurationClass.SetShowSplashAtStart(const Value: boolean);
begin
  if FShowSplashAtStart<>Value then
    FShowSplashAtStart:=Value;
end;

procedure TConfigurationClass.SetShowStatusbar(const Value: boolean);
begin
  if FShowStatusbar<>Value then
    FShowStatusbar:=Value;
end;

end.
