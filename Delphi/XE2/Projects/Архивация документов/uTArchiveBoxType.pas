unit uTArchiveBoxType;

interface

uses
  DB,
  uIArchiveBoxType,
  uTLoadableItem;

type
  TArchiveBoxType = class(TLoadableItem, IArchiveBoxType)
  public
    class function GetLoadSQL(const AId: Integer): string; override; final;

  private
    FId: Integer;
    function GetId: Integer;
  public
    property Id: Integer read GetId;

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

constructor TArchiveBoxType.Create;
begin
  inherited;
  FId := -1;
  FName := EmptyStr;
  FCode := EmptyStr;
  FCapacity := -1;
end;

function TArchiveBoxType.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TArchiveBoxType.GetCode: string;
begin
  Result := FCode;
end;

function TArchiveBoxType.GetId: Integer;
begin
  Result := FId;
end;

class function TArchiveBoxType.GetLoadSQL(const AId: Integer): string;
begin
  Result := Format('BSOArchiving_sel_ArchiveBoxTypes %d', [AId]);
end;

function TArchiveBoxType.GetName: string;
begin
  Result := FName;
end;

procedure TArchiveBoxType.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FId := ADataSet.FieldByName('Id').AsInteger;
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
    FCapacity := ADataSet.FieldByName('Capacity').AsInteger;
  end;
end;

end.
