unit uTShipmentBSO;

interface

uses
  DB,
  Controls,
  uTCustomBSO;

type
  TShipmentBSO = class sealed(TCustomBSO)
  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
    procedure Show(const AParentControl: TCustomControl); override; final;
  end;

implementation

constructor TShipmentBSO.Create;
begin
  inherited;
  AddVisualizableField('Компания:', 'CompanyName');
  AddVisualizableField('Тип документа:', 'TypeName');
  AddVisualizableField('Серия:', 'Series');
  AddVisualizableField('Номер:', 'Number');
  AddVisualizableField('Штрих-код:', 'Barcode');
end;

procedure TShipmentBSO.Load(const ADataSet: TDataSet);
begin
  inherited;
end;

procedure TShipmentBSO.Show(const AParentControl: TCustomControl);
begin
  inherited;
end;

end.
