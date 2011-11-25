/// <summary>
/// Модуль-обёртка класса TChunkClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uChunkClass;

interface

type
  /// <summary>
  /// Класс, хранящий данные текущего полученного через общую память блока
  /// файла.
  /// </summary>
  TChunkClass=class
  strict private
    /// <summary>
    /// Размер фрагмента данных в байтах
    /// </summary>
    FSize: cardinal;
    /// <summary>
    /// Контрольная сумма фрагмента данных
    /// </summary>
    FCRC32: string;
    /// <summary>
    /// Массив с данными фрагмента
    /// </summary>
    FData: TArray<byte>;
    procedure SetCRC32(const Value: string);
    procedure SetSize(const Value: cardinal);
    procedure SetData(const Value: TArray<byte>);
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
    /// Метод, сверяющий контрольную сумму данных по алгоритму CRC32.
    /// </summary>
    function Check: boolean;
    /// <summary>
    /// Размер фрагмента данных в байтах
    /// </summary>
    property Size: cardinal read FSize write SetSize stored False;
    /// <summary>
    /// Контрольная сумма фрагмента данных
    /// </summary>
    property CRC32: string read FCRC32 write SetCRC32 stored False;
    /// <summary>
    /// Массив с данными фрагмента
    /// </summary>
    property Data: TArray<byte> read FData write SetData stored False;
  end;

implementation

uses
  Winapi.Windows,
  System.TypInfo,
  System.SysUtils;

function TChunkClass.Check: boolean;
begin
  Result:=False;
end;

constructor TChunkClass.Create;
begin
  inherited Create;
  FSize:=0;
  FCRC32:='';
  SetLength(FData, FSize);
end;

destructor TChunkClass.Destroy;
begin
  SetLength(FData, 0);
  inherited;
end;

procedure TChunkClass.SetCRC32(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FCRC32<>s then
    FCRC32:=s;
end;

procedure TChunkClass.SetData(const Value: TArray<byte>);
begin
  if FData<>Value then
    FData:=Copy(Value, 0, FSize); // CopyMemory(FData, Value, FSize);
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
