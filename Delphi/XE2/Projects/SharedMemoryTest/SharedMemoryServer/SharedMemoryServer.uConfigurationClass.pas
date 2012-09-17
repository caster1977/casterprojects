/// <summary>
/// Модуль-обёртка класса TConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryServer.uConfigurationClass;

interface

uses
  System.IniFiles,
  SharedMemoryCommon.uCommon,
  SharedMemoryCommon.uCommonConfigurationClass;

const
  CONST_DEFAULTVALUE_DESTINATIONFOLDER: string = '';

type
  TConfigurationClass = class(TCommonConfigurationClass)
  strict private
    FDestinationFolder: string;
    FRetranslatorPause: integer;
    function GetDestinationFolder: string;
    procedure SetDestinationFolder(const Value: string);
    procedure SetRetranslatorPause(const Value: integer);
  strict protected
    procedure Loading(const IniFile: TIniFile); override;
    procedure Saving(const IniFile: TIniFile); override;
  public
    constructor Create(const IniFileName: string = '');
    property ConfigurationFormPage;
    property ConfigurationFormPosition;
    property DestinationFolder: string read GetDestinationFolder write SetDestinationFolder stored False;
    property KeepLogTypes;
    property MainFormPosition;
    property PlaySoundOnComplete;
    property RetranslatorPause: integer read FRetranslatorPause write SetRetranslatorPause
      default CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
    property ScrollLogToBottom;
    property SharedMemoryName;
    property SharedMemSize;
    property ShowConfirmationOnQuit;
    property ShowSplashAtStart;
    property ShowStatusbar;
    property WatchPause;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils;

resourcestring
  TEXT_WRONGSHAREDMEMORYNAME = 'Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE = 'Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGINIFILENAME = 'Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR = 'Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS = 'Каталог для сохранения переданных файлов не существует!';

  TEXT_VARNAME_DESTINATIONFOLDER = 'sDestinationFolder';
  TEXT_VARNAME_SHAREDMEMSIZE = 'iSharedMemSize';
  TEXT_VARNAME_RETRANSLATORPAUSE = 'iRetranslatorPause';

constructor TConfigurationClass.Create(const IniFileName: string = '');
begin
  inherited Create(IniFileName);
  FRetranslatorPause := CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
  FDestinationFolder := CONST_DEFAULTVALUE_DESTINATIONFOLDER;
end;

procedure TConfigurationClass.Loading(const IniFile: TIniFile);
begin
  inherited;
  with IniFile do
  begin
    DestinationFolder := ReadString(TEXT_SECTION_COMMON, TEXT_VARNAME_DESTINATIONFOLDER,
      CONST_DEFAULTVALUE_DESTINATIONFOLDER);
    RetranslatorPause := ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_RETRANSLATORPAUSE,
      CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
    SharedMemSize := cardinal(ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_SHAREDMEMSIZE,
      CONST_DEFAULTVALUE_SHAREDMEMSIZE));
  end;
end;

procedure TConfigurationClass.Saving(const IniFile: TIniFile);
begin
  inherited;
  with IniFile do
  begin
    WriteString(TEXT_SECTION_COMMON, TEXT_VARNAME_DESTINATIONFOLDER, DestinationFolder);
    WriteInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_RETRANSLATORPAUSE, RetranslatorPause);
    WriteInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_SHAREDMEMSIZE, SharedMemSize);
  end;
end;

function TConfigurationClass.GetDestinationFolder: string;
begin
  if FDestinationFolder <> '' then
    Result := FDestinationFolder
  else
    Result := ExtractFilePath(ExpandFileName(Application.ExeName));
end;

procedure TConfigurationClass.SetDestinationFolder(const Value: string);
begin
  if FDestinationFolder <> Value then
    if Trim(Value) <> '' then
      if DirectoryExists(Trim(Value)) then
        FDestinationFolder := IncludeTrailingPathDelimiter(Trim(Value))
      else
        raise Exception.Create(TEXT_WRONGDESTINATIONFOLDER_NONEXISTS)
    else
      FDestinationFolder := ExtractFilePath(ExpandFileName(Application.ExeName));
end;

procedure TConfigurationClass.SetRetranslatorPause(const Value: integer);
begin
  if Value < 0 then
    raise Exception.Create(TEXT_WRONGRETRANSLATORPAUSE)
  else
    if FRetranslatorPause <> Value then
      FRetranslatorPause := Value;
end;

end.
