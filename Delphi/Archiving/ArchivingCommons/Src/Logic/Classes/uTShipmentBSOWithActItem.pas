unit uTShipmentBSOWithActItem;

interface

uses
  uTCustomBSOItem,
  uIShipmentBSOWithActItem,
  DB;

type
  TShipmentBSOWithActItem = class {$IFNDEF VER150} sealed {$ENDIF}(TCustomBSOItem, IShipmentBSOWithActItem)
  protected
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetValidateSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure FillShowableFieldsList; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

const
  SP_ARCHIVING_UPD_SHIPMENT_BSO_WITH_ACT = 'Archiving_upd_ShipmentBSOWithAct';
  SP_ARCHIVING_SEL_VALIDATE_SHIPMENT_BSO_WITH_ACT = 'Archiving_sel_ValidateShipmentBSOWithAct';

implementation

uses
  uArchivingCommonConsts,
  uArchivingCommonResourceStrings,
  SysUtils;

procedure TShipmentBSOWithActItem.Load(const ADataSet: TDataSet);
begin
  inherited;
end;

function TShipmentBSOWithActItem.GetSaveSQL: string;
begin
  Result := Format(SP_ARCHIVING_UPD_SHIPMENT_BSO_WITH_ACT + ' %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d, %d',
    [Id, ArchiveBoxId, SequenceNumber, ArchivedByUser, FormatDateTime(DATE_TIME_FORMAT, ArchivingDate),
    Integer(Issued), IssuedToUser, FormatDateTime(DATE_TIME_FORMAT, IssuanceDate), Year, BSOId]);
end;

function TShipmentBSOWithActItem.GetValidateSQL: string;
begin
  Result := Format(SP_ARCHIVING_SEL_VALIDATE_SHIPMENT_BSO_WITH_ACT + ' %d', [BSOId]);
end;

constructor TShipmentBSOWithActItem.Create;
begin
  inherited;
end;

procedure TShipmentBSOWithActItem.FillShowableFieldsList;
begin
  AddShowableField(RsBarcode, CONST_BARCODE, Barcode);
  AddShowableField(RsYear, CONST_YEAR, IntToStr(Year));
  AddShowableField(RsSeries, CONST_SERIES, Series);
  AddShowableField(RsNumber, CONST_NUMBER, Number);
  AddShowableField(RsSequenceNumber, CONST_SEQUENCE_NUMBER, IntToStr(SequenceNumber));
end;

end.
