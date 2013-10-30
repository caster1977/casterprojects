unit uTArchiveBoxList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveBoxItem,
  uIArchiveBoxList;

type
  TArchiveBoxList = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableList, IArchiveBoxList)
  public
    function GetItemById(const AId: Integer): IArchiveBoxItem;
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  uArchivingCommonRoutines,
  uTArchiveBoxItem,
  SysUtils;

function TArchiveBoxList.GetItemById(const AId: Integer): IArchiveBoxItem;
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
        if (IArchiveBoxItem(Items[i])).Id = AId then
        begin
          Result := IArchiveBoxItem(Items[i]);
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveBoxList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TArchiveBoxItem;
end;

end.
