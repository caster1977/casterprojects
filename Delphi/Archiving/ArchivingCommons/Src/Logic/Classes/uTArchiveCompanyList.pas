unit uTArchiveCompanyList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveCompanyItem,
  uIArchiveCompanyList;

type
  TArchiveCompanyList = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableList, IArchiveCompanyList)
  public
    function GetItemById(const AId: Integer): IArchiveCompanyItem;
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  uTArchiveCompanyItem;

function TArchiveCompanyList.GetItemById(const AId: Integer): IArchiveCompanyItem;
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
        if (Items[i] as IArchiveCompanyItem).Id = AId then
        begin
          Result := Items[i] as IArchiveCompanyItem;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveCompanyList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TArchiveCompanyItem;
end;

end.
