unit OA5.uTPrivilegies;

interface

type
  TPrivilegies = class
  strict private
    FEditing: boolean;
    FClearing: boolean;
    FAccounting: boolean;
    FReporting: boolean;
    function GetAccounting: boolean;
    function GetClearing: boolean;
    function GetEditing: boolean;
    function GetReporting: boolean;
    procedure SetAccounting(const Value: boolean);
    procedure SetClearing(const Value: boolean);
    procedure SetEditing(const Value: boolean);
    procedure SetReporting(const Value: boolean);
  public
    constructor Create; virtual;
    property Editing: boolean read GetEditing write SetEditing default False;
    property Clearing: boolean read GetClearing write SetClearing default False;
    property Accounting: boolean read GetAccounting write SetAccounting default False;
    property Reporting: boolean read GetReporting write SetReporting default False;
  end;

implementation

constructor TPrivilegies.Create;
begin
  inherited;
  FAccounting := False;
  FClearing := False;
  FEditing := False;
  FReporting := False;
end;

function TPrivilegies.GetAccounting: boolean;
begin
  Result := FAccounting;
end;

function TPrivilegies.GetClearing: boolean;
begin
  Result := FClearing;
end;

function TPrivilegies.GetEditing: boolean;
begin
  Result := FEditing;
end;

function TPrivilegies.GetReporting: boolean;
begin
  Result := FReporting;
end;

procedure TPrivilegies.SetAccounting(const Value: boolean);
begin
  if FAccounting <> Value then
    FAccounting := Value;
end;

procedure TPrivilegies.SetClearing(const Value: boolean);
begin
  if FClearing <> Value then
    FClearing := Value;
end;

procedure TPrivilegies.SetEditing(const Value: boolean);
begin
  if FEditing <> Value then
    FEditing := Value;
end;

procedure TPrivilegies.SetReporting(const Value: boolean);
begin
  if FReporting <> Value then
    FReporting := Value;
end;

end.
