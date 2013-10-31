unit uTCauseOfArchiveDocumentDamageItem;

interface

uses
  uTLoadableItem,
  uICauseOfArchiveDocumentDamageItem,
  DB,
  uILoadableItem;

type
  TCauseOfArchiveDocumentDamageItem = class(TLoadableItem, ICauseOfArchiveDocumentDamageItem)
  protected
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    function GetLoadSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
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
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Assign(const AValue: ILoadableItem); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

const
  SP_ARCHIVING_SEL_CAUSE_OF_ARCHIVE_DOCUMENT_DAMAGE = 'Archiving_sel_CauseOfArchiveDocumentDamage';

implementation

uses
  SysUtils,
  uArchivingCommonConsts;

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

procedure TCauseOfArchiveDocumentDamageItem.Assign(const AValue: ILoadableItem);
var
  a: ICauseOfArchiveDocumentDamageItem;
begin
  inherited;
  if Supports(AValue, ICauseOfArchiveDocumentDamageItem, a) then
  begin
    FName := a.name;
    FBarcode := a.Barcode;
  end;
end;

constructor TCauseOfArchiveDocumentDamageItem.Create;
begin
  inherited;
  FName := EmptyStr;
  FBarcode := EmptyStr;
end;

function TCauseOfArchiveDocumentDamageItem.GetLoadSQL: string;
begin
  Result := Format(SP_ARCHIVING_SEL_CAUSE_OF_ARCHIVE_DOCUMENT_DAMAGE + ' %d', [Id]);
end;

procedure TCauseOfArchiveDocumentDamageItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName(CONST_NAME).AsString;
    FBarcode := ADataSet.FieldByName(CONST_BARCODE).AsString;
  end;
end;

end.
