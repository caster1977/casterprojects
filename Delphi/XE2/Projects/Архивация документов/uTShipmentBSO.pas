unit uTShipmentBSO;

interface

uses
  DB,
  Controls,
  uTCustomBSO;

type
  TShipmentBSO = class sealed(TCustomBSO)
  public
    class function GetLoadSQL(const AId: Integer): string; override; final;
  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
    procedure Show(const AParentControl: TCustomControl); override; final;
  end;

implementation

uses
  SysUtils;

constructor TShipmentBSO.Create;
begin
  inherited;
  AddVisualizableField('��������:', 'CompanyName');
  AddVisualizableField('��� ���������:', 'TypeName');
  AddVisualizableField('�����:', 'Series');
  AddVisualizableField('�����:', 'Number');
  AddVisualizableField('�����-���:', 'Barcode');
end;

class function TShipmentBSO.GetLoadSQL(const AId: Integer): string;
begin
  Result := Format('BSOArchiving_sel_ %d', [AId]);
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
