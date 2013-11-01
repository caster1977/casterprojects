unit uTLoadableList;

interface

uses
  Classes,
  uILoadableList,
  DB,
  uTLoadableItemClass,
  uILoadableItem,
  uTLoadableItem;

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

{$IFDEF VER150}
  protected
{$ELSE}
  private
{$ENDIF}
    function GetItem(const AIndex: Integer): ILoadableItem;
    procedure PutItem(const AIndex: Integer; const AItem: ILoadableItem);
  public
    property Item[const AIndex: Integer]: ILoadableItem read GetItem write PutItem; default;

{$IFDEF VER150}
  protected
{$ELSE}
  private
{$ENDIF}
    function GetCount: Integer;
  public
    property Count: Integer read GetCount nodefault;

  private
    FItemClass: TLoadableItemClass;
    function GetItemClass: TLoadableItemClass;
    procedure SetItemClass(const AValue: TLoadableItemClass);
  protected
    property ItemClass: TLoadableItemClass read GetItemClass write SetItemClass nodefault;

  protected
    procedure BeforeLoad(const AItem: TLoadableItem); virtual;
  public
    constructor Create(const AConnection: TCustomConnection = nil); reintroduce; virtual;
    function Add: Integer; overload;
    function Add(const AItem: ILoadableItem): Integer; overload;
    procedure Load(const AConnection: TCustomConnection = nil);
    function Save(const AConnection: TCustomConnection = nil): Boolean;
    function Clear(const AConnection: TCustomConnection = nil): Boolean;
    function Delete(const AIndex: Integer; const AConnection: TCustomConnection = nil): Boolean;
    function IndexOf(const AItem: ILoadableItem): Integer;
    procedure Assign(const AValue: ILoadableList);
  end;

implementation

uses
  uArchivingCommonRoutines,
  SysUtils;

resourcestring
  RsAssignListError = 'Ќе удалось выполнить копирование списка';

function TLoadableList.Add: Integer;
begin
  Result := Items.Add(IInterface(ItemClass.Create(Connection, -1)));
end;

function TLoadableList.Add(const AItem: ILoadableItem): Integer;
begin
{$IFNDEF VER150}
  Result := -1;
  if AItem is ItemClass then
  begin
{$ENDIF}
    Result := Items.Add(IInterface(AItem));
{$IFNDEF VER150}
  end;
{$ENDIF}
end;

procedure TLoadableList.Assign(const AValue: ILoadableList);
var
  i: Integer;
  j: Integer;
begin
  Items.Clear;
  if Assigned(AValue) then
  begin
    for i := 0 to AValue.Count - 1 do
    begin
      j := Add;
      if j > -1 then
      begin
        Item[j].Assign(AValue[j]);
      end;
    end;
    if Count <> AValue.Count then
    begin
      raise EListError.Create(RsAssignListError);
    end;
  end;
end;

constructor TLoadableList.Create(const AConnection: TCustomConnection);
begin
  inherited Create;
  FConnection := AConnection;
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

function TLoadableList.GetItem(const AIndex: Integer): ILoadableItem;
var
  a: ILoadableItem;
begin
  Result := nil;
  if Assigned(Items) then
  begin
    if Supports(Items[AIndex], ILoadableItem, a) then
    begin
      Result := a;
    end;
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

function TLoadableList.IndexOf(const AItem: ILoadableItem): Integer;
begin
  Result := -1;
  if Assigned(AItem) and Assigned(FItems) then
  begin
    Result := FItems.IndexOf(IInterface(AItem));
  end;
end;

procedure TLoadableList.BeforeLoad(const AItem: TLoadableItem);
begin
end;

procedure TLoadableList.Load(const AConnection: TCustomConnection);
var
  ds: TDataSet;
  tli: TLoadableItem;
  ili: ILoadableItem;
  s: string;
begin
  if Assigned(AConnection) then
  begin
    Connection := AConnection;
  end;
  if Assigned(Connection) then
  begin
    ds := GetQuery(Connection);
    if Assigned(ds) then
    begin
      try
        s := EmptyStr;
        tli := ItemClass.Create(Connection, -1);
        if Assigned(tli) then
        begin
          try
            BeforeLoad(tli);
            s := tli.GetLoadSQL;
          finally
            FreeAndNil(tli);
          end;
        end;
        SetSQLForQuery(ds, s, True);
        try
          Items.Clear;
          while not ds.Eof do
          begin
            ili := ItemClass.Create(Connection, -1);
            if Assigned(ili) then
            begin
              ili.Load(ds);
              Items.Add(ili);
            end;
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

procedure TLoadableList.PutItem(const AIndex: Integer; const AItem: ILoadableItem);
begin
  if (AIndex >= 0) or (AIndex < Count) then
  begin
    if Assigned(FItems) then
    begin
      FItems[AIndex] := IInterface(AItem);
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
      Result := ILoadableItem(Items[i]).Save(Connection);
      if not Result then
      begin
        Break;
      end;
    end;
  end;
end;

function TLoadableList.Delete(const AIndex: Integer; const AConnection: TCustomConnection): Boolean;
begin
  Result := False;
  if AIndex > -1 then
  begin
    if Assigned(FItems) then
    begin
      if Assigned(AConnection) then
      begin
        Connection := AConnection;
      end;
      if Assigned(Connection) then
      begin
        Result := ILoadableItem(Items[AIndex]).Delete(Connection);
        if Result then
        begin
          FItems.Delete(AIndex);
        end;
      end;
    end;
  end;
end;

function TLoadableList.Clear(const AConnection: TCustomConnection): Boolean;
var
  i: Integer;
begin
  Result := True;
  if Assigned(FItems) then
  begin
    if Assigned(AConnection) then
    begin
      Connection := AConnection;
    end;
    if Assigned(Connection) then
    begin
      for i := 0 to Count - 1 do
      begin
        Result := ILoadableItem(Items[i]).Delete(Connection);
        if Result then
        begin
          FItems.Delete(i);
        end
        else
        begin
          Break;
        end;
      end;
    end;
  end;
end;

end.
