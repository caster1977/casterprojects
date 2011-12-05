/// <summary>
/// ������-������ ������ TChunkedFileClass
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
    /// ������ ������ ������
    /// </summary>
    FChunkSize: cardinal;

    /// <summary>
    /// ���������� ������ ������ ���������� ������� � �������� �����
    /// </summary>
    FCount: cardinal;

    /// <summary>
    /// ����� ������� ������ ������
    /// </summary>
    FIndex: cardinal;

    /// <summary>
    /// ����������� ����� ����������� �����
    /// </summary>
    FCRC32: cardinal;
  public

    /// <summary>
    /// ����������� ������
    /// </summary>
    constructor Create(const FileName: string; const SizeOfChunk: cardinal; const QuantityOfChunks: cardinal=0);

    /// <summary>
    /// ���������� ������.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// �����, �������������� ������ ��������� ������ ������ �� �����.
    /// </summary>
    /// <param name="Chunk">
    /// ������ ������ ������, � ������� ����� �������� ��������� �� �����
    /// ������ ������
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ������������ ������ �������, <b>False</b> �
    /// ������ ������.
    /// </returns>
    function Read(out Chunk: TChunkClass): boolean;

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
    property Name: string read FName stored False;

    /// <summary>
    /// ������ ������ ������
    /// </summary>
    property ChunkSize: cardinal read FChunkSize stored False;

    /// <summary>
    /// ���������� ������ ������ ���������� ������� � �������� �����
    /// </summary>
    property Count: cardinal read FCount stored False;

    /// <summary>
    /// ����� ������� ������ ������
    /// </summary>
    property Index: cardinal read FIndex stored False;

    /// <summary>
    /// ����������� ����� "�����������" �����
    /// </summary>
    property ���32: cardinal read FCRC32 stored False;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  uCommon;

resourcestring
  TEXT_ERROR_WRONG_CHUNK_SIZE='������ ������ ������ �� ������ ���� ����� ������ �����!';
  TEXT_ERROR_WRONG_CHUNK_QUANTITY='���������� ������ ������������ ����� �� ������ ���� ����� �����!';
  TEXT_ERROR_WRONG_FILE_STREAM_OBJECT='�� ������� ������� ������ ��������� ������!';
  TEXT_ERROR_WRITING_CHUNK_TO_FILE='�� ������� �������� ������ ������ � ����!';

constructor TChunkedFileClass.Create(const FileName: string; const SizeOfChunk: cardinal; const QuantityOfChunks: cardinal=0);
begin
  inherited Create;
  FName:=Trim(FileName);

  // ���� ������ ������ ����� ������ �����
  if SizeOfChunk<1 then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_SIZE)
  else
    FChunkSize:=SizeOfChunk;

  // ���� ���������� ����� �� ���������� � �� ���� ������ ���������� ������ � �����
  if (not FileExists(FName))and(QuantityOfChunks=0) then
    raise Exception.Create(TEXT_ERROR_WRONG_CHUNK_QUANTITY);

  // ���� ���� � ������ ������ ����������, � ��� �� �� ������� ���������� ������ � �����, ����� ��������� ��������� ���� ��� ������
  try
    if FileExists(FName)and(QuantityOfChunks=0) then
      begin
        FStream:=TFile.OpenRead(FName);
        FCount:=FStream.Size div SizeOfChunk;
      end
    else // ���� ��� � �� ������� ���������� ������ � ����� � ������ �����
      begin
        FStream:=TFile.Create(FName);
        FCount:=QuantityOfChunks;
      end;
  except
    if not Assigned(FStream) then
      raise Exception.Create(TEXT_ERROR_WRONG_FILE_STREAM_OBJECT);
  end;

  // �������������� ������� ������
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
