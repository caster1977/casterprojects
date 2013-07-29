unit TAPEstimator.uTLocation;

interface

uses
  Generics.Collections,
  TAPEstimator.uILocation;

type
  TLocation = class(TInterfacedObject, ILocation)
  strict private
    FCoordinates: TList<Double>;
    function GetCoordinate(AIndex: Int64): Double;
    procedure SetCoordinate(AIndex: Int64; const AValue: Double);
  public
    property Coordinates[AIndex: Int64]: Double read GetCoordinate write SetCoordinate;
  public
    constructor Create; reintroduce; overload; virtual;
    constructor Create(const ACoordinates: TArray<Double>); overload; virtual;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

constructor TLocation.Create;
var
  a: TArray<Double>;
begin
  Create(a);
end;

constructor TLocation.Create(const ACoordinates: TArray<Double>);
var
  i: Integer;
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

function TLocation.GetCoordinate(AIndex: Int64): Double;
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

procedure TLocation.SetCoordinate(AIndex: Int64; const AValue: Double);
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
