unit DBUShared.uTDatabaseType;

interface

uses
  DBUShared.uIDatabaseType,
  CastersPackage.uICustomized,
  System.Classes;

type
  TDatabaseType = class(TInterfacedObject, IDatabaseType, ICustomized)
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

  public
    function ToString: string; override;
  end;

function GetIDatabaseType: IDatabaseType;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function GetIDatabaseType: IDatabaseType;
begin
  Result := TDatabaseType.Create;
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
  Name := EmptyStr;
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
  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) +
    Format('=> Id: %d, Name: %s', [Id, Name]);
end;

end.
