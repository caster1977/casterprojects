unit uTCustomBSOItem;

interface

uses
  Classes,
  DB,
  Controls,
  uIArchiveDocumentItem,
  uTArchiveDocumentItem,
  uICustomBSOItem;

type

  TCustomBSOItem = class {$IFNDEF VER150} abstract {$ENDIF}(TArchiveDocumentItem, ICustomBSOItem)
  private
    FBSOId: Integer;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetBSOId: Integer;
    procedure SetBSOId(const AValue: Integer);
  public
    property BSOId: Integer read GetBSOId write SetBSOId nodefault;

  private
    FSeries: string;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetSeries: string;
    procedure SetSeries(const AValue: string);
  public
    property Series: string read GetSeries write SetSeries nodefault;

  private
    FNumber: string;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetNumber: string;
    procedure SetNumber(const AValue: string);
  public
    property Number: string read GetNumber write SetNumber nodefault;

  public
    constructor Create; override;
    procedure Load(const ADataSet: TDataSet); override;
    function FromString(const AValue: string): Boolean; override; {$IFNDEF VER150} final; {$ENDIF}
    function AlreadyArchived(const AConnection: TCustomConnection = nil): Integer; override; {$IFNDEF VER150} final;
{$ENDIF}
  end;

implementation

uses
  SysUtils,
  StrUtils,
  uArchivingCommonRoutines;

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
{$IFDEF VER150}
      case s[i] of
        '0' .. '9':
          begin
          end;
      else
        begin
          Exit;
        end;
      end;
{$ELSE}
      if not CharInSet(s[i], ['0' .. '9']) then
      begin
        Exit;
      end;
{$ENDIF}
    end;
    if Assigned(Connection) then
    begin
      ds := GetQuery(Connection);
      if Assigned(ds) then
      begin
        try
          SetSQLForQuery(ds, Format('Archiving_sel_ArchiveDocumentDataForBSOByBarcode ''%s''', [s]), True);
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
        SetSQLForQuery(ds, Format('Archiving_sel_BSOAlreadyArchivedInBox %d, %d', [Id, BSOId]), True);
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
