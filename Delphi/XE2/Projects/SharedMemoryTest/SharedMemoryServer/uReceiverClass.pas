unit uReceiverClass;

interface

uses
  uSharedFileClass,
  uChunkClass;

type
  {
    FFileProperties: TFileProperties;
    property CurrentFileProperties: TFileProperties read FFileProperties write SetFileProperties stored False;
    Taob=array of Byte;
    procedure SetFileProperties(const Value: TFileProperties);
    обновление переменной текущего открытого файла
    FFileProperties:=TFileProperties.Create;
    FreeAndNil(FFileProperties);

    TFileProperties=class
    strict private
    FFileName: string;
    FDataBlocksQuantity: cardinal;
    FFileStream: TFileStream;
    FCurrentDataBlockNumber: cardinal;
    FCurrentDataBlockSize: cardinal;
    FCurrentDataBlockData: Taob;
    protected
    property FileName: string read FFileName write SetFileName stored False;
    property DataBlocksQuantity: cardinal read FDataBlocksQuantity write SetFDataBlocksQuantity stored False;
    property FileStream: TFileStream read FFileStream write SetFileStream stored False;
    property CurrentDataBlockNumber: cardinal read FCurrentDataBlockNumber write SetCurrentDataBlockNumber stored False;
    property CurrentDataBlockSize: cardinal read FCurrentDataBlockSize write SetCurrentDataBlockSize stored False;
    property CurrentDataBlockData: Taob read FCurrentDataBlockData write SetCurrentDataBlockData stored False;

    constructor TFileProperties.Create(const sFileName: string='');
    begin
    inherited Create;
    FFileName:=Trim(sFileName);
    FDataBlocksQuantity:=0;
    FFileStream:=nil;
    FCurrentDataBlockNumber:=0;
    FCurrentDataBlockSize:=0;
    FCurrentDataBlockData:=nil;
    end;

    destructor TFileProperties.Destroy;
    begin
    FreeAndNil(FFileStream);
    if Assigned(FCurrentDataBlockData) then
    SetLength(FCurrentDataBlockData, 0);
    FreeAndNil(FCurrentDataBlockData);
    inherited;
    end;

  }

  /// <summary>
  /// Класс, обеспечивающий получение данных о передаваемом через общую
  /// память файле, их проверку и запись в файл на диске.
  /// </summary>
  TReceiverClass=class
  strict private
    /// <summary>
    /// Объект для доступа к общей памяти
    /// </summary>
    FSharedFile: TSharedFileClass;
    /// <summary>
    /// Объект для манипуляций с фрагментом данных
    /// </summary>
    FChunk: TChunkClass;
    /// <summary>
    /// Имя каталога для сохранения получаемых файлов
    /// </summary>
    FPath: string;
    /// <summary>
    /// Имя дискового файла, в который сохраняются полученные и проверенные данные
    /// </summary>
    FFileName: string;
    /// <summary>
    /// Файл, в который сохраняются полученные и проверенные данные
    /// </summary>
    FFile: file of byte;
    /// <summary>
    /// Байтовый массив для получения через общую память очередного блока данных
    /// </summary>
    FChunkData: TArray<byte>;
    /// <summary>
    /// Размер последнего полученного через общую память блока данных
    /// </summary>
    FChunkSize: cardinal;
    /// <summary>
    /// Контрольная сумма CRC32 последнего полученного через общую память блока данных
    /// </summary>
    FChunkCRC32: string;
    /// <summary>
    /// Метод, обеспечивающий расчёт контрольной суммы (CRC32) для последнего
    /// полученного блока данных получаемого файла и сверку его с полученной
    /// контрольной суммой.
    /// </summary>
    /// <returns>
    /// Возращает <b>True</b>, если сверка котрольных сумм прошла успешно,
    /// <b>False</b> в случае ошибки.
    /// </returns>
    function _CheckDataByCRC32: boolean;
    procedure SetPath(const Value: string);
    procedure SetChunkCRC32(const Value: string);
    procedure SetFileName(const Value: string);
  protected
    property _Path: string read FPath write SetPath stored False;
    property _FileName: string read FFileName write SetFileName stored False;

    property _ChunkCRC32: string read FChunkCRC32 write SetChunkCRC32 stored False;
  public
    /// <summary>
    /// Конструктор класса
    /// </summary>
    /// <remarks>
    /// Создаёт объект для доступа к блоку общей памяти.
    /// </remarks>
    constructor Create(const Path: string);
    /// <summary>
    /// Деструктор класса.
    /// </summary>
    /// <remarks>
    /// При необходимости удаляет объект доступа к общей памяти.
    /// </remarks>
    destructor Destroy; override;
    /// <summary>
    /// Метод, обеспечивающий получение через общую память имени получаемого
    /// файла.
    /// </summary>
    /// <param name="Size">
    /// Длина строки имени файла в байтах
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если удалось получить имя получаемого файла,
    /// <b>False</b> в случае ошибки.
    /// </returns>
    /// <remarks>
    /// При успешном выполнении функции, можно получить имя получаемого файла
    /// при помощи свойства <b>FileName</b>.
    /// </remarks>
    function GetFileName(const Size: cardinal): boolean;
    /// <summary>
    /// Метод, обеспечивающий получение через общую память блока данных
    /// получаемого файла и сохранения его в байтовом массиве для дальнейшей
    /// работы.
    /// </summary>
    /// <param name="Size">
    /// Размер получаемого блока
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если удалось получить блок данных получаемого
    /// файла, <b>False</b> в случае ошибки.
    /// </returns>
    function GetChunk(const Size: cardinal): boolean;
    /// <summary>
    /// Метод, обеспечивающий получение через общую память контрольную сумму
    /// (CRC32) блока данных получаемого файла.
    /// </summary>
    /// <param name="Size">
    /// Длина получаемой строки CRC32 в байтах
    /// </param>
    /// <returns>
    /// Возращает <b>True</b>, если удалось получить CRC32 получаемого файла,
    /// <b>False</b> в случае ошибки.
    /// </returns>
    function GetCRC32(const Size: cardinal): boolean;
    /// <summary>
    /// Метод, обеспечивающий сверку контрольной суммы полученного блока
    /// данных и дозапись его в файл на диске.
    /// </summary>
    /// <returns>
    /// Возращает <b>True</b>, если удалось выполнить операцию сверки и
    /// записи в файл, <b>False</b> в случае ошибки.
    /// </returns>
    function SaveChank: boolean;
    property SharedFile: TSharedFileClass read FSharedFile stored False;
  end;

implementation

uses
  System.Variants,
  System.IOUtils,
  System.SysUtils,
  Winapi.Windows,
  uCommon;

resourcestring
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='Каталог для сохранения переданных файлов не существует!';

constructor TReceiverClass.Create(const Path: string);
begin
  inherited Create;
  FSharedFile:=TSharedFileClass.Create;
  _Path:=Path;
end;

destructor TReceiverClass.Destroy;
begin
  FreeAndNil(FSharedFile);
  inherited;
end;

function TReceiverClass.GetChunk(const Size: cardinal): boolean;
begin

end;

function TReceiverClass.GetCRC32(const Size: cardinal): boolean;
begin

end;

function TReceiverClass.GetFileName(const Size: cardinal): boolean;
begin

end;

function TReceiverClass.SaveChank: boolean;
begin

end;

procedure TReceiverClass.SetChunkCRC32(const Value: string);
begin
  FChunkCRC32 := Value;
end;

procedure TReceiverClass.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TReceiverClass.SetPath(const Value: string);
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

function TReceiverClass._CheckDataByCRC32: boolean;
begin

end;

end.
