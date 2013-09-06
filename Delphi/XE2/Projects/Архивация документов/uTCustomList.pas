unit uTCustomList;

interface

uses
  Classes,
  uICustomList;

type
  TCustomList = class abstract(TInterfacedObject, ICustomList)
  private
    FItems: IInterfaceList;
    function GetItems: IInterfaceList;
    function GetCount: Integer;
  protected
    property Items: IInterfaceList read GetItems nodefault;
  public
    property Count: Integer read GetCount nodefault;
  end;

implementation

function TCustomList.GetCount: Integer;
begin
  Result := 0;
  if Assigned(FItems) then
  begin
    Result := FItems.Count;
  end;
end;

function TCustomList.GetItems: IInterfaceList;
begin
  if not Assigned(FItems) then
  begin
    FItems := TInterfaceList.Create;
  end;
  Result := FItems;
end;

end.
