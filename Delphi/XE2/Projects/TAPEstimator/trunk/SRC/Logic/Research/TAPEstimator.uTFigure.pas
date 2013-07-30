unit TAPEstimator.uTFigure;

interface

uses
  CastersPackage.uIInitializable,
  TAPEstimator.uIFigure,
  TAPEstimator.uILocation;

type
  TFigure = class(TInterfacedObject, IFigure, IInitializable)
  strict protected
    FLocations: TArray<ILocation>;
  strict protected
    function Distance(const ALocationA, ALocationB: ILocation): Double;
  strict protected
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual; abstract;
  public
    constructor Create(const ALocations: TArray<ILocation>); virtual;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

constructor TFigure.Create(const ALocations: TArray<ILocation>);
var
  i: Integer;
begin
  inherited Create;
  SetLength(FLocations, Length(ALocations));
  for i := 0 to Length(ALocations) - 1 do
  begin
    FLocations[i] := ALocations[i];
  end;
end;

destructor TFigure.Destroy;
var
  i: Integer;
begin
  if Length(FLocations) > 0 then
  begin
    for i := 0 to Length(FLocations) - 1 do
    begin
      FLocations[i] := nil;
    end;
    SetLength(FLocations, 0);
  end;
  inherited;
end;

function TFigure.Distance(const ALocationA, ALocationB: ILocation): Double;
var
  i: Integer;
  current: Double;
  total: Double;
begin
  // длина вектора в пространстве равна корню квадратному из суммы квадратов его координат

  // количество "местоположений" должно быть не меньше двух (начало и конец отрезка)
  if Assigned(ALocationA) and Assigned(ALocationB) then
  begin
    // количество координат должно совпадать
    if ALocationA.CoordinatesCount = ALocationB.CoordinatesCount then
    begin
      // обнуляем сумму квардатов координат вектора
      current := 0.0;
      for i := 0 to ALocationA.CoordinatesCount - 1 do
      begin
        // вычисляем очередную координату вектора
        current := ALocationB.Coordinates[i] - ALocationA.Coordinates[i];
        // добавляем квадрат координаты вектора к сумме квадратов длин
        total := total + (current * current);
      end;
      // получаем квадратный корень из суммы
      Result := Sqrt(total);
    end
    else
    begin
      raise ERangeError.Create
        ('Length of coordinate arrays of location A and location B is different.');
    end;
  end;
end;

end.
