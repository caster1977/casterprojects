unit uConfigurationClass;

interface

uses
  uCommon,
  uCommonConfigurationClass;

type
  TConfigurationClass=class(TCommonConfigurationClass)
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
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  System.IniFiles;

resourcestring
  TEXT_WRONGINIFILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

  TEXT_SECTION_COMMON='Общие';
  TEXT_SECTION_INTERFACE='Интерфейс';
  TEXT_SECTION_LOG='Протоколирование';
  TEXT_VARNAME_WATCHPAUSE='iWatchPause';
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
end;

procedure TConfigurationClass.Load;
begin
  if FIniFileName>'' then
    with TIniFile.Create(FIniFileName) do
      try
        SharedMemSize:=cardinal(ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, CONST_DEFAULTVALUE_WATCHPAUSE));
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
          WriteInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_WATCHPAUSE, WatchPause);
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

end.
