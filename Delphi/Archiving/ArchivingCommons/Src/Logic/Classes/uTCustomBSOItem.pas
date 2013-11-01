unit uTCustomBSOItem;

interface

uses
  DB,
  uTArchiveDocumentItem,
  uICustomBSOItem,
  uILoadableItem;

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
    procedure Assign(const AValue: ILoadableItem); override;
  end;

const
  SP_ARCHIVING_SEL_ARCHIVE_DOCUMENT_DATA_FOR_BSO_BY_BARCODE = 'Archiving_sel_ArchiveDocumentDataForBSOByBarcode';
  SP_ARCHIVING_SEL_BSO_ALREADY_ARCHIVED_IN_BOX = 'Archiving_sel_BSOAlreadyArchivedInBox';

implementation

uses
  SysUtils,
  uArchivingCommonConsts,
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

procedure TCustomBSOItem.Assign(const AValue: ILoadableItem);
var
  a: ICustomBSOItem;
begin
  inherited;
  if Supports(AValue, ICustomBSOItem, a) then
  begin
    BSOId := a.BSOId;
    Series := a.Series;
    Number := a.Number;
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
          SetSQLForQuery(ds, Format(SP_ARCHIVING_SEL_ARCHIVE_DOCUMENT_DATA_FOR_BSO_BY_BARCODE + ' ''%s''', [s]), True);
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
    BSOId := ADataSet.FieldByName(CONST_BSO_ID).AsInteger;
    Series := ADataSet.FieldByName(CONST_SERIES).AsString;
    Number := ADataSet.FieldByName(CONST_NUMBER).AsString;
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
        SetSQLForQuery(ds, Format(SP_ARCHIVING_SEL_BSO_ALREADY_ARCHIVED_IN_BOX + ' %d, %d', [Id, BSOId]), True);
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
