/// <summary>
/// Модуль-обёртка класса TChunkedFileClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uChunkedFileClass;

interface

uses
  System.Classes,
  uChunkClass;

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
    /// Размер порции данных
    /// </summary>
    FChunkSize: cardinal;

    /// <summary>
    /// Количество порций данных указанного размера в дисковом файле
    /// </summary>
    FCount: cardinal;

    /// <summary>
    /// Номер текущей порции данных
    /// </summary>
    FIndex: cardinal;

    /// <summary>
    /// Контрольная сумма порционного файла
    /// </summary>
    FCRC32: cardinal;
  public

    /// <summary>
    /// Конструктор класса
    /// </summary>
    constructor Create(const FileName: string; const SizeOfChunk: cardinal; const QuantityOfChunks: cardinal=0);

    /// <summary>
    /// Деструктор класса.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// Метод, обеспечивающий чтение очередной порции данных из файла.
    /// </summary>
    /// <param name="Chunk">
    /// Объект порции данных, в который будет помещена считанная из файла
    /// порция данных
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если операция прошла успешно, <b>False</b> в
    /// случае ошибки.
    /// </returns>
    function Read(out Chunk: TChunkClass): boolean;

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
    property Name: string read FName stored False;

    /// <summary>
    /// Размер порций данных
    /// </summary>
    property ChunkSize: cardinal read FChunkSize stored False;

    /// <summary>
    /// Количество порций данных указанного размера в дисковом файле
    /// </summary>
    property Count: cardinal read FCount stored False;

    /// <summary>
    /// Номер текущей порции данных
    /// </summary>
    property Index: cardinal read FIndex stored False;

    /// <summary>
    /// Контрольная сумма "порционного" файла
    /// </summary>
    property СКС32: cardinal read FCRC32 stored False;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  uCommon;

resourcestring
  TEXT_ERROR_WRONG_CHUNK_SIZE='Размер порции данных не должен быть менее одного байта!';
  TEXT_ERROR_WRONG_CHUNK_QUANTITY='Количество порций создаваемого файла не должно быть менее одной!';
  TEXT_ERROR_WRONG_FILE_STREAM_OBJECT='Не удалось создать объект файлового потока!';
  TEXT_ERROR_WRITING_CHUNK_TO_FILE='Не удалось записать порцию данных в файл!';

constructor TChunkedFileClass.Create(const FileName: string; const SizeOfChunk: cardinal; const QuantityOfChunks: cardinal=0);
begin
  inherited Create;
  FName:=Trim(FileName);

  // если размер порции менее одного байта
  if SizeOfChunk<1 then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_SIZE)
  else
    FChunkSize:=SizeOfChunk;

  // если указанного файла не существует и не было задано количество порций в файле
  if (not FileExists(FName))and(QuantityOfChunks=0) then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_QUANTITY);

  // если файл с данным именем существует, а так же не указано количество чанков в файле, будем открывать имеющийся файл для чтения
  try
    if FileExists(FName)and(QuantityOfChunks=0) then
      begin
        FStream:=TFile.OpenRead(FName);
        FCount:=FStream.Size div SizeOfChunk;
      end
    else // если нет и не указано количество чанков в файле и размер чанка
      begin
        FStream:=TFile.Create(FName);
        FCount:=QuantityOfChunks;
      end;
  except
    if not Assigned(FStream) then
      raise Exception.Create(TEXT_ERROR_WRONG_FILE_STREAM_OBJECT);
  end;

  // инициализируем счётчик порций
  FIndex:=0;
end;

destructor TChunkedFileClass.Destroy;
begin
  FreeAndNil(FStream);
  inherited;
end;

function TChunkedFileClass.Read(out Chunk: TChunkClass): boolean;
var
  Data: TArray<byte>;
begin
  Result:=False;
  if not Assigned(Chunk) then
    Chunk:=TChunkClass.Create;
  if Assigned(FStream) then
    begin
      Chunk.Size:=FStream.Read(Data, ChunkSize);
      SetLength(Data, Chunk.Size);
      Chunk.Data:=Data;
      if Chunk.Size>0 then
        Result:=Chunk.CRC32=CommonFunctions.CRC32OfByteArray(Data);
    end;
end;

function TChunkedFileClass.Write(const Chunk: TChunkClass): boolean;
begin
  Result:=False;
  if not Assigned(Chunk) then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_OBJECT);
  if Assigned(FStream) then
    try
      FStream.WriteBuffer(Chunk.Data,Chunk.Size);
      Result:=True;
    except
      on EWriteError do
        raise Exception.Create(TEXT_ERROR_WRITING_CHUNK_TO_FILE);
    end;
end;

end.
