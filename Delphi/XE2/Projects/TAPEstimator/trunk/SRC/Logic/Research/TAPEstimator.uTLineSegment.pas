unit TAPEstimator.uTLineSegment;

interface

uses
  TAPEstimator.uTPoint,
  TAPEstimator.uILineSegment,
  TAPEstimator.uILocation;

type
  TLineSegment = class(TPoint, ILineSegment)
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

implementation

uses
  System.SysUtils,
  System.Math;

function TLineSegment.GetLength: Double;
begin
  Result := Distance(LocationA, LocationB);
end;

function TLineSegment.GetLocationB: ILocation;
begin
  if System.Length(FLocations) > 1 then
  begin
    Result := FLocations[1];
  end
  else
  begin
    raise ERangeError.Create('Can not get location B: wrong array length.');
  end;
end;

procedure TLineSegment.SetLocationB(const AValue: ILocation);
begin
  if System.Length(FLocations) < 2 then
  begin
    SetLength(FLocations, 2);
  end;
  FLocations[1] := AValue;
end;

end.
