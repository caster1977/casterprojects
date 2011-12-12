/// <summary>
/// Модуль-обёртка класса TConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uConfigurationClass;

interface

uses
  uCommon,
  uCommonConfigurationClass;

type
  TConfigurationClass=class(TCommonConfigurationClass)
  strict private
    FRetranslatorPause: integer;
    FDestinationFolder: string;
    procedure SetRetranslatorPause(const Value: integer);
    function GetDestinationFolder: string;
    procedure SetDestinationFolder(const Value: string);
  public
    constructor Create(const IniFileName: string='');
    procedure Load; override;
    procedure Save; override;
    property SharedMemoryName;
    property SharedMemSize;
    property KeepLogTypes;
    property ShowStatusbar;
    property ScrollLogToBottom;
    property ShowSplashAtStart;
    property WatchPause;
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
  TEXT_SECTION_COMMON='Общие';
  TEXT_SECTION_INTERFACE='Интерфейс';
  TEXT_SECTION_LOG='Протоколирование';
  TEXT_VARNAME_WATCHPAUSE='iWatchPause';
  TEXT_VARNAME_DESTINATIONFOLDER='sDestinationFolder';
  TEXT_VARNAME_SCROLLLOGTOBOTTOM='bScrollLogToBottom';
  TEXT_VARNAME_SHOWSTATUSBAR='bShowStatusbar';
  TEXT_VARNAME_SHOWSPASHATSTART='bShowSplashAtStart';
  TEXT_VARNAME_KEEPERRORLOG='bKeepErrorLog';
  TEXT_VARNAME_KEEPWARNINGLOG='bKeepWarningLog';
  TEXT_VARNAME_KEEPINFOLOG='bKeepInfoLog';
  TEXT_VARNAME_KEEPDEBUGLOG='bKeepDebugLog';

constructor TConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create(IniFileName);
  FRetranslatorPause:=CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
  FDestinationFolder:=CONST_DEFAULTVALUE_DESTINATIONFOLDER;
end;

procedure TConfigurationClass.Load;
begin
  if FIniFileName>'' then
    with TIniFile.Create(FIniFileName) do
      try
        SharedMemSize:=cardinal(ReadInteger(TEXT_SECTION_COMMON, 'iSharedMemSize', CONST_DEFAULTVALUE_SHAREDMEMSIZE));
        RetranslatorPause:=ReadInteger(TEXT_SECTION_COMMON, 'iRetranslatorPause', CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
        //RetranslatorPause:=ReadInteger(TEXT_SECTION_COMMON, 'iRetranslatorPause', CONST_DEFAULTVALUE_RETRANSLATORPAUSE);


        DestinationFolder:=ReadString(TEXT_SECTION_COMMON, TEXT_VARNAME_DESTINATIONFOLDER, CONST_DEFAULTVALUE_DESTINATIONFOLDER);
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
          WriteInteger(TEXT_SECTION_COMMON, 'iSharedMemSize', SharedMemSize);
          WriteInteger(TEXT_SECTION_COMMON, 'iRetranslatorPause', RetranslatorPause);
          //WriteInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, );
          WriteString(TEXT_SECTION_COMMON, TEXT_VARNAME_DESTINATIONFOLDER, DestinationFolder);
          WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SCROLLLOGTOBOTTOM, ScrollLogToBottom);
          WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSTATUSBAR, ShowStatusbar);
          WriteBool(TEXT_SECTION_INTERFACE, TEXT_VARNAME_SHOWSPASHATSTART, ShowSplashAtStart);
          WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPERRORLOG, lmtError in KeepLogTypes);
          WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPWARNINGLOG, lmtWarning in KeepLogTypes);
          WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPINFOLOG, lmtInfo in KeepLogTypes);
          WriteBool(TEXT_SECTION_LOG, TEXT_VARNAME_KEEPDEBUGLOG, lmtDebug in KeepLogTypes);
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
        FDestinationFolder:=IncludeTrailingPathDelimiter(Trim(Value))
      else
        raise Exception.Create(TEXT_WRONGDESTINATIONFOLDER_NONEXISTS)
    else
      raise Exception.Create(TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME);
end;

procedure TConfigurationClass.SetRetranslatorPause(const Value: integer);
begin
  if Value<0 then
    raise Exception.Create(TEXT_WRONGRETRANSLATORPAUSE)
  else
    if FRetranslatorPause<>Value then
      FRetranslatorPause:=Value;
end;

end.
