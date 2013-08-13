unit TAPEstimator.uTLocation;

interface

uses
  Generics.Collections,
  TAPEstimator.uILocation;

type
  TLocation = class(TInterfacedObject, ILocation)
  strict private
    FCoordinates: TList<Double>;
    function GetCoordinate(AIndex: Integer): Double;
    procedure SetCoordinate(AIndex: Integer; const AValue: Double);
  public
    property Coordinates[AIndex: Integer]: Double read GetCoordinate write SetCoordinate;
  strict private
    function GetCoordinatesCount: Integer;
  public
    property CoordinatesCount: Integer read GetCoordinatesCount;
  public
    constructor Create; reintroduce; overload; virtual;
    constructor Create(const ACoordinates: TArray<Double>); overload; virtual;
    destructor Destroy; override;
  end;

function GetILocation: ILocation; overload;
function GetILocation(const ACoordinates: TArray<Double>): ILocation; overload;

implementation

uses
  System.SysUtils;

function GetILocation: ILocation; overload;
begin
  Result := TLocation.Create;
end;

function GetILocation(const ACoordinates: TArray<Double>): ILocation; overload;
begin
  Result := TLocation.Create(ACoordinates);
end;

constructor TLocation.Create;
var
  a: TArray<Double>;
begin
  Create(a);
end;

constructor TLocation.Create(const ACoordinates: TArray<Double>);
begin
  inherited Create;
  FCoordinates.Create;
  if Length(ACoordinates) > 0 then
  begin
    FCoordinates.AddRange(ACoordinates);
  end;
end;

destructor TLocation.Destroy;
begin
  if Assigned(FCoordinates) then
  begin
    FreeAndNil(FCoordinates);
  end;
  inherited;
end;

function TLocation.GetCoordinate(AIndex: Integer): Double;
begin
  if FCoordinates.Count - 1 < AIndex then
  begin
    Result := FCoordinates[AIndex];
  end
  else
  begin
    Result := 0;
  end;
end;

function TLocation.GetCoordinatesCount: Integer;
begin
  Result := FCoordinates.Count;
end;

procedure TLocation.SetCoordinate(AIndex: Integer; const AValue: Double);
begin
  if FCoordinates.Count - 1 < AIndex then
  begin
    FCoordinates.Count := AIndex - 1;
  end;
  if FCoordinates[AIndex] <> AValue then
  begin
    FCoordinates[AIndex] := AValue;
  end;
end;

end.
