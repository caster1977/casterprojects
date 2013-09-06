unit uTArchiveCompanies;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveCompany,
  uIArchiveCompanies;

type
  TArchiveCompanies = class sealed(TLoadableList, IArchiveCompanies)
  private
    function GetItem(const AIndex: Integer): IArchiveCompany;
  public
    function GetItemById(const AId: Integer): IArchiveCompany;
    property Item[const AIndex: Integer]: IArchiveCompany read GetItem; default;
  protected
    function GetLoadSQL: string; override; final;
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uCommonRoutines,
  uTArchiveCompany,
  SysUtils;

function TArchiveCompanies.GetItemById(const AId: Integer): IArchiveCompany;
var
  i: Integer;
begin
  Result := nil;
  if AId > -1 then
  begin
    for i := 0 to Count - 1 do
    begin
      if Assigned(Items[i]) then
      begin
        if IArchiveCompany(Items[i]).Id = AId then
        begin
          Result := IArchiveCompany(Items[i]);
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveCompanies.Create;
begin
  inherited Create(TArchiveCompany);
end;

function TArchiveCompanies.GetItem(const AIndex: Integer): IArchiveCompany;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := IArchiveCompany(Items[AIndex]);
      end;
    end;
  end;
end;

function TArchiveCompanies.GetLoadSQL: string;
begin
  Result := 'SELECT ac.Id_Company AS Id, ac.Code AS Code FROM ArchiveCompanies ac ORDER BY Id';
end;

end.
