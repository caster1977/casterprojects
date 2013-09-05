unit uTBSOArchivingLogic;

interface

uses
  uTDocumentArchivingLogic,
  uIBSOArchivingLogic,
  uIDocument,
  uIArchiveCompanies;

type
  TBSOArchivingLogic = class(TDocumentArchivingLogic, IBSOArchivingLogic)
  private
    function GetArchiveCompanies: IArchiveCompanies;
  public
    FArchiveCompanies: IArchiveCompanies;
    property ArchiveCompanies: IArchiveCompanies read GetArchiveCompanies nodefault;
  public
    function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;
    function GetOpenedBoxQuantity(const ADocument: IDocument): Integer; overload;
  end;

implementation

uses
  uCommonRoutines,
  SysUtils,
  uTCustomBSO,
  uTArchiveCompanies;

function TBSOArchivingLogic.GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer;
begin
  try
    SetSQL(Query,
      Format('SELECT COUNT(1) AS Quantity FROM ArchiveBoxes ab WHERE ab.Id_ArchiveBoxType = %d AND ab.Id_Company = %d AND ab.Closed = 0',
      [AType, ACompanyId]), True);
    Result := Query.FieldByName('Quantity').AsInteger;
  finally
    CloseQuery;
  end;
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
