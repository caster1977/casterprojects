unit TAPEstimator.uTPoint;

interface

uses
  TAPEstimator.uTFigure,
  TAPEstimator.uIPoint,
  TAPEstimator.uILocation;

type
  TPoint = class(TFigure, IPoint)
  strict private
    FLocationA: ILocation;
    function GetLocationA: ILocation;
    procedure SetLocationA(const AValue: ILocation);
  public
    property LocationA: ILocation read GetLocationA write SetLocationA;
  end;

implementation

uses
  System.SysUtils;

function TPoint.GetLocationA: ILocation;
begin
  if Length(FLocations) > 0 then
  begin
    Result := FLocations[0];
  end
  else
  begin
    raise ERangeError.Create('Can not get location A: wrong array length.');
  end;
end;

procedure TPoint.SetLocationA(const AValue: ILocation);
begin
  if Length(FLocations) < 1 then
  begin
    SetLength(FLocations, 1);
  end;
  FLocations[0] := AValue;
end;

end.
