unit uTCustomBSOItem;

interface

uses
  Classes,
  DB,
  Vcl.Controls,
  uIArchiveDocumentItem,
  uTArchiveDocumentItem,
  uICustomBSOItem;

type
  TCustomBSOItem = class abstract(TArchiveDocumentItem, ICustomBSOItem)
  private
    FBSOId: Integer;
    function GetBSOId: Integer;
    procedure SetBSOId(const AValue: Integer);
  public
    property BSOId: Integer read GetBSOId write SetBSOId nodefault;

  private
    FSeries: string;
    function GetSeries: string;
    procedure SetSeries(const AValue: string);
  public
    property Series: string read GetSeries write SetSeries nodefault;

  private
    FNumber: string;
    function GetNumber: string;
    procedure SetNumber(const AValue: string);
  public
    property Number: string read GetNumber write SetNumber nodefault;

  public
    constructor Create; override;
    procedure Load(const ADataSet: TDataSet); override;
    function FromString(const AValue: string): Boolean; override; final;
    function AlreadyArchived(const AConnection: TCustomConnection = nil): Integer; override; final;
  end;

implementation

uses
  SysUtils,
  StrUtils,
  uCommonRoutines;

function TCustomBSOItem.GetBSOId: Integer;
begin
  Result := FBSOId;
end;

function TCustomBSOItem.GetNumber: string;
begin
  Result := FNumber;
end;

function TCustomBSOItem.GetSeries: string;
begin
  Result := FSeries;
end;

procedure TCustomBSOItem.SetBSOId(const AValue: Integer);
begin
  if FBSOId <> AValue then
  begin
    FBSOId := AValue;
  end;
end;

procedure TCustomBSOItem.SetNumber(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FNumber <> s then
  begin
    FNumber := s;
  end;
end;

procedure TCustomBSOItem.SetSeries(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FSeries <> s then
  begin
    FSeries := s;
  end;
end;

constructor TCustomBSOItem.Create;
begin
  inherited;
  BSOId := -1;
  Series := EmptyStr;
  Number := EmptyStr;
end;

function TCustomBSOItem.FromString(const AValue: string): Boolean;
var
  s: string;
  ds: TDataSet;
  i: Integer;
begin
  Result := False;
  s := Trim(AValue);
  if Length(s) >= 14 then
  begin
    for i := 1 to Length(s) do
    begin
      if not CharInSet(s[i], ['0' .. '9']) then
      begin
        Exit;
      end;
    end;
    if Assigned(Connection) then
    begin
      ds := GetQuery(Connection);
      if Assigned(ds) then
      begin
        try
          SetSQLForQuery(ds, Format('BSOArchiving_sel_ArchiveDocumentDataByBarcode ''%s''', [s]), True);
          try
            if not ds.Eof then
            begin
              Load(ds);
              Result := True;
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
end;

procedure TCustomBSOItem.Load(const ADataSet: TDataSet);
begin
  inherited;
  if Assigned(ADataSet) then
  begin
    BSOId := ADataSet.FieldByName('BSOId').AsInteger;
    Series := ADataSet.FieldByName('Series').AsString;
    Number := ADataSet.FieldByName('Number').AsString;
  end;
end;

function TCustomBSOItem.AlreadyArchived(const AConnection: TCustomConnection): Integer;
var
  ds: TDataSet;
begin
  Result := -1;
  if Assigned(AConnection) then
  begin
    Connection := AConnection;
  end;
  if Assigned(Connection) then
  begin
    ds := GetQuery(Connection);
    if Assigned(ds) then
    begin
      try
        SetSQLForQuery(ds, Format('BSOArchiving_sel_BSOAlreadyArchived %d, %d', [Id, BSOId]), True);
        try
          if not ds.Eof then
          begin
            Result := ds.Fields[0].AsInteger;
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
