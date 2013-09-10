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
    procedure SetItemClass(const AValue: TLoadableItemClass);
  protected
    function GetLoadSQL: string; virtual; final;
    property ItemClass: TLoadableItemClass read GetItemClass write SetItemClass nodefault;
  public
    constructor Create; reintroduce; virtual;
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

constructor TLoadableList.Create;
begin
  inherited;
end;

function TLoadableList.GetItemClass: TLoadableItemClass;
begin
  Result := FItemClass;
end;

function TLoadableList.GetLoadSQL: string;
begin
  Result := ItemClass.GetLoadSQL;
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

procedure TLoadableList.SetItemClass(const AValue: TLoadableItemClass);
begin
  if FItemClass <> AValue then
  begin
    FItemClass := AValue;
  end;
end;

end.
