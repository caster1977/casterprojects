unit OA5.uMultiBufferClass;

interface

uses
  System.Generics.Collections,
  OA5.uMeasureDataClass;

resourcestring
  SMultiBufferIndexError='Задан неверный индекс элемента буфера!';

type

  TMultiBufferClass=class
  strict private
    FItems: TList<TMeasureDataClass>;
  private
    function GetCount: integer;
    function GetItem(Index: Integer): TMeasureDataClass;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Append(Item: TMeasureDataClass);
    procedure Insert(const Index: integer; Item: TMeasureDataClass);
    procedure Delete(const Index: integer);
    procedure Clear;
    property Count: integer read GetCount;
    property Items[index: Integer]: TMeasureDataClass read GetItem; default;
  end;

implementation

uses
  System.SysUtils;

procedure TMultiBufferClass.Append(Item: TMeasureDataClass);
begin
  Insert(Count, Item);
end;

procedure TMultiBufferClass.Clear;
var
  i: Integer;
begin
  for i:=Count-1 downto 0 do
    Items[i].Free;
  FItems.Clear;
end;

constructor TMultiBufferClass.Create;
begin
  inherited;
  FItems:=nil;
end;

procedure TMultiBufferClass.Delete(const Index: integer);
begin
  if (index<0)or(FItems=nil)or(index>=Count) then
    raise Exception.Create(SMultiBufferIndexError);
  FItems[index].Free;
  FItems.Delete(index);
end;

destructor TMultiBufferClass.Destroy;
var
  i: integer;
begin
  for i:=Count-1 downto 0 do
    Items[i].Free;
  FreeAndNil(FItems);
  inherited;
end;

function TMultiBufferClass.GetCount: integer;
begin
  if Assigned(FItems) then
    Result:=TList<TMeasureDataClass>(FItems).Count
  else
    Result:=0;
end;

function TMultiBufferClass.GetItem(Index: Integer): TMeasureDataClass;
begin
  if not Assigned(FItems) then
    raise Exception.Create(SMultiBufferIndexError);
  Result:=TMeasureDataClass(FItems[index]);
end;

procedure TMultiBufferClass.Insert(const Index: integer; Item: TMeasureDataClass);
begin
  if not Assigned(FItems) then
    FItems:=TList<TMeasureDataClass>.Create;
  FItems.Insert(index, Item);
end;

end.
