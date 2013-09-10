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
        if (Items[i] as IArchiveCompany).Id = AId then
        begin
          Result := Items[i] as IArchiveCompany;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveCompanies.Create;
begin
  inherited;
  ItemClass := TArchiveCompany;
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
        Result := Items[AIndex] as IArchiveCompany;
      end;
    end;
  end;
end;

end.
