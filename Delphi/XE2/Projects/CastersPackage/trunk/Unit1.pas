unit Unit1;

interface

uses
  System.Classes,
  CastersPackage.uICustomized,
  Generics.Collections;

type
  ///	<summary>
  ///	  интерфейс дл€ доступа к фигурам, которые можно визуализировать
  ///	</summary>
  IDrawable = interface
    ['{6673CCA7-5642-448A-933D-B734C28DEB26}']
    procedure Draw;
  end;

  ///	<summary>
  ///	  интерфейс дл€ доступа к любым фигурам
  ///	</summary>
  ///	<typeparam name="T">
  ///	  тип данных координаты
  ///	</typeparam>
  IFigure<T> = interface
    ['{000A8D06-5EBE-4DC5-8407-77204433CE6A}']
    function GetRawCoordinate(AIndex: Int64): T;
    procedure SetRawCoordinate(AIndex: Int64; const AValue: T);
    property RawCoordinates[AIndex: Int64]: T read GetRawCoordinate write SetRawCoordinate;

    function GetDimensionCount: Integer;
    property DimensionCount: Integer read GetDimensionCount;
  end;

  ///	<summary>
  ///	  ѕростейша€ фигура, состо€ща€ из набора координат
  ///	</summary>
  ///	<typeparam name="T">
  ///	  тип данных координаты
  ///	</typeparam>
  TGenericFigure<T> = class(TInterfacedObject, ICustomized, IFigure<T>)
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

  TGenericPoint<T> = class(TGenericFigure<T>)
    function GetCoordinate: TList<T>; virtual; abstract;
    procedure SetCoordinate; virtual; abstract;
    property Coordinates[AIndex: Int64]: T read GetCoordinate write SetCoordinate;
  end;

(*  IAbstractPoint<T> = interface
    ['{044E85D4-E206-4F85-B6D0-7F9E6B3F7406}']

    function GetX: T;
    procedure SetX(const AValue: T);
    property X: T read GetX write SetX;

    function GetY: T;
    procedure SetY(const AValue: T);
    property Y: T read GetY write SetY;

    function GetZ: T;
    procedure SetZ(const AValue: T);
    property Z: T read GetZ write SetZ;
  end;


  TAbstractPoint<T> = class(TInterfacedObject, ICustomized, IAbstractPoint<T>)
  strict private
    FX: T;
    function GetX: T;
    procedure SetX(const AValue: T);
  strict protected
    property X: T read GetX write SetX;
  strict private
    FY: T;
    function GetY: T;
    procedure SetY(const AValue: T);
  strict protected
    property Y: T read GetY write SetY;
  strict private
    FZ: T;
    function GetZ: T;
    procedure SetZ(const AValue: T);
  strict protected
    property Z: T read GetZ write SetZ;
  end;

function GetIIntegerPoint(const ADimension: TDimensions): IAbstractPoint<Integer>;*)

implementation

uses
  System.SysUtils;

(* function GetIIntegerPoint(const ADimension: TDimensions): IAbstractPoint<Integer>;
begin
  Result := TIntegerPoint.Create(ADimension);
end;

constructor TAbstractPoint<T>.Create(const ADimensions: TDimensions);
begin
  inherited Create;
  FDimensions := ADimensions;
  Initialize;
end;

destructor TAbstractPoint<T>.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TAbstractPoint<T>.Finalize;
begin
end;

function TAbstractPoint<T>.GetDimensions: TDimensions;
begin
  Result := FDimensions;
end;

function TAbstractPoint<T>.GetX: T;
begin
  Result := FX;
end;

function TAbstractPoint<T>.GetY: T;
begin
  Result := FY;
end;

procedure TAbstractPoint<T>.SetX(const AValue: T);
begin
  FX := AValue;
end;

procedure TAbstractPoint<T>.SetY(const AValue: T);
begin
  FY := AValue;
end;

function TAbstractPoint<T>.GetZ: T;
begin
  Result := FZ;
end;

procedure TAbstractPoint<T>.SetZ(const AValue: T);
begin
  FZ := AValue;
end;

{ TIntegerPoint }

procedure TIntegerPoint.Initialize;
begin
  inherited;
end;*)

constructor TGenericFigure<T>.Create(const ADimensionCount: Integer;
  const ARawCoordinates: array of T);
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

constructor TGenericFigure<T>.Create(const ADimensionCount: Integer);
begin
  Create(ADimensionCount, []);
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

procedure TGenericFigure<T>.Initialize;
begin
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

procedure TGenericFigure<T>.SetRawCoordinate(AIndex: Int64; const AValue: T);
begin
  FRawCoordinates[AIndex] := AValue;
end;

end.
