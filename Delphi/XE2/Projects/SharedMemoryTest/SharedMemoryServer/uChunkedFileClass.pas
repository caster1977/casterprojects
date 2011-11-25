unit uChunkedFileClass;

interface
uses
  System.Classes,
  uChunkClass;
type
  TChunkedFileClass=class
  strict private
    /// <summary>
    /// ��� ��������
    /// </summary>
    FPath: string;
    /// <summary>
    /// ��� ��������� �����
    /// </summary>
    FName: string;
    /// <summary>
    /// �������� �����, � ������� ����������� ���������� � ����������� ������ ������
    /// </summary>
    FStream: TFileStream;
    /// <summary>
    /// ������ ������ ������
    /// </summary>
    FChunkSize: cardinal;
    /// <summary>
    /// ���������� ������ ������ ���������� ������� � ���������� �����
    /// </summary>
    FChunksQuantity: cardinal;
    /// <summary>
    /// ����� ������� ������ ������ (������ � ���� �� ������)
    /// </summary>
    FCurrentChunkNumber: cardinal;
    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>Path</b> � ����������� �� ������� �������.
    /// </summary>
    procedure SetPath(const Value: string);
    /// <summary>
    /// �����, �������������� ��������� �������� �������� <b>Name</b> � ����������� �� ������� �������.
    /// </summary>
    procedure SetName(const Value: string);
  protected
    /// <summary>
    /// ��� �������� ��� ���������� ���������� ������
    /// </summary>
    property Path: string read FPath write SetPath stored False;
    /// <summary>
    /// ��� ��������� �����, � ������� ����������� ���������� � ����������� ������ ������
    /// </summary>
    property Name: string read FName write SetName stored False;
    /// <summary>
    /// �������� �����, � ������� ����������� ���������� � ����������� ������ ������
    /// </summary>
    property Stream: TFileStream read FStream write SetStream stored False;
    /// <summary>
    /// ������ ������ ������
    /// </summary>
    property ChunkSize: cardinal read FChunkSize stored False;
    /// <summary>
    /// ���������� ������ ������ ���������� ������� � ���������� �����
    /// </summary>
    property ChunksQuantity: cardinal read FChunksQuantity write SetChunksQuantity stored False;
    /// <summary>
    /// ����� ������� ���������� ������ ������ (������ �� ������)
    /// </summary>
    property CurrentChunkNumber: cardinal read FCurrentChunkNumber write SetCurrentChunkNumber stored False;
  public
    /// <summary>
    /// ����������� ������
    /// </summary>
    constructor Create(const FilePath, FileName: string; const ChunkSize, FChunksQuantity);
    /// <summary>
    /// ���������� ������.
    /// </summary>
    destructor Destroy; override;
    function ReadChunk(out Chunk: TChunkClass): boolean;
    function WriteChunk(const Chunk: TChunkClass): boolean;
  end;

implementation

uses
  System.SysUtils;

resourcestring
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='������� ��� ���������� ���������� ������ �� ����������!';

procedure TChunkedFileClass.SetPath(const Value: string);
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

end.
