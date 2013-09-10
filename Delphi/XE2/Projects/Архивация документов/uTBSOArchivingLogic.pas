unit uTBSOArchivingLogic;

interface

uses
  uTDocumentArchivingLogic,
  uIBSOArchivingLogic,
  uIDocument,
  uIArchiveCompanies,
  uIArchiveBoxTypes;

type
  TBSOArchivingLogic = class(TDocumentArchivingLogic, IBSOArchivingLogic)
  private
    FArchiveCompanies: IArchiveCompanies;
    function GetArchiveCompanies: IArchiveCompanies;
  public
    property ArchiveCompanies: IArchiveCompanies read GetArchiveCompanies nodefault;
  private
    FArchiveBoxTypes: IArchiveBoxTypes;
    function GetArchiveBoxTypes: IArchiveBoxTypes;
  public
    property ArchiveBoxTypes: IArchiveBoxTypes read GetArchiveBoxTypes;
  public
    function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;
    function GetOpenedBoxQuantity(const ADocument: IDocument): Integer; overload;
  end;

implementation

uses
  uCommonRoutines,
  SysUtils,
  uTCustomBSO,
  uTArchiveCompanies,
  uTArchiveBoxTypes;

function TBSOArchivingLogic.GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer;
begin
  try
    SetSQLForQuery(Query,
      Format('SELECT COUNT(1) AS Quantity FROM ArchiveBoxes ab WHERE ab.Id_ArchiveBoxType = %d AND ab.Id_Company = %d AND ab.Closed = 0',
      [AType, ACompanyId]), True);
    Result := Query.FieldByName('Quantity').AsInteger;
  finally
    CloseQuery;
  end;
end;

function TBSOArchivingLogic.GetArchiveBoxTypes: IArchiveBoxTypes;
begin
  if not Assigned(FArchiveBoxTypes) then
  begin
    FArchiveBoxTypes := TArchiveBoxTypes.Create;
    FArchiveBoxTypes.Load(Connection);
  end;
  Result := FArchiveBoxTypes;
end;

function TBSOArchivingLogic.GetArchiveCompanies: IArchiveCompanies;
begin
  if not Assigned(FArchiveCompanies) then
  begin
    FArchiveCompanies := TArchiveCompanies.Create;
    FArchiveCompanies.Load(Connection);
  end;
  Result := FArchiveCompanies;
end;

function TBSOArchivingLogic.GetOpenedBoxQuantity(const ADocument: IDocument): Integer;
var
  d: TCustomBSO;
begin
  Result := -1;
  if Assigned(ADocument) then
  begin
    if ADocument is TCustomBSO then
    begin
      d := ADocument as TCustomBSO;
      Result := GetOpenedBoxQuantity(d.TypeId, d.CompanyId);
    end;
  end;
end;

end.
