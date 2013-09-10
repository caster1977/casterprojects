unit uTArchiveCompany;

interface

uses
  uIArchiveCompany,
  uTLoadableItem,
  DB;

type
  TArchiveCompany = class sealed(TLoadableItem, IArchiveCompany)
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
  FName := EmptyStr;
  FCode := EmptyStr;
end;

function TArchiveCompany.GetId: Integer;
begin
  Result := FId;
end;

class function TArchiveCompany.GetLoadSQL(const AId: Integer): string;
begin
  Result := Format('BSOArchiving_sel_ArchiveCompanies %d', [AId]);
end;

function TArchiveCompany.GetName: string;
begin
  Result := FName;
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
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
  end;
end;

end.
