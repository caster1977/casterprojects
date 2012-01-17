/// <summary>
/// ������-������ ������ TChunkedFileClass
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
  /// �����-������ ��� "�����������" �����
  /// </summary>
  TChunkedFileClass=class
  strict private

    /// <summary>
    /// ������ (� ������) ��� ��������� �����
    /// </summary>
    FName: string;

    /// <summary>
    /// �������� ����� ��� ������ � �������� ������
    /// </summary>
    FStream: TFileStream;

    /// <summary>
    /// ������ ����� � ������
    /// </summary>
    FSize: Int64;

    /// <summary>
    /// ������ ������ ������
    /// </summary>
    FChunkSize: cardinal;

    /// <summary>
    /// ����������� ����� ����������� �����
    /// </summary>
    FCRC32: cardinal;

    /// <summary>
    /// ����� ������� ������ �����, � ������� ������ ������
    /// </summary>
    FIndex: cardinal;

    /// <summary>
    /// ���� ��������� ���������� ������ � ������
    /// </summary>
    FComplete: boolean;

    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>Count</b> � ����������� �� ������� �������.
    /// </summary>
    function GetCount: cardinal;

    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>Complete</b> � ����������� �� ������� �������.
    /// </summary>
    procedure SetComplete(const Value: boolean);
  public

    /// <summary>
    /// ����������� ������
    /// </summary>
    constructor Create(const FileName: string; const SizeOfChunk: cardinal; const FileSize: Int64=0);

    /// <summary>
    /// ���������� ������.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// �����, �������������� ������ ��������� ������ ������ �� �����.
    /// </summary>
    /// <param name="Index">
    /// ����� ������ ������ � �����, ������� � ����
    /// </param>
    /// <param name="Chunk">
    /// ������ ������ ������, � ������� ����� �������� ��������� �� �����
    /// ������ ������
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ������������ ������ �������, <b>False</b> �
    /// ������ ������.
    /// </returns>
    function Read(const Index: cardinal; out Chunk: TChunkClass): boolean;

    /// <summary>
    /// �����, �������������������� ��������� ������ ������ � ����.
    /// </summary>
    /// <param name="Chunk">
    /// ������ ������ ������, ������ �������� ������������� ����
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ���� �������� ������ �������, <b>False</b> �
    /// ������ ������.
    /// </returns>
    function Write(const Chunk: TChunkClass): boolean;

    /// <summary>
    /// ������ (� ������) ��� �������� �����
    /// </summary>
    property name: string read FName stored False;

    /// <summary>
    /// ������ ����� � ������
    /// </summary>
    property Size: Int64 read FSize stored False;

    /// <summary>
    /// ������ ������ ������
    /// </summary>
    property ChunkSize: cardinal read FChunkSize stored False;

    /// <summary>
    /// ���������� ������ ������ ���������� ������� � �������� �����
    /// </summary>
    property Count: cardinal read GetCount stored False;

    /// <summary>
    /// ����������� ����� "�����������" �����
    /// </summary>
    property ���32: cardinal read FCRC32 stored False;

    /// <summary>
    /// ����� ������� ������ �����, � ������� ������ ������
    /// </summary>
    property index: cardinal read FIndex write FIndex stored False;

    /// <summary>
    /// ���� ��������� ���������� ������ � ������
    /// </summary>
    property Complete: boolean write SetComplete stored False;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  SharedMemoryCommon.uCommon;

resourcestring
  TEXT_ERROR_WRONG_CHUNK_SIZE='������ ������ ������ �� ������ ���� ����� ������ �����!';
  TEXT_ERROR_WRONG_FILE_SIZE='������ ��������� �������� ����� ���������� �� ������� ������������� ��������!';
  TEXT_ERROR_WRONG_FILE_STREAM_OBJECT='�� ������� ������� ������ ��������� ������!';
  TEXT_ERROR_WRITING_CHUNK_TO_FILE='�� ������� �������� ������ ������ � ����!';

constructor TChunkedFileClass.Create(const FileName: string; const SizeOfChunk: cardinal; const FileSize: Int64=0);
begin
  inherited Create;
  FIndex:=0;
  FName:=Trim(FileName);

  // ���� ������ ������ ����� ������ �����
  if SizeOfChunk<1 then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_SIZE)
  else
    FChunkSize:=SizeOfChunk;

  // ���� ���� � ������ ������ ����������, � ��� �� �� ������ ������ ����� � ������, ����� ��������� ��������� ���� ��� ������
  try
    if FileExists(FName)and(FileSize=0) then
      begin
        FStream:=TFile.OpenRead(FName);
        FSize:=FStream.Size;
        FComplete:=True;
      end
    else // ���� ��� - ������ � ��������� �� ������
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
