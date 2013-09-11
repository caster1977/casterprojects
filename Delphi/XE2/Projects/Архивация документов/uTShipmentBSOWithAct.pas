unit uTShipmentBSOWithAct;

interface

uses
  Controls,
  DB,
  uTCustomBSO;

type
  TShipmentBSOWithAct = class sealed(TCustomBSO)
  protected
    class function GetDocumentType: Integer; override; final;

  private
    FActId: Integer;
    function GetActId: Integer;
    procedure SetActId(const AValue: Integer);
  public
    property ActId: Integer read GetActId write SetActId nodefault;

  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
    procedure Show(const AParentControl: TCustomControl); override; final;
  end;

implementation

uses
  SysUtils,
  uCommonRoutines;

function TShipmentBSOWithAct.GetActId: Integer;
begin
  Result := FActId;
end;

class function TShipmentBSOWithAct.GetDocumentType: Integer;
begin
  Result := 2;
end;

procedure TShipmentBSOWithAct.SetActId(const AValue: Integer);
begin
  if FActId <> AValue then
  begin
    FActId := AValue;
  end;
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

constructor TShipmentBSOWithAct.Create;
begin
  inherited;
  AddVisualizableField('Компания:', 'CompanyName');
  AddVisualizableField('Тип документа:', 'TypeName');
  AddVisualizableField('Серия:', 'Series');
  AddVisualizableField('Номер:', 'Number');
  AddVisualizableField('Штрих-код:', 'Barcode');
end;

end.
