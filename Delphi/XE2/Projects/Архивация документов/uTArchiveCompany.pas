unit uTArchiveCompany;

interface

uses
  uIArchiveCompany,
  uTLoadableItem,
  DB;

type
  TArchiveCompany = class sealed(TLoadableItem, IArchiveCompany)
  private
    FId: Integer;
    function GetId: Integer;
  public
    property Id: Integer read GetId;

  private
    FCode: string;
    function GetCode: string;
  public
    property Code: string read GetCode;

  public
    constructor Create; override; final;
    procedure Load(const ADataSet: TDataSet); override; final;
  end;

implementation

uses
  SysUtils;

constructor TArchiveCompany.Create;
begin
  inherited;
  FId := -1;
  FCode := EmptyStr;
end;

function TArchiveCompany.GetId: Integer;
begin
  Result := FId;
end;

function TArchiveCompany.GetCode: string;
begin
  Result := FCode;
end;

procedure TArchiveCompany.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    FId := ADataSet.FieldByName('Id').AsInteger;
    FCode := ADataSet.FieldByName('Code').AsString;
  end;
end;

end.
