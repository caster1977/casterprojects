/// <summary>
/// Модуль-обёртка класса TCommonConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uCommonConfigurationClass;

interface

uses
  System.IniFiles,
  uCommon;

const
  CONST_DEFAULTVALUE_SHAREDMEMSIZE=32768;
  CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM=True;
  CONST_DEFAULTVALUE_SHOWSTATUSBAR=True;
  CONST_DEFAULTVALUE_SHOWSPLASHATSTART=True;
  CONST_DEFAULTVALUE_KEEPLOGTYPES=[lmtError, lmtWarning, lmtInfo];

resourcestring
  TEXT_SECTION_COMMON='Общие';
  TEXT_SECTION_INTERFACE='Интерфейс';
  TEXT_SECTION_LOG='Протоколирование';

type
  TFormPosition=record
    Centered, Maximized: boolean;
    Left, Top, Width, Height: integer;
  end;

  TCommonConfigurationClass=class
  strict private
    FSharedMemSize: cardinal;
    FSharedMemoryName: WideString;
    FKeepLogTypes: TLogMessagesTypes;
    FShowStatusbar: boolean;
    FScrollLogToBottom: boolean;
    FShowSplashAtStart: boolean;
    FWatchPause: cardinal;
    FConfigurationFormPosition: TFormPosition;
    FMainFormPosition: TFormPosition;
    procedure SetSharedMemSize(const Value: cardinal);
    procedure SetSharedMemoryName(const Value: WideString);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    procedure SetShowStatusbar(const Value: boolean);
    procedure SetScrollLogToBottom(const Value: boolean);
    procedure SetShowSplashAtStart(const Value: boolean);
    procedure SetWatchPause(const Value: cardinal);
  strict private
    procedure SetConfigurationFormPosition(const Value: TFormPosition);
  private
    procedure SetMainFormPosition(const Value: TFormPosition);
  protected
    FIniFileName: string;
    procedure Loading(const IniFile: TIniFile); virtual;
    procedure Saving(const IniFile: TIniFile); virtual;
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes default CONST_DEFAULTVALUE_KEEPLOGTYPES;
    property ShowStatusbar: boolean read FShowStatusbar write SetShowStatusbar default CONST_DEFAULTVALUE_SHOWSTATUSBAR;
    property ScrollLogToBottom: boolean read FScrollLogToBottom write SetScrollLogToBottom default CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM;
    property ShowSplashAtStart: boolean read FShowSplashAtStart write SetShowSplashAtStart default CONST_DEFAULTVALUE_SHOWSPLASHATSTART;
    property SharedMemoryName: WideString read FSharedMemoryName write SetSharedMemoryName stored False;
    property SharedMemSize: cardinal read FSharedMemSize write SetSharedMemSize default CONST_DEFAULTVALUE_SHAREDMEMSIZE;
    property WatchPause: cardinal read FWatchPause write SetWatchPause default CONST_DEFAULTVALUE_WATCHPAUSE;
    property ConfigurationFormPosition: TFormPosition read FConfigurationFormPosition write SetConfigurationFormPosition stored False;
    property MainFormPosition: TFormPosition read FMainFormPosition write SetMainFormPosition stored False;
  public
    constructor Create(const IniFileName: string='');
    procedure Load;
    procedure Save;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils;

const
  CONST_DEFAULTVALUE_FORMPOSITION_CENTERED: boolean=True;
  CONST_DEFAULTVALUE_FORMPOSITION_LEFT: integer=0;
  CONST_DEFAULTVALUE_FORMPOSITION_TOP: integer=0;

  CONST_DEFAULTVALUE_MAINFORM_CENTERED: boolean=True;
  CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED: boolean=False;
  CONST_DEFAULTVALUE_MAINFORM_LEFT: integer=0;
  CONST_DEFAULTVALUE_MAINFORM_TOP: integer=0;
  CONST_DEFAULTVALUE_MAINFORM_WIDTH: integer=800;
  CONST_DEFAULTVALUE_MAINFORM_HEIGHT: integer=600;

resourcestring
  TEXT_WRONGBUFFERSIZE='Размер буфера для передачи данных не должен быть менее килобайта!';
  TEXT_WRONGSHAREDMEMORYNAME='Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE='Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGINIFILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME='Имя каталога для сохранения переданных файлов не должно быть пустым!';
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='Каталог для сохранения переданных файлов не существует!';
  TEXT_WRONGWATCHPAUSE='Пауза между циклами опроса состояния подключения не должна быть ниже минимального значения в 0,1 секунды!';
  TEXT_WRONG_INIFILE_NAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_ERROR_SAVE_INIFILE='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

  TEXT_SECTION_FORMPOSITION='Размеры и положение окон';

  TEXT_VARNAME_SCROLLLOGTOBOTTOM='bScrollLogToBottom';
  TEXT_VARNAME_SHOWSTATUSBAR='bShowStatusbar';
  TEXT_VARNAME_SHOWSPASHATSTART='bShowSplashAtStart';
  TEXT_VARNAME_KEEPERRORLOG='bKeepErrorLog';
  TEXT_VARNAME_KEEPWARNINGLOG='bKeepWarningLog';
  TEXT_VARNAME_KEEPINFOLOG='bKeepInfoLog';
  TEXT_VARNAME_KEEPDEBUGLOG='bKeepDebugLog';
  TEXT_VARNAME_WATCHPAUSE='iWatchPause';

  TEXT_VARNAME_CONFIRURATIONFORMPOSITION_CENTERED='ConfigurationFormPosition.bCentered';
  TEXT_VARNAME_CONFIRURATIONFORMPOSITION_LEFT='ConfigurationFormPosition.iLeft';
  TEXT_VARNAME_CONFIRURATIONFORMPOSITION_TOP='ConfigurationFormPosition.iTop';

  TEXT_VARNAME_MAINFORMPOSITION_CENTERED='MainFormPosition.bCentered';
  TEXT_VARNAME_MAINFORMPOSITION_MAXIMIZED='MainFormPosition.bMaximized';
  TEXT_VARNAME_MAINFORMPOSITION_LEFT='MainFormPosition.iLeft';
  TEXT_VARNAME_MAINFORMPOSITION_TOP='MainFormPosition.iTop';
  TEXT_VARNAME_MAINFORMPOSITION_WIDTH='MainFormPosition.iWidth';
  TEXT_VARNAME_MAINFORMPOSITION_HEIGHT='MainFormPosition.iHeight';

constructor TCommonConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create;
  if Trim(IniFileName)='' then
    FIniFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase])
  else
    FIniFileName:=Trim(IniFileName);
  FWatchPause:=CONST_DEFAULTVALUE_WATCHPAUSE;
  FSharedMemoryName:='';
  FSharedMemSize:=CONST_DEFAULTVALUE_SHAREDMEMSIZE;
  FShowStatusbar:=CONST_DEFAULTVALUE_SHOWSTATUSBAR;
  FScrollLogToBottom:=CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM;
  FShowSplashAtStart:=CONST_DEFAULTVALUE_SHOWSPLASHATSTART;
  FKeepLogTypes:=CONST_DEFAULTVALUE_KEEPLOGTYPES;
end;

procedure TCommonConfigurationClass.SetSharedMemSize(const Value: cardinal);
begin
  if Value<CONST_MINVALUE_SHAREDMEMSIZE then
    raise Exception.Create(TEXT_WRONGBUFFERSIZE)
  else
    if FSharedMemSize<>Value then
      FSharedMemSize:=Value;
end;

procedure TCommonConfigurationClass.Load;
var
  IniFile: TIniFile;
begin
  if FIniFileName>'' then
    begin
      IniFile:=TIniFile.Create(FIniFileName);
      try
        Loading(IniFile);
      finally
        IniFile.Free;
      end
    end
  else
    raise Exception.Create(TEXT_WRONG_INIFILE_NAME);
end;

procedure TCommonConfigurationClass.Loading(const IniFile: TIniFile);
var
  FormPosition: TFormPosition;
begin
  with IniFile do
    begin
      ScrollLogToBottom:=ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SCROLLLOGTOBOTTOM, CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM);
      ShowStatusbar:=ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSTATUSBAR, CONST_DEFAULTVALUE_SHOWSTATUSBAR);
      ShowSplashAtStart:=ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSPASHATSTART, CONST_DEFAULTVALUE_SHOWSPLASHATSTART);
      if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPERRORLOG, lmtError in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
        KeepLogTypes:=KeepLogTypes+[lmtError]
      else
        KeepLogTypes:=KeepLogTypes-[lmtError];
      if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPWARNINGLOG, lmtWarning in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
        KeepLogTypes:=KeepLogTypes+[lmtWarning]
      else
        KeepLogTypes:=KeepLogTypes-[lmtWarning];
      if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPINFOLOG, lmtInfo in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
        KeepLogTypes:=KeepLogTypes+[lmtInfo]
      else
        KeepLogTypes:=KeepLogTypes-[lmtInfo];
      if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPDEBUGLOG, lmtDebug in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
        KeepLogTypes:=KeepLogTypes+[lmtDebug]
      else
        KeepLogTypes:=KeepLogTypes-[lmtDebug];
      WatchPause:=ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, CONST_DEFAULTVALUE_WATCHPAUSE);

      FormPosition.Centered:=ReadBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_CENTERED, CONST_DEFAULTVALUE_FORMPOSITION_CENTERED);
      FormPosition.Left:=ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_LEFT, CONST_DEFAULTVALUE_FORMPOSITION_LEFT);
      FormPosition.Top:=ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_TOP, CONST_DEFAULTVALUE_FORMPOSITION_TOP);
      ConfigurationFormPosition:=FormPosition;

      FormPosition.Centered:=ReadBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_CENTERED, CONST_DEFAULTVALUE_MAINFORM_CENTERED);
      FormPosition.Maximized:=ReadBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_MAXIMIZED, CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED);
      FormPosition.Left:=ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_LEFT, CONST_DEFAULTVALUE_MAINFORM_LEFT);
      FormPosition.Top:=ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_TOP, CONST_DEFAULTVALUE_MAINFORM_TOP);
      FormPosition.Width:=ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_WIDTH, CONST_DEFAULTVALUE_MAINFORM_WIDTH);
      FormPosition.Height:=ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_HEIGHT, CONST_DEFAULTVALUE_MAINFORM_HEIGHT);
      MainFormPosition:=FormPosition;
    end;
end;

procedure TCommonConfigurationClass.Save;
var
  IniFile: TIniFile;
begin
  if FIniFileName>'' then
    begin
      IniFile:=TIniFile.Create(FIniFileName);
      try
        try
          Saving(IniFile);
        except
          on EIniFileException do
            raise EIniFileException.Create(TEXT_ERROR_SAVE_INIFILE);
        end;
      finally
        IniFile.Free;
      end
    end
  else
    raise Exception.Create(TEXT_WRONG_INIFILE_NAME);
end;

procedure TCommonConfigurationClass.Saving(const IniFile: TIniFile);
begin
  with IniFile do
    begin
      WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SCROLLLOGTOBOTTOM, ScrollLogToBottom);
      WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSTATUSBAR, ShowStatusbar);
      WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSPASHATSTART, ShowSplashAtStart);
      WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPERRORLOG, lmtError in KeepLogTypes);
      WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPWARNINGLOG, lmtWarning in KeepLogTypes);
      WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPINFOLOG, lmtInfo in KeepLogTypes);
      WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPDEBUGLOG, lmtDebug in KeepLogTypes);
      WriteInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, WatchPause);

      WriteBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_CENTERED, ConfigurationFormPosition.Centered);
      WriteInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_LEFT, ConfigurationFormPosition.Left);
      WriteInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_TOP, ConfigurationFormPosition.Top);

      WriteBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_CENTERED, MainFormPosition.Centered);
      WriteBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_MAXIMIZED, MainFormPosition.Maximized);
      WriteInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_LEFT, MainFormPosition.Left);
      WriteInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_TOP, MainFormPosition.Top);
      WriteInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_WIDTH, MainFormPosition.Width);
      WriteInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_HEIGHT, MainFormPosition.Height);
    end;
end;

procedure TCommonConfigurationClass.SetConfigurationFormPosition(const Value: TFormPosition);
begin
  if ((FConfigurationFormPosition.Centered<>Value.Centered)or(FConfigurationFormPosition.Top<>Value.Top)or(FConfigurationFormPosition.Left<>Value.Left)or(FConfigurationFormPosition.Width<>Value.Width)or
    (FConfigurationFormPosition.Height<>Value.Height)) then
    FConfigurationFormPosition:=Value;
end;

procedure TCommonConfigurationClass.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes<>Value then
    FKeepLogTypes:=Value;
end;

procedure TCommonConfigurationClass.SetMainFormPosition(const Value: TFormPosition);
begin
  if ((FMainFormPosition.Centered<>Value.Centered)or(FMainFormPosition.Top<>Value.Top)or(FMainFormPosition.Left<>Value.Left)or(FMainFormPosition.Width<>Value.Width)or(FMainFormPosition.Height<>Value.Height)) then
    FMainFormPosition:=Value;
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
  if Value<CONST_MINVALUE_WATCHPAUSE then
    raise Exception.Create(TEXT_WRONGWATCHPAUSE)
  else
    if FWatchPause<>Value then
      FWatchPause:=Value;
end;

end.
