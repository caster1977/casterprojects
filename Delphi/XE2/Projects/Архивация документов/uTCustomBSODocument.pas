unit uTCustomBSODocument;

interface

uses
  System.Classes,
  Data.DB,
  Vcl.Controls,
  uICustomDocument,
  uTCustomDocument;

type
  TCustomBSODocument = class abstract(TCustomDocument)
  private
    FBarcode: string;
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
  public
    property Barcode: string read GetBarcode write SetBarcode nodefault;

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
    FSeries: string;
    function GetSeries: string;
    procedure SetSeries(const AValue: string);
  public
    property Series: string read GetSeries write SetSeries nodefault;

  private
    FNumber: string;
    function GetNumber: string;
    procedure SetNumber(const AValue: string);
  public
    property Number: string read GetNumber write SetNumber nodefault;

  protected
    procedure Initialize; override;

  public
    procedure Load(const ADataSet: TDataSet); override;
    procedure Show(const AParentControl: TCustomControl); override;
  end;

implementation

uses
  SysUtils,
  uCommonRoutines;

function TCustomBSODocument.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TCustomBSODocument.GetCompanyId: Integer;
begin
  Result := FCompanyId;
end;

function TCustomBSODocument.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TCustomBSODocument.GetNumber: string;
begin
  Result := FNumber;
end;

function TCustomBSODocument.GetSeries: string;
begin
  Result := FSeries;
end;

procedure TCustomBSODocument.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FBarcode <> s then
  begin
    FBarcode := s;
  end;
end;

procedure TCustomBSODocument.SetCompanyId(const AValue: Integer);
begin
  if FCompanyId <> AValue then
  begin
    FCompanyId := AValue;
  end;
end;

procedure TCustomBSODocument.SetCompanyName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCompanyName <> s then
  begin
    FCompanyName := s;
  end;
end;

procedure TCustomBSODocument.SetNumber(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FNumber <> s then
  begin
    FNumber := s;
  end;
end;

procedure TCustomBSODocument.SetSeries(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FSeries <> s then
  begin
    FSeries := s;
  end;
end;

procedure TCustomBSODocument.Initialize;
begin
  inherited;
  Barcode := EmptyStr;
  CompanyId := -1;
  CompanyName := EmptyStr;
  Series := EmptyStr;
  Number := EmptyStr;
end;

procedure TCustomBSODocument.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    Barcode := ADataSet.FieldByName('Barcode').AsString;
    CompanyId := ADataSet.FieldByName('CompanyId').AsInteger;
    CompanyName := ADataSet.FieldByName('CompanyName').AsString;
    Series := ADataSet.FieldByName('Series').AsString;
    Number := ADataSet.FieldByName('Number').AsString;
  end;
end;

procedure TCustomBSODocument.Show(const AParentControl: TCustomControl);
begin
  inherited;
  SetLabelCaption(FParentControl, 'lblDocumentBarcode', Barcode);
  SetLabelCaption(FParentControl, 'lblDocumentCompanyId', IntToStr(CompanyId));
  SetLabelCaption(FParentControl, 'lblDocumentCompanyName', CompanyName);
  SetLabelCaption(FParentControl, 'lblDocumentSeries', Series);
  SetLabelCaption(FParentControl, 'lblDocumentNumber', Number);
end;

end.
