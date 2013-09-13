unit uTArchiveBoxList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveBoxItem,
  uIArchiveBoxList;

type
  TArchiveBoxList = class sealed(TLoadableList, IArchiveBoxList)
  private
    function GetItem(const AIndex: Integer): IArchiveBoxItem;
  public
    function GetItemById(const AId: Integer): IArchiveBoxItem;
    property Item[const AIndex: Integer]: IArchiveBoxItem read GetItem; default;
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uCommonRoutines,
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
        if (Items[i] as IArchiveBoxItem).Id = AId then
        begin
          Result := Items[i] as IArchiveBoxItem;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveBoxList.Create;
begin
  inherited;
  ItemClass := TArchiveBoxItem;
end;

function TArchiveBoxList.GetItem(const AIndex: Integer): IArchiveBoxItem;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as IArchiveBoxItem;
      end;
    end;
  end;
end;

end.
