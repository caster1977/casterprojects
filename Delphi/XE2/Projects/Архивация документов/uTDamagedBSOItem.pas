unit uTDamagedBSOItem;

interface

uses
  DB,
  Controls,
  uTCustomBSOItem,
  uIDamagedBSOItem;

type
  TDamagedBSOItem = class sealed(TCustomBSOItem, IDamagedBSOItem)
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

function TDamagedBSOItem.GetCauseOfDamageId: Integer;
begin
  Result := FCauseOfDamageId;
end;

function TDamagedBSOItem.GetCauseOfDamageName: string;
begin
  Result := FCauseOfDamageName;
end;

procedure TDamagedBSOItem.SetCauseOfDamageId(const AValue: Integer);
begin
  if FCauseOfDamageId <> AValue then
  begin
    FCauseOfDamageId := AValue;
  end;
end;

procedure TDamagedBSOItem.SetCauseOfDamageName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCauseOfDamageName <> s then
  begin
    FCauseOfDamageName := s;
  end;
end;

procedure TDamagedBSOItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    CauseOfDamageId := ADataSet.FieldByName('CauseOfDamageId').AsInteger;
    CauseOfDamageName := ADataSet.FieldByName('CauseOfDamageName').AsString;
  end;
end;

function TDamagedBSOItem.GetSaveSQL: string;
begin
  Result := Format('BSOArchiving_upd_DamagedBSO %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d, %d',
    [Id, ArchiveBoxId, SequenceNumber, ArchivedByUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', ArchivingDate), Integer(Issued),
    IssuedToUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', IssuanceDate), BSOId, CauseOfDamageId]);
end;

constructor TDamagedBSOItem.Create;
begin
  inherited;
  CauseOfDamageId := -1;
  CauseOfDamageName := EmptyStr;
end;

procedure TDamagedBSOItem.FillShowableFieldsList;
begin
  AddShowableField('Штрих-код:', 'Barcode', Barcode);
  AddShowableField('Компания:', 'CompanyName', CompanyName);
  AddShowableField('Серия:', 'Series', Series);
  AddShowableField('Номер:', 'Number', Number);
  AddShowableField('Причина порчи:', 'CauseOfDamageName', CauseOfDamageName);
end;

end.
