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

  private
    FBarcode: string;
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
  public
    property Barcode: string read GetBarcode write SetBarcode nodefault;

  public
    constructor Create; override;
    constructor Create(const AConnection: TCustomConnection; const AId: Integer); override;
    procedure Load(const ADataSet: TDataSet); override;
    function FromString(const AValue: string): Boolean; override; final;
  end;

implementation

uses
  SysUtils,
  StrUtils,
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

function TCustomBSOItem.FromString(const AValue: string): Boolean;
var
  s: string;
  ds: TDataSet;
  c: Char;
  i: Integer;
begin
  Result := False;
  s := Trim(AValue);
  if Length(s) >= 14 then
  begin
    for i := 1 to Length(s) do
    begin
      if not CharInSet(s[i], ['0' .. '9']) then
      begin
        Exit;
      end;
    end;
    if Assigned(Connection) then
    begin
      ds := GetQuery(Connection);
      if Assigned(ds) then
      begin
        try
          SetSQLForQuery(ds, Format('BSOArchiving_sel_ArchiveDocumentDataByBarcode ''%s''', [s]), True);
          try
            if not ds.Eof then
            begin
              Load(ds);
              Result := True;
            end;
          finally
            ds.Close;
          end;
        finally
          FreeAndNil(ds);
        end;
      end;
    end;
  end;
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
