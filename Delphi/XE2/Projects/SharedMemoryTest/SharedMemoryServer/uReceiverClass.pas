unit uReceiverClass;

interface

uses
  uSharedMemClass,
  uChunkClass,
  uChunkedFileClass;

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
  /// �����, �������������� ��������� ������ � ������������ ����� �����
  /// ������ �����, �� �������� � ������ � ���� �� �����.
  /// </summary>
  TReceiverClass=class
  strict private

    /// <summary>
    /// ������ ��� ������� � ����� ������
    /// </summary>
    FSharedMem: TSharedMemClass;

    /// <summary>
    /// ������ ��� ����������� � ���������� ������
    /// </summary>
    FChunk: TChunkClass;

    /// <summary>
    /// ������ ��� ����������� � "����������" ������ ������
    /// </summary>
    FChunkedFile: TChunkedFileClass;
  protected

    /// <summary>
    /// ������ ��� ������� � ����� ������
    /// </summary>
    property SharedMem: TSharedMemClass read FSharedMem stored False;

    /// <summary>
    /// ������ ��� ����������� � ���������� ������
    /// </summary>
    property Chunk: TChunkClass read FChunk stored False;

    /// <summary>
    /// ������ ��� ����������� � "����������" ������ ������
    /// </summary>
    property ChunkedFile: TChunkedFileClass read FChunkedFile stored False;
  public

    /// <summary>
    /// ����������� ������
    /// </summary>
    /// <remarks>
    /// ������ ������ ��� ������� � ����� ����� ������.
    /// </remarks>
    constructor Create(const FileName: string; const SharedMemName: WideString; const SharedMemSize: cardinal);

    /// <summary>
    /// ���������� ������.
    /// </summary>
    /// <remarks>
    /// ��� ������������� ������� ������ ������� � ����� ������.
    /// </remarks>
    destructor Destroy; override;

    /// <summary>
    /// �����, �������������� ��������� ����� ����� ������ ����������������
    /// �����.
    /// </summary>
    /// <param name="Size">
    /// ����� ������ ����� ����� � ������
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ���� ������� �������� ��������������� �����,
    /// <b>False</b> � ������ ������.
    /// </returns>
    /// <remarks>
    /// ��� �������� ���������� �������, ����� �������� ��� ����������� �����
    /// ��������� �������� <b>FileName</b>.
    /// </remarks>
//    function GetFileName(const Size: cardinal): boolean;

    /// <summary>
    /// �����, �������������� �������������� ����� ������ ����� ������
    /// ����������� ����� � ���������� ��� � �������� ������� ��� ����������
    /// ������.
    /// </summary>
    /// <param name="Size">
    /// ������ ����������� �����
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ���� ������� �������������������������������
    /// �����, <b>False</b> � ������ ������.
    /// </returns>
//    function GetChunk(const Size: cardinal): boolean;

  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  Winapi.Windows,
  uCommon;

constructor TReceiverClass.Create(const FileName: string; const SharedMemName: WideString; const SharedMemSize: cardinal);
begin
  inherited Create;
  FSharedMem:=TSharedMemClass.Create;
end;

destructor TReceiverClass.Destroy;
begin
  FreeAndNil(FSharedMem);
  inherited;
end;

end.
