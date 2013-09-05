unit uTArchiveCompanies;

interface

uses
  Classes,
  DB,
  uIArchiveCompany,
  uIArchiveCompanies;

type
  TArchiveCompanies = class(TInterfacedObject, IArchiveCompanies)
  private
    FItems: IInterfaceList;
    function GetItem(const AIndex: Integer): IArchiveCompany;
  public
    function GetArchiveCompanyById(const AId: Integer): IArchiveCompany;
  public
    procedure Load(const AConnection: TCustomConnection); overload;
  public
    property Items[const AIndex: Integer]: IArchiveCompany read GetItem; default;
  end;

implementation

uses
  ADODB,
  SqlExpr,
  uCommonRoutines,
  uTArchiveCompany,
  SysUtils;

function TArchiveCompanies.GetArchiveCompanyById(const AId: Integer): IArchiveCompany;
var
  i: Integer;
begin
  Result := nil;
  if AId > -1 then
  begin
    if Assigned(FItems) then
    begin
      for i := 0 to FItems.Count - 1 do
      begin
        if Assigned(FItems[i]) then
        begin
          if IArchiveCompany(FItems[i]).Id = AId then
          begin
            Result := IArchiveCompany(FItems[i]);
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TArchiveCompanies.GetItem(const AIndex: Integer): IArchiveCompany;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(FItems) then
    begin
      if FItems.Count > AIndex then
      begin
        Result := IArchiveCompany(FItems[AIndex]);
      end;
    end;
  end;
end;

procedure TArchiveCompanies.Load(const AConnection: TCustomConnection);
var
  ds: TDataSet;
  ac: IArchiveCompany;
begin
  if Assigned(AConnection) then
  begin
    if AConnection.Connected then
    begin
      if AConnection is TADOConnection then
      begin
        ds := TADOQuery.Create(nil);
        (ds as TADOQuery).Connection := AConnection as TADOConnection;
        (ds as TADOQuery).CommandTimeout := 60000;
        (ds as TADOQuery).LockType := ltReadOnly;
        (ds as TADOQuery).CursorType := ctOpenForwardOnly;
      end
      else
      begin
        ds := TSQLQuery.Create(nil);
        (ds as TSQLQuery).SQLConnection := AConnection as TSQLConnection;
      end;
      try
        SetSQL(ds, 'SELECT ac.Id_Company AS Id, ac.Code AS Code FROM ArchiveCompanies ac ORDER BY Id', True);
        try
          if not Assigned(FItems) then
          begin
            FItems := TInterfaceList.Create;
          end
          else
          begin
            FItems.Clear;
          end;
          while not ds.Eof do
          begin
            ac := TArchiveCompany.Create;
            ac.Load(ds);
            FItems.Add(ac);
            ds.Next;
          end;
        finally
          ds.Close;
        end;
      finally
        FreeAndNil(ds);
      end;
    end;
  end;
end;

end.
