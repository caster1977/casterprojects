unit uTArchiveCompanyItem;

interface

uses
  uIArchiveCompanyItem,
  uTLoadableItem,
  DB;

type
  TArchiveCompanyItem = class sealed(TLoadableItem, IArchiveCompanyItem)
  protected
    function GetSaveSQL: string; override; final;
    function GetDeleteSQL: string; override; final;
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
  uArchivingCommonRoutines;

function TArchiveCompanyItem.GetName: string;
begin
  Result := FName;
end;

constructor TArchiveCompanyItem.Create;
begin
  inherited;
  FName := EmptyStr;
  FCode := EmptyStr;
end;

function TArchiveCompanyItem.GetCode: string;
begin
  Result := FCode;
end;

function TArchiveCompanyItem.GetLoadSQL: string;
begin
  Result := Format('BSOArchiving_sel_ArchiveCompany %d', [Id]);
end;

function TArchiveCompanyItem.GetDeleteSQL: string;
begin
  Result := EmptyStr;
end;

procedure TArchiveCompanyItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    FName := ADataSet.FieldByName('Name').AsString;
    FCode := ADataSet.FieldByName('Code').AsString;
  end;
end;

function TArchiveCompanyItem.GetSaveSQL: string;
begin
  Result := EmptyStr;
end;

end.
