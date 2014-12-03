unit DBUShared.uTDBUState;

interface

uses
  DBUShared.uIDBUState,
  CastersPackage.uICustomized,
  System.Classes,
  Vcl.Graphics,
  CastersPackage.uIListItemAdapter,
  Vcl.ComCtrls;

type
  TDBUState = class(TInterfacedObject, IDBUState, ICustomized, IListItemAdapter)
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
    property Name: string read GetName write SetName nodefault;

  strict private
    FFlags: Word;
    function GetFlags: Word;
    procedure SetFlags(const AValue: Word);
  public
    property Flags: Word read GetFlags write SetFlags nodefault;

  strict private
    FIcon: TIcon;
    function GetIcon: TIcon;
    procedure SetIcon(const AValue: TIcon);
  public
    property Icon: TIcon read GetIcon write SetIcon nodefault;

  public
    function ToString: string; override;
    procedure AppendToListView(const AListView: TListView); virtual;
  end;

function GetIDBUState: IDBUState; overload;
function GetIDBUState(const AId: Integer; const AName: string; const AFlags: Word; const AIcon: TIcon = nil): IDBUState; overload;

implementation

uses
  System.StrUtils,
  System.SysUtils;

function GetIDBUState: IDBUState;
begin
  Result := TDBUState.Create;
end;

function GetIDBUState(const AId: Integer; const AName: string; const AFlags: Word; const AIcon: TIcon): IDBUState;
begin
  Result := GetIDBUState;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Id := AId;
  Result.Name := Trim(AName);
  Result.Flags := AFlags;
  Result.Icon := AIcon;
end;


procedure TDBUState.AppendToListView(const AListView: TListView);
var
  a: IDBUState;
  li: TListItem;
  s: string;
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
    li.SubItems.Add(Name);
    s := EmptyStr;
    if (Flags and 1) > 0 then
    begin
      s := s + 'заблокирован';
    end;
    if (Flags and 2) > 0 then
    begin
      if Length(s) > 0 then
      begin
        s := s + ', ';
      end;
      s := s + 'дорабатывается';
    end;
    if (Flags and 4) > 0 then
    begin
      if Length(s) > 0 then
      begin
        s := s + ', ';
      end;
      s := s + 'отменён';
    end;
    li.SubItems.Add(s);

    if Supports(Self, IDBUState, a) then
    begin
      li.Data := Pointer(a);
    end;
  end;
end;

constructor TDBUState.Create;
begin
  inherited;
  Initialize;
end;

destructor TDBUState.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TDBUState.Initialize;
begin
  Id := -1;
  Name := EmptyStr;
  Flags := 0;
  Icon := nil;
end;

procedure TDBUState.Finalize;
begin
  Icon := nil;
end;

function TDBUState.GetFlags: Word;
begin
  Result := FFlags;
end;

function TDBUState.GetIcon: TIcon;
begin
  Result := FIcon;
end;

function TDBUState.GetId: Integer;
begin
  Result := FId;
end;

function TDBUState.GetName: string;
begin
  Result := FName;
end;

procedure TDBUState.SetFlags(const AValue: Word);
begin
  if FFlags <> AValue then
  begin
    FFlags := AValue;
  end;
end;

procedure TDBUState.SetIcon(const AValue: TIcon);
begin
  if FIcon <> AValue then
  begin
    if Assigned(FIcon) then
    begin
      FreeAndNil(FIcon);
    end;
    if Assigned(AValue) then
    begin
      FIcon := TIcon.Create;
      if Assigned(FIcon) then
      begin
        FIcon.Assign(AValue);
      end;
    end;
  end;
end;

procedure TDBUState.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

procedure TDBUState.SetName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FName <> s then
  begin
    FName := s;
  end;
end;

function TDBUState.ToString: string;
var
  ico_s: string;
begin
  if Assigned(Icon) then
  begin
    ico_s := Icon.ToString;
  end
  else
  begin
    ico_s := 'nil';
  end;

  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) +
    Format('=> Id: %d, Name: %s, Flags: %d, Icon: %s', [Id, Name, Flags, ico_s]);
end;

end.
