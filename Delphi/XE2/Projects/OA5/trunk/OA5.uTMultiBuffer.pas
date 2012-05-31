unit OA5.uTMultiBuffer;

interface

uses
  System.Generics.Collections,
  System.Classes,
  OA5.uTMeasure;

type
  TMultiBuffer = class
  strict private
    FItems: TList<TMeasure>;
  private
    function GetCount: integer;
    function GetItem(Index: Integer): TMeasure;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Append(Item: TMeasure);
    procedure Insert(const Index: integer; Item: TMeasure);
    procedure Delete(const Index: integer);
    procedure Clear;
    property Count: integer read GetCount;
    property Items[index: Integer]: TMeasure read GetItem; default;
  end;

implementation

uses
  System.SysUtils;

resourcestring
  SMultiBufferIndexError = 'Задан неверный индекс элемента буфера!';

procedure TMultiBuffer.Append(Item: TMeasure);
begin
  Insert(Count, Item);
end;

procedure TMultiBuffer.Clear;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    Items[i].Free;
  FItems.Clear;
end;

constructor TMultiBuffer.Create;
begin
  inherited;
  FItems := nil;
end;

procedure TMultiBuffer.Delete(const Index: integer);
begin
  if (index < 0) or (FItems = nil) or (index >= Count) then
    raise Exception.Create(SMultiBufferIndexError);
  FItems[index].Free;
  FItems.Delete(index);
end;

destructor TMultiBuffer.Destroy;
var
  i: integer;
begin
  for i := Count - 1 downto 0 do
    Items[i].Free;
  FreeAndNil(FItems);
  inherited;
end;

function TMultiBuffer.GetCount: integer;
begin
  if Assigned(FItems) then
    Result := TList<TMeasure>(FItems).Count
  else
    Result := 0;
end;

function TMultiBuffer.GetItem(Index: Integer): TMeasure;
begin
  if not Assigned(FItems) then
    raise Exception.Create(SMultiBufferIndexError);
  Result := TMeasure(FItems[index]);
end;

procedure TMultiBuffer.Insert(const Index: integer; Item: TMeasure);
begin
  if not Assigned(FItems) then
    FItems := TList<TMeasure>.Create;
  FItems.Insert(index, Item);
end;

end.
