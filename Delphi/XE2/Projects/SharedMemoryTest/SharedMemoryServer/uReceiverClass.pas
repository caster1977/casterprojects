unit uReceiverClass;

interface

uses
  uSharedMemClass,
  uChunkClass,
  uChunkedFileClass;

type

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
    constructor Create(const Path: string; const SharedMemName: WideString; const SharedMemSize: cardinal);

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
    function GetFileName(const Size: cardinal): boolean;

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

constructor TReceiverClass.Create(const Path: string; const SharedMemName: WideString; const SharedMemSize: cardinal);
begin
  inherited Create;
  FSharedMem:=TSharedMemClass.Create(SharedMemName, SharedMemSize);
end;

destructor TReceiverClass.Destroy;
begin
  FreeAndNil(FSharedMem);
  inherited;
end;

function TReceiverClass.GetFileName(const Size: cardinal): boolean;
begin
  // ������ ������ ����� ��� ��������� � ���� ������ ����� ����� �� ����� ������
  {
  try
    if not Assigned(FChunk) then
      FChunk:=TChunkClass.Create;
    try
      FSharedMem.Mapped:=True;
      FSharedMem.Read(Size,FChunk);
      FChunk.Data

      FChunkedFile:=TChunkedFileClass.Create();


    finally
      FSharedMem.Mapped:=False;
    end;
  finally
    FreeAndNil(FChunk);
  end;
  }
end;

end.
