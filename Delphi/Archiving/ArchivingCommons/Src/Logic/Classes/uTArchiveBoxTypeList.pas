unit uTArchiveBoxTypeList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveBoxTypeItem,
  uIArchiveBoxTypeList;

type
  TArchiveBoxTypeList = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableList, IArchiveBoxTypeList)
  public
    function GetItemById(const AId: Integer): IArchiveBoxTypeItem;
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  uTArchiveBoxTypeItem;

function TArchiveBoxTypeList.GetItemById(const AId: Integer): IArchiveBoxTypeItem;
var
  i: Integer;
begin
  Result := nil;
  if AId > -1 then
  begin
    for i := 0 to Count - 1 do
    begin
      if Assigned(Items[i]) then
      begin
        if (Items[i] as IArchiveBoxTypeItem).Id = AId then
        begin
          Result := Items[i] as IArchiveBoxTypeItem;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveBoxTypeList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TArchiveBoxTypeItem;
end;

end.
