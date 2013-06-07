unit TAPEstimator.uTAbstractCoordinate;

interface

uses
  CastersPackage.uICustomized,
  TAPEstimator.uICoordinate,
  TAPEstimator.uICoordinateConverter;

type
  TAbstractCoordinate<T, F> = class(TInterfacedObject, ICoordinate<T>, ICoordinateConverter<T, F>, ICustomized)

  strict private
    FAbsoluteValue: T;
    function GetAbsoluteValue: T;
    procedure SetAbsoluteValue(const AValue: T); virtual;
  public
    property AbsoluteValue: T read GetAbsoluteValue write SetAbsoluteValue nodefault;

  strict private
    function GetRelativeValue: T; virtual;
    procedure SetRelativeValue(const AValue: T); virtual;
  public
    property RelativeValue: T read GetRelativeValue write SetRelativeValue nodefault;

  strict protected
    function AbsoluteToRelative(const AValue: T): T; virtual; abstract;
    function RelativeToAbsolute(const AValue: T): T; virtual; abstract;

  strict private
    FOnAbsoluteToRelative: F;
    function GetOnAbsoluteToRelative: F;
    procedure SetOnAbsoluteToRelative(const AValue: F); virtual;
  public
    property OnAbsoluteToRelative: F read GetOnAbsoluteToRelative write SetOnAbsoluteToRelative nodefault;

  strict private
    FOnRelativeToAbsolute: F;
    function GetOnRelativeToAbsolute: F;
    procedure SetOnRelativeToAbsolute(const AValue: F); virtual;
  public
    property OnRelativeToAbsolute: F read GetOnRelativeToAbsolute write SetOnRelativeToAbsolute nodefault;

  strict protected
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual;
  public
    constructor Create; reintroduce; overload; virtual;
    destructor Destroy; override; final;
  end;

implementation

constructor TAbstractCoordinate<T, F>.Create;
begin
  Initialize;
end;

destructor TAbstractCoordinate<T, F>.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TAbstractCoordinate<T, F>.Finalize;
begin
end;

function TAbstractCoordinate<T, F>.GetAbsoluteValue: T;
begin
  Result := FAbsoluteValue;
end;

procedure TAbstractCoordinate<T, F>.SetAbsoluteValue(const AValue: T);
begin
  FAbsoluteValue := AValue;
end;

procedure TAbstractCoordinate<T, F>.SetOnAbsoluteToRelative(const AValue: F);
begin
  FOnAbsoluteToRelative := AValue;
end;

procedure TAbstractCoordinate<T, F>.SetOnRelativeToAbsolute(const AValue: F);
begin
  FOnRelativeToAbsolute := AValue;
end;

function TAbstractCoordinate<T, F>.GetRelativeValue: T;
begin
  Result := AbsoluteToRelative(AbsoluteValue);
end;

procedure TAbstractCoordinate<T, F>.SetRelativeValue(const AValue: T);
begin
  AbsoluteValue := RelativeToAbsolute(AValue);
end;

function TAbstractCoordinate<T, F>.GetOnAbsoluteToRelative: F;
begin
  Result := FOnAbsoluteToRelative;
end;

function TAbstractCoordinate<T, F>.GetOnRelativeToAbsolute: F;
begin
  Result := FOnRelativeToAbsolute;
end;

end.
