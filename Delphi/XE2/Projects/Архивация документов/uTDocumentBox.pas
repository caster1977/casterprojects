unit uTDocumentBox;

interface

uses
  DB,
  uTLoadableItem,
  uIDocuments,
  uIDocument,
  uIDocumentBox,
  uTDocumentListClass;

type
  TDocumentBox = class abstract(TLoadableItem, IDocumentBox)
  private
    FId: Integer;
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
  public
    property Id: Integer read GetId write SetId;

  public
    procedure Load(const ADataSet: TDataSet); override;

  private
    FDocuments: IDocuments;
    function GetDocuments: IDocuments;
  public
    property Documents: IDocuments read GetDocuments;

  private
    FConnection: TCustomConnection;
    function GetConnection: TCustomConnection;
  protected
    property Connection: TCustomConnection read GetConnection nodefault;
  public
    constructor Create(const AConnection: TCustomConnection;
      const ADocumentsClass: TDocumentListClass); reintroduce; virtual;

  private
    FDocumentsClass: TDocumentListClass;
    function GetDocumentsClass: TDocumentListClass;
  protected
    property DocumentsClass: TDocumentListClass read GetDocumentsClass nodefault;
  end;

implementation

function TDocumentBox.GetId: Integer;
begin
  Result := FId;
end;

procedure TDocumentBox.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    Id := ADataSet.FieldByName('Id').AsInteger;
    if Assigned(Connection) then
    begin
      Documents.Load(Connection);
    end;
  end;
end;

procedure TDocumentBox.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

function TDocumentBox.GetDocumentsClass: TDocumentListClass;
begin
  Result := FDocumentsClass;
end;

constructor TDocumentBox.Create(const AConnection: TCustomConnection;
  const ADocumentsClass: TDocumentListClass);
begin
  inherited Create;
  FId := -1;
  FDocumentsClass := ADocumentsClass;
  FConnection := AConnection;
end;

function TDocumentBox.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

function TDocumentBox.GetDocuments: IDocuments;
begin
  if not Assigned(FDocuments) then
  begin
    if Assigned(DocumentsClass) then
    begin
      FDocuments := DocumentsClass.Create;
    end;
  end;
  Result := FDocuments;
end;

end.
