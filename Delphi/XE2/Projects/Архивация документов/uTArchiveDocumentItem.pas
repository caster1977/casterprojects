unit uTArchiveDocumentItem;

interface

uses
  DB,
  Controls,
  Classes,
  uTLoadableItem,
  uIArchiveDocumentItem,
  uIShowable,
  uIArchiveBoxItem;

type
  TArchiveDocumentItem = class abstract(TLoadableItem, IArchiveDocumentItem, IShowable)
  private
    FArchiveBoxId: Integer;
    function GetArchiveBoxId: Integer;
    procedure SetArchiveBoxId(const AValue: Integer);
  public
    property ArchiveBoxId: Integer read GetArchiveBoxId write SetArchiveBoxId nodefault;

  private
    FArchivedByUser: Integer;
    function GetArchivedByUser: Integer;
    procedure SetArchivedByUser(const AValue: Integer);
  public
    property ArchivedByUser: Integer read GetArchivedByUser write SetArchivedByUser nodefault;

  private
    FArchivingDate: TDateTime;
    function GetArchivingDate: TDateTime;
    procedure SetArchivingDate(const AValue: TDateTime);
  public
    property ArchivingDate: TDateTime read GetArchivingDate write SetArchivingDate nodefault;

  private
    FIssued: Boolean;
    function GetIssued: Boolean;
    procedure SetIssued(const AValue: Boolean);
  public
    property Issued: Boolean read GetIssued write SetIssued nodefault;

  private
    FIssuedToUser: Integer;
    function GetIssuedToUser: Integer;
    procedure SetIssuedToUser(const AValue: Integer);
  public
    property IssuedToUser: Integer read GetIssuedToUser write SetIssuedToUser nodefault;

  private
    FIssuanceDate: TDateTime;
    function GetIssuanceDate: TDateTime;
    procedure SetIssuanceDate(const AValue: TDateTime);
  public
    property IssuanceDate: TDateTime read GetIssuanceDate write SetIssuanceDate nodefault;

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
    FBarcode: string;
    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);
  public
    property Barcode: string read GetBarcode write SetBarcode nodefault;

  private
    FSequenceNumber: Integer;
    function GetSequenceNumber: Integer;
    procedure SetSequenceNumber(const AValue: Integer);
  public
    property SequenceNumber: Integer read GetSequenceNumber write SetSequenceNumber;

  private
    FShowableFields: IInterfaceList;
    function GetShowableFields: IInterfaceList;
  public
    property ShowableFields: IInterfaceList read GetShowableFields nodefault;

  protected
    procedure AddShowableField(const ACaption, AName, AValue: string);
    procedure FillShowableFieldsList; virtual; abstract;
    function GetDeleteSQL: string; override; final;

  public
    function FromString(const AValue: string): Boolean; virtual; abstract;
    function GetLoadSQL: string; override; final;
    procedure Load(const ADataSet: TDataSet); override;
    constructor Create; override;
    function AlreadyArchived(const AConnection: TCustomConnection = nil): Integer; virtual; abstract;
  end;

implementation

uses
  SysUtils,
  StdCtrls,
  Types,
  uArchivingCommonRoutines,
  uIShowableField,
  uTShowableField;

function TArchiveDocumentItem.GetArchiveBoxId: Integer;
begin
  Result := FArchiveBoxId;
end;

function TArchiveDocumentItem.GetArchivedByUser: Integer;
begin
  Result := FArchivedByUser;
end;

function TArchiveDocumentItem.GetArchivingDate: TDateTime;
begin
  Result := FArchivingDate;
end;

function TArchiveDocumentItem.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TArchiveDocumentItem.GetCompanyId: Integer;
begin
  Result := FCompanyId;
end;

function TArchiveDocumentItem.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TArchiveDocumentItem.GetIssuanceDate: TDateTime;
begin
  Result := FIssuanceDate;
end;

function TArchiveDocumentItem.GetIssued: Boolean;
begin
  Result := FIssued;
end;

function TArchiveDocumentItem.GetIssuedToUser: Integer;
begin
  Result := FIssuedToUser;
end;

procedure TArchiveDocumentItem.SetArchiveBoxId(const AValue: Integer);
begin
  if FArchiveBoxId <> AValue then
  begin
    FArchiveBoxId := AValue;
  end;
end;

procedure TArchiveDocumentItem.SetArchivedByUser(const AValue: Integer);
begin
  if FArchivedByUser <> AValue then
  begin
    FArchivedByUser := AValue;
  end;
end;

procedure TArchiveDocumentItem.SetArchivingDate(const AValue: TDateTime);
begin
  if FArchivingDate <> AValue then
  begin
    FArchivingDate := AValue;
  end;
end;

procedure TArchiveDocumentItem.SetBarcode(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FBarcode <> s then
  begin
    FBarcode := s;
  end;
end;

procedure TArchiveDocumentItem.SetCompanyId(const AValue: Integer);
begin
  if FCompanyId <> AValue then
  begin
    FCompanyId := AValue;
  end;
end;

procedure TArchiveDocumentItem.SetCompanyName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCompanyName <> s then
  begin
    FCompanyName := s;
  end;
end;

procedure TArchiveDocumentItem.SetIssuanceDate(const AValue: TDateTime);
begin
  if FIssuanceDate <> AValue then
  begin
    FIssuanceDate := AValue;
  end;
end;

procedure TArchiveDocumentItem.SetIssued(const AValue: Boolean);
begin
  if FIssued <> AValue then
  begin
    FIssued := AValue;
  end;
end;

procedure TArchiveDocumentItem.SetIssuedToUser(const AValue: Integer);
begin
  if FIssuedToUser <> AValue then
  begin
    FIssuedToUser := AValue;
  end;
end;

function TArchiveDocumentItem.GetSequenceNumber: Integer;
begin
  Result := FSequenceNumber;
end;

procedure TArchiveDocumentItem.SetSequenceNumber(const AValue: Integer);
begin
  if FSequenceNumber <> AValue then
  begin
    FSequenceNumber := AValue;
  end;
end;

function TArchiveDocumentItem.GetShowableFields: IInterfaceList;
begin
  FShowableFields := TInterfaceList.Create;
  FillShowableFieldsList;
  Result := FShowableFields;
end;

procedure TArchiveDocumentItem.AddShowableField(const ACaption, AName, AValue: string);
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

constructor TArchiveDocumentItem.Create;
begin
  inherited;
  Saveable := True;
  ArchiveBoxId := -1;
  ArchivedByUser := -1;
  ArchivingDate := 0;
  Issued := False;
  IssuedToUser := -1;
  IssuanceDate := 0;
  CompanyId := -1;
  CompanyName := EmptyStr;
  Barcode := EmptyStr;
  SequenceNumber := -1;
end;

procedure TArchiveDocumentItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    ArchiveBoxId := ADataSet.FieldByName('ArchiveBoxId').AsInteger;
    ArchivedByUser := ADataSet.FieldByName('ArchivedByUser').AsInteger;
    ArchivingDate := ADataSet.FieldByName('ArchivingDate').AsDateTime;
    Issued := ADataSet.FieldByName('Issued').AsBoolean;
    IssuedToUser := ADataSet.FieldByName('IssuedToUser').AsInteger;
    IssuanceDate := ADataSet.FieldByName('IssuanceDate').AsDateTime;
    CompanyId := ADataSet.FieldByName('CompanyId').AsInteger;
    CompanyName := ADataSet.FieldByName('CompanyName').AsString;
    Barcode := ADataSet.FieldByName('Barcode').AsString;
    SequenceNumber := ADataSet.FieldByName('SequenceNumber').AsInteger;
  end;
end;

function TArchiveDocumentItem.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveDocument %d, %d', [ArchiveBoxId, Id]);
end;

function TArchiveDocumentItem.GetDeleteSQL: string;
begin
  Result := Format('BSOArchiving_del_ArchiveDocument %d', [Id]);
end;

end.
