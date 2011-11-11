unit uConfigurationClass;

interface

uses
  uCommon;

type
  TConfiguration=class
  strict private
    FIniFileName: string;
    FDataBlockSize: cardinal;
    FSharedMemoryName: WideString;
    FRetranslatorPause: integer;
  private
    procedure SetDataBlockSize(const Value: cardinal);
    procedure SetIniFileName(const Value: string);
    procedure SetSharedMemoryName(const Value: WideString);
    procedure SetRetranslatorPause(const Value: integer);
  public
    constructor Create;
    procedure Load;
    procedure Save;
    property IniFileName: string read FIniFileName write SetIniFileName stored False;
    property DataBlockSize: cardinal read FDataBlockSize write SetDataBlockSize default CONST_DEFAULTVALUE_DATABLOCKSIZE;
    property RetranslatorPause: integer read FRetranslatorPause write SetRetranslatorPause default CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
    property SharedMemoryName: WideString read FSharedMemoryName write SetSharedMemoryName stored False;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  System.IniFiles;

resourcestring
  TEXT_WRONGBUFFERSIZE='Размер буфера для передачи данных не должен быть менее одного байта!';
  TEXT_WRONGSHAREDMEMORYNAME='Имя общей области памяти не должно быть пустым!';
  TEXT_WRONGRETRANSLATORPAUSE='Пауза между циклами трансляции сообщения не должна быть менее нуля секунд!';
  TEXT_WRONGINIFILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_INIFILESAVEERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

  { TConfiguration }

constructor TConfiguration.Create;
begin
  inherited;
  FIniFileName:=ExtractFilePath(ExpandFileName(Application.ExeName))+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.ini', [rfIgnoreCase]);
  FDataBlockSize:=CONST_DEFAULTVALUE_DATABLOCKSIZE;
  RetranslatorPause:=CONST_DEFAULTVALUE_RETRANSLATORPAUSE;
  FSharedMemoryName:='';
end;

procedure TConfiguration.Load;
begin
  if IniFileName>'' then
    with TIniFile.Create(IniFileName) do
      try
        DataBlockSize:=cardinal(ReadInteger('Общие', 'iDataBlockSize', CONST_DEFAULTVALUE_DATABLOCKSIZE));
        RetranslatorPause:=ReadInteger('Общие', 'iRetranslatorPause', CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
      finally
        Free;
      end
  else
    raise Exception.Create(TEXT_WRONGINIFILENAME);
end;

procedure TConfiguration.Save;
begin
  if IniFileName>'' then
    with TIniFile.Create(IniFileName) do
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

procedure TConfiguration.SetDataBlockSize(const Value: cardinal);
begin
  if Value<=0 then
    raise Exception.Create(TEXT_WRONGBUFFERSIZE)
  else
    if FDataBlockSize<>Value then
      FDataBlockSize:=Value;
end;

procedure TConfiguration.SetIniFileName(const Value: string);
begin
  if FIniFileName<>Value then
    if Trim(Value)<>'' then
      FIniFileName:=Trim(Value)
    else
      raise Exception.Create(TEXT_WRONGINIFILENAME);
end;

procedure TConfiguration.SetRetranslatorPause(const Value: integer);
begin
  if Value<0 then
    raise Exception.Create(TEXT_WRONGRETRANSLATORPAUSE)
  else
    if FRetranslatorPause<>Value then
      FRetranslatorPause:=Value;
end;

procedure TConfiguration.SetSharedMemoryName(const Value: WideString);
begin
  if FSharedMemoryName<>Value then
    if Trim(Value)<>'' then
      FSharedMemoryName:=Trim(Value)
    else
      raise Exception.Create(TEXT_WRONGSHAREDMEMORYNAME);
end;

end.
