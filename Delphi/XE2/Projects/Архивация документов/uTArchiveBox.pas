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
  public
    class function GetLoadSQL(const AId: Integer): string; override; final;

  private
    FTypeId: Integer;
    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);
  public
    property TypeId: Integer read GetTypeId write SetTypeId nodefault;

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
    FNumber: Integer;
    function GetNumber: Integer;
    procedure SetNumber(const AValue: Integer);
  public
    property Number: Integer read GetNumber write SetNumber nodefault;

  private
    FCompanyId: Integer;
    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);
  public
    property CompanyId: Integer read GetCompanyId write SetCompanyId nodefault;

  private
    FClosed: Boolean;
    function GetClosed: Boolean;
    procedure SetClosed(const AValue: Boolean);
  public
    property Closed: Boolean read GetClosed write SetClosed;

  private
    FClosureDate: TDateTime;
    function GetClosureDate: TDateTime;
    procedure SetClosureDate(const AValue: TDateTime);
  public
    property ClosureDate: TDateTime read GetClosureDate write SetClosureDate;

  private
    FRegistryPrinted: Boolean;
    function GetRegistryPrinted: Boolean;
    procedure SetRegistryPrinted(const AValue: Boolean);
  public
    property RegistryPrinted: Boolean read GetRegistryPrinted write SetRegistryPrinted;

  private
    FStickerPrinted: Boolean;
    function GetStickerPrinted: Boolean;
    procedure SetStickerPrinted(const AValue: Boolean);
  public
    property StickerPrinted: Boolean read GetStickerPrinted write SetStickerPrinted;

  private
    FUserId: Integer;
    function GetUserId: Integer;
    procedure SetUserId(const AValue: Integer);
  public
    property UserId: Integer read GetUserId write SetUserId;

  public
    procedure Load(const ADataSet: TDataSet); override;
    procedure Close;
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

function TArchiveBox.GetNumber: Integer;
begin
  Result := FNumber;
end;

function TArchiveBox.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TArchiveBox.GetUserId: Integer;
begin
  Result := FUserId;
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

procedure TArchiveBox.SetNumber(const AValue: Integer);
begin
  if FNumber <> AValue then
  begin
    FNumber := AValue;
  end;
end;

procedure TArchiveBox.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TArchiveBox.SetUserId(const AValue: Integer);
begin
  if FUserId <> AValue then
  begin
    FUserId := AValue;
  end;
end;

procedure TArchiveBox.SetYear(const AValue: Integer);
begin
  if FYear <> AValue then
  begin
    FYear := AValue;
  end;
end;

function TArchiveBox.GetClosed: Boolean;
begin
  Result := FClosed;
end;

procedure TArchiveBox.SetClosed(const AValue: Boolean);
begin
  if FClosed <> AValue then
  begin
    FClosed := AValue;
  end;
end;

function TArchiveBox.GetClosureDate: TDateTime;
begin
  Result := FClosureDate;
end;

procedure TArchiveBox.SetClosureDate(const AValue: TDateTime);
begin
  if FClosureDate <> AValue then
  begin
    FClosureDate := AValue;
  end;
end;

function TArchiveBox.GetRegistryPrinted: Boolean;
begin
  Result := FRegistryPrinted;
end;

procedure TArchiveBox.SetRegistryPrinted(const AValue: Boolean);
begin
  if FRegistryPrinted <> AValue then
  begin
    FRegistryPrinted := AValue;
  end;
end;

function TArchiveBox.GetStickerPrinted: Boolean;
begin
  Result := FStickerPrinted;
end;

procedure TArchiveBox.SetStickerPrinted(const AValue: Boolean);
begin
  if FStickerPrinted <> AValue then
  begin
    FStickerPrinted := AValue;
  end;
end;

procedure TArchiveBox.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    Barcode := ADataSet.FieldByName('Barcode').AsString;
    Closed := ADataSet.FieldByName('Closed').AsBoolean;
    ClosureDate := ADataSet.FieldByName('ClosureDate').AsDateTime;
    CompanyId := ADataSet.FieldByName('CompanyId').AsInteger;
    Number := ADataSet.FieldByName('Number').AsInteger;
    RegistryPrinted := ADataSet.FieldByName('RegistryPrinted').AsBoolean;
    StickerPrinted := ADataSet.FieldByName('StickerPrinted').AsBoolean;
    TypeId := ADataSet.FieldByName('TypeId').AsInteger;
    Year := ADataSet.FieldByName('Year').AsInteger;
    UserId := ADataSet.FieldByName('UserId').AsInteger;
  end;
  inherited;
end;

class function TArchiveBox.GetLoadSQL(const AId: Integer): string;
begin
  Result := Format('BSOArchiving_sel_ArchiveBoxes %d', [AId]);
end;

procedure TArchiveBox.Close;
begin
  if not Closed then
  begin
    Closed := True;
    ClosureDate := Now;
    UserId := -1;
  end;
end;

end.
