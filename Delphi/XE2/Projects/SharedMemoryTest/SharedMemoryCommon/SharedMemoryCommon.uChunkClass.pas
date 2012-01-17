/// <summary>
/// ������-������ ������ TChunkClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryCommon.uChunkClass;

interface

resourcestring
  TEXT_ERROR_WRONG_CHUNK_OBJECT='������ �������������� ������ ������ ������!';

type

  ///	<summary>
  ///	  �����, �������� ������ ������, �� ������ � ������ � ����������� �����
  ///	  (CRC32).
  ///	</summary>
  TChunkClass=class
  strict private

    /// <summary>
    /// ������ ��������� ������ � ������
    /// </summary>
    FSize: cardinal;

    /// <summary>
    /// ������ � ������� ���������
    /// </summary>
    FData: TArray<byte>;

    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>Size</b> � ����������� �� ������� �������.
    /// </summary>
    procedure SetSize(const Value: cardinal);

    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>Data</b> � ����������� �� ������� �������.
    /// </summary>
    procedure SetData(const Value: TArray<byte>);

    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>CRC32</b> � ����������� �� ������� �������.
    /// </summary>
    function GetCRC32: cardinal;
  public

    /// <summary>
    /// ����������� ������.
    /// </summary>
    constructor Create;

    /// <summary>
    /// ���������� ������.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// ������ ��������� ������ � ������
    /// </summary>
    property Size: cardinal read FSize write SetSize stored False;

    /// <summary>
    /// ����������� ����� ��������� ������
    /// </summary>
    property CRC32: cardinal read GetCRC32 stored False;

    /// <summary>
    /// ������ � ������� ���������
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
