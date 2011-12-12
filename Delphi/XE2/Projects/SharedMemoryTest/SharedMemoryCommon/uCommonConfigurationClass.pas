/// <summary>
/// Модуль-обёртка класса TCommonConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uCommonConfigurationClass;

interface

uses
  uCommon;

type
  TCommonConfigurationClass=class
  strict private
    FSharedMemSize: cardinal;
    FSharedMemoryName: WideString;
    FKeepLogTypes: TLogMessagesTypes;
    FShowStatusbar: boolean;
    FScrollLogToBottom: boolean;
    FShowSplashAtStart: boolean;
    FWatchPause: cardinal;
    procedure SetSharedMemSize(const Value: cardinal);
    procedure SetSharedMemoryName(const Value: WideString);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    procedure SetShowStatusbar(const Value: boolean);
    procedure SetScrollLogToBottom(const Value: boolean);
    procedure SetShowSplashAtStart(const Value: boolean);
    procedure SetWatchPause(const Value: cardinal);
  strict protected
    FIniFileName: string;
    procedure Load; virtual; abstract;
    procedure Save; virtual; abstract;
    property SharedMemoryName: WideString read FSharedMemoryName write SetSharedMemoryName stored False;
    property SharedMemSize: cardinal read FSharedMemSize write SetSharedMemSize default CONST_DEFAULTVALUE_SHAREDMEMSIZE;
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default [lmtError, lmtWarning, lmtInfo];
    property ShowStatusbar: boolean read FShowStatusbar write SetShowStatusbar default True;
    property ScrollLogToBottom: boolean read FScrollLogToBottom write SetScrollLogToBottom stored False;
    property ShowSplashAtStart: boolean read FShowSplashAtStart write SetShowSplashAtStart default True;
    property WatchPause: cardinal read FWatchPause write SetWatchPause default CONST_DEFAULTVALUE_WATCHPAUSE;
  public
    constructor Create(const IniFileName: string='');
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  System.IniFiles;

resourcestring
  TEXT_WRONGBUFFERSIZE='Размер буфера для передачи данных не должен быть менее килобайта!';
  TEXT_WRONGSHAREDMEMORYNAME='Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE='Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGINIFILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME='Имя каталога для сохранения переданных файлов не должно быть пустым!';
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='Каталог для сохранения переданных файлов не существует!';

constructor TCommonConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create;
  if Trim(IniFileName)='' then
    FIniFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase])
  else
    FIniFileName:=Trim(IniFileName);
  FSharedMemoryName:='';
  FSharedMemSize:=CONST_DEFAULTVALUE_SHAREDMEMSIZE;
  FKeepLogTypes:=CONST_DEFAULTVALUE_KEEPLOGTYPES;
  FShowStatusbar:=CONST_DEFAULTVALUE_SHOWSTATUSBAR;
  FScrollLogToBottom:=False;
  FShowSplashAtStart:=True;
  FWatchPause:=CONST_DEFAULTVALUE_WATCHPAUSE;
end;

procedure TCommonConfigurationClass.SetSharedMemSize(const Value: cardinal);
begin
  if Value<=CONST_DEFAULTVALUE_MINSHAREDMEMSIZE then
    raise Exception.Create(TEXT_WRONGBUFFERSIZE)
  else
    if FSharedMemSize<>Value then
      FSharedMemSize:=Value;
end;

procedure TCommonConfigurationClass.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes:=Value;
end;

procedure TCommonConfigurationClass.SetScrollLogToBottom(const Value: boolean);
begin
  if FScrollLogToBottom<>Value then
    FScrollLogToBottom:=Value;
end;

procedure TCommonConfigurationClass.SetSharedMemoryName(const Value: WideString);
begin
  if FSharedMemoryName<>Value then
    if Trim(Value)<>'' then
      FSharedMemoryName:=Trim(Value)
    else
      raise Exception.Create(TEXT_WRONGSHAREDMEMORYNAME);
end;

procedure TCommonConfigurationClass.SetShowSplashAtStart(const Value: boolean);
begin
  if FShowSplashAtStart<>Value then
    FShowSplashAtStart:=Value;
end;

procedure TCommonConfigurationClass.SetShowStatusbar(const Value: boolean);
begin
  if FShowStatusbar<>Value then
    FShowStatusbar:=Value;
end;

procedure TCommonConfigurationClass.SetWatchPause(const Value: cardinal);
begin
  if FWatchPause<>Value then
    FWatchPause:=Value;
end;

end.
