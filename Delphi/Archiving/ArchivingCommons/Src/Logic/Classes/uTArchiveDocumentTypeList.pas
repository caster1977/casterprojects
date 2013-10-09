unit uTArchiveDocumentTypeList;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveDocumentTypeItem,
  uIArchiveDocumentTypeList;

type
  TArchiveDocumentTypeList = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableList, IArchiveDocumentTypeList)
  private
    function GetItem(const AIndex: Integer): IArchiveDocumentTypeItem;
  public
    function GetItemById(const AId: Integer): IArchiveDocumentTypeItem;
    property Item[const AIndex: Integer]: IArchiveDocumentTypeItem read GetItem; default;
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  uArchivingCommonRoutines,
  uTArchiveDocumentTypeItem,
  SysUtils;

function TArchiveDocumentTypeList.GetItemById(const AId: Integer): IArchiveDocumentTypeItem;
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
        if (Items[i] as IArchiveDocumentTypeItem).Id = AId then
        begin
          Result := Items[i] as IArchiveDocumentTypeItem;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveDocumentTypeList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TArchiveDocumentTypeItem;
end;

function TArchiveDocumentTypeList.GetItem(const AIndex: Integer): IArchiveDocumentTypeItem;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as IArchiveDocumentTypeItem;
      end;
    end;
  end;
end;

end.
