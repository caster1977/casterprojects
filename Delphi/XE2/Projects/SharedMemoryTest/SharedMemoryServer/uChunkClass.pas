unit uChunkClass;

interface

type
  TChunkClass=class
  strict private
    FSize: cardinal;
    FCRC32: string;
    FData: TArray<byte>;
    procedure SetCRC32(const Value: string);
    procedure SetSize(const Value: cardinal);
    procedure SetData(const Value: TArray<byte>);
  public
    constructor Create;
    destructor Destroy; override;
    function Check: boolean;
    property Size: cardinal read FSize write SetSize stored False;
    property CRC32: string read FCRC32 write SetCRC32 stored False;
    property Data: TArray<byte> read FData write SetData stored False;
  end;

implementation

uses
  Winapi.Windows,
  System.TypInfo,
  System.SysUtils;

function TChunkClass.Check: boolean;
begin
  Result:=False;
end;

constructor TChunkClass.Create;
begin
  inherited Create;
  FSize:=0;
  FCRC32:='';
  SetLength(FData, FSize);
end;

destructor TChunkClass.Destroy;
begin
  SetLength(FData, 0);
  inherited;
end;

procedure TChunkClass.SetCRC32(const Value: string);
var
  s: string;
begin
  s:=Trim(Value);
  if FCRC32<>s then
    FCRC32:=s;
end;

procedure TChunkClass.SetData(const Value: TArray<byte>);
begin
  if FData<>Value then
    FData:=Copy(Value, 0, FSize); // CopyMemory(FData, Value, FSize);
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
