unit uTDocumentBox;

interface

uses
  utloadableitem,
  uidocuments,
  uidocument,
  uIDocumentBox,
  uTDocumentClass;

type
  TDocumentBox = class abstract(TLoadableItem, IDocumentBox)
  private
    FId: Integer;
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
  public
    property Id: Integer read GetId write SetId;

  private
    function GetDocuments: IDocuments;
  public
    property Documents: IDocuments read GetDocuments;

  public
    function AddDocument(const AValue: IDocument): Integer;
    procedure DeleteLastDocument;
  private
    FDocumentClass: TDocumentClass;
  protected
    constructor Create(const ADocumentClass: TDocumentClass); override;
  end;

implementation

function TDocumentBox.AddDocument(const AValue: IDocument): Integer;
begin
//  Result := -1;
//  if Assigned(AValue) then
//  begin
//    if not Assigned(FDocuments) then
//    begin
//      FDocuments := TInterfaceList.Create;
//    end;
//    if Assigned(FDocuments) then
//    begin
//      Result := FDocuments.Add(AValue);
//    end;
//  end;
end;

constructor TDocumentBox.Create;
begin
  inherited;
  FId := -1;
end;

procedure TDocumentBox.DeleteLastDocument;
begin
//  if Assigned(FDocuments) then
//  begin
//    if FDocuments.Count > 0 then
//    begin
//      FDocuments.Delete(FDocuments.Count - 1);
//    end;
//  end;
end;

function TDocumentBox.GetId: Integer;
begin
  Result := FId;
end;

procedure TDocumentBox.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

function TDocumentBox.GetDocuments: IDocuments;
begin
  if not Assigned(FDocuments) then
  begin
    FDocuments := TArchiveCompanies.Create;
    FDocuments.Load(Connection);
  end;
  Result := FDocuments;
end;

end.
