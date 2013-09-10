unit uTDocumentArchivingLogic;

interface

uses
  uTCustomBusinessLogic,
  uIDocumentArchivingLogic,
  uIDocument,
  uIArchiveBox;

type
  TDocumentArchivingLogic = class abstract(TCustomBusinessLogic, IDocumentArchivingLogic)
  private
    FCurrentBox: IArchiveBox;
    function GetCurrentBox: IArchiveBox;
    procedure SetCurrentBox(const AValue: IArchiveBox);
  public
    property CurrentBox: IArchiveBox read GetCurrentBox write SetCurrentBox nodefault;
  public
    function GetBoxCapacity(const AType: Integer): Integer; overload;
    function GetBoxCapacity(const ABox: IArchiveBox): Integer; overload;
  end;

implementation

uses
  uCommonRoutines,
  uTDocument,
  uTArchiveBox,
  SysUtils;

function TDocumentArchivingLogic.GetBoxCapacity(const AType: Integer): Integer;
begin
  try
    SetSQLForQuery(Query,
      Format('SELECT abt.Capacity AS Capacity FROM ArchiveBoxTypes abt WHERE abt.Id_ArchiveBoxType = %d',
      [AType]), True);
    Result := Query.FieldByName('Capacity').AsInteger;
  finally
    CloseQuery;
  end;
end;

function TDocumentArchivingLogic.GetBoxCapacity(const ABox: IArchiveBox): Integer;
begin
  Result := -1;
  if Assigned(ABox) then
  begin
    try
      SetSQLForQuery(Query,
        Format('SELECT abt.Capacity AS Capacity FROM ArchiveBoxTypes abt WHERE abt.Id_ArchiveBoxType = %d',
        [ABox.TypeId]), True);
      Result := Query.FieldByName('Capacity').AsInteger;
    finally
      CloseQuery;
    end;
  end;
end;

function TDocumentArchivingLogic.GetCurrentBox: IArchiveBox;
begin
  Result := FCurrentBox;
end;

procedure TDocumentArchivingLogic.SetCurrentBox(const AValue: IArchiveBox);
begin
  if FCurrentBox <> AValue then
  begin
    FCurrentBox := AValue;
  end;
end;

end.
