unit uTArchiveDocumentList;

interface

uses
  uTLoadableList,
  uTLoadableItem,
  uIArchiveDocumentList,
  uIArchiveDocumentItem;

type
  TArchiveDocumentList = class {$IFNDEF VER150}abstract{$ENDIF}(TLoadableList, IArchiveDocumentList)
  private
    FArchiveBoxId: Integer;
    function GetArchiveBoxId: Integer;
    procedure SetArchiveBoxId(const AValue: Integer);
  protected
    procedure BeforeLoad(const AItem: TLoadableItem); override; {$IFNDEF VER150}final; {$ENDIF}
  public
    property ArchiveBoxId: Integer read GetArchiveBoxId write SetArchiveBoxId nodefault;
  public
    function GetItemById(const AId: Integer): IArchiveDocumentItem;
  end;

implementation

uses
  uTArchiveDocumentItem;

function TArchiveDocumentList.GetItemById(const AId: Integer): IArchiveDocumentItem;
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
        if (Items[i] as IArchiveDocumentItem).Id = AId then
        begin
          Result := Items[i] as IArchiveDocumentItem;
          Break;
        end;
      end;
    end;
  end;
end;

function TArchiveDocumentList.GetArchiveBoxId: Integer;
begin
  Result := FArchiveBoxId;
end;

procedure TArchiveDocumentList.SetArchiveBoxId(const AValue: Integer);
begin
  if FArchiveBoxId <> AValue then
  begin
    FArchiveBoxId := AValue;
  end;
end;

procedure TArchiveDocumentList.BeforeLoad(const AItem: TLoadableItem);
begin
  if Assigned(AItem) then
  begin
    TArchiveDocumentItem(AItem).ArchiveBoxId := ArchiveBoxId;
  end;
end;

end.
