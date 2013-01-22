unit CastersPackage.uTDialogPosition;

interface

const
  DEFAULT_DIALOG_POSITION_CENTERED = True;
  DEFAULT_DIALOG_POSITION_LEFT = 0;
  DEFAULT_DIALOG_POSITION_TOP = 0;

type
  TDialogPosition = packed record
  strict private
    FCentered: Boolean;
    FLeft: Integer;
    FTop: Integer;
    function GetCentered: Boolean;
    function GetLeft: Integer;
    function GetTop: Integer;
    procedure SetCentered(const AValue: Boolean);
    procedure SetLeft(const AValue: Integer);
    procedure SetTop(const AValue: Integer);
  public
    function Equals(const AValue: TDialogPosition): Boolean;
    procedure Assign(const AValue: TDialogPosition);
    procedure AssignTo(var AValue: TDialogPosition);
    property Centered: Boolean read GetCentered write SetCentered;
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
  end;

implementation

procedure TDialogPosition.Assign(const AValue: TDialogPosition);
begin
  Self.Centered := AValue.Centered;
  Self.Left := AValue.Left;
  Self.Top := AValue.Top;
end;

procedure TDialogPosition.AssignTo(var AValue: TDialogPosition);
begin
  AValue.Centered := Self.Centered;
  AValue.Left := Self.Left;
  AValue.Top := Self.Top;
end;

function TDialogPosition.Equals(const AValue: TDialogPosition): Boolean;
begin
  Result := (Self.Centered = AValue.Centered) and (Self.Left = AValue.Left) and
    (Self.Top = AValue.Top);
end;

function TDialogPosition.GetCentered: Boolean;
begin
  Result := FCentered;
end;

function TDialogPosition.GetLeft: Integer;
begin
  Result := FLeft;
end;

function TDialogPosition.GetTop: Integer;
begin
  Result := FTop;
end;

procedure TDialogPosition.SetCentered(const AValue: Boolean);
begin
  if FCentered <> AValue then
  begin
    FCentered := AValue;
  end;
end;

procedure TDialogPosition.SetLeft(const AValue: Integer);
begin
  if FLeft <> AValue then
  begin
    FLeft := AValue;
  end;
end;

procedure TDialogPosition.SetTop(const AValue: Integer);
begin
  if FTop <> AValue then
  begin
    FTop := AValue;
  end;
end;

end.
