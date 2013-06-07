unit TAPEstimator.uTInt64Coordinate;

interface

uses
  TAPEstimator.uTInt64Function,
  TAPEstimator.uTAbstractCoordinate,
  TAPEstimator.uIInt64Coordinate;

type
  TInt64Coordinate = class(TAbstractCoordinate<Int64, TInt64Function>, IInt64Coordinate)
  strict protected
    procedure Initialize; override;
  strict protected
    function AbsoluteToRelative(const AValue: Int64): Int64; override; final;
    function RelativeToAbsolute(const AValue: Int64): Int64; override; final;
  public
    function ToString: string; override;
  end;

function GetIInt64Coordinate: IInt64Coordinate;

implementation

uses
  System.SysUtils;

function GetIInt64Coordinate: IInt64Coordinate;
begin
  Result := TInt64Coordinate.Create;
end;


procedure TInt64Coordinate.Initialize;
begin
  inherited;
  AbsoluteValue := 0;
end;

function TInt64Coordinate.AbsoluteToRelative(const AValue: Int64): Int64;
begin
  if Assigned(OnAbsoluteToRelative) then
  begin
    Result := OnAbsoluteToRelative(AValue);
  end
  else
  begin
    Result := AValue;
  end;
end;

function TInt64Coordinate.RelativeToAbsolute(const AValue: Int64): Int64;
begin
  if Assigned(OnRelativeToAbsolute) then
  begin
    Result := OnRelativeToAbsolute(AValue);
  end
  else
  begin
    Result := AValue;
  end;
end;

function TInt64Coordinate.ToString: string;
begin
  Result := 'Absolute: ' + IntToStr(AbsoluteValue) + ', Relative: ' + IntToStr(RelativeValue);
end;

end.
