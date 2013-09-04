unit uTShipmentBSOWithAct;

interface

uses
  Vcl.Controls,
  Data.DB,
  uTCustomBSO;

type
  TShipmentBSOWithAct = class sealed(TCustomBSO)
  private
    FActId: Integer;
    function GetActId: Integer;
    procedure SetActId(const AValue: Integer);
  public
    property ActId: Integer read GetActId write SetActId nodefault;

  protected
    procedure Initialize; override;
  public
    function GetLoadSQL: string; override;
    procedure Load(const ADataSet: TDataSet); override;
    procedure Show(const AParentControl: TCustomControl); override;
  end;

implementation

uses
  SysUtils,
  uCommonRoutines;

procedure TShipmentBSOWithAct.Initialize;
begin
  inherited;
  AddVisualizableField('Компания:', 'CompanyName');
  AddVisualizableField('Тип документа:', 'TypeName');
  AddVisualizableField('Серия:', 'Series');
  AddVisualizableField('Номер:', 'Number');
  AddVisualizableField('Штрих-код:', 'Barcode');
end;

function TShipmentBSOWithAct.GetLoadSQL: string;
begin
  Result := 'SELECT 1 AS Id, 2 AS ArchiveBoxId, 3 AS TypeId, 4 AS TypeName, ' +
    '5 AS Barcode, 6 AS CompanyId, 7 AS CompanyName, 8 AS Series, 9 AS Number, 10 AS ActId';
end;

procedure TShipmentBSOWithAct.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    ActId := ADataSet.FieldByName('ActId').AsInteger;
  end;
end;

procedure TShipmentBSOWithAct.Show(const AParentControl: TCustomControl);
begin
  inherited;
  SetLabelCaption(FParentControl, 'lblDocumentActId', IntToStr(ActId));
end;

function TShipmentBSOWithAct.GetActId: Integer;
begin
  Result := FActId;
end;

procedure TShipmentBSOWithAct.SetActId(const AValue: Integer);
begin
  if FActId <> AValue then
  begin
    FActId := AValue;
  end;
end;

end.
