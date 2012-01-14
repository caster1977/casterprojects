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
    function _GetCount: integer;
    function _GetItem(Index: Integer): TMeasureDataClass;
  public
    constructor Create;
    destructor Destroy; override;
    procedure _Append(Item: TMeasureDataClass);
    procedure _Insert(const Index: integer; Item: TMeasureDataClass);
    procedure _Delete(const Index: integer);
    procedure _Clear;
    property _Count: integer read _GetCount;
    property _Items[index: Integer]: TMeasureDataClass read _GetItem; default;
  end;

implementation

uses
  System.SysUtils;

procedure TMultiBufferClass._Append(Item: TMeasureDataClass);
begin
  _Insert(_Count, Item);
end;

procedure TMultiBufferClass._Clear;
var
  i: Integer;
begin
  for i:=_Count-1 downto 0 do
    _Items[i].Free;
  FItems.Clear;
end;

constructor TMultiBufferClass.Create;
begin
  inherited;
  FItems:=nil;
end;

procedure TMultiBufferClass._Delete(const Index: integer);
begin
  if (index<0)or(FItems=nil)or(index>=_Count) then
    raise Exception.Create(SMultiBufferIndexError);
  FItems[index].Free;
  FItems.Delete(index);
end;

destructor TMultiBufferClass.Destroy;
var
  i: integer;
begin
  for i:=_Count-1 downto 0 do
    _Items[i].Free;
  FreeAndNil(FItems);
  inherited;
end;

function TMultiBufferClass._GetCount: integer;
begin
  if Assigned(FItems) then
    Result:=TList<TMeasureDataClass>(FItems).Count
  else
    Result:=0;
end;

function TMultiBufferClass._GetItem(Index: Integer): TMeasureDataClass;
begin
  if not Assigned(FItems) then
    raise Exception.Create(SMultiBufferIndexError);
  Result:=TMeasureDataClass(FItems[index]);
end;

procedure TMultiBufferClass._Insert(const Index: integer; Item: TMeasureDataClass);
begin
  if not Assigned(FItems) then
    FItems:=TList<TMeasureDataClass>.Create;
  FItems.Insert(index, Item);
end;

{ TODO : Протестировать работу класса }

end.
