unit uTCauseOfDamageList;

interface

uses
  DB,
  uTLoadableList,
  uICauseOfDamageList,
  uICauseOfDamageItem;

type
  TCauseOfDamageList = class sealed(TLoadableList, ICauseOfDamageList)
  private
    function GetItem(const AIndex: Integer): ICauseOfDamageItem;
  public
    function GetItemById(const AId: Integer): ICauseOfDamageItem;
    property Item[const AIndex: Integer]: ICauseOfDamageItem read GetItem; default;
  public
    constructor Create(const AConnection: TCustomConnection); override; final;
  end;

implementation

uses
  uTCauseOfDamageItem;

function TCauseOfDamageList.GetItemById(const AId: Integer): ICauseOfDamageItem;
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
        if (Items[i] as ICauseOfDamageItem).Id = AId then
        begin
          Result := Items[i] as ICauseOfDamageItem;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TCauseOfDamageList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TCauseOfDamageItem;
end;

function TCauseOfDamageList.GetItem(const AIndex: Integer): ICauseOfDamageItem;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as ICauseOfDamageItem;
      end;
    end;
  end;
end;

end.
