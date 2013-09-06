unit uTLoadableList;

interface

uses
  DB,
  uILoadableList,
  uTCustomList,
  uTLoadableItemClass;

type
  TLoadableList = class(TCustomList, ILoadableList)
  private
    FItemClass: TLoadableItemClass;
    function GetItemClass: TLoadableItemClass;
  protected
    function GetLoadSQL: string; virtual; abstract;
    property ItemClass: TLoadableItemClass read GetItemClass nodefault;
    constructor Create(const AItemClass: TLoadableItemClass); reintroduce; virtual;
  public
    procedure Load(const AConnection: TCustomConnection);
  end;

implementation

uses
  Classes,
  uCommonRoutines,
  ADODB,
  SqlExpr,
  uTLoadableItem,
  SysUtils;

constructor TLoadableList.Create(const AItemClass: TLoadableItemClass);
begin
  Assert(Assigned(AItemClass), 'AItemClass is nil!');
  FItemClass := AItemClass;
end;

function TLoadableList.GetItemClass: TLoadableItemClass;
begin
  Result := FItemClass;
end;

procedure TLoadableList.Load(const AConnection: TCustomConnection);
var
  ds: TDataSet;
  ic: TLoadableItem;
begin
  if Assigned(AConnection) then
  begin
    if AConnection.Connected then
    begin
      if AConnection is TADOConnection then
      begin
        ds := TADOQuery.Create(nil);
        (ds as TADOQuery).Connection := AConnection as TADOConnection;
        (ds as TADOQuery).CommandTimeout := 60000;
        (ds as TADOQuery).LockType := ltReadOnly;
        (ds as TADOQuery).CursorType := ctOpenForwardOnly;
      end
      else
      begin
        ds := TSQLQuery.Create(nil);
        (ds as TSQLQuery).SQLConnection := AConnection as TSQLConnection;
      end;
      try
        SetSQL(ds, GetLoadSQL, True);
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
end;

end.
