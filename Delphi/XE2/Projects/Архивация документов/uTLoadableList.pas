unit uTLoadableList;

interface

uses
  DB,
  Classes,
  uILoadableList,
  uTLoadableItemClass,
  uILoadableItem;

type
  TLoadableList = class(TInterfacedObject, ILoadableList)
  private
    FItems: IInterfaceList;
    function GetItems: IInterfaceList;
    function GetCount: Integer;
  protected
    property Items: IInterfaceList read GetItems nodefault;
  public
    property Count: Integer read GetCount nodefault;
  public
    procedure Clear;
    procedure Delete(const AIndex: Integer);
    function IndexOf(const AItem: ILoadableItem): Integer;
  private
    FItemClass: TLoadableItemClass;
    function GetItemClass: TLoadableItemClass;
    procedure SetItemClass(const AValue: TLoadableItemClass);
  protected
    property ItemClass: TLoadableItemClass read GetItemClass write SetItemClass nodefault;
  protected
    function GetLoadSQL: string;
  public
    constructor Create; reintroduce; virtual;
    function Add: Integer; overload;
    function Add(const AItem: ILoadableItem): Integer; overload;
    procedure Load(const AConnection: TCustomConnection);
    function Save(const AConnection: TCustomConnection): Boolean;
  end;

implementation

uses
  uCommonRoutines,
  ADODB,
  SqlExpr,
  uTLoadableItem,
  SysUtils;

function TLoadableList.Add: Integer;
begin
  Result := Items.Add(ItemClass.Create);
end;

function TLoadableList.Add(const AItem: ILoadableItem): Integer;
begin
  Result := -1;
  if AItem is ItemClass then
  begin
    Result := Items.Add(AItem);
  end;
end;

procedure TLoadableList.Clear;
begin
  if Assigned(FItems) then
  begin
    FItems.Clear;
  end;
end;

constructor TLoadableList.Create;
begin
  inherited;
end;

procedure TLoadableList.Delete(const AIndex: Integer);
begin
  if Assigned(FItems) then
  begin
    FItems.Delete(AIndex);
  end;
end;

function TLoadableList.GetCount: Integer;
begin
  Result := 0;
  if Assigned(FItems) then
  begin
    Result := FItems.Count;
  end;
end;

function TLoadableList.GetItemClass: TLoadableItemClass;
begin
  Result := FItemClass;
end;

function TLoadableList.GetItems: IInterfaceList;
begin
  if not Assigned(FItems) then
  begin
    FItems := TInterfaceList.Create;
  end;
  Result := FItems;
end;

procedure TLoadableList.SetItemClass(const AValue: TLoadableItemClass);
begin
  if FItemClass <> AValue then
  begin
    FItemClass := AValue;
  end;
end;

function TLoadableList.GetLoadSQL: string;
var
  ic: TLoadableItem;
begin
  Result := EmptyStr;
  ic := ItemClass.Create;
  try
    Result := ic.GetLoadSQL;
  finally
    FreeAndNil(ic);
  end;
end;

function TLoadableList.IndexOf(const AItem: ILoadableItem): Integer;
begin
  Result := -1;
  if Assigned(AItem) and Assigned(FItems) then
  begin
    Result := FItems.IndexOf(AItem);
  end;
end;

procedure TLoadableList.Load(const AConnection: TCustomConnection);
var
  ds: TDataSet;
  ic: TLoadableItem;
begin
  ds := GetQuery(AConnection);
  if Assigned(ds) then
  begin
    try
      SetSQLForQuery(ds, GetLoadSQL, True);
      try
        Items.Clear;
        while not ds.Eof do
        begin
          ic := ItemClass.Create;
          ic.Load(ds);
          Items.Add(ic);
          ds.Next;
        end;
      finally
        ds.Close;
      end;
    finally
      FreeAndNil(ds);
    end;
  end;
end;

function TLoadableList.Save(const AConnection: TCustomConnection): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
  begin
    Result := (Items[i] as ItemClass).Save(AConnection);
    if not Result then
    begin
      Break;
    end;
  end;
end;

end.
