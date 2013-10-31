unit uTDamagedBSOItem;

interface

uses
  DB,
  Controls,
  uTCustomBSOItem,
  uIDamagedBSOItem,
  uILoadableItem;

type
  TDamagedBSOItem = class {$IFNDEF VER150} sealed {$ENDIF}(TCustomBSOItem, IDamagedBSOItem)
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
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetValidateSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure FillShowableFieldsList; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Assign(const AValue: ILoadableItem); override; {$IFNDEF VER150} final; {$ENDIF}
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
    CauseOfDamageId := ADataSet.FieldByName('CauseOfArchiveDocumentDamageId').AsInteger;
    CauseOfDamageName := ADataSet.FieldByName('CauseOfArchiveDocumentDamageName').AsString;
  end;
end;

function TDamagedBSOItem.GetSaveSQL: string;
begin
  Result := Format('Archiving_upd_DamagedBSO %d, %d, %d, %d, ''%s'', %d, %d, ''%s'', %d, %d, %d',
    [Id, ArchiveBoxId, SequenceNumber, ArchivedByUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', ArchivingDate),
    Integer(Issued), IssuedToUser, FormatDateTime('yyyy-mm-dd hh:nn:ss', IssuanceDate), Year, BSOId, CauseOfDamageId]);
end;

function TDamagedBSOItem.GetValidateSQL: string;
begin
  Result := Format('Archiving_sel_ValidateDamagedBSO %d', [BSOId]);
end;

procedure TDamagedBSOItem.Assign(const AValue: ILoadableItem);
var
  a: IDamagedBSOItem;
begin
  inherited;
  if Supports(AValue, IDamagedBSOItem, a) then
  begin
    CauseOfDamageId := a.CauseOfDamageId;
    CauseOfDamageName := a.CauseOfDamageName;
  end;
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
  AddShowableField('Год:', 'Year', IntToStr(Year));
  AddShowableField('Серия:', 'Series', Series);
  AddShowableField('Номер:', 'Number', Number);
  AddShowableField('Порядковый номер в коробе:', 'SequenceNumber', IntToStr(SequenceNumber));
  AddShowableField('Причина порчи:', 'CauseOfDamageName', CauseOfDamageName);
end;

end.
