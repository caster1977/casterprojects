unit uReceiverClass;

interface

uses
  uSharedFileClass;

type
 {
    FFileProperties: TFileProperties;
    property CurrentFileProperties: TFileProperties read FFileProperties write SetFileProperties stored False;
  Taob=array of Byte;
    procedure SetFileProperties(const Value: TFileProperties);
   обновление переменной текущего открытого файла
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
    procedure SetCurrentDataBlockData(const Value: Taob);
    procedure SetCurrentDataBlockNumber(const Value: cardinal);
    procedure SetCurrentDataBlockSize(const Value: cardinal);
    procedure SetFDataBlocksQuantity(const Value: cardinal);
    procedure SetFileName(const Value: string);
    procedure SetFileStream(const Value: TFileStream);
  protected
    property FileName: string read FFileName write SetFileName stored False;
    property DataBlocksQuantity: cardinal read FDataBlocksQuantity write SetFDataBlocksQuantity stored False;
    property FileStream: TFileStream read FFileStream write SetFileStream stored False;
    property CurrentDataBlockNumber: cardinal read FCurrentDataBlockNumber write SetCurrentDataBlockNumber stored False;
    property CurrentDataBlockSize: cardinal read FCurrentDataBlockSize write SetCurrentDataBlockSize stored False;
    property CurrentDataBlockData: Taob read FCurrentDataBlockData write SetCurrentDataBlockData stored False;
  public
    constructor Create(const sFileName: string='');
    destructor Destroy; override;
  end;

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

procedure TFileProperties.SetCurrentDataBlockData(const Value: Taob);
begin
  if FCurrentDataBlockData<>Value then

    FCurrentDataBlockData:=Value;
end;

procedure TFileProperties.SetCurrentDataBlockNumber(const Value: cardinal);
begin
  if FCurrentDataBlockNumber<>Value then
    FCurrentDataBlockNumber:=Value;
end;

procedure TFileProperties.SetCurrentDataBlockSize(const Value: cardinal);
begin
  if FCurrentDataBlockSize<>Value then
    FCurrentDataBlockSize:=Value;
end;

procedure TFileProperties.SetFDataBlocksQuantity(const Value: cardinal);
begin
  if FDataBlocksQuantity<>Value then
    FDataBlocksQuantity:=Value;
end;

procedure TFileProperties.SetFileName(const Value: string);
begin
  if FFileName<>Value then
    FFileName:=Value;
end;

procedure TFileProperties.SetFileStream(const Value: TFileStream);
begin
  if FFileStream<>Value then
    FFileStream:=Value;
end;

procedure TMainForm.SetFileProperties(const Value: TFileProperties);
begin
  if FFileProperties<>Value then
    FFileProperties:=Value;
end;
}

  TReceiverClass = class
  strict private
//    FSharedFile: TSharedFileClass;
//    FSharedMemoryName: WideString;
//    FSharedMemorySize: cardinal;
//    hSharedMemory: THandle;

    //    pMapView: pointer;
    //    FDataFile: file of byte;

  public
    constructor Create(const SharedMemoryName: WideString = ''; const SharedMemorySize: cardinal = 1024);
    destructor Destroy; override;
    function GetFilename: boolean;
    function GetFileData: boolean;
    function GetCRC32: boolean;
//    property SharedFile: TSharedFileClass read FSharedFile stored False;
  end;

implementation

uses
  System.Variants,
  System.IOUtils,
  System.SysUtils,
  Winapi.Windows,
  uCommon;

constructor TReceiverClass.Create(const SharedMemoryName: WideString = ''; const SharedMemorySize: cardinal = 1024);
begin
  inherited Create;
end;

destructor TReceiverClass.Destroy;
begin
  inherited;
end;

function TReceiverClass.GetCRC32: boolean;
begin
  Result:=False;
end;

function TReceiverClass.GetFileData: boolean;
begin
  Result:=False;
end;

function TReceiverClass.GetFilename: boolean;
begin
  Result:=False;
end;

end.
