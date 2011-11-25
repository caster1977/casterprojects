unit uReceiverClass;

interface

uses
//  System.Classes,
  uSharedMemClass,
  uChunkClass;
type

  {
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
    FSharedMem: TSharedMemClass;
    /// <summary>
    /// Объект для манипуляций с фрагментом данных
    /// </summary>
    FChunk: TChunkClass;
  protected
    /// <summary>
    /// Контрольная сумма CRC32 последнего полученного через общую память блока данных
    /// </summary>
    property SharedMem: TSharedMemClass read FSharedMem stored False;
  public
    /// <summary>
    /// Конструктор класса
    /// </summary>
    /// <remarks>
    /// Создаёт объект для доступа к блоку общей памяти.
    /// </remarks>
    constructor Create(const DestinationPath: string; const SharedMemName: WideString; const SharedMemSize: cardinal);
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
    function SaveChunk: boolean;
  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  Winapi.Windows,
  uCommon;

constructor TReceiverClass.Create(const DestinationPath: string; const SharedMemName: WideString; const SharedMemSize: cardinal);
begin
  inherited Create;
  FSharedMem:=TSharedMemClass.Create;
  Path:=DestinationPath;
end;

destructor TReceiverClass.Destroy;
begin
  FreeAndNil(FSharedMem);
  inherited;
end;

end.
