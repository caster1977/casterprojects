unit uTArchiveBoxType;

interface

uses
  DB,
  uIArchiveBoxType,
  uTLoadableItem;

type
  TArchiveBoxType = class(TLoadableItem, IArchiveBoxType)
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

function TArchiveBoxType.GetName: string;
begin
  Result := FName;
end;

function TArchiveBoxType.GetCode: string;
begin
  Result := FCode;
end;

function TArchiveBoxType.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

constructor TArchiveBoxType.Create;
begin
  inherited;
  FName := EmptyStr;
  FCode := EmptyStr;
  FCapacity := -1;
end;

function TArchiveBoxType.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveBoxType %d', [Id]);
end;

procedure TArchiveBoxType.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
    FCapacity := ADataSet.FieldByName('Capacity').AsInteger;
  end;
end;

function TArchiveBoxType.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

end.
