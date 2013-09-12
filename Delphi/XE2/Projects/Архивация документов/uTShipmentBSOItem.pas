unit uTShipmentBSOItem;

interface

uses
  DB,
  Controls,
  uTCustomBSOItem,
  uIShipmentBSOItem;

type
  TShipmentBSOItem = class sealed(TCustomBSOItem, IShipmentBSOItem)
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

constructor TShipmentBSOItem.Create;
begin
  inherited;
end;

procedure TShipmentBSOItem.Load(const ADataSet: TDataSet);
begin
  inherited;
end;

function TShipmentBSOItem.GetSaveSQL: string;
begin
  Result := Format('BSOArchiving_upd_ShipmentBSO %d, %d, %d, %s, %d, %d, %s, %d',
    [Id, ArchiveBoxId, ArchivedByUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', ArchivingDate), Issued,
    IssuedToUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', IssuanceDate), BSOId]);
end;

procedure TShipmentBSOItem.FillShowableFieldsList;
begin
  AddShowableField('Штрих-код:', 'Barcode', Barcode);
  AddShowableField('Компания:', 'CompanyName', CompanyName);
  AddShowableField('Серия:', 'Series', Series);
  AddShowableField('Номер:', 'Number', Number);
end;

end.
