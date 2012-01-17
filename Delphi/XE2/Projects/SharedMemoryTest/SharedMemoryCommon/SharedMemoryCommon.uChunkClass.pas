/// <summary>
/// Модуль-обёртка класса TChunkClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryCommon.uChunkClass;

interface

resourcestring
  TEXT_ERROR_WRONG_CHUNK_OBJECT='Указан несуществующий объект порции данных!';

type

  ///	<summary>
  ///	  Класс, хранящий порцию данных, их размер в байтах и контрольную сумму
  ///	  (CRC32).
  ///	</summary>
  TChunkClass=class
  strict private

    /// <summary>
    /// Размер фрагмента данных в байтах
    /// </summary>
    FSize: cardinal;

    /// <summary>
    /// Массив с данными фрагмента
    /// </summary>
    FData: TArray<byte>;

    /// <summary>
    /// Метод, контролирующий устанавку значения свойства <b>Size</b> в зависимости от текущих условий.
    /// </summary>
    procedure SetSize(const Value: cardinal);

    /// <summary>
    /// Метод, контролирующий устанавку значения свойства <b>Data</b> в зависимости от текущих условий.
    /// </summary>
    procedure SetData(const Value: TArray<byte>);

    /// <summary>
    /// Метод, контролирующий получение значения свойства <b>CRC32</b> в зависимости от текущих условий.
    /// </summary>
    function GetCRC32: cardinal;
  public

    /// <summary>
    /// Конструктор класса.
    /// </summary>
    constructor Create;

    /// <summary>
    /// Деструктор класса.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// Размер фрагмента данных в байтах
    /// </summary>
    property Size: cardinal read FSize write SetSize stored False;

    /// <summary>
    /// Контрольная сумма фрагмента данных
    /// </summary>
    property CRC32: cardinal read GetCRC32 stored False;

    /// <summary>
    /// Массив с данными фрагмента
    /// </summary>
    property Data: TArray<byte> read FData write SetData stored False;
  end;

implementation

uses
  SharedMemoryCommon.uCommon;

constructor TChunkClass.Create;
begin
  inherited Create;
  Size:=0;
end;

destructor TChunkClass.Destroy;
begin
  Size:=0;
  inherited;
end;

function TChunkClass.GetCRC32: cardinal;
begin
  Result:=CommonFunctions.CRC32OfByteArray(Data);
end;

procedure TChunkClass.SetData(const Value: TArray<byte>);
begin
  if FData<>Value then
    begin
      Size:=Length(Value);
      FData:=Copy(Value, 0, FSize);
    end;
end;

procedure TChunkClass.SetSize(const Value: cardinal);
begin
  if FSize<>Value then
    begin
      SetLength(FData, 0);
      FSize:=Value;
      SetLength(FData, FSize);
    end;
end;

end.
