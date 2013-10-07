unit uTCauseOfArchiveDocumentDamageItem;

interface

uses
  uTLoadableItem,
  uICauseOfArchiveDocumentDamageItem,
  DB;

type
  TCauseOfArchiveDocumentDamageItem = class(TLoadableItem, ICauseOfArchiveDocumentDamageItem)
  protected
    function GetSaveSQL: string; override; final;
  public
    function GetLoadSQL: string; override; final;

  private
    FName: string;
    function GetName: string;
  public
    property name: string read GetName;

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

function TCauseOfArchiveDocumentDamageItem.GetName: string;
begin
  Result := FName;
end;

function TCauseOfArchiveDocumentDamageItem.GetBarcode: string;
begin
  Result := FBarcode;
end;

function TCauseOfArchiveDocumentDamageItem.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

constructor TCauseOfArchiveDocumentDamageItem.Create;
begin
  inherited;
  FName := EmptyStr;
  FBarcode := EmptyStr;
end;

function TCauseOfArchiveDocumentDamageItem.GetLoadSQL: string;
begin
  Result := Format('Archiving_sel_CauseOfArchiveDocumentDamage %d', [Id]);
end;

procedure TCauseOfArchiveDocumentDamageItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FBarcode := ADataSet.FieldByName('Barcode').AsString;
  end;
end;

end.
