/// <summary>
/// Модуль-обёртка класса TConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uConfigurationClass;

interface

uses
  System.IniFiles,
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
  strict protected
    procedure Loading(const IniFile: TIniFile); override;
    procedure Saving(const IniFile: TIniFile); override;
  public
    constructor Create(const IniFileName: string='');
    property SharedMemoryName;
    property SharedMemSize;
    property KeepLogTypes;
    property ShowStatusbar;
    property ScrollLogToBottom;
    property ShowSplashAtStart;
    property WatchPause;
    property ConfigurationFormPosition;
    property MainFormPosition;
    property RetranslatorPause: integer read FRetranslatorPause write SetRetranslatorPause default CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
    property DestinationFolder: string read GetDestinationFolder write SetDestinationFolder stored False;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils;

const
  CONST_DEFAULTVALUE_DESTINATIONFOLDER: string = '';

resourcestring
  TEXT_WRONGSHAREDMEMORYNAME='Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE='Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGINIFILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';
  TEXT_WRONGDESTINATIONFOLDER_EMPTYNAME='Имя каталога для сохранения переданных файлов не должно быть пустым!';
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='Каталог для сохранения переданных файлов не существует!';

  TEXT_VARNAME_DESTINATIONFOLDER='sDestinationFolder';
  TEXT_VARNAME_SHAREDMEMSIZE='iSharedMemSize';
  TEXT_VARNAME_RETRANSLATORPAUSE='iRetranslatorPause';


constructor TConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create(IniFileName);
  FRetranslatorPause:=CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
  FDestinationFolder:=CONST_DEFAULTVALUE_DESTINATIONFOLDER;
end;

procedure TConfigurationClass.Loading(const IniFile: TIniFile);
begin
  inherited;
  with IniFile do
    begin
      DestinationFolder:=ReadString(TEXT_SECTION_COMMON, TEXT_VARNAME_DESTINATIONFOLDER, CONST_DEFAULTVALUE_DESTINATIONFOLDER);
      RetranslatorPause:=ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_RETRANSLATORPAUSE, CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
      SharedMemSize:=cardinal(ReadInteger(TEXT_SECTION_COMMON, TEXT_VARNAME_SHAREDMEMSIZE, CONST_DEFAULTVALUE_SHAREDMEMSIZE));
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
