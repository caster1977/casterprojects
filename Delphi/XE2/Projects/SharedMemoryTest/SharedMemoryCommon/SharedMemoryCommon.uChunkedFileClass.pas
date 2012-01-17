/// <summary>
/// Модуль-обёртка класса TChunkedFileClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryCommon.uChunkedFileClass;

interface

uses
  System.Classes,
  SharedMemoryCommon.uChunkClass;

type

  /// <summary>
  /// Класс-обёртка для "порционного" файла
  /// </summary>
  TChunkedFileClass=class
  strict private

    /// <summary>
    /// Полное (с путями) имя дискового файла
    /// </summary>
    FName: string;

    /// <summary>
    /// Файловый поток для работы с дисковым файлом
    /// </summary>
    FStream: TFileStream;

    /// <summary>
    /// Размер файла в байтах
    /// </summary>
    FSize: Int64;

    /// <summary>
    /// Размер порции данных
    /// </summary>
    FChunkSize: cardinal;

    /// <summary>
    /// Контрольная сумма порционного файла
    /// </summary>
    FCRC32: cardinal;

    /// <summary>
    /// Номер текущей порции файла, с которой ведётся работа
    /// </summary>
    FIndex: cardinal;

    /// <summary>
    /// Флаг успешного завершения работы с файлом
    /// </summary>
    FComplete: boolean;

    /// <summary>
    /// Метод, контролирующий получение значения свойства <b>Count</b> в зависимости от текущих условий.
    /// </summary>
    function GetCount: cardinal;

    /// <summary>
    /// Метод, контролирующий устанавку значения свойства <b>Complete</b> в зависимости от текущих условий.
    /// </summary>
    procedure SetComplete(const Value: boolean);
  public

    /// <summary>
    /// Конструктор класса
    /// </summary>
    constructor Create(const FileName: string; const SizeOfChunk: cardinal; const FileSize: Int64=0);

    /// <summary>
    /// Деструктор класса.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// Метод, обеспечивающий чтение очередной порции данных из файла.
    /// </summary>
    /// <param name="Index">
    /// Номер порции данных в файле, начиная с нуля
    /// </param>
    /// <param name="Chunk">
    /// Объект порции данных, в который будет помещена считанная из файла
    /// порция данных
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если операция прошла успешно, <b>False</b> в
    /// случае ошибки.
    /// </returns>
    function Read(const Index: cardinal; out Chunk: TChunkClass): boolean;

    /// <summary>
    /// Метод, обеспечивающий запись очередной порции данных в файл.
    /// </summary>
    /// <param name="Chunk">
    /// Объект порции данных, данные которого будут записаны файл
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если операция прошла успешно, <b>False</b> в
    /// случае ошибки.
    /// </returns>
    function Write(const Chunk: TChunkClass): boolean;

    /// <summary>
    /// Полное (с путями) имя рабочего файла
    /// </summary>
    property name: string read FName stored False;

    /// <summary>
    /// Размер файла в байтах
    /// </summary>
    property Size: Int64 read FSize stored False;

    /// <summary>
    /// Размер порций данных
    /// </summary>
    property ChunkSize: cardinal read FChunkSize stored False;

    /// <summary>
    /// Количество порций данных указанного размера в дисковом файле
    /// </summary>
    property Count: cardinal read GetCount stored False;

    /// <summary>
    /// Контрольная сумма "порционного" файла
    /// </summary>
    property СКС32: cardinal read FCRC32 stored False;

    /// <summary>
    /// Номер текущей порции файла, с которой ведётся работа
    /// </summary>
    property index: cardinal read FIndex write FIndex stored False;

    /// <summary>
    /// Флаг успешного завершения работы с файлом
    /// </summary>
    property Complete: boolean write SetComplete stored False;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  SharedMemoryCommon.uCommon;

resourcestring
  TEXT_ERROR_WRONG_CHUNK_SIZE='Размер порции данных не должен быть менее одного байта!';
  TEXT_ERROR_WRONG_FILE_SIZE='Размер принятого сервером файла отличается от размера передаваемого клиентом!';
  TEXT_ERROR_WRONG_FILE_STREAM_OBJECT='Не удалось создать объект файлового потока!';
  TEXT_ERROR_WRITING_CHUNK_TO_FILE='Не удалось записать порцию данных в файл!';

constructor TChunkedFileClass.Create(const FileName: string; const SizeOfChunk: cardinal; const FileSize: Int64=0);
begin
  inherited Create;
  FIndex:=0;
  FName:=Trim(FileName);

  // если размер порции менее одного байта
  if SizeOfChunk<1 then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_SIZE)
  else
    FChunkSize:=SizeOfChunk;

  // если файл с данным именем существует, а так же не указан размер файла в байтах, будем открывать имеющийся файл для чтения
  try
    if FileExists(FName)and(FileSize=0) then
      begin
        FStream:=TFile.OpenRead(FName);
        FSize:=FStream.Size;
        FComplete:=True;
      end
    else // если нет - создаём и открываем на запись
      begin
        FStream:=TFile.Create(FName);
        FSize:=FileSize;
        FComplete:=False;
      end;
  except
    on EInOutError do
      raise
    else
      if not Assigned(FStream) then
        raise Exception.Create(TEXT_ERROR_WRONG_FILE_STREAM_OBJECT);
  end;
end;

destructor TChunkedFileClass.Destroy;
begin
  FreeAndNil(FStream);
  if not FComplete then
    TFile.Delete(FName);
  inherited;
end;

function TChunkedFileClass.GetCount: cardinal;
begin
  Result:=(Size div ChunkSize)+1;
end;

function TChunkedFileClass.Read(const Index: cardinal; out Chunk: TChunkClass): boolean;
var
  Data: TArray<byte>;
begin
  Result:=False;
  if not Assigned(Chunk) then
    Chunk:=TChunkClass.Create;
  if Assigned(FStream) then
    begin
      FStream.Position:=Int64(ChunkSize)*Int64(index);
      SetLength(Data, ChunkSize);
      Chunk.Size:=FStream.Read(Data[0], ChunkSize);
      SetLength(Data, Chunk.Size);
      Chunk.Data:=Data;
      if Chunk.Size>0 then
        Result:=Chunk.CRC32=CommonFunctions.CRC32OfByteArray(Data);
    end;
end;

procedure TChunkedFileClass.SetComplete(const Value: boolean);
begin
  if Value<>FComplete then
    if Value then
      if Assigned(FStream) then
        if Size=FStream.Size then
          FComplete:=Value
        else
          raise Exception.Create(TEXT_ERROR_WRONG_FILE_SIZE)
      else
        raise Exception.Create(TEXT_ERROR_WRONG_FILE_STREAM_OBJECT);
end;

function TChunkedFileClass.Write(const Chunk: TChunkClass): boolean;
begin
  Result:=False;
  if not Assigned(Chunk) then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_OBJECT);
  if Assigned(FStream) then
    try
      FStream.WriteBuffer(Chunk.Data[0], Chunk.Size);
      Result:=True;
    except
      on EWriteError do
        raise Exception.Create(TEXT_ERROR_WRITING_CHUNK_TO_FILE);
    end;
end;

end.
