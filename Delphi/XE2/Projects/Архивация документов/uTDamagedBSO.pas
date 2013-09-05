unit uTDamagedBSO;

interface

uses
  DB,
  Controls,
  uTCustomBSO;

type
  TDamagedBSO = class sealed(TCustomBSO)
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
    property CauseOfDamageName: string read GetCauseOfDamageName
      write SetCauseOfDamageName nodefault;
  protected
    procedure Initialize; override;
    function GetLoadSQL: string; override;
  public
    procedure Load(const ADataSet: TDataSet); override;
    procedure Show(const AParentControl: TCustomControl); override;
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

function TDamagedBSO.GetLoadSQL: string;
begin
  Result := 'SELECT 1 AS Id, 3 AS ArchiveBoxId, 2 AS TypeId, 4 AS TypeName, ' +
    '5 AS Barcode, 3 AS CompanyId, 7 AS CompanyName, 8 AS Series, 9 AS Number, ' +
    '10 AS CauseOfDamageId, 11 AS CauseOfDamageName';
end;

procedure TDamagedBSO.Show(const AParentControl: TCustomControl);
begin
  inherited;
  SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageId', IntToStr(CauseOfDamageId));
  SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageName', CauseOfDamageName);
end;

procedure TDamagedBSO.Initialize;
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
