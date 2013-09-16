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
    FConnection: TCustomConnection;
    function GetConnection: TCustomConnection;
    procedure SetConnection(const AValue: TCustomConnection);
  protected
    property Connection: TCustomConnection read GetConnection write SetConnection nodefault;

  private
    FItems: IInterfaceList;
    function GetItems: IInterfaceList;
  protected
    property Items: IInterfaceList read GetItems nodefault;

  private
    function GetCount: Integer;
  public
    property Count: Integer read GetCount nodefault;

  private
    FItemClass: TLoadableItemClass;
    function GetItemClass: TLoadableItemClass;
    procedure SetItemClass(const AValue: TLoadableItemClass);
  protected
    property ItemClass: TLoadableItemClass read GetItemClass write SetItemClass nodefault;

  public
    procedure Clear;
    procedure Delete(const AIndex: Integer);
    function IndexOf(const AItem: ILoadableItem): Integer;
  protected
    function GetLoadSQL: string;
  public
    constructor Create(const AConnection: TCustomConnection = nil); reintroduce; virtual;
    function Add: Integer; overload;
    function Add(const AItem: ILoadableItem): Integer; overload;
    procedure Load(const AConnection: TCustomConnection = nil);
    function Save(const AConnection: TCustomConnection = nil): Boolean;
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
  Result := Items.Add(ItemClass.Create(Connection, -1));
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

constructor TLoadableList.Create(const AConnection: TCustomConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

procedure TLoadableList.Delete(const AIndex: Integer);
begin
  if Assigned(FItems) then
  begin
    FItems.Delete(AIndex);
  end;
end;

function TLoadableList.GetConnection: TCustomConnection;
begin
  Result := FConnection;
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

procedure TLoadableList.SetConnection(const AValue: TCustomConnection);
begin
  if FConnection <> AValue then
  begin
    FConnection := AValue;
  end;
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
  ic := ItemClass.Create(Connection, -1);
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
  if Assigned(AConnection) then
  begin
    Connection := AConnection;
  end;
  if Assigned(Connection) then
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
            ic := ItemClass.Create(Connection, -1);
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
end;

function TLoadableList.Save(const AConnection: TCustomConnection): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Assigned(AConnection) then
  begin
    Connection := AConnection;
  end;
  if Assigned(Connection) then
  begin
    for i := 0 to Count - 1 do
    begin
      Result := (Items[i] as ItemClass).Save(Connection);
      if not Result then
      begin
        Break;
      end;
    end;
  end;
end;

end.
