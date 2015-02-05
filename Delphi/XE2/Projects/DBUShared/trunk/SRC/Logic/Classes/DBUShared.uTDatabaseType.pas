unit DBUShared.uTDatabaseType;

interface

uses
  DBUShared.uIDatabaseType,
  CastersPackage.uICustomized,
  System.Classes,
  CastersPackage.uIListItemAdapter,
  Vcl.ComCtrls;

type
  TDatabaseType = class(TInterfacedObject, IDatabaseType, ICustomized, IListItemAdapter)
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override; final;

  strict private
    FId: Integer;
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
  public
    property Id: Integer read GetId write SetId nodefault;

  strict private
    FName: string;
    function GetName: string;
    procedure SetName(const AValue: string);
  public
    property name: string read GetName write SetName nodefault;

  public
    function ToString: string; override;
    procedure AppendToListView(const AListView: TListView); virtual;
  end;

function GetIDatabaseType: IDatabaseType; overload;
function GetIDatabaseType(const AId: Integer; const AName: string): IDatabaseType; overload;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function GetIDatabaseType: IDatabaseType;
begin
  Result := TDatabaseType.Create;
end;

function GetIDatabaseType(const AId: Integer; const AName: string): IDatabaseType;
begin
  Result := GetIDatabaseType;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Id := AId;
  Result.Name := Trim(AName);
end;

procedure TDatabaseType.AppendToListView(const AListView: TListView);
var
  a: IDatabaseType;
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

  li.StateIndex := Id;
  li.Caption := IntToStr(Id);

  if Assigned(li.SubItems) then
  begin
    li.SubItems.Add(name);

    if Supports(Self, IDatabaseType, a) then
    begin
      li.Data := Pointer(a);
    end;
  end;
end;

constructor TDatabaseType.Create;
begin
  inherited;
  Initialize;
end;

destructor TDatabaseType.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TDatabaseType.Initialize;
begin
  Id := -1;
  name := EmptyStr;
end;

procedure TDatabaseType.Finalize;
begin
end;

function TDatabaseType.GetId: Integer;
begin
  Result := FId;
end;

function TDatabaseType.GetName: string;
begin
  Result := FName;
end;

procedure TDatabaseType.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

procedure TDatabaseType.SetName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FName <> s then
  begin
    FName := s;
  end;
end;

function TDatabaseType.ToString: string;
begin
  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) + Format('=> Id: %d, Name: %s', [Id, name]);
end;

end.
