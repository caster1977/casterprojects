unit uTDamagedBSOItem;

interface

uses
  DB,
  uTCustomBSOItem,
  uIDamagedBSOItem,
  uILoadableItem;

type
  TDamagedBSOItem = class {$IFNDEF VER150} sealed {$ENDIF}(TCustomBSOItem, IDamagedBSOItem)
  private
    FCauseOfDamageId: Integer;
    function GetCauseOfDamageId: Integer;
    procedure SetCauseOfDamageId(const AValue: Integer);
  public
    property CauseOfDamageId: Integer read GetCauseOfDamageId write SetCauseOfDamageId nodefault;

  private
    FCauseOfDamageName: string;
    function GetCauseOfDamageName: string;
    procedure SetCauseOfDamageName(const AValue: string);
  public
    property CauseOfDamageName: string read GetCauseOfDamageName write SetCauseOfDamageName nodefault;

  protected
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetValidateSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure FillShowableFieldsList; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Assign(const AValue: ILoadableItem); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

const
  SP_ARCHIVING_UPD_DAMAGED_BSO = 'Archiving_upd_DamagedBSO';
  SP_ARCHIVING_SEL_VALIDATE_DAMAGED_BSO = 'Archiving_sel_ValidateDamagedBSO';

implementation

uses
  uArchivingCommonConsts,
  uArchivingCommonResourceStrings,
  SysUtils;

function TDamagedBSOItem.GetCauseOfDamageId: Integer;
begin
  Result := FCauseOfDamageId;
end;

function TDamagedBSOItem.GetCauseOfDamageName: string;
begin
  Result := FCauseOfDamageName;
end;

procedure TDamagedBSOItem.SetCauseOfDamageId(const AValue: Integer);
begin
  if FCauseOfDamageId <> AValue then
  begin
    FCauseOfDamageId := AValue;
  end;
end;

procedure TDamagedBSOItem.SetCauseOfDamageName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCauseOfDamageName <> s then
  begin
    FCauseOfDamageName := s;
  end;
end;

procedure TDamagedBSOItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    CauseOfDamageId := ADataSet.FieldByName(CONST_CAUSE_OF_ARCHIVE_DOCUMENT_DAMAGE_ID).AsInteger;
    CauseOfDamageName := ADataSet.FieldByName(CONST_CAUSE_OF_ARCHIVE_DOCUMENT_DAMAGE_NAME).AsString;
  end;
end;

function TDamagedBSOItem.GetSaveSQL: string;
begin
  Result := Format(SP_ARCHIVING_UPD_DAMAGED_BSO + ' %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d, %d, %d',
    [Id, ArchiveBoxId, SequenceNumber, ArchivedByUser, FormatDateTime(DATE_TIME_FORMAT, ArchivingDate), Integer(Issued),
    IssuedToUser, FormatDateTime(DATE_TIME_FORMAT, IssuanceDate), Year, BSOId, CauseOfDamageId]);
end;

function TDamagedBSOItem.GetValidateSQL: string;
begin
  Result := Format(SP_ARCHIVING_SEL_VALIDATE_DAMAGED_BSO + ' %d', [BSOId]);
end;

procedure TDamagedBSOItem.Assign(const AValue: ILoadableItem);
var
  a: IDamagedBSOItem;
begin
  inherited;
  if Supports(AValue, IDamagedBSOItem, a) then
  begin
    CauseOfDamageId := a.CauseOfDamageId;
    CauseOfDamageName := a.CauseOfDamageName;
  end;
end;

constructor TDamagedBSOItem.Create;
begin
  inherited;
  CauseOfDamageId := -1;
  CauseOfDamageName := EmptyStr;
end;

procedure TDamagedBSOItem.FillShowableFieldsList;
begin
  AddShowableField(RsBarcode, CONST_BARCODE, Barcode);
  AddShowableField(RsYear, CONST_YEAR, IntToStr(Year));
  AddShowableField(RsSeries, CONST_SERIES, Series);
  AddShowableField(RsNumber, CONST_NUMBER, Number);
  AddShowableField(RsSequenceNumber, CONST_SEQUENCE_NUMBER, IntToStr(SequenceNumber));
  AddShowableField(RsCauseOfDamage, CONST_CAUSE_OF_DAMAGE_NAME, CauseOfDamageName);
end;

end.
