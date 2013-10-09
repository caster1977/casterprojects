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
  private
    function GetItem(const AIndex: Integer): ICauseOfArchiveDocumentDamageItem;
  public
    function GetItemById(const AId: Integer): ICauseOfArchiveDocumentDamageItem;
    property Item[const AIndex: Integer]: ICauseOfArchiveDocumentDamageItem read GetItem; default;
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

function TCauseOfArchiveDocumentDamageList.GetItem(const AIndex: Integer): ICauseOfArchiveDocumentDamageItem;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as ICauseOfArchiveDocumentDamageItem;
      end;
    end;
  end;
end;

end.
