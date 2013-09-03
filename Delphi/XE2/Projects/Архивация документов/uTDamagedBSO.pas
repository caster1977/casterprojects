unit uTDamagedBSO;

interface

uses
  DB,
  Controls,
  uTCustomBSODocument;

type
  TDamagedBSO = class(TCustomBSODocument)
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
  public
    function GetSQLForLoad: string; override;
    procedure Load(const ASource: TDataSet); override;
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

function TDamagedBSO.GetSQLForLoad: string;
begin
  Result := '';
end;

procedure TDamagedBSO.Show(const AParentControl: TCustomControl);
begin
  inherited;
  SetLabelCaption(AParentControl, 'lblDocumentCauseOfDamageId', IntToStr(CauseOfDamageId));
  SetLabelCaption(AParentControl, 'lblDocumentCauseOfDamageName', CauseOfDamageName);
end;

procedure TDamagedBSO.Initialize;
begin
  inherited;
  CauseOfDamageId := -1;
  CauseOfDamageName := EmptyStr;
  AddField('Компания:', 'CompanyName');
  AddField('Тип документа:', 'TypeName');
  AddField('Серия:', 'Series');
  AddField('Номер:', 'Number');
  AddField('Штрих-код:', 'Barcode');
  AddField('Причина порчи:', 'CauseOfDamageName');
end;

procedure TDamagedBSO.Load(const ASource: TDataSet);
begin
  inherited;
  if Assigned(ASource) then
  begin
    CauseOfDamageId := ASource.FieldByName('CauseOfDamageId').AsInteger;
    CauseOfDamageName := ASource.FieldByName('CauseOfDamageName').AsString;
  end;
end;

end.
