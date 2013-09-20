unit uTShipmentBSOWithActItem;

interface

uses
  DB,
  Controls,
  uTCustomBSOItem,
  uIShipmentBSOWithActItem;

type
  TShipmentBSOWithActItem = class sealed(TCustomBSOItem, IShipmentBSOWithActItem)
  protected
    function GetSaveSQL: string; override; final;
    procedure FillShowableFieldsList; override; final;
  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
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
  Result := Format('BSOArchiving_upd_ShipmentBSOWithAct %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d',
    [Id, ArchiveBoxId, SequenceNumber, ArchivedByUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', ArchivingDate), Integer(Issued),
    IssuedToUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', IssuanceDate), BSOId]);
end;

constructor TShipmentBSOWithActItem.Create;
begin
  inherited;
end;

procedure TShipmentBSOWithActItem.FillShowableFieldsList;
begin
  AddShowableField('Штрих-код:', 'Barcode', Barcode);
  AddShowableField('Компания:', 'CompanyName', CompanyName);
  AddShowableField('Серия:', 'Series', Series);
  AddShowableField('Номер:', 'Number', Number);
end;

end.
