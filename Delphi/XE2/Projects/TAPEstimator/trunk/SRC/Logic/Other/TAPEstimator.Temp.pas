unit TAPEstimator.Temp;

interface

uses
  TAPEstimator.uTTableRotation,
  TAPEstimator.uICoordinate,
  TAPEstimator.uTGenericCoordinate,
  TAPEstimator.uIIntegerCoordinate,
  TAPEstimator.uIInt64Coordinate,
  TAPEstimator.uTIntegerCoordinate,
  TAPEstimator.uTInt64Coordinate,
  TAPEstimator.uTIntegerFunction,
  TAPEstimator.uTInt64Function,
  TAPEstimator.uICoordinateConverter,
  Generics.Collections,
  System.Classes;

type
  ///	<summary>
  ///	  Интерфейс "Местоположение"
  ///	</summary>
  ILocation = interface
    ['{B98C78E3-A7BB-4437-AB3E-4A57E915B1B9}']
    function GetCoordinate(AIndex: Int64): Double;
    procedure SetCoordinate(AIndex: Int64; const AValue: Double);
    property Coordinates[AIndex: Int64]: Double read GetCoordinate write SetCoordinate;
  end;

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

  ///	<summary>
  ///	  Интерфейс "Фигура"
  ///	</summary>
  IFigure = interface
    ['{6D1F425D-A14D-46EE-97DD-09519FE6B633}']
  end;

  ///	<summary>
  ///	  Интерфейс "Точка"
  ///	</summary>
  IPoint = interface(IFigure)
    ['{DAC078D9-E632-4CC3-BDEE-8CDCFE47AF5F}']
    function GetLocationA: ILocation;
    procedure SetLocationA(const AValue: ILocation);

    ///	<summary>
    ///	  Точка A
    ///	</summary>
    property LocationA: ILocation read GetLocationA write SetLocationA;
  end;

  ///	<summary>
  ///	  Интерфейс "Отрезок прямой"
  ///	</summary>
  ILineSegment = interface(IPoint)
    ['{6D95B53A-58F9-4C08-BE07-5F16FB10AF76}']
    function GetLength: Double;

    ///	<summary>
    ///	  Длина фигуры
    ///	</summary>
    property Length: Double read GetLength;

    function GetLocationB: ILocation;
    procedure SetLocationB(const AValue: ILocation);

    ///	<summary>
    ///	  Точка B
    ///	</summary>
    property LocationB: ILocation read GetLocationB write SetLocationB;
  end;

  ///	<summary>
  ///	  Интерфейс "Дуга"
  ///	</summary>
  IArc = interface(ILineSegment)
    ['{EF76CC51-040A-4FDD-9264-800E1454F013}']
    function GetRadius: Double;

    ///	<summary>
    ///	  Радиус (расстояние от точки С до точки A(B))
    ///	</summary>
    property Radius: Double read GetRadius;

    ///	<summary>
    ///	  Проверка на корректность координат точки B (A-&gt;C должно равняться
    ///	  B-&gt;C)
    ///	</summary>
    function Valid: Boolean;
    function GetSkewAngle: Double;

    ///	<summary>
    ///	  Угол отклонения
    ///	</summary>
    property SkewAngle: Double read GetSkewAngle;
    function GetLocationC: ILocation;
    procedure SetLocationC(const AValue: ILocation);

    ///	<summary>
    ///	  Точка C
    ///	</summary>
    property LocationC: ILocation read GetLocationC write SetLocationC;
  end;

  TFigure = class(TInterfacedObject, IFigure{, ICustomized})
  strict protected
    FLocations: TArray<ILocation>;
  strict protected
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual; abstract;
  public
    constructor Create; reintroduce; overload; virtual;
    constructor Create(const ALocations: TArray<ILocation>); overload; virtual;
    destructor Destroy; override;
  end;

  TPoint = class(TFigure, IPoint, IFigure)
  strict private
    FLocationA: ILocation;
    function GetLocationA: ILocation;
    procedure SetLocationA(const AValue: ILocation);
  public
    property LocationA: ILocation read GetLocationA write SetLocationA;
  end;

  TLineSegment = class(TPoint, ILineSegment, IFigure)
  strict private
    FLocationB: ILocation;
    function GetLocationB: ILocation;
    procedure SetLocationB(const AValue: ILocation);
  strict private
    function GetLength: Double;
  public
    property LocationB: ILocation read GetLocationB write SetLocationB;
    property Length: Double read GetLength;
  end;

  TArc = class(TLineSegment, IArc, IFigure)
  strict private
    function GetRadius: Double;
    function GetSkewAngle: Double;
    function GetLocationC: ILocation;
    procedure SetLocationC(const AValue: ILocation);
  strict protected
    function Valid: Boolean;
  public
    property LocationC: ILocation read GetLocationC write SetLocationC;
    property Radius: Double read GetRadius;
    property SkewAngle: Double read GetSkewAngle;
  end;

  TTest = class
  strict private
    FX: IIntegerCoordinate;
    FY: IInt64Coordinate;
    function GetX: IIntegerCoordinate;
    function GetY: IInt64Coordinate;
  public
    function OnAbsoluteYToRelativeY(const AValue: Int64): Int64;
    function OnRelativeYToAbsoluteY(const AValue: Int64): Int64;
    function OnAbsoluteXToRelativeX(const AValue: Integer): Integer;
    function OnRelativeXToAbsoluteX(const AValue: Integer): Integer;
    constructor Create(const AX: Integer; const AY: Int64); virtual;
    property X: IIntegerCoordinate read GetX nodefault;
    property Y: IInt64Coordinate read GetY nodefault;
  end;

var
  Test: TTest;
  IntegerCoordinateConverter: ICoordinateConverter<Integer, TIntegerFunction>;
  Int64CoordinateConverter: ICoordinateConverter<Int64, TInt64Function>;

  //
  //
  //
  // ICustomFigure<T1, T2> = interface
  // ['{7BAD1648-41FF-4446-AE7A-03694B717BEB}']
  // function GetX: T1;
  // procedure SetX(const AValue: T1);
  // property X: ICustomCoordinate<T1> read GetX write SetX;
  //
  // function GetY: T1;
  // procedure SetY(const AValue: T1);
  // property Y: ICustomCoordinate<T1> read GetY write SetY;
  //
  // function GetProperties: T2;
  // procedure SetProperties(const AValue: T2);
  // property Properties: T2 read GetProperties write SetProperties;
  // end;
  //
  // ICustomVisualFigure<T1, T2> = interface(ICustomFigure<T1, T2>)
  // ['{8BEFFC2E-5256-4147-9DA1-10D83BAF7EBC}']
  // procedure Draw; virtual;
  // end;
  //
  // TCustom<T1, T2> = class(TInterfacedObject, ICustomFigure<T1, T2>)
  // public
  // FX: ICustomCoordinate<T1>;
  // FY: ICustomCoordinate<T1>;
  // public
  // function GetX: T1;
  // procedure SetX(const AValue: T1);
  // property X: ICustomCoordinate<T1> read GetX write SetX nodefault;
  //
  // function GetY: T1;
  // procedure SetY(const AValue: T1);
  // property Y: ICustomCoordinate<T1> read GetY write SetY nodefault;
  //
  // function GetProperties: T2;
  // procedure SetProperties(const AValue: T2);
  // property Properties: T2 read GetProperties write SetProperties nodefault;
  // public
  // procedure Draw; virtual; abstract;
  // public
  // constructor Create; virtual;
  // destructor Destroy; override;
  // end;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs;

constructor TTest.Create(const AX: Integer; const AY: Int64);
begin
  X.AbsoluteValue := AX;
  Y.AbsoluteValue := AY;
end;

function TTest.GetX: IIntegerCoordinate;
begin
  if not Assigned(FX) then
  begin
    FX := GetIIntegerCoordinate;
  end;
  Result := FX;
end;

function TTest.GetY: IInt64Coordinate;
begin
  if not Assigned(FY) then
  begin
    FY := GetIInt64Coordinate;
  end;
  Result := FY;
end;

function TTest.OnAbsoluteXToRelativeX(const AValue: Integer): Integer;
begin
  Result := AValue + 4;
end;

function TTest.OnRelativeXToAbsoluteX(const AValue: Integer): Integer;
begin
  Result := AValue - 4;
end;

function TTest.OnAbsoluteYToRelativeY(const AValue: Int64): Int64;
begin
  Result := AValue + 16;
end;

function TTest.OnRelativeYToAbsoluteY(const AValue: Int64): Int64;
begin
  Result := AValue - 16;
end;

{ TLocation }

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

constructor TLocation.Create;
var
  a: TArray<Double>;
begin
  Create(a);
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

initialization

Test := TTest.Create(TABLE_ROTATIONS[ttr90], 2);
if (Supports(Test.X, ICoordinateConverter<Integer, TIntegerFunction>)) then
begin
  IntegerCoordinateConverter := Test.X as ICoordinateConverter<Integer, TIntegerFunction>;
  if Assigned(IntegerCoordinateConverter) then
  begin
    IntegerCoordinateConverter.OnRelativeToAbsolute := Test.OnRelativeXToAbsoluteX;
    IntegerCoordinateConverter.OnAbsoluteToRelative := Test.OnAbsoluteXToRelativeX;
  end;
end;
if (Supports(Test.Y, ICoordinateConverter<Int64, TInt64Function>)) then
begin
  Int64CoordinateConverter := Test.Y as ICoordinateConverter<Int64, TInt64Function>;
  if Assigned(Int64CoordinateConverter) then
  begin
    Int64CoordinateConverter.OnRelativeToAbsolute := Test.OnRelativeYToAbsoluteY;
    Int64CoordinateConverter.OnAbsoluteToRelative := Test.OnAbsoluteYToRelativeY;
  end;
end;
if Assigned(IntegerCoordinateConverter) and Assigned(Int64CoordinateConverter) then
begin
  ShowMessage('X: ' + IntegerCoordinateConverter.ToString + sLineBreak + 'Y: ' + Int64CoordinateConverter.ToString);
end;

finalization

if Assigned(Test) then
begin
  FreeAndNil(Test);
end;

end.
