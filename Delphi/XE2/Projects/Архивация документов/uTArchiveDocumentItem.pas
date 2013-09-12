unit uTArchiveDocumentItem;

interface

uses
  DB,
  Controls,
  Classes,
  uTLoadableItem,
  uIArchiveDocumentItem;

type
  TArchiveDocumentItem = class abstract(TLoadableItem, IArchiveDocumentItem)
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
    FShowableFields: IInterfaceList;
    function GetShowableFields: IInterfaceList;
  public
    property ShowableFields: IInterfaceList read GetShowableFields nodefault;

  protected
    procedure AddShowableField(const ACaption, AName, AValue: string);
    procedure FillShowableFieldsList; virtual; abstract;

  public
    constructor Create; override;
    function GetLoadSQL: string; override; final;
    procedure Load(const ADataSet: TDataSet); override;
  end;

implementation

uses
  SysUtils,
  StdCtrls,
  Types,
  uCommonRoutines,
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
  end;
end;

function TArchiveDocumentItem.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveDocument %d, %d', [Id, ArchiveBoxId]);
end;

end.
