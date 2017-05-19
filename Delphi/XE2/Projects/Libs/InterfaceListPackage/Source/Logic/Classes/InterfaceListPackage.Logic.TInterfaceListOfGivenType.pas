unit InterfaceListPackage.Logic.TInterfaceListOfGivenType;

interface

uses
  InterfaceListPackage.Logic.IInterfaceListOfGivenType,
  System.Classes;

type
  TInterfaceListOfGivenType<T: IInterface> = class(TInterfacedPersistent, IInterfaceListOfGivenType<T>)
  strict private
    FList: IInterfaceList;
    FAddItemErrorString: string;
    FRemoveItemErrorString: string;
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
    function GetItem(const AIndex: Integer): T;
    procedure PutItem(const AIndex: Integer; const AItem: T);
    function GetAddItemErrorString: string;
    procedure SetAddItemErrorString(const AValue: string);
    function GetRemoveItemErrorString: string;
    procedure SetRemoveItemErrorString(const AValue: string);
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    property AddItemErrorString: string read GetAddItemErrorString write SetAddItemErrorString nodefault;
    property RemoveItemErrorString: string read GetRemoveItemErrorString write SetRemoveItemErrorString nodefault;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function Equals(const AItems: IInterfaceListOfGivenType<T>): Boolean; reintroduce; virtual;
    procedure Assign(const AItems: IInterfaceListOfGivenType<T>); reintroduce; virtual;

    function Add(const AItem: T): Integer; virtual;
    procedure Append(const AItems: IInterfaceListOfGivenType<T>); virtual;
    procedure Insert(const AIndex: Integer; const AItem: T); virtual;
    procedure Delete(const AIndex: Integer); virtual;
    function Remove(const AItem: T; const ASkipIfNotFound: Boolean = False): Integer; overload; virtual;
    procedure Remove(const AItems: IInterfaceListOfGivenType<T>; const ASkipIfNotFound: Boolean = False);
      overload; virtual;
    procedure Clear; virtual;
    function First: T; virtual;
    function Last: T; virtual;
    procedure Exchange(const AIndex1, AIndex2: Integer); virtual;
    function IndexOf(const AItem: T): Integer; virtual;

    property Count: Integer read GetCount write SetCount;
    property Items[const AIndex: Integer]: T read GetItem write PutItem; default;
  end;

resourcestring
  RsCantAddItemToList = 'Не могу добавить элемент в список.';
  RsCantRemoveItemFromList = 'Не могу удалить элемент из списка.';

implementation

uses
  System.SysUtils,
  InterfaceListPackage.Logic.EInterfaceListOfGivenType;

function TInterfaceListOfGivenType<T>.Add(const AItem: T): Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.Add(IInterface(AItem));
  end;
end;

procedure TInterfaceListOfGivenType<T>.Append(const AItems: IInterfaceListOfGivenType<T>);
var
  i: Integer;
begin
  for i := 0 to Pred(AItems.Count) do
  begin
    if Add(AItems[i]) = -1 then
    begin
      raise EInterfaceListOfGivenType.Create(AddItemErrorString);
    end;
  end;
end;

procedure TInterfaceListOfGivenType<T>.Clear;
begin
  if Assigned(FList) then
  begin
    FList.Clear;
  end;
end;

constructor TInterfaceListOfGivenType<T>.Create;
begin
  inherited;
  Initialize;
end;

destructor TInterfaceListOfGivenType<T>.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TInterfaceListOfGivenType<T>.Delete(const AIndex: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Delete(AIndex);
  end;
end;

procedure TInterfaceListOfGivenType<T>.Assign(const AItems: IInterfaceListOfGivenType<T>);
begin
  if Assigned(AItems) then
  begin
    Clear;
    Append(AItems);
  end;
end;

function TInterfaceListOfGivenType<T>.Equals(const AItems: IInterfaceListOfGivenType<T>): Boolean;
var
  i: Integer;
  b: Boolean;
  o1, o2: T;
begin
  Result := True;

  if not Assigned(AItems) then
  begin
    Result := False;
    Exit;
  end;

  if Count <> AItems.Count then
  begin
    Result := False;
    Exit;
  end;

  for i := 0 to Pred(Count) do
  begin
    o1 := Items[i];
    o2 := AItems[i];
    if @o1 = @o2 then
    begin
      Result := False;
      Break;
    end;
  end;
end;

procedure TInterfaceListOfGivenType<T>.Exchange(const AIndex1, AIndex2: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Exchange(AIndex1, AIndex2);
  end;
end;

procedure TInterfaceListOfGivenType<T>.Finalize;
begin
  Clear;
end;

function TInterfaceListOfGivenType<T>.First: T;
begin
  Result := GetItem(0);
end;

function TInterfaceListOfGivenType<T>.GetAddItemErrorString: string;
begin
  Result := FAddItemErrorString;
end;

function TInterfaceListOfGivenType<T>.GetCount: Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    FList.Lock;
    try
      Result := FList.Count;
    finally
      FList.Unlock;
    end;
  end;
end;

function TInterfaceListOfGivenType<T>.GetItem(const AIndex: Integer): T;
begin
  Result := nil;
  if Assigned(FList) then
  begin
    Result := T(FList[AIndex]);
  end;
end;

function TInterfaceListOfGivenType<T>.GetRemoveItemErrorString: string;
begin
  Result := FRemoveItemErrorString;
end;

function TInterfaceListOfGivenType<T>.IndexOf(const AItem: T): Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.IndexOf(IInterface(AItem));
  end;
end;

procedure TInterfaceListOfGivenType<T>.Initialize;
begin
  FList := TInterfaceList.Create;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

procedure TInterfaceListOfGivenType<T>.Insert(const AIndex: Integer; const AItem: T);
begin
  if Assigned(FList) then
  begin
    FList.Insert(AIndex, IInterface(AItem));
  end;
end;

function TInterfaceListOfGivenType<T>.Last: T;
begin
  Result := Self.GetItem(Pred(Count));
end;

procedure TInterfaceListOfGivenType<T>.PutItem(const AIndex: Integer; const AItem: T);
begin
  if (AIndex >= 0) or (AIndex < Count) then
  begin
    if Assigned(FList) then
    begin
      FList[AIndex] := IInterface(AItem);
    end;
  end;
end;

function TInterfaceListOfGivenType<T>.Remove(const AItem: T; const ASkipIfNotFound: Boolean): Integer;
begin
  Result := -1;
  if Assigned(FList) and (not((IndexOf(AItem) = Result) and ASkipIfNotFound)) then
  begin
    Result := FList.Remove(IInterface(AItem));
  end;
end;

procedure TInterfaceListOfGivenType<T>.Remove(const AItems: IInterfaceListOfGivenType<T>;
  const ASkipIfNotFound: Boolean);
var
  i: Integer;
begin
  for i := 0 to Pred(AItems.Count) do
  begin
    if Remove(AItems[i], ASkipIfNotFound) = -1 then
    begin
      raise EInterfaceListOfGivenType.Create(RemoveItemErrorString);
    end;
  end;
end;

procedure TInterfaceListOfGivenType<T>.SetAddItemErrorString(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FAddItemErrorString <> s then
  begin
    FAddItemErrorString := s;
  end;
end;

procedure TInterfaceListOfGivenType<T>.SetCount(const ANewCount: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Count := ANewCount;
  end;
end;

procedure TInterfaceListOfGivenType<T>.SetRemoveItemErrorString(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FRemoveItemErrorString <> s then
  begin
    FRemoveItemErrorString := s;
  end;
end;

end.
