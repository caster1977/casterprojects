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
    FDataBlockSize: cardinal;
    FSharedMemoryName: WideString;
    FRetranslatorPause: integer;
    FDestinationFolder: string;
  private
    procedure SetDataBlockSize(const Value: cardinal);
    {procedure SetIniFileName(const Value: string);}
    procedure SetSharedMemoryName(const Value: WideString);
    procedure SetRetranslatorPause(const Value: integer);
    procedure SetDestinationFolder(const Value: string);
  public
    constructor Create(const IniFileName: string='');
    procedure Load;
    procedure Save;
    { property IniFileName: string read FIniFileName write SetIniFileName stored False; }
    property DataBlockSize: cardinal read FDataBlockSize write SetDataBlockSize default CONST_DEFAULTVALUE_DATABLOCKSIZE;
    property RetranslatorPause: integer read FRetranslatorPause write SetRetranslatorPause default CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
    property SharedMemoryName: WideString read FSharedMemoryName write SetSharedMemoryName stored False;
    property DestinationFolder: string read FDestinationFolder write SetDestinationFolder stored False;
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
  FDataBlockSize:=CONST_DEFAULTVALUE_DATABLOCKSIZE;
  RetranslatorPause:=CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
  FSharedMemoryName:='';
end;

procedure TConfigurationClass.Load;
begin
  if FIniFileName>'' then
    with TIniFile.Create(FIniFileName) do
      try
        DataBlockSize:=cardinal(ReadInteger('Общие', 'iDataBlockSize', CONST_DEFAULTVALUE_DATABLOCKSIZE));
        RetranslatorPause:=ReadInteger('Общие', 'iRetranslatorPause', CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
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
          WriteInteger('Общие', 'iDataBlockSize', DataBlockSize);
          WriteInteger('Общие', 'iRetranslatorPause', RetranslatorPause);
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

procedure TConfigurationClass.SetDataBlockSize(const Value: cardinal);
begin
  if Value<=0 then
    raise Exception.Create(TEXT_WRONGBUFFERSIZE)
  else
    if FDataBlockSize<>Value then
      FDataBlockSize:=Value;
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

procedure TConfigurationClass.SetSharedMemoryName(const Value: WideString);
begin
  if FSharedMemoryName<>Value then
    if Trim(Value)<>'' then
      FSharedMemoryName:=Trim(Value)
    else
      raise Exception.Create(TEXT_WRONGSHAREDMEMORYNAME);
end;

end.
