unit uTLoadableItem;

interface

uses
  DB,
  uILoadableItem;

type
  TLoadableItem = class(TInterfacedObject, ILoadableItem)
  public
    class function GetLoadSQL(const AId: Integer = -1): string; virtual; abstract;
    constructor Create; overload; virtual;
    constructor Create(const AConnection: TCustomConnection; const AId: Integer); overload; virtual;
    procedure Load(const ADataSet: TDataSet); overload; virtual; abstract;
    procedure Load(const AConnection: TCustomConnection; const AId: Integer); overload;
      virtual; final;
  end;

implementation

uses
  uCommonRoutines,
  ADODB,
  SqlExpr,
  SysUtils;

constructor TLoadableItem.Create;
begin
  inherited;
end;

constructor TLoadableItem.Create(const AConnection: TCustomConnection; const AId: Integer);
begin
  Create;
  Load(AConnection, AId);
end;

procedure TLoadableItem.Load(const AConnection: TCustomConnection; const AId: Integer);
var
  ds: TDataSet;
begin
  ds := GetQuery(AConnection);
  if Assigned(ds) then
  begin
    try
      SetSQLForQuery(ds, GetLoadSQL(AId), True);
      try
        if not ds.Eof then
        begin
          Load(ds);
        end;
      finally
        ds.Close;
      end;
    finally
      FreeAndNil(ds);
    end;
  end;
end;

end.
