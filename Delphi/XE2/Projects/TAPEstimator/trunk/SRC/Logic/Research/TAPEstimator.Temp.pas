unit TAPEstimator.Temp;

interface

uses
  Generics.Collections,
  System.Classes;

type
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
