unit uTArchiveBoxTypeList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveBoxTypeItem,
  uIArchiveBoxTypeList;

type
  TArchiveBoxTypeList = class sealed(TLoadableList, IArchiveBoxTypeList)
  private
    function GetItem(const AIndex: Integer): IArchiveBoxTypeItem;
  public
    function GetItemById(const AId: Integer): IArchiveBoxTypeItem;
    property Item[const AIndex: Integer]: IArchiveBoxTypeItem read GetItem; default;
  public
    constructor Create(const AConnection: TCustomConnection); override; final;
  end;

implementation

uses
  uArchivingCommonRoutines,
  uTArchiveBoxTypeItem,
  SysUtils;

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

function TArchiveBoxTypeList.GetItem(const AIndex: Integer): IArchiveBoxTypeItem;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as IArchiveBoxTypeItem;
      end;
    end;
  end;
end;

end.
