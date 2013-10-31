unit uTCauseOfArchiveDocumentDamageList;

interface

uses
  DB,
  uTLoadableList,
  uICauseOfArchiveDocumentDamageList,
  uICauseOfArchiveDocumentDamageItem;

type
  TCauseOfArchiveDocumentDamageList = class {$IFNDEF VER150} sealed
{$ENDIF}(TLoadableList, ICauseOfArchiveDocumentDamageList)
  public
    function GetItemById(const AId: Integer): ICauseOfArchiveDocumentDamageItem;
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  uTCauseOfArchiveDocumentDamageItem;

function TCauseOfArchiveDocumentDamageList.GetItemById(const AId: Integer): ICauseOfArchiveDocumentDamageItem;
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
        if (Items[i] as ICauseOfArchiveDocumentDamageItem).Id = AId then
        begin
          Result := Items[i] as ICauseOfArchiveDocumentDamageItem;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TCauseOfArchiveDocumentDamageList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TCauseOfArchiveDocumentDamageItem;
end;

end.
