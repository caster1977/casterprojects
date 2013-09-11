unit uTArchiveCompany;

interface

uses
  uIArchiveCompany,
  uTLoadableItem,
  DB;

type
  TArchiveCompany = class sealed(TLoadableItem, IArchiveCompany)
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
  SysUtils,
  uCommonRoutines;

function TArchiveCompany.GetName: string;
begin
  Result := FName;
end;

function TArchiveCompany.GetCode: string;
begin
  Result := FCode;
end;

constructor TArchiveCompany.Create;
begin
  inherited;
  FName := EmptyStr;
  FCode := EmptyStr;
end;

function TArchiveCompany.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveCompany %d', [Id]);
end;

procedure TArchiveCompany.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
  end;
end;

function TArchiveCompany.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

end.
