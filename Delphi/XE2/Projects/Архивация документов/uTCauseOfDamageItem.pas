unit uTCauseOfDamageItem;

interface

uses
  uTLoadableItem,
  uICauseOfDamageItem,
  DB;

type
  TCauseOfDamageItem = class(TLoadableItem, ICauseOfDamageItem)
  protected
    function GetSaveSQL: string; override; final;
  public
    function GetLoadSQL: string; override; final;

  private
    FName: string;
    function GetName: string;
  public
    property Name: string read GetName;

  private
    FBarcode: string;
    function GetBarcode: string;
  public
    property Barcode: string read GetBarcode;

  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
  end;

implementation

uses
  SysUtils;

function TCauseOfDamageItem.GetName: string;
begin
  Result := FName;
end;

function TCauseOfDamageItem.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TCauseOfDamageItem.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

constructor TCauseOfDamageItem.Create;
begin
  inherited;
  FName := EmptyStr;
  FBarcode := EmptyStr;
end;

function TCauseOfDamageItem.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_CauseOfDamage %d', [Id]);
end;

procedure TCauseOfDamageItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FBarcode := ADataSet.FieldByName('Barcode').AsString;
  end;
end;

end.
