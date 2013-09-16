unit uTCustomBSOItem;

interface

uses
  Classes,
  DB,
  Vcl.Controls,
  uIArchiveDocumentItem,
  uTArchiveDocumentItem,
  uICustomBSOItem;

type
  TCustomBSOItem = class abstract(TArchiveDocumentItem, ICustomBSOItem)
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
    FBSOId: Integer;
    function GetBSOId: Integer;
    procedure SetBSOId(const AValue: Integer);
  public
    property BSOId: Integer read GetBSOId write SetBSOId nodefault;

  private
    FBarcode: string;
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
  public
    property Barcode: string read GetBarcode write SetBarcode nodefault;

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

  public
    constructor Create; override;
    constructor Create(const AConnection: TCustomConnection; const AId: Integer); override;
    procedure Load(const ADataSet: TDataSet); override;
  end;

implementation

uses
  SysUtils,
  uCommonRoutines;

function TCustomBSOItem.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TCustomBSOItem.GetBSOId: Integer;
begin
  Result := FBSOId;
end;

function TCustomBSOItem.GetCompanyId: Integer;
begin
  Result := FCompanyId;
end;

function TCustomBSOItem.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TCustomBSOItem.GetNumber: string;
begin
  Result := FNumber;
end;

function TCustomBSOItem.GetSeries: string;
begin
  Result := FSeries;
end;

procedure TCustomBSOItem.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FBarcode <> s then
  begin
    FBarcode := s;
  end;
end;

procedure TCustomBSOItem.SetBSOId(const AValue: Integer);
begin
  if FBSOId <> AValue then
  begin
    FBSOId := AValue;
  end;
end;

procedure TCustomBSOItem.SetCompanyId(const AValue: Integer);
begin
  if FCompanyId <> AValue then
  begin
    FCompanyId := AValue;
  end;
end;

procedure TCustomBSOItem.SetCompanyName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCompanyName <> s then
  begin
    FCompanyName := s;
  end;
end;

procedure TCustomBSOItem.SetNumber(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FNumber <> s then
  begin
    FNumber := s;
  end;
end;

procedure TCustomBSOItem.SetSeries(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FSeries <> s then
  begin
    FSeries := s;
  end;
end;

constructor TCustomBSOItem.Create;
begin
  inherited;
  CompanyId := -1;
  CompanyName := EmptyStr;
  BSOId := -1;
  Barcode := EmptyStr;
  Series := EmptyStr;
  Number := EmptyStr;
end;

constructor TCustomBSOItem.Create(const AConnection: TCustomConnection; const AId: Integer);
begin
  inherited;
end;

procedure TCustomBSOItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    CompanyId := ADataSet.FieldByName('CompanyId').AsInteger;
    CompanyName := ADataSet.FieldByName('CompanyName').AsString;
    BSOId := ADataSet.FieldByName('BSOId').AsInteger;
    Barcode := ADataSet.FieldByName('Barcode').AsString;
    Series := ADataSet.FieldByName('Series').AsString;
    Number := ADataSet.FieldByName('Number').AsString;
  end;
end;

end.
