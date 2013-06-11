unit TAPEstimator.uTGenericFigure;

interface

uses
  System.Classes,
  CastersPackage.uICustomized,
  TAPEstimator.uIGenericFigure,
  Generics.Collections;

type
  /// <summary>
  /// ѕростейша€ фигура, состо€ща€ из набора координат
  /// </summary>
  /// <typeparam name="T">
  /// тип данных координаты
  /// </typeparam>
  TGenericFigure<T> = class(TInterfacedObject, ICustomized, IGenericFigure<T>)
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  strict private
    FRawCoordinates: TList<T>;
    function GetRawCoordinate(AIndex: Int64): T;
    procedure SetRawCoordinate(AIndex: Int64; const AValue: T);
  strict protected
    property RawCoordinates[AIndex: Int64]: T read GetRawCoordinate write SetRawCoordinate;
  strict private
    FDimensionCount: Integer;
    function GetDimensionCount: Integer;
  public
    property DimensionCount: Integer read GetDimensionCount nodefault;
  public
    constructor Create(const ADimensionCount: Integer); reintroduce; overload; virtual;
    constructor Create(const ADimensionCount: Integer; const ARawCoordinates: array of T); reintroduce; overload; virtual;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

constructor TGenericFigure<T>.Create(const ADimensionCount: Integer);
begin
  Create(ADimensionCount, []);
end;

constructor TGenericFigure<T>.Create(const ADimensionCount: Integer; const ARawCoordinates: array of T);
begin
  inherited Create;
  FDimensionCount := ADimensionCount;
  if not Assigned(FRawCoordinates) then
  begin
    FRawCoordinates.Create;
  end;
  if Length(ARawCoordinates) > 0 then
  begin
    FRawCoordinates.AddRange(ARawCoordinates);
  end;
  Initialize;
end;

destructor TGenericFigure<T>.Destroy;
begin
  Finalize;
  if Assigned(FRawCoordinates) then
  begin
    FreeAndNil(FRawCoordinates);
  end;
  inherited;
end;

procedure TGenericFigure<T>.Finalize;
begin
end;

function TGenericFigure<T>.GetDimensionCount: Integer;
begin
  Result := FDimensionCount;
end;

function TGenericFigure<T>.GetRawCoordinate(AIndex: Int64): T;
begin
  Result := FRawCoordinates[AIndex];
end;

procedure TGenericFigure<T>.Initialize;
begin
end;

procedure TGenericFigure<T>.SetRawCoordinate(AIndex: Int64; const AValue: T);
begin
  FRawCoordinates[AIndex] := AValue;
end;

end.
