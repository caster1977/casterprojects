unit uTArchiveBox;

interface

uses
  Classes,
  uIDocument,
  uIArchiveBox;

type
  TAcriveBox = class(TInterfacedObject, IArchiveBox)
  private
    FId: Integer;
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
  public
    property Id: Integer read GetId write SetId nodefault;

  private
    function GetName: string;
  public
    property name: string read GetName nodefault;

  private
    FTypeId: Integer;
    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);
  public
    property TypeId: Integer read GetTypeId write SetTypeId nodefault;

  private
    FTypeName: string;
    function GetTypeName: string;
    procedure SetTypeName(const AValue: string);
  public
    property TypeName: string read GetTypeName write SetTypeName nodefault;

  private
    FBarcode: string;
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
  public
    property Barcode: string read GetBarcode write SetBarcode nodefault;

  private
    FYear: Integer;
    function GetYear: Integer;
    procedure SetYear(const AValue: Integer);
  public
    property Year: Integer read GetYear write SetYear nodefault;

  private
    FNumber: string;
    function GetNumber: string;
    procedure SetNumber(const AValue: string);

  public
    property Number: string read GetNumber write SetNumber nodefault;

  private
    FCompanyId: Integer;
    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

  public
    property CompanyId: Integer read GetCompanyId write SetCompanyId nodefault;

  private
    FCompanyName: string;
    function GetCompanyName: string;
    procedure SetCompanyName(const AValue: string);
  public
    property CompanyName: string read GetCompanyName write SetCompanyName nodefault;

  private
    FDocuments: IInterfaceList;
    function GetDocument(const AIndex: Integer): IDocument;
  public
    property Document[const AIndex: Integer]: IDocument read GetDocument; default;
  private
    function GetDocumentCount: Integer;
  public
    property DocumentCount: Integer read GetDocumentCount nodefault;

  public
    function AddDocument(const AValue: IDocument): Integer;
    procedure DeleteLastDocument;
  end;

implementation

uses
  SysUtils;

function TAcriveBox.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TAcriveBox.GetCompanyId: Integer;
begin
  Result := FCompanyId;
end;

function TAcriveBox.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TAcriveBox.GetDocument(const AIndex: Integer): IDocument;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if not Assigned(FDocuments) then
    begin
      FDocuments := TInterfaceList.Create;
    end;
    if Assigned(FDocuments) then
    begin
      if FDocuments.Count > AIndex then
      begin
        Result := IDocument(FDocuments[AIndex]);
      end;
    end;
  end;
end;

function TAcriveBox.GetDocumentCount: Integer;
begin
  Result := FDocuments.Count;
end;

function TAcriveBox.GetId: Integer;
begin
  Result := FId;
end;

function TAcriveBox.GetNumber: string;
begin
  Result := FNumber;
end;

function TAcriveBox.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TAcriveBox.GetTypeName: string;
begin
  Result := FTypeName;
end;

function TAcriveBox.GetYear: Integer;
begin
  Result := FYear;
end;

procedure TAcriveBox.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FBarcode <> s then
  begin
    FBarcode := s;
  end;
end;

procedure TAcriveBox.SetCompanyId(const AValue: Integer);
begin
  if FCompanyId <> AValue then
  begin
    FCompanyId := AValue;
  end;
end;

procedure TAcriveBox.SetCompanyName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCompanyName <> s then
  begin
    FCompanyName := s;
  end;
end;

procedure TAcriveBox.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

procedure TAcriveBox.SetNumber(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FNumber <> s then
  begin
    FNumber := s;
  end;
end;

procedure TAcriveBox.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TAcriveBox.SetTypeName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTypeName <> s then
  begin
    FTypeName := s;
  end;
end;

procedure TAcriveBox.SetYear(const AValue: Integer);
begin
  if FYear <> AValue then
  begin
    FYear := AValue;
  end;
end;

function TAcriveBox.AddDocument(const AValue: IDocument): Integer;
begin
  Result := -1;
  if Assigned(AValue) then
  begin
    if not Assigned(FDocuments) then
    begin
      FDocuments := TInterfaceList.Create;
    end;
    if Assigned(FDocuments) then
    begin
      Result := FDocuments.Add(AValue);
    end;
  end;
end;

procedure TAcriveBox.DeleteLastDocument;
begin
  if Assigned(FDocuments) then
  begin
    if FDocuments.Count > 0 then
    begin
      FDocuments.Delete(FDocuments.Count - 1);
    end;
  end;
end;

function TAcriveBox.GetName: string;
begin
  Result := EmptyStr;
end;

end.
