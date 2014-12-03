unit DBUShared.uTDBUServerLogRecord;

interface

uses
  DBUShared.uIDBUServerLogRecord,
  CastersPackage.uICustomized,
  CastersPackage.uIListItemAdapter,
  System.Classes,
  Vcl.ComCtrls;

type
  TDBUServerLogRecord = class(TInterfacedObject, IDBUServerLogRecord, ICustomized, IListItemAdapter)
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override; final;

  strict private
    FDateTime: TDateTime;
    function GetDateTime: TDateTime;
    procedure SetDateTime(const AValue: TDateTime);
  public
    property DateTime: TDateTime read GetDateTime write SetDateTime nodefault;

  strict private
    FDatabaseType: string;
    function GetDatabaseType: string;
    procedure SetDatabaseType(const AValue: string);
  public
    property DatabaseType: string read GetDatabaseType write SetDatabaseType nodefault;

  strict private
    FCreator: string;
    function GetCreator: string;
    procedure SetCreator(const AValue: string);
  public
    property Creator: string read GetCreator write SetCreator nodefault;

  strict private
    FFirstNumber: Integer;
    function GetFirstNumber: Integer;
    procedure SetFirstNumber(const AValue: Integer);
  public
    property FirstNumber: Integer read GetFirstNumber write SetFirstNumber nodefault;

  strict private
    FQuantity: Integer;
    function GetQuantity: Integer;
    procedure SetQuantity(const AValue: Integer);
  public
    property Quantity: Integer read GetQuantity write SetQuantity nodefault;

  public
    function ToString: string; override;
    procedure AppendToListView(const AListView: TListView); virtual;
  end;

function GetIDBUServerLogRecord: IDBUServerLogRecord; overload;
function GetIDBUServerLogRecord(const ADatabaseType: string; const AFirstNumber, AQuantity: Integer;
  const ACreator: string; const ADateTime: TDateTime = 0): IDBUServerLogRecord; overload;

implementation

uses
  CastersPackage.uConsts,
  System.SysUtils,
  System.StrUtils;

function GetIDBUServerLogRecord: IDBUServerLogRecord;
begin
  Result := TDBUServerLogRecord.Create;
end;

function GetIDBUServerLogRecord(const ADatabaseType: string; const AFirstNumber, AQuantity: Integer;
  const ACreator: string; const ADateTime: TDateTime): IDBUServerLogRecord; overload;
begin
  Result := GetIDBUServerLogRecord;
  if not Assigned(Result) then
  begin
    Exit;
  end;

  if ADateTime = 0 then
  begin
    Result.DateTime := Now;
  end
  else
  begin
    Result.DateTime := ADateTime;
  end;
  Result.DatabaseType := ADatabaseType;
  Result.Creator := ACreator;
  Result.FirstNumber := AFirstNumber;
  Result.Quantity := AQuantity;
end;

constructor TDBUServerLogRecord.Create;
begin
  inherited;
  Initialize;
end;

destructor TDBUServerLogRecord.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TDBUServerLogRecord.Initialize;
begin
  DateTime := 0;
  DatabaseType := EmptyStr;
  Creator := EmptyStr;
  FirstNumber := 0;
  Quantity := 0;
end;

procedure TDBUServerLogRecord.Finalize;
begin
end;

function TDBUServerLogRecord.GetDateTime: TDateTime;
begin
  Result := FDateTime;
end;

function TDBUServerLogRecord.GetCreator: string;
begin
  Result := FCreator;
end;

function TDBUServerLogRecord.GetFirstNumber: Integer;
begin
  Result := FFirstNumber;
end;

function TDBUServerLogRecord.GetQuantity: Integer;
begin
  Result := FQuantity;
end;

function TDBUServerLogRecord.GetDatabaseType: string;
begin
  Result := FDatabaseType;
end;

procedure TDBUServerLogRecord.SetDateTime(const AValue: TDateTime);
begin
  if FDateTime <> AValue then
  begin
    FDateTime := AValue;
  end;
end;

procedure TDBUServerLogRecord.SetCreator(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCreator <> s then
  begin
    FCreator := s;
  end;
end;

procedure TDBUServerLogRecord.SetFirstNumber(const AValue: Integer);
begin
  if FFirstNumber <> AValue then
  begin
    FFirstNumber := AValue;
  end;
end;

procedure TDBUServerLogRecord.SetQuantity(const AValue: Integer);
begin
  if FQuantity <> AValue then
  begin
    FQuantity := AValue;
  end;
end;

procedure TDBUServerLogRecord.SetDatabaseType(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FDatabaseType <> s then
  begin
    FDatabaseType := s;
  end;
end;

procedure TDBUServerLogRecord.AppendToListView(const AListView: TListView);
var
  a: IDBUServerLogRecord;
  li: TListItem;
begin
  if not Assigned(AListView) then
  begin
    Exit;
  end;

  if not Assigned(AListView.Items) then
  begin
    Exit;
  end;

  li := AListView.Items.Add;

  if not Assigned(li) then
  begin
    Exit;
  end;

  li.Caption := FormatDateTime(DATE_TIME_FORMAT_RU, DateTime);

  if Assigned(li.SubItems) then
  begin
    li.SubItems.Add(DatabaseType);
    li.SubItems.Add(Format('%d', [FirstNumber]));
    li.SubItems.Add(Creator);
    li.SubItems.Add(Format('%d', [Quantity]));

    if Supports(Self, IDBUServerLogRecord, a) then
    begin
      li.Data := Pointer(a);
    end;
  end;
end;

function TDBUServerLogRecord.ToString: string;
begin
  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) +
    Format('=> DateTime: %s, DatabaseType: %s, Creator: %s, FirstNumber: %d, Quantity: %d',
    [FormatDateTime('yyyy.mm.dd HH.mm.ss', DateTime), DatabaseType, Creator, FirstNumber,
    Quantity]);
end;

end.
