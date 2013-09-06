unit uTDocuments;

interface

uses
  uTLoadableList,
  DB,
  uIDocument,
  uIDocuments;

type
  TDocuments = class abstract(TLoadableList, IDocuments)
  private
    function GetItem(const AIndex: Integer): IDocument;
  public
    function GetItemById(const AId: Integer): IDocument;
    property Item[const AIndex: Integer]: IDocument read GetItem; default;
  end;

implementation

uses
  uCommonRoutines,
  uTArchiveCompany,
  SysUtils;

function TDocuments.GetItemById(const AId: Integer): IDocument;
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
        if IDocument(Items[i]).Id = AId then
        begin
          Result := IDocument(Items[i]);
          Break;
        end;
      end;
    end;
  end;
end;

function TDocuments.GetItem(const AIndex: Integer): IDocument;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := IDocument(Items[AIndex]);
      end;
    end;
  end;
end;

end.
