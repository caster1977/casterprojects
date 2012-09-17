/// <summary>
/// Модуль-обёртка класса TCommonConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryCommon.uCommonConfigurationClass;

interface

uses
  System.IniFiles,
  SharedMemoryCommon.uCommon;

const
  CONST_DEFAULTVALUE_CONFIGURATIONFORMPAGE = 0;
  CONST_DEFAULTVALUE_FORMPOSITION_CENTERED: boolean = True;
  CONST_DEFAULTVALUE_FORMPOSITION_LEFT: integer = 0;
  CONST_DEFAULTVALUE_FORMPOSITION_TOP: integer = 0;
  CONST_DEFAULTVALUE_KEEPLOGTYPES = [lmtError, lmtWarning, lmtInfo];
  CONST_DEFAULTVALUE_MAINFORM_CENTERED: boolean = True;
  CONST_DEFAULTVALUE_MAINFORM_HEIGHT: integer = 600;
  CONST_DEFAULTVALUE_MAINFORM_LEFT: integer = 0;
  CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED: boolean = False;
  CONST_DEFAULTVALUE_MAINFORM_TOP: integer = 0;
  CONST_DEFAULTVALUE_MAINFORM_WIDTH: integer = 800;
  CONST_DEFAULTVALUE_PLAYSOUNDONCOMPLETE = True;
  CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM = True;
  CONST_DEFAULTVALUE_SHAREDMEMSIZE = 65536;
  CONST_DEFAULTVALUE_SHOWCONFIRMATIONONQUIT = True;
  CONST_DEFAULTVALUE_SHOWSPLASHATSTART = True;
  CONST_DEFAULTVALUE_SHOWSTATUSBAR = True;

resourcestring
  TEXT_SECTION_COMMON = 'Общие';
  TEXT_SECTION_INTERFACE = 'Интерфейс';
  TEXT_SECTION_LOG = 'Протоколирование';

type
  TFormPosition = record
    Centered, Maximized: boolean;
    Left, Top, Width, Height: integer;
  end;

  TCommonConfigurationClass = class
  strict private
    FConfigurationFormPage: integer;
    FConfigurationFormPosition: TFormPosition;
    FKeepLogTypes: TLogMessagesTypes;
    FMainFormPosition: TFormPosition;
    FPlaySoundOnComplete: boolean;
    FScrollLogToBottom: boolean;
    FSharedMemoryName: WideString;
    FSharedMemSize: cardinal;
    FShowConfirmationOnQuit: boolean;
    FShowSplashAtStart: boolean;
    FShowStatusbar: boolean;
    FWatchPause: cardinal;
    procedure SetConfigurationFormPosition(const Value: TFormPosition);
    procedure SetKeepLogTypes(const Value: TLogMessagesTypes);
    procedure SetMainFormPosition(const Value: TFormPosition);
    procedure SetPlaySoundOnComplete(const Value: boolean);
    procedure SetScrollLogToBottom(const Value: boolean);
    procedure SetSharedMemoryName(const Value: WideString);
    procedure SetSharedMemSize(const Value: cardinal);
    procedure SetShowConfirmationOnQuit(const Value: boolean);
    procedure SetShowSplashAtStart(const Value: boolean);
    procedure SetShowStatusbar(const Value: boolean);
    procedure SetWatchPause(const Value: cardinal);
  protected
    FIniFileName: string;
    procedure Loading(const IniFile: TIniFile); virtual;
    procedure Saving(const IniFile: TIniFile); virtual;
    property ConfigurationFormPage: integer read FConfigurationFormPage write FConfigurationFormPage
      default CONST_DEFAULTVALUE_CONFIGURATIONFORMPAGE;
    property ConfigurationFormPosition: TFormPosition read FConfigurationFormPosition write SetConfigurationFormPosition
      stored False;
    property KeepLogTypes: TLogMessagesTypes read FKeepLogTypes write SetKeepLogTypes
      default CONST_DEFAULTVALUE_KEEPLOGTYPES;
    property MainFormPosition: TFormPosition read FMainFormPosition write SetMainFormPosition stored False;
    property PlaySoundOnComplete: boolean read FPlaySoundOnComplete write SetPlaySoundOnComplete
      default CONST_DEFAULTVALUE_PLAYSOUNDONCOMPLETE;
    property ScrollLogToBottom: boolean read FScrollLogToBottom write SetScrollLogToBottom
      default CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM;
    property SharedMemoryName: WideString read FSharedMemoryName write SetSharedMemoryName stored False;
    property SharedMemSize: cardinal read FSharedMemSize write SetSharedMemSize default CONST_DEFAULTVALUE_SHAREDMEMSIZE;
    property ShowConfirmationOnQuit: boolean read FShowConfirmationOnQuit write SetShowConfirmationOnQuit
      default CONST_DEFAULTVALUE_SHOWCONFIRMATIONONQUIT;
    property ShowSplashAtStart: boolean read FShowSplashAtStart write SetShowSplashAtStart
      default CONST_DEFAULTVALUE_SHOWSPLASHATSTART;
    property ShowStatusbar: boolean read FShowStatusbar write SetShowStatusbar default CONST_DEFAULTVALUE_SHOWSTATUSBAR;
    property WatchPause: cardinal read FWatchPause write SetWatchPause default CONST_DEFAULTVALUE_WATCHPAUSE;
  public
    constructor Create(const IniFileName: string = '');
    procedure Load;
    procedure Save;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils;

resourcestring
  TEXT_ERROR_SAVE_INIFILE = 'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_INIFILESAVEERROR = 'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_WRONG_INIFILE_NAME = 'Имя файла конфигурации не должно быть пустым!';
  TEXT_WRONGBUFFERSIZE = 'Размер буфера для передачи данных не должен быть менее килобайта!';
  TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME = 'Имя каталога для сохранения переданных файлов не должно быть пустым!';
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS = 'Каталог для сохранения переданных файлов не существует!';
  TEXT_WRONGINIFILENAME = 'Имя файла конфигурации не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE = 'Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGSHAREDMEMORYNAME = 'Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGWATCHPAUSE =
    'Пауза между циклами опроса состояния подключения не должна быть ниже минимального значения в 0,1 секунды!';

  TEXT_SECTION_FORMPOSITION = 'Размеры и положение окон';

  TEXT_VARNAME_SCROLLLOGTOBOTTOM = 'bScrollLogToBottom';
  TEXT_VARNAME_SHOWSTATUSBAR = 'bShowStatusbar';
  TEXT_VARNAME_SHOWSPASHATSTART = 'bShowSplashAtStart';
  TEXT_VARNAME_SHOWCONFIRMATIONONQUIT = 'bShowConfirmationOnQuit';
  TEXT_VARNAME_KEEPERRORLOG = 'bKeepErrorLog';
  TEXT_VARNAME_KEEPWARNINGLOG = 'bKeepWarningLog';
  TEXT_VARNAME_KEEPINFOLOG = 'bKeepInfoLog';
  TEXT_VARNAME_KEEPDEBUGLOG = 'bKeepDebugLog';
  TEXT_VARNAME_WATCHPAUSE = 'iWatchPause';
  TEXT_VARNAME_PLAYSOUNDONCOMPLETE = 'bPlaySoundOnComplete';

  TEXT_VARNAME_CONFIRURATIONFORMPOSITION_CENTERED = 'ConfigurationFormPosition.bCentered';
  TEXT_VARNAME_CONFIRURATIONFORMPOSITION_LEFT = 'ConfigurationFormPosition.iLeft';
  TEXT_VARNAME_CONFIRURATIONFORMPOSITION_TOP = 'ConfigurationFormPosition.iTop';

  TEXT_VARNAME_MAINFORMPOSITION_CENTERED = 'MainFormPosition.bCentered';
  TEXT_VARNAME_MAINFORMPOSITION_MAXIMIZED = 'MainFormPosition.bMaximized';
  TEXT_VARNAME_MAINFORMPOSITION_LEFT = 'MainFormPosition.iLeft';
  TEXT_VARNAME_MAINFORMPOSITION_TOP = 'MainFormPosition.iTop';
  TEXT_VARNAME_MAINFORMPOSITION_WIDTH = 'MainFormPosition.iWidth';
  TEXT_VARNAME_MAINFORMPOSITION_HEIGHT = 'MainFormPosition.iHeight';

constructor TCommonConfigurationClass.Create(const IniFileName: string = '');
begin
  inherited Create;
  if Trim(IniFileName) = '' then
    FIniFileName := ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')
  else
    FIniFileName := Trim(IniFileName);
  FWatchPause := CONST_DEFAULTVALUE_WATCHPAUSE;
  FPlaySoundOnComplete := CONST_DEFAULTVALUE_PLAYSOUNDONCOMPLETE;
  FSharedMemoryName := '';
  FSharedMemSize := CONST_DEFAULTVALUE_SHAREDMEMSIZE;
  FShowStatusbar := CONST_DEFAULTVALUE_SHOWSTATUSBAR;
  FScrollLogToBottom := CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM;
  FShowSplashAtStart := CONST_DEFAULTVALUE_SHOWSPLASHATSTART;
  FShowConfirmationOnQuit := CONST_DEFAULTVALUE_SHOWCONFIRMATIONONQUIT;
  FKeepLogTypes := CONST_DEFAULTVALUE_KEEPLOGTYPES;
  FConfigurationFormPage := CONST_DEFAULTVALUE_CONFIGURATIONFORMPAGE;
end;

procedure TCommonConfigurationClass.SetSharedMemSize(const Value: cardinal);
begin
  if Value < CONST_MINVALUE_SHAREDMEMSIZE then
    raise Exception.Create(TEXT_WRONGBUFFERSIZE)
  else
    if FSharedMemSize <> Value then
      FSharedMemSize := Value;
end;

procedure TCommonConfigurationClass.Load;
var
  IniFile: TIniFile;
begin
  if FIniFileName > '' then
  begin
    IniFile := TIniFile.Create(FIniFileName);
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
    ScrollLogToBottom := ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SCROLLLOGTOBOTTOM,
      CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM);
    ShowStatusbar := ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSTATUSBAR, CONST_DEFAULTVALUE_SHOWSTATUSBAR);
    ShowSplashAtStart := ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSPASHATSTART,
      CONST_DEFAULTVALUE_SHOWSPLASHATSTART);
    ShowConfirmationOnQuit := ReadBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWCONFIRMATIONONQUIT,
      CONST_DEFAULTVALUE_SHOWCONFIRMATIONONQUIT);
    if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPERRORLOG, lmtError in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
      KeepLogTypes := KeepLogTypes + [lmtError]
    else
      KeepLogTypes := KeepLogTypes - [lmtError];
    if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPWARNINGLOG, lmtWarning in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
      KeepLogTypes := KeepLogTypes + [lmtWarning]
    else
      KeepLogTypes := KeepLogTypes - [lmtWarning];
    if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPINFOLOG, lmtInfo in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
      KeepLogTypes := KeepLogTypes + [lmtInfo]
    else
      KeepLogTypes := KeepLogTypes - [lmtInfo];
    if ReadBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPDEBUGLOG, lmtDebug in CONST_DEFAULTVALUE_KEEPLOGTYPES) then
      KeepLogTypes := KeepLogTypes + [lmtDebug]
    else
      KeepLogTypes := KeepLogTypes - [lmtDebug];
    WatchPause := ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, CONST_DEFAULTVALUE_WATCHPAUSE);
    PlaySoundOnComplete := ReadBool(TEXT_SECTION_COMMON, TEXT_VARNAME_PLAYSOUNDONCOMPLETE,
      CONST_DEFAULTVALUE_PLAYSOUNDONCOMPLETE);

    FormPosition.Centered := ReadBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_CENTERED,
      CONST_DEFAULTVALUE_FORMPOSITION_CENTERED);
    FormPosition.Left := ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_LEFT,
      CONST_DEFAULTVALUE_FORMPOSITION_LEFT);
    FormPosition.Top := ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_TOP,
      CONST_DEFAULTVALUE_FORMPOSITION_TOP);
    ConfigurationFormPosition := FormPosition;

    FormPosition.Centered := ReadBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_CENTERED,
      CONST_DEFAULTVALUE_MAINFORM_CENTERED);
    FormPosition.Maximized := ReadBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_MAXIMIZED,
      CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED);
    FormPosition.Left := ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_LEFT,
      CONST_DEFAULTVALUE_MAINFORM_LEFT);
    FormPosition.Top := ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_TOP,
      CONST_DEFAULTVALUE_MAINFORM_TOP);
    FormPosition.Width := ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_WIDTH,
      CONST_DEFAULTVALUE_MAINFORM_WIDTH);
    FormPosition.Height := ReadInteger(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_MAINFORMPOSITION_HEIGHT,
      CONST_DEFAULTVALUE_MAINFORM_HEIGHT);
    MainFormPosition := FormPosition;
  end;
end;

procedure TCommonConfigurationClass.Save;
var
  IniFile: TIniFile;
begin
  if FIniFileName > '' then
  begin
    IniFile := TIniFile.Create(FIniFileName);
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
    WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWCONFIRMATIONONQUIT, ShowConfirmationOnQuit);
    WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPERRORLOG, lmtError in KeepLogTypes);
    WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPWARNINGLOG, lmtWarning in KeepLogTypes);
    WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPINFOLOG, lmtInfo in KeepLogTypes);
    WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPDEBUGLOG, lmtDebug in KeepLogTypes);
    WriteInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, WatchPause);
    WriteBool(TEXT_SECTION_COMMON, TEXT_VARNAME_PLAYSOUNDONCOMPLETE, PlaySoundOnComplete);

    WriteBool(TEXT_SECTION_FORMPOSITION, TEXT_VARNAME_CONFIRURATIONFORMPOSITION_CENTERED,
      ConfigurationFormPosition.Centered);
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
  if ((FConfigurationFormPosition.Centered <> Value.Centered) or (FConfigurationFormPosition.Top <> Value.Top) or
    (FConfigurationFormPosition.Left <> Value.Left) or (FConfigurationFormPosition.Width <> Value.Width) or
    (FConfigurationFormPosition.Height <> Value.Height)) then
    FConfigurationFormPosition := Value;
end;

procedure TCommonConfigurationClass.SetKeepLogTypes(const Value: TLogMessagesTypes);
begin
  if FKeepLogTypes <> Value then
    FKeepLogTypes := Value;
end;

procedure TCommonConfigurationClass.SetMainFormPosition(const Value: TFormPosition);
begin
  if ((FMainFormPosition.Centered <> Value.Centered) or (FMainFormPosition.Top <> Value.Top) or
    (FMainFormPosition.Left <> Value.Left) or (FMainFormPosition.Width <> Value.Width) or
    (FMainFormPosition.Height <> Value.Height)) then
    FMainFormPosition := Value;
end;

procedure TCommonConfigurationClass.SetPlaySoundOnComplete(const Value: boolean);
begin
  if FPlaySoundOnComplete <> Value then
    FPlaySoundOnComplete := Value;
end;

procedure TCommonConfigurationClass.SetScrollLogToBottom(const Value: boolean);
begin
  if FScrollLogToBottom <> Value then
    FScrollLogToBottom := Value;
end;

procedure TCommonConfigurationClass.SetSharedMemoryName(const Value: WideString);
begin
  if FSharedMemoryName <> Value then
    if Trim(Value) <> '' then
      FSharedMemoryName := Trim(Value)
    else
      raise Exception.Create(TEXT_WRONGSHAREDMEMORYNAME);
end;

procedure TCommonConfigurationClass.SetShowConfirmationOnQuit(const Value: boolean);
begin
  if FShowConfirmationOnQuit <> Value then
    FShowConfirmationOnQuit := Value;
end;

procedure TCommonConfigurationClass.SetShowSplashAtStart(const Value: boolean);
begin
  if FShowSplashAtStart <> Value then
    FShowSplashAtStart := Value;
end;

procedure TCommonConfigurationClass.SetShowStatusbar(const Value: boolean);
begin
  if FShowStatusbar <> Value then
    FShowStatusbar := Value;
end;

procedure TCommonConfigurationClass.SetWatchPause(const Value: cardinal);
begin
  if Value < CONST_MINVALUE_WATCHPAUSE then
    raise Exception.Create(TEXT_WRONGWATCHPAUSE)
  else
    if FWatchPause <> Value then
      FWatchPause := Value;
end;

end.
