unit uTArchiveBoxTypeItem;

interface

uses
  DB,
  uIArchiveBoxTypeItem,
  uTLoadableItem;

type
  TArchiveBoxTypeItem = class(TLoadableItem, IArchiveBoxTypeItem)
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
    FCode: string;
    function GetCode: string;
  public
    property Code: string read GetCode;

  private
    FCapacity: Integer;
    function GetCapacity: Integer;
  public
    property Capacity: Integer read GetCapacity;

  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
  end;

implementation

uses
  SysUtils;

function TArchiveBoxTypeItem.GetName: string;
begin
  Result := FName;
end;

function TArchiveBoxTypeItem.GetCode: string;
begin
  Result := FCode;
end;

function TArchiveBoxTypeItem.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

constructor TArchiveBoxTypeItem.Create;
begin
  inherited;
  FName := EmptyStr;
  FCode := EmptyStr;
  FCapacity := -1;
end;

function TArchiveBoxTypeItem.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveBoxType %d', [Id]);
end;

procedure TArchiveBoxTypeItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
    FCapacity := ADataSet.FieldByName('Capacity').AsInteger;
  end;
end;

function TArchiveBoxTypeItem.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

end.
