unit uTShipmentBSO;

interface

uses
  uTCustomBSO;

type
  TShipmentBSO = class sealed(TCustomBSO)
  protected
    procedure Initialize; override;
  public
    function GetLoadSQL: string; override;
  end;

implementation

function TShipmentBSO.GetLoadSQL: string;
begin
  Result := 'SELECT 1 AS Id, 2 AS ArchiveBoxId, 3 AS TypeId, 4 AS TypeName, ' +
    '5 AS Barcode, 7 AS CompanyId, 6 AS CompanyName, 8 AS Series, 9 AS Number';
end;

procedure TShipmentBSO.Initialize;
begin
  inherited;
  AddVisualizableField('Компания:', 'CompanyName');
  AddVisualizableField('Тип документа:', 'TypeName');
  AddVisualizableField('Серия:', 'Series');
  AddVisualizableField('Номер:', 'Number');
  AddVisualizableField('Штрих-код:', 'Barcode');
end;

end.
