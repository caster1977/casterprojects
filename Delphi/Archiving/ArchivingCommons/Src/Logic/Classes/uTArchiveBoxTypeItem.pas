unit uTArchiveBoxTypeItem;

interface

uses
  DB,
  uIArchiveBoxTypeItem,
  uTLoadableItem,
  uILoadableItem;

type
  TArchiveBoxTypeItem = class(TLoadableItem, IArchiveBoxTypeItem)
  protected
    function GetSaveSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetDeleteSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
  public
    function GetLoadSQL: string; override; {$IFNDEF VER150} final; {$ENDIF}
  private
    FName: string;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetName: string;
  public
    property name: string read GetName nodefault;

  private
    FCode: string;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetCode: string;
  public
    property Code: string read GetCode nodefault;

  private
    FCapacity: Integer;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetCapacity: Integer;
    procedure SetCapacity(const AValue: Integer);
  public
    property Capacity: Integer read GetCapacity write SetCapacity nodefault;

  public
    constructor Create; override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Load(const ADataSet: TDataSet); override; {$IFNDEF VER150} final; {$ENDIF}
    procedure Assign(const AValue: ILoadableItem); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

const
  SP_ARCHIVING_UPD_ARHIVE_BOX_TYPE = 'Archiving_upd_ArchiveBoxType';
  SP_ARCHIVING_SEL_ARHIVE_BOX_TYPE = 'Archiving_sel_ArchiveBoxType';

implementation

uses
  SysUtils;

const
  FIELD_NAME = 'Name';
  FIELD_CODE = 'Code';
  FIELD_CAPACITY = 'Capacity';

procedure TArchiveBoxTypeItem.Assign(const AValue: ILoadableItem);
var
  a: IArchiveBoxTypeItem;
begin
  inherited;
  if Supports(AValue, IArchiveBoxTypeItem, a) then
  begin
    FName := a.name;
    FCode := a.Code;
    FCapacity := a.Capacity;
  end;
end;

function TArchiveBoxTypeItem.GetName: string;
begin
  Result := FName;
end;

function TArchiveBoxTypeItem.GetCode: string;
begin
  Result := FCode;
end;

constructor TArchiveBoxTypeItem.Create;
begin
  inherited;
  Saveable := True;
  FName := EmptyStr;
  FCode := EmptyStr;
  FCapacity := -1;
end;

function TArchiveBoxTypeItem.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TArchiveBoxTypeItem.GetLoadSQL: string;
begin
  Result := Format(SP_ARCHIVING_SEL_ARHIVE_BOX_TYPE + ' %d', [Id]);
end;

procedure TArchiveBoxTypeItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName(FIELD_NAME).AsString;
    FCode := ADataSet.FieldByName(FIELD_CODE).AsString;
    FCapacity := ADataSet.FieldByName(FIELD_CAPACITY).AsInteger;
  end;
end;

procedure TArchiveBoxTypeItem.SetCapacity(const AValue: Integer);
begin
  if FCapacity <> AValue then
  begin
    FCapacity := AValue;
  end;
end;

function TArchiveBoxTypeItem.GetSaveSQL: string;
begin
  Result := Format(SP_ARCHIVING_UPD_ARHIVE_BOX_TYPE + ' %d, ''%s'', ''%s'', %d', [Id, name, Code, Capacity]);
end;

function TArchiveBoxTypeItem.GetDeleteSQL: string;
begin
  Result := EmptyStr;
end;

end.
