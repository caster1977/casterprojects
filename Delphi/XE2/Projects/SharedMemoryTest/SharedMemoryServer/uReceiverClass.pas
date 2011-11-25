unit uReceiverClass;

interface

uses
//  System.Classes,
  uSharedMemClass,
  uChunkClass;
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
  protected
    /// <summary>
    /// ����������� ����� CRC32 ���������� ����������� ����� ����� ������ ����� ������
    /// </summary>
    property SharedMem: TSharedMemClass read FSharedMem stored False;
  public
    /// <summary>
    /// ����������� ������
    /// </summary>
    /// <remarks>
    /// ������ ������ ��� ������� � ����� ����� ������.
    /// </remarks>
    constructor Create(const DestinationPath: string; const SharedMemName: WideString; const SharedMemSize: cardinal);
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
    function SaveChunk: boolean;
  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  Winapi.Windows,
  uCommon;

constructor TReceiverClass.Create(const DestinationPath: string; const SharedMemName: WideString; const SharedMemSize: cardinal);
begin
  inherited Create;
  FSharedMem:=TSharedMemClass.Create;
  Path:=DestinationPath;
end;

destructor TReceiverClass.Destroy;
begin
  FreeAndNil(FSharedMem);
  inherited;
end;

end.
