unit uReceiverClass;

interface

uses
  uSharedFileClass,
  uChunkClass;

type
  {
    FFileProperties: TFileProperties;
    property CurrentFileProperties: TFileProperties read FFileProperties write SetFileProperties stored False;
    Taob=array of Byte;
    procedure SetFileProperties(const Value: TFileProperties);
    ���������� ���������� �������� ��������� �����
    FFileProperties:=TFileProperties.Create;
    FreeAndNil(FFileProperties);

    TFileProperties=class
    strict private
    FFileName: string;
    FDataBlocksQuantity: cardinal;
    FFileStream: TFileStream;
    FCurrentDataBlockNumber: cardinal;
    FCurrentDataBlockSize: cardinal;
    FCurrentDataBlockData: Taob;
    protected
    property FileName: string read FFileName write SetFileName stored False;
    property DataBlocksQuantity: cardinal read FDataBlocksQuantity write SetFDataBlocksQuantity stored False;
    property FileStream: TFileStream read FFileStream write SetFileStream stored False;
    property CurrentDataBlockNumber: cardinal read FCurrentDataBlockNumber write SetCurrentDataBlockNumber stored False;
    property CurrentDataBlockSize: cardinal read FCurrentDataBlockSize write SetCurrentDataBlockSize stored False;
    property CurrentDataBlockData: Taob read FCurrentDataBlockData write SetCurrentDataBlockData stored False;

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
    FSharedFile: TSharedFileClass;
    /// <summary>
    /// ������ ��� ����������� � ���������� ������
    /// </summary>
    FChunk: TChunkClass;
    /// <summary>
    /// ��� �������� ��� ���������� ���������� ������
    /// </summary>
    FPath: string;
    /// <summary>
    /// ��� ��������� �����, � ������� ����������� ���������� � ����������� ������
    /// </summary>
    FFileName: string;
    /// <summary>
    /// ����, � ������� ����������� ���������� � ����������� ������
    /// </summary>
    FFile: file of byte;
    /// <summary>
    /// �������� ������ ��� ��������� ����� ����� ������ ���������� ����� ������
    /// </summary>
    FChunkData: TArray<byte>;
    /// <summary>
    /// ������ ���������� ����������� ����� ����� ������ ����� ������
    /// </summary>
    FChunkSize: cardinal;
    /// <summary>
    /// ����������� ����� CRC32 ���������� ����������� ����� ����� ������ ����� ������
    /// </summary>
    FChunkCRC32: string;
    /// <summary>
    /// �����, ������������������������������� ����� (CRC32) ��� ����������
    /// ����������� ����� ������ ����������� ����� � ������ ��� � ����������
    /// ����������� ������.
    /// </summary>
    /// <returns>
    /// ��������� <b>True</b>, ���� ������ ���������� ���� ������ �������,
    /// <b>False</b> � ������ ������.
    /// </returns>
    function _CheckDataByCRC32: boolean;
    procedure SetPath(const Value: string);
    procedure SetChunkCRC32(const Value: string);
    procedure SetFileName(const Value: string);
  protected
    property _Path: string read FPath write SetPath stored False;
    property _FileName: string read FFileName write SetFileName stored False;

    property _ChunkCRC32: string read FChunkCRC32 write SetChunkCRC32 stored False;
  public
    /// <summary>
    /// ����������� ������
    /// </summary>
    /// <remarks>
    /// ������ ������ ��� ������� � ����� ����� ������.
    /// </remarks>
    constructor Create(const Path: string);
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
    function GetChunk(const Size: cardinal): boolean;
    /// <summary>
    /// �����, �������������� ��������� ����� ����� ������ ����������� �����
    /// (CRC32) ����� ������ ����������� �����.
    /// </summary>
    /// <param name="Size">
    /// ����� ���������� ������ CRC32 � ������
    /// </param>
    /// <returns>
    /// ��������� <b>True</b>, ���� ������� ���������CRC32������������ �����,
    /// <b>False</b> � ������ ������.
    /// </returns>
    function GetCRC32(const Size: cardinal): boolean;
    /// <summary>
    /// �����, �������������� ������ ����������� ����� ����������� �����
    /// ������ � ������������� ���� �� �����.
    /// </summary>
    /// <returns>
    /// ��������� <b>True</b>, ���� ����������������� �������� ������ �
    /// ������ � ����, <b>False</b> � ������ ������.
    /// </returns>
    function SaveChank: boolean;
    property SharedFile: TSharedFileClass read FSharedFile stored False;
  end;

implementation

uses
  System.Variants,
  System.IOUtils,
  System.SysUtils,
  Winapi.Windows,
  uCommon;

resourcestring
  TEXT_WRONGDESTINATIONFOLDER_NONEXISTS='������� ��� ���������� ���������� ������ �� ����������!';

constructor TReceiverClass.Create(const Path: string);
begin
  inherited Create;
  FSharedFile:=TSharedFileClass.Create;
  _Path:=Path;
end;

destructor TReceiverClass.Destroy;
begin
  FreeAndNil(FSharedFile);
  inherited;
end;

function TReceiverClass.GetChunk(const Size: cardinal): boolean;
begin

end;

function TReceiverClass.GetCRC32(const Size: cardinal): boolean;
begin

end;

function TReceiverClass.GetFileName(const Size: cardinal): boolean;
begin

end;

function TReceiverClass.SaveChank: boolean;
begin

end;

procedure TReceiverClass.SetChunkCRC32(const Value: string);
begin
  FChunkCRC32 := Value;
end;

procedure TReceiverClass.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TReceiverClass.SetPath(const Value: string);
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

function TReceiverClass._CheckDataByCRC32: boolean;
begin

end;

end.
