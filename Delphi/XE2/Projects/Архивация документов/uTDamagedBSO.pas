unit uTDamagedBSO;

interface

uses
  DB,
  Controls,
  uTCustomBSO;

type
  TDamagedBSO = class sealed(TCustomBSO)
  protected
    class function GetDocumentType: Integer; override; final;

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

  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
    procedure Show(const AParentControl: TCustomControl); override; final;
  end;

implementation

uses
  SysUtils,
  StdCtrls,
  Types,
  uCommonRoutines,
  uIDocumentField;

function TDamagedBSO.GetCauseOfDamageId: Integer;
begin
  Result := FCauseOfDamageId;
end;

function TDamagedBSO.GetCauseOfDamageName: string;
begin
  Result := FCauseOfDamageName;
end;

class function TDamagedBSO.GetDocumentType: Integer;
begin
  Result := 5;
end;

procedure TDamagedBSO.SetCauseOfDamageId(const AValue: Integer);
begin
  if FCauseOfDamageId <> AValue then
  begin
    FCauseOfDamageId := AValue;
  end;
end;

procedure TDamagedBSO.SetCauseOfDamageName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCauseOfDamageName <> s then
  begin
    FCauseOfDamageName := s;
  end;
end;

constructor TDamagedBSO.Create;
begin
  inherited;
  CauseOfDamageId := -1;
  CauseOfDamageName := EmptyStr;
  AddVisualizableField('Компания:', 'CompanyName');
  AddVisualizableField('Тип документа:', 'TypeName');
  AddVisualizableField('Серия:', 'Series');
  AddVisualizableField('Номер:', 'Number');
  AddVisualizableField('Штрих-код:', 'Barcode');
  AddVisualizableField('Причина порчи:', 'CauseOfDamageName');
end;

procedure TDamagedBSO.Show(const AParentControl: TCustomControl);
begin
  inherited;
  SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageId', IntToStr(CauseOfDamageId));
  SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageName', CauseOfDamageName);
end;

procedure TDamagedBSO.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    CauseOfDamageId := ADataSet.FieldByName('CauseOfDamageId').AsInteger;
    CauseOfDamageName := ADataSet.FieldByName('CauseOfDamageName').AsString;
  end;
end;

end.
