unit CastersPackage.uIInterfaceListOfGivenType;

interface

uses
  System.SysUtils,
  System.Classes;

type
  EInterfaceListOfGivenInterfaceType = class(Exception);

  IInterfaceListOfGivenInterfaceType<T: IInterface> = interface
    ['{CAA4BD57-6B34-4049-B339-1CDC686C5CA8}']
    function Add(const AItem: T): Integer;
    procedure Append(const AItems: IInterfaceListOfGivenInterfaceType<T>);
    procedure Insert(const AIndex: Integer; const AItem: T);
    procedure Delete(const AIndex: Integer);
    function Remove(const AItem: T; const ASkipIfNotFound: Boolean = False): Integer; overload;
    procedure Remove(const AItems: IInterfaceListOfGivenInterfaceType<T>; const ASkipIfNotFound: Boolean = False); overload;
    procedure Clear;
    function First: T;
    function Last: T;
    procedure Exchange(const AIndex1, AIndex2: Integer);
    function IndexOf(const AItem: T): Integer;
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
    property Count: Integer read GetCount write SetCount;
    function GetItem(const AIndex: Integer): T;
    procedure PutItem(const AIndex: Integer; const AItem: T);
    property Items[const AIndex: Integer]: T read GetItem write PutItem; default;
  end;

  TInterfaceListOfGivenInterfaceType<T: IInterface> = class(TInterfacedObject, IInterfaceListOfGivenInterfaceType<T>)
  strict private
    Flist: IInterfaceList;
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
    function GetItem(const AIndex: Integer): T;
    procedure PutItem(const AIndex: Integer; const AItem: T);
  protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function Add(const AItem: T): Integer; virtual;
    procedure Insert(const AIndex: Integer; const AItem: T); virtual;
    procedure Delete(const AIndex: Integer); virtual;
    function Remove(const AItem: T; const ASkipIfNotFound: Boolean = False): Integer; overload; virtual;
    procedure Clear; virtual;
    function First: T; virtual;
    function Last: T; virtual;
    procedure Exchange(const AIndex1, AIndex2: Integer); virtual;
    function IndexOf(const AItem: T): Integer; virtual;

    procedure Append(const AItems: IInterfaceListOfGivenInterfaceType<T>); virtual;
    procedure Remove(const AItems: IInterfaceListOfGivenInterfaceType<T>; const ASkipIfNotFound: Boolean = False); overload; virtual;

    property Count: Integer read GetCount write SetCount;
    property Items[const AIndex: Integer]: T read GetItem write PutItem; default;
  end;

  (* ICar = interface
    ['{89398A1E-913F-42DA-A65C-88CB3F40808D}']
    end;

    TCar = class(TInterfacedObject, ICar)
    end;

    ICarList = interface(IInterfaceListOfGivenInterfaceType<ICar>)
    ['{AA0A1D68-AB7B-49F1-BCCE-0EADE6CDBA1D}']
    end;

    TCarList = class(TInterfaceListOfGivenInterfaceType<ICar>, ICarList)
    end;
  *)

resourcestring
  RsCantAddItemToList = 'Не могу добавить элемент в список!';
  RsCantRemoveItemFromList = 'Не могу удалить элемент из списка!';

implementation

function TInterfaceListOfGivenInterfaceType<T>.Add(const AItem: T): Integer;
begin
  Result := -1;
  if Assigned(Flist) then
  begin
    Result := Flist.Add(AItem);
  end;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Append(const AItems: IInterfaceListOfGivenInterfaceType<T>);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
  begin
    if Add(AItems[i]) = -1 then
    begin
      raise EInterfaceListOfGivenInterfaceType.Create(RsCantAddItemToList);
    end;
  end;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Clear;
begin
  if Assigned(Flist) then
  begin
    Flist.Clear;
  end;
end;

constructor TInterfaceListOfGivenInterfaceType<T>.Create;
begin
  inherited;
  Initialize;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Delete(const AIndex: Integer);
begin
  if Assigned(Flist) then
  begin
    Flist.Delete(AIndex);
  end;
end;

destructor TInterfaceListOfGivenInterfaceType<T>.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Exchange(const AIndex1, AIndex2: Integer);
begin
  if Assigned(Flist) then
  begin
    Flist.Exchange(AIndex1, AIndex2);
  end;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Finalize;
begin
  Clear;
end;

function TInterfaceListOfGivenInterfaceType<T>.First: T;
begin
  Result := GetItem(0);
end;

function TInterfaceListOfGivenInterfaceType<T>.GetCount: Integer;
begin
  Result := -1;
  if Assigned(Flist) then
  begin
    Result := Flist.Count;
  end;
end;

function TInterfaceListOfGivenInterfaceType<T>.GetItem(const AIndex: Integer): T;
begin
  Result := nil;
  if Assigned(Flist) then
  begin
    Result := T(Flist[AIndex]);
  end;
end;

function TInterfaceListOfGivenInterfaceType<T>.IndexOf(const AItem: T): Integer;
begin
  Result := -1;
  if Assigned(Flist) then
  begin
    Result := Flist.IndexOf(AItem);
  end;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Initialize;
begin
  Flist := TInterfaceList.Create;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Insert(const AIndex: Integer; const AItem: T);
begin
  if Assigned(Flist) then
  begin
    Flist.Insert(AIndex, AItem);
  end;
end;

function TInterfaceListOfGivenInterfaceType<T>.Last: T;
begin
  Result := Self.GetItem(Count - 1);
end;

procedure TInterfaceListOfGivenInterfaceType<T>.PutItem(const AIndex: Integer; const AItem: T);
begin
  if (AIndex >= 0) or (AIndex < Count) then
  begin
    if Assigned(Flist) then
    begin
      Flist[AIndex] := AItem;
    end;
  end;
end;

function TInterfaceListOfGivenInterfaceType<T>.Remove(const AItem: T; const ASkipIfNotFound: Boolean): Integer;
begin
  Result := -1;
  if Assigned(Flist) and (not((IndexOf(AItem) = Result) and ASkipIfNotFound)) then
  begin
    Result := Flist.Remove(AItem);
  end;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.Remove(const AItems: IInterfaceListOfGivenInterfaceType<T>; const ASkipIfNotFound: Boolean);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
  begin
    if Remove(AItems[i], ASkipIfNotFound) = -1 then
    begin
      raise EInterfaceListOfGivenInterfaceType.Create(RsCantRemoveItemFromList);
    end;
  end;
end;

procedure TInterfaceListOfGivenInterfaceType<T>.SetCount(const ANewCount: Integer);
begin
  if Assigned(Flist) then
  begin
    Flist.Count := ANewCount;
  end;
end;

end.
