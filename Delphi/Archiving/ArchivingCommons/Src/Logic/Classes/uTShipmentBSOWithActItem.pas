unit uTShipmentBSOWithActItem;

interface

uses
  DB,
  Controls,
  uTCustomBSOItem,
  uIShipmentBSOWithActItem;

type
  TShipmentBSOWithActItem = class {$IFNDEF VER150} sealed {$ENDIF}(TCustomBSOItem, IShipmentBSOWithActItem)
  protected
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure FillShowableFieldsList; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  SysUtils;

procedure TShipmentBSOWithActItem.Load(const ADataSet: TDataSet);
begin
  inherited;
end;

function TShipmentBSOWithActItem.GetSaveSQL: string;
begin
  Result := Format('Archiving_upd_ShipmentBSO %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d, %d',
    [Id, ArchiveBoxId, SequenceNumber, ArchivedByUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', ArchivingDate),
    Integer(Issued), IssuedToUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', IssuanceDate), Year, BSOId]);
end;

constructor TShipmentBSOWithActItem.Create;
begin
  inherited;
end;

procedure TShipmentBSOWithActItem.FillShowableFieldsList;
begin
  AddShowableField('Штрих-код:', 'Barcode', Barcode);
  AddShowableField('Год:', 'Year', IntToStr(Year));
  AddShowableField('Серия:', 'Series', Series);
  AddShowableField('Номер:', 'Number', Number);
  AddShowableField('Порядковый номер в коробе:', 'SequenceNumber', IntToStr(SequenceNumber));
end;

end.
