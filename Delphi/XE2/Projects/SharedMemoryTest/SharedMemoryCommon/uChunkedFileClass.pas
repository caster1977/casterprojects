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
    /// ������ ����� � ������
    /// </summary>
    FSize: cardinal;

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
  private
    function GetCount: cardinal;
  public

    /// <summary>
    /// ����������� ������
    /// </summary>
    constructor Create(const FileName: string; const SizeOfChunk: cardinal; const FileSize: cardinal=0);

    /// <summary>
    /// ���������� ������.
    /// </summary>
    destructor Destroy; override;

    ///	<summary>
    ///	  �����, �������������� ������ ��������� ������ ������ �� �����.
    ///	</summary>
    ///	<param name="Index">
    ///	  ����� ������ ������ � �����, ������� � ����
    ///	</param>
    ///	<param name="Chunk">
    ///	  ������ ������ ������, � ������� ����� �������� ��������� �� �����
    ///	  ������ ������
    ///	</param>
    ///	<returns>
    ///	  ��������� <b>True</b>, ������������ ������ �������, <b>False</b> �
    ///	  ������ ������.
    ///	</returns>
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
    property Name: string read FName stored False;

    /// <summary>
    /// ������ ����� � ������
    /// </summary>
    property Size: cardinal read FSize stored False;

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
    property Index: cardinal read FIndex write FIndex stored False;

    /// <summary>
    /// ���� ��������� ���������� ������ � ������
    /// </summary>
    property Complete: boolean write FComplete stored False;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  uCommon;

resourcestring
  TEXT_ERROR_WRONG_CHUNK_SIZE='������ ������ ������ �� ������ ���� ����� ������ �����!';
  TEXT_ERROR_WRONG_FILE_STREAM_OBJECT='�� ������� ������� ������ ��������� ������!';
  TEXT_ERROR_WRITING_CHUNK_TO_FILE='�� ������� �������� ������ ������ � ����!';

constructor TChunkedFileClass.Create(const FileName: string; const SizeOfChunk: cardinal; const FileSize: cardinal=0);
begin
  inherited Create;
  FIndex:=0;
  FName:=Trim(FileName);
//  FComplete:=True;

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
    else // ���� ��� � �� ������� ���������� ������ � ����� � ������ �����
      begin
        FStream:=TFile.Create(FName);
        FSize:=FileSize;
        FComplete:=False;
      end;
  except
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
      FStream.Seek(ChunkSize*Index, soFromBeginning);
      SetLength(Data, ChunkSize);
      Chunk.Size:=FStream.Read(Data[0], ChunkSize);
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
      FStream.WriteBuffer(Chunk.Data[0], Chunk.Size);
      Result:=True;
    except
      on EWriteError do
        raise Exception.Create(TEXT_ERROR_WRITING_CHUNK_TO_FILE);
    end;
end;

end.
