unit uTArchiveBox;

interface

uses
  DB,
  Classes,
  uTDocumentBox,
  uIDocument,
  uIArchiveBox,
  uTLoadableItem;

type
  TArchiveBox = class(TDocumentBox, IArchiveBox)
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

  public
    procedure Load(const ADataSet: TDataSet); override;
  end;

implementation

uses
  SysUtils;

function TArchiveBox.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TArchiveBox.GetCompanyId: Integer;
begin
  Result := FCompanyId;
end;

function TArchiveBox.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TArchiveBox.GetNumber: string;
begin
  Result := FNumber;
end;

function TArchiveBox.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TArchiveBox.GetTypeName: string;
begin
  Result := FTypeName;
end;

function TArchiveBox.GetYear: Integer;
begin
  Result := FYear;
end;

procedure TArchiveBox.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FBarcode <> s then
  begin
    FBarcode := s;
  end;
end;

procedure TArchiveBox.SetCompanyId(const AValue: Integer);
begin
  if FCompanyId <> AValue then
  begin
    FCompanyId := AValue;
  end;
end;

procedure TArchiveBox.SetCompanyName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCompanyName <> s then
  begin
    FCompanyName := s;
  end;
end;

procedure TArchiveBox.SetNumber(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FNumber <> s then
  begin
    FNumber := s;
  end;
end;

procedure TArchiveBox.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TArchiveBox.SetTypeName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTypeName <> s then
  begin
    FTypeName := s;
  end;
end;

procedure TArchiveBox.SetYear(const AValue: Integer);
begin
  if FYear <> AValue then
  begin
    FYear := AValue;
  end;
end;

function TArchiveBox.GetName: string;
begin
  Result := 'Дописать метод TArchiveBox.GetName';
end;

procedure TArchiveBox.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    // Id := ADataSet.FieldByName('Id').AsInteger;
    TypeId := ADataSet.FieldByName('TypeId').AsInteger;
    TypeName := ADataSet.FieldByName('TypeName').AsString;
    Barcode := ADataSet.FieldByName('Barcode').AsString;
    Year := ADataSet.FieldByName('Year').AsInteger;
    Number := ADataSet.FieldByName('Number').AsString;
    CompanyId := ADataSet.FieldByName('CompanyId').AsInteger;
    CompanyName := ADataSet.FieldByName('CompanyName').AsString;
  end;
  inherited;
end;

end.
