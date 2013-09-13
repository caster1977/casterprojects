unit uTLoadableItem;

interface

uses
  DB,
  uILoadableItem;

type
  TLoadableItem = class(TInterfacedObject, ILoadableItem)
  private
    FId: Integer;
    function GetId: Integer;
  public
    property Id: Integer read GetId nodefault;
  private
    FSaveable: Boolean;
    function GetSaveable: Boolean;
    procedure SetSaveable(const AValue: Boolean);
  protected
    property Saveable: Boolean read GetSaveable write SetSaveable nodefault;

  protected
    function GetSaveSQL: string; virtual; abstract;
  public
    function GetLoadSQL: string; virtual; abstract;

  public
    procedure Load(const AConnection: TCustomConnection); overload;
    procedure Load(const ADataSet: TDataSet); overload; virtual;
    function Save(const AConnection: TCustomConnection): Boolean;

    constructor Create; overload; virtual;
    constructor Create(const AConnection: TCustomConnection; const AId: Integer); overload; virtual;
  end;

implementation

uses
  uCommonRoutines,
  ADODB,
  SqlExpr,
  Dialogs,
  SysUtils;

function TLoadableItem.GetId: Integer;
begin
  Result := FId;
end;

function TLoadableItem.GetSaveable: Boolean;
begin
  Result := FSaveable;
end;

procedure TLoadableItem.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    FId := ADataSet.FieldByName('Id').AsInteger;
  end;
end;

procedure TLoadableItem.SetSaveable(const AValue: Boolean);
begin
  if FSaveable <> AValue then
  begin
    FSaveable := AValue;
  end;
end;

constructor TLoadableItem.Create;
begin
  inherited;
  FId := -1;
  Saveable := False;
end;

constructor TLoadableItem.Create(const AConnection: TCustomConnection; const AId: Integer);
begin
  Create;
  FId := AId;
  if AId <> -1 then
  begin
    Load(AConnection);
  end;
end;

procedure TLoadableItem.Load(const AConnection: TCustomConnection);
var
  ds: TDataSet;
begin
  ds := GetQuery(AConnection);
  if Assigned(ds) then
  begin
    try
      SetSQLForQuery(ds, GetLoadSQL, True);
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

function TLoadableItem.Save(const AConnection: TCustomConnection): Boolean;
var
  ds: TDataSet;
  i: Integer;
begin
  Result := False;
  if Saveable then
  begin
    ds := GetQuery(AConnection);
    if Assigned(ds) then
    begin
      try
        SetSQLForQuery(ds, GetSaveSQL, True);
        try
          if not ds.Eof then
          begin
            i := ds.Fields[0].AsInteger;
            Result := i > -1;
            if Result then
            begin
              FId := i; // получение идентификатора записи в случае вставки/апдейта
            end;
          end;
        finally
          ds.Close;
        end;
      finally
        FreeAndNil(ds);
      end;
    end
  end
  else
  begin
    ShowMessage(Format('%s item cannot be saved cause it''s not saveable.', [ClassName]));
  end;
end;

end.
