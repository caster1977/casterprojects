unit uTArchiveBoxItem;

interface

uses
  DB,
  Classes,
  uTLoadableItem,
  uIArchiveBoxItem,
  uIArchiveDocumentList,
  uIShowable;

type
  TArchiveBoxItem = class sealed(TLoadableItem, IArchiveBoxItem, IShowable)
  private
    FCreationDate: TDateTime;
    function GetCreationDate: TDateTime;
    procedure SetCreationDate(const AValue: TDateTime);
  public
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate nodefault;

  private
    FBarcode: string;
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
  public
    property Barcode: string read GetBarcode write SetBarcode nodefault;

  private
    FClosed: Boolean;
    function GetClosed: Boolean;
    procedure SetClosed(const AValue: Boolean);
  public
    property Closed: Boolean read GetClosed write SetClosed nodefault;

  private
    FClosureDate: TDateTime;
    function GetClosureDate: TDateTime;
    procedure SetClosureDate(const AValue: TDateTime);
  public
    property ClosureDate: TDateTime read GetClosureDate write SetClosureDate nodefault;

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
    FNumber: Integer;
    function GetNumber: Integer;
    procedure SetNumber(const AValue: Integer);
  public
    property Number: Integer read GetNumber write SetNumber nodefault;

  private
    FRegistryPrinted: Boolean;
    function GetRegistryPrinted: Boolean;
    procedure SetRegistryPrinted(const AValue: Boolean);
  public
    property RegistryPrinted: Boolean read GetRegistryPrinted write SetRegistryPrinted nodefault;

  private
    FStickerPrinted: Boolean;
    function GetStickerPrinted: Boolean;
    procedure SetStickerPrinted(const AValue: Boolean);
  public
    property StickerPrinted: Boolean read GetStickerPrinted write SetStickerPrinted nodefault;

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
    FYear: Integer;
    function GetYear: Integer;
    procedure SetYear(const AValue: Integer);
  public
    property Year: Integer read GetYear write SetYear nodefault;

  private
    FUserId: Integer;
    function GetUserId: Integer;
    procedure SetUserId(const AValue: Integer);
  public
    property UserId: Integer read GetUserId write SetUserId nodefault;

  private
    FDocuments: IArchiveDocumentList;
    function GetDocuments: IArchiveDocumentList;
  public
    property Documents: IArchiveDocumentList read GetDocuments nodefault;

  private
    FShowableFields: IInterfaceList;
    function GetShowableFields: IInterfaceList;
  public
    property ShowableFields: IInterfaceList read GetShowableFields nodefault;

  protected
    procedure AddShowableField(const ACaption, AName, AValue: string);
    procedure FillShowableFieldsList;

  protected
    function GetSaveSQL: string; override; final;
  public
    constructor Create; override; final;
    constructor Create(const AConnection: TCustomConnection; const AId: Integer); override; final;
    function GetLoadSQL: string; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
  end;

implementation

uses
  SysUtils,
  uCommonRoutines,
  uIShowableField,
  uTShowableField;

function TArchiveBoxItem.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TArchiveBoxItem.GetClosed: Boolean;
begin
  Result := FClosed;
end;

function TArchiveBoxItem.GetClosureDate: TDateTime;
begin
  Result := FClosureDate;
end;

function TArchiveBoxItem.GetCompanyId: Integer;
begin
  Result := FCompanyId;
end;

function TArchiveBoxItem.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TArchiveBoxItem.GetCreationDate: TDateTime;
begin
  Result := FCreationDate;
end;

function TArchiveBoxItem.GetDocuments: IArchiveDocumentList;
begin
  if not Assigned(FDocuments) then
  begin
    FDocuments := GetDocumentListByTypeId(TypeId);
  end;
  Result := FDocuments;
end;

function TArchiveBoxItem.GetNumber: Integer;
begin
  Result := FNumber;
end;

function TArchiveBoxItem.GetRegistryPrinted: Boolean;
begin
  Result := FRegistryPrinted;
end;

function TArchiveBoxItem.GetStickerPrinted: Boolean;
begin
  Result := FStickerPrinted;
end;

function TArchiveBoxItem.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TArchiveBoxItem.GetTypeName: string;
begin
  Result := FTypeName;
end;

function TArchiveBoxItem.GetUserId: Integer;
begin
  Result := FUserId;
end;

function TArchiveBoxItem.GetYear: Integer;
begin
  Result := FYear;
end;

procedure TArchiveBoxItem.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FBarcode <> s then
  begin
    FBarcode := s;
  end;
end;

procedure TArchiveBoxItem.SetClosed(const AValue: Boolean);
begin
  if FClosed <> AValue then
  begin
    FClosed := AValue;
  end;
end;

procedure TArchiveBoxItem.SetClosureDate(const AValue: TDateTime);
begin
  if FClosureDate <> AValue then
  begin
    FClosureDate := AValue;
  end;
end;

procedure TArchiveBoxItem.SetCompanyId(const AValue: Integer);
begin
  if FCompanyId <> AValue then
  begin
    FCompanyId := AValue;
  end;
end;

procedure TArchiveBoxItem.SetCompanyName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCompanyName <> s then
  begin
    FCompanyName := s;
  end;
end;

procedure TArchiveBoxItem.SetCreationDate(const AValue: TDateTime);
begin
  if FCreationDate <> AValue then
  begin
    FCreationDate := AValue;
  end;
end;

procedure TArchiveBoxItem.SetNumber(const AValue: Integer);
begin
  if FNumber <> AValue then
  begin
    FNumber := AValue;
  end;
end;

procedure TArchiveBoxItem.SetRegistryPrinted(const AValue: Boolean);
begin
  if FRegistryPrinted <> AValue then
  begin
    FRegistryPrinted := AValue;
  end;
end;

procedure TArchiveBoxItem.SetStickerPrinted(const AValue: Boolean);
begin
  if FStickerPrinted <> AValue then
  begin
    FStickerPrinted := AValue;
  end;
end;

procedure TArchiveBoxItem.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TArchiveBoxItem.SetTypeName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTypeName <> s then
  begin
    FTypeName := s;
  end;
end;

procedure TArchiveBoxItem.SetUserId(const AValue: Integer);
begin
  if FUserId <> AValue then
  begin
    FUserId := AValue;
  end;
end;

procedure TArchiveBoxItem.SetYear(const AValue: Integer);
begin
  if FYear <> AValue then
  begin
    FYear := AValue;
  end;
end;

function TArchiveBoxItem.GetShowableFields: IInterfaceList;
begin
  FShowableFields := TInterfaceList.Create;
  FillShowableFieldsList;
  Result := FShowableFields;
end;

procedure TArchiveBoxItem.AddShowableField(const ACaption, AName, AValue: string);
var
  f: IShowableField;
begin
  if Assigned(FShowableFields) then
  begin
    f := TShowableField.Create(ACaption, AName, AValue);
    if Assigned(f) then
    begin
      FShowableFields.Add(f);
    end;
  end;
end;

procedure TArchiveBoxItem.FillShowableFieldsList;
begin
  AddShowableField('Компания:', 'CompanyName', CompanyName);
  AddShowableField('Тип документов:', 'TypeName', TypeName);
  AddShowableField('Год:', 'Year', IntToStr(Year));
  AddShowableField('Номер:', 'Number', IntToStr(Number));
  AddShowableField('Штрих-код:', 'Barcode', Barcode);
end;

function TArchiveBoxItem.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveBox %d', [Id]);
end;

function TArchiveBoxItem.GetSaveSQL: string;
begin
  Result := Format('BSOArchiving_upd_ArchiveBox %d, %d, %d, %d, %s, %d, %d, %s, %d, %s, %d, %d',
    [Id, TypeId, CompanyId, UserId, Barcode, Year, Number, FormatDateTime('yyyy-mm-dd hh:nn:ss',
    CreationDate), Closed, FormatDateTime('yyyy-mm-dd hh:nn:ss', ClosureDate),
    Integer(StickerPrinted), Integer(RegistryPrinted)]);
end;

procedure TArchiveBoxItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    Barcode := ADataSet.FieldByName('Barcode').AsString;
    Closed := ADataSet.FieldByName('Closed').AsBoolean;
    ClosureDate := ADataSet.FieldByName('ClosureDate').AsDateTime;
    CompanyId := ADataSet.FieldByName('CompanyId').AsInteger;
    CompanyName := ADataSet.FieldByName('CompanyName').AsString;
    Number := ADataSet.FieldByName('Number').AsInteger;
    RegistryPrinted := ADataSet.FieldByName('RegistryPrinted').AsBoolean;
    StickerPrinted := ADataSet.FieldByName('StickerPrinted').AsBoolean;
    TypeId := ADataSet.FieldByName('TypeId').AsInteger;
    TypeName := ADataSet.FieldByName('TypeName').AsString;
    Year := ADataSet.FieldByName('Year').AsInteger;
    UserId := ADataSet.FieldByName('UserId').AsInteger;
  end;
end;

constructor TArchiveBoxItem.Create(const AConnection: TCustomConnection; const AId: Integer);
begin
  inherited;
  if Assigned(AConnection) then
  begin
    Documents.Load(AConnection);
  end;
end;

constructor TArchiveBoxItem.Create;
begin
  inherited;
  Saveable := True;
  Barcode := EmptyStr;
  Closed := False;
  ClosureDate := 0;
  CompanyId := -1;
  CompanyName := EmptyStr;
  Number := -1;
  RegistryPrinted := False;
  StickerPrinted := False;
  TypeId := -1;
  TypeName := EmptyStr;
  Year := -1;
  UserId := -1;
end;

end.
