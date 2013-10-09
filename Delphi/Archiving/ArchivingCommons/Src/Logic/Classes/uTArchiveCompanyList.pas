unit uTArchiveCompanyList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveCompanyItem,
  uIArchiveCompanyList;

type
  TArchiveCompanyList = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableList, IArchiveCompanyList)
  private
    function GetItem(const AIndex: Integer): IArchiveCompanyItem;
  public
    function GetItemById(const AId: Integer): IArchiveCompanyItem;
    property Item[const AIndex: Integer]: IArchiveCompanyItem read GetItem; default;
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

function TArchiveCompanyList.GetItem(const AIndex: Integer): IArchiveCompanyItem;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as IArchiveCompanyItem;
      end;
    end;
  end;
end;

end.
