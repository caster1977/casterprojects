unit uTArchiveBoxItem;

interface

uses
  DB,
  Classes,
  uTLoadableItem,
  uIArchiveBoxItem,
  uIArchiveDocumentList,
  uIShowable,
  uILoadableItem;

type
  TArchiveBoxItem = class {$IFNDEF VER150} sealed {$ENDIF}(TLoadableItem, IArchiveBoxItem, IShowable)
  private
    FCreationDate: TDateTime;
    function GetCreationDate: TDateTime;
    procedure SetCreationDate(const AValue: TDateTime);
  public
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate nodefault;

  private
    function GetBarcode: string;
  public
    property Barcode: string read GetBarcode nodefault;

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
    FArchived: Boolean;
    function GetArchived: Boolean;
    procedure SetArchived(const AValue: Boolean);
  public
    property Archived: Boolean read GetArchived write SetArchived;

  private
    FArchivingDate: TDateTime;
    function GetArchivingDate: TDateTime;
    procedure SetArchivingDate(const AValue: TDateTime);
  public
    property ArchivingDate: TDateTime read GetArchivingDate write SetArchivingDate;

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
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetDeleteSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetLoadSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
    function Delete(const AConnection: TCustomConnection = nil): Boolean; override;
    procedure Assign(const AValue: ILoadableItem); override; {$IFNDEF VER150} final; {$ENDIF}
    function FromString(const AValue: string): Boolean;
  end;

const
  SP_ARCHIVING_SEL_ARCHIVE_BOX = 'Archiving_sel_ArchiveBox';
  SP_ARCHIVING_DEL_ARCHIVE_BOX = 'Archiving_del_ArchiveBox';
  SP_ARCHIVING_UPD_ARCHIVE_BOX = 'Archiving_upd_ArchiveBox';
  SP_ARCHIVING_SEL_ARCHIVE_BOX_BY_BARCODE = 'Archiving_sel_ArchiveBoxByBarcode';

implementation

uses
  SysUtils,
  uTArchiveDocumentListClass,
  uArchivingCommonConsts,
  uArchivingCommonResourceStrings,
  uArchivingCommonRoutines,
  uIShowableField,
  uTShowableField,
  StrUtils;

function TArchiveBoxItem.GetArchived: Boolean;
begin
  Result := FArchived;
end;

function TArchiveBoxItem.GetArchivingDate: TDateTime;
begin
  Result := FArchivingDate;
end;

function TArchiveBoxItem.GetBarcode: string;
var
  s: string;
begin
  Result := EmptyStr;
  s := Format(BOX_BARCODE_FORMAT, [CompanyId, TypeId, RightStr(IntToStr(Year), 2), Number]);
  if Length(s) = 12 then
  begin
    Result := s;
  end;
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

procedure TArchiveBoxItem.SetArchived(const AValue: Boolean);
begin
  if FArchived <> AValue then
  begin
    FArchived := AValue;
  end;
end;

procedure TArchiveBoxItem.SetArchivingDate(const AValue: TDateTime);
begin
  if FArchivingDate <> AValue then
  begin
    FArchivingDate := AValue;
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
  AddShowableField(RsCompany, CONST_COMPANY_NAME, CompanyName);
  AddShowableField(RsTypeName, CONST_TYPE_NAME, TypeName);
  AddShowableField(RsYear, CONST_YEAR, IfThen(Year <> -1, IntToStr(Year)));
  AddShowableField(RsNumber, CONST_NUMBER, IfThen(Number <> -1, IntToStr(Number)));
  AddShowableField(RsBarcode, CONST_BARCODE, Barcode);
  if Assigned(Documents) then
  begin
    AddShowableField(RsDocumentCount, CONST_DOCUMENT_COUNT, IntToStr(Documents.Count));
  end;
end;

function TArchiveBoxItem.GetLoadSQL: string;
begin
  Result := Format(SP_ARCHIVING_SEL_ARCHIVE_BOX + ' %d', [Id]);
end;

function TArchiveBoxItem.GetDeleteSQL: string;
begin
  Result := Format(SP_ARCHIVING_DEL_ARCHIVE_BOX + ' %d', [Id]);
end;

function TArchiveBoxItem.GetSaveSQL: string;
begin
  Result := Format(SP_ARCHIVING_UPD_ARCHIVE_BOX +
    ' %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d, ''%s'', %d, ''%s'', %d, %d', [Id, TypeId, CompanyId, UserId, Barcode,
    Year, Number, FormatDateTime(DATE_TIME_FORMAT, CreationDate), Integer(Closed), FormatDateTime(DATE_TIME_FORMAT,
    ClosureDate), Integer(Archived), FormatDateTime(DATE_TIME_FORMAT, ArchivingDate), Integer(StickerPrinted),
    Integer(RegistryPrinted)]);
end;

procedure TArchiveBoxItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    CreationDate := ADataSet.FieldByName(CONST_CREATION_DATE).AsDateTime;
    Closed := ADataSet.FieldByName(CONST_CLOSED).AsBoolean;
    ClosureDate := ADataSet.FieldByName(CONST_CLOSURE_DATE).AsDateTime;
    Archived := ADataSet.FieldByName(CONST_ARCHIVED).AsBoolean;
    ArchivingDate := ADataSet.FieldByName(CONST_ARCHIVING_DATE).AsDateTime;
    UserId := ADataSet.FieldByName(CONST_USER_ID).AsInteger;
    CompanyId := ADataSet.FieldByName(CONST_COMPANY_ID).AsInteger;
    CompanyName := ADataSet.FieldByName(CONST_COMPANY_NAME).AsString;
    TypeId := ADataSet.FieldByName(CONST_TYPE_ID).AsInteger;
    TypeName := ADataSet.FieldByName(CONST_TYPE_NAME).AsString;
    Year := ADataSet.FieldByName(CONST_YEAR).AsInteger;
    Number := ADataSet.FieldByName(CONST_NUMBER).AsInteger;
    RegistryPrinted := ADataSet.FieldByName(CONST_REGISTRY_PRINTED).AsBoolean;
    StickerPrinted := ADataSet.FieldByName(CONST_STICKER_PRINTED).AsBoolean;
  end;
end;

procedure TArchiveBoxItem.Assign(const AValue: ILoadableItem);
var
  a: IArchiveBoxItem;
begin
  inherited;
  if Supports(AValue, IArchiveBoxItem, a) then
  begin
    CreationDate := a.CreationDate;
    Closed := a.Closed;
    ClosureDate := a.ClosureDate;
    Archived := a.Archived;
    ArchivingDate := a.ArchivingDate;
    UserId := a.UserId;
    CompanyId := a.CompanyId;
    CompanyName := a.CompanyName;
    TypeId := a.TypeId;
    TypeName := a.TypeName;
    Year := a.Year;
    Number := a.Number;
    RegistryPrinted := a.RegistryPrinted;
    StickerPrinted := a.StickerPrinted;
  end;
end;

constructor TArchiveBoxItem.Create;
begin
  inherited;
  Saveable := True;
  Closed := False;
  ClosureDate := 0;
  Archived := False;
  ArchivingDate := -1;
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

function TArchiveBoxItem.GetDocuments: IArchiveDocumentList;
var
  item_class: TArchiveDocumentListClass;
begin
  if not Assigned(FDocuments) then
  begin
    item_class := GetArchiveDocumentListClassByTypeId(TypeId);
    if Assigned(item_class) then
    begin
      FDocuments := item_class.Create(Connection);
      if Assigned(FDocuments) then
      begin
        FDocuments.ArchiveBoxId := Id;
        FDocuments.Load;
      end;
    end;
  end;
  Result := FDocuments;
end;

function TArchiveBoxItem.Delete(const AConnection: TCustomConnection): Boolean;
begin
  // нельзя удалять короб, пока в нём имеются документы
  Result := False;
  if Assigned(Documents) then
  begin
    Result := Documents.Count = 0;
  end;
  if Result then
  begin
    Result := inherited Delete(AConnection);
  end;
end;

function TArchiveBoxItem.FromString(const AValue: string): Boolean;
var
  s: string;
  ds: TDataSet;
  i: Integer;
begin
  Result := False;
  s := Trim(AValue);
  if Length(s) = 12 then
  begin
    for i := 1 to Length(s) do
    begin
{$IFDEF VER150}
      case s[i] of
        '0' .. '9':
          begin
          end;
      else
        begin
          Exit;
        end;
      end;
{$ELSE}
      if not CharInSet(s[i], ['0' .. '9']) then
      begin
        Exit;
      end;
{$ENDIF}
    end;
    if Assigned(Connection) then
    begin
      ds := GetQuery(Connection);
      if Assigned(ds) then
      begin
        try
          SetSQLForQuery(ds, Format(SP_ARCHIVING_SEL_ARCHIVE_BOX_BY_BARCODE + ' ''%s''', [s]), True);
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

end.
