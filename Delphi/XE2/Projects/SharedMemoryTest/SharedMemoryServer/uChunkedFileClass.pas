unit uChunkedFileClass;

interface
uses
  System.Classes,
  uChunkClass;
type
  TChunkedFileClass=class
  strict private
    /// <summary>
    /// Имя каталога
    /// </summary>
    FPath: string;
    /// <summary>
    /// Имя дискового файла
    /// </summary>
    FName: string;
    /// <summary>
    /// Файловый поток, в который сохраняются полученные и проверенные порции данных
    /// </summary>
    FStream: TFileStream;
    /// <summary>
    /// Размер порции данных
    /// </summary>
    FChunkSize: cardinal;
    /// <summary>
    /// Количество порций данных указанного размера в получаемом файле
    /// </summary>
    FChunksQuantity: cardinal;
    /// <summary>
    /// Номер текущей порции данных (считая с нуля от начала)
    /// </summary>
    FCurrentChunkNumber: cardinal;
    /// <summary>
    /// Метод, контролирующий устанавку значения свойства <b>Path</b> в зависимости от текущих условий.
    /// </summary>
    procedure SetPath(const Value: string);
    /// <summary>
    /// Метод, контролирующий устанавку значения свойства <b>Name</b> в зависимости от текущих условий.
    /// </summary>
    procedure SetName(const Value: string);
  protected
    /// <summary>
    /// Имя каталога для сохранения получаемых файлов
    /// </summary>
    property Path: string read FPath write SetPath stored False;
    /// <summary>
    /// Имя дискового файла, в который сохраняются полученные и проверенные порции данных
    /// </summary>
    property Name: string read FName write SetName stored False;
    /// <summary>
    /// Файловый поток, в который сохраняются полученные и проверенные порции данных
    /// </summary>
    property Stream: TFileStream read FStream write SetStream stored False;
    /// <summary>
    /// Размер порций данных
    /// </summary>
    property ChunkSize: cardinal read FChunkSize stored False;
    /// <summary>
    /// Количество порций данных указанного размера в получаемом файле
    /// </summary>
    property ChunksQuantity: cardinal read FChunksQuantity write SetChunksQuantity stored False;
    /// <summary>
    /// Номер текущей получаемой порции данных (считая от начала)
    /// </summary>
    property CurrentChunkNumber: cardinal read FCurrentChunkNumber write SetCurrentChunkNumber stored False;
  public
    /// <summary>
    /// Конструктор класса
    /// </summary>
    constructor Create(const FilePath, FileName: string; const ChunkSize, FChunksQuantity);
    /// <summary>
    /// Деструктор класса.
    /// </summary>
    destructor Destroy; override;
    function ReadChunk(out Chunk: TChunkClass): boolean;
    function WriteChunk(const Chunk: TChunkClass): boolean;
  end;

implementation

uses
  System.SysUtils;

resourcestring
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='Каталог для сохранения переданных файлов не существует!';

procedure TChunkedFileClass.SetPath(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FPath<>s then
    if s<>'' then
      if DirectoryExists(s) then
        begin
          if s[Length(s)]<>'\' then
            s:=s+'\';
          FPath:=s;
        end
      else
        raise Exception.Create(TEXT_WRONGDESTINATIONFOLDER_NONEXISTS)
    else
      FPath:=s;
end;

end.
