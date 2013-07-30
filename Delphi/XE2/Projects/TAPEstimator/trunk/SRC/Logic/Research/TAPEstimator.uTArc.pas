unit TAPEstimator.uTArc;

interface

uses
  TAPEstimator.uTLineSegment,
  TAPEstimator.uIArc,
  TAPEstimator.uILocation;

type
  TArc = class(TLineSegment, IArc)
  strict private
    function GetRadius: Double;
    function GetLocationC: ILocation;
    procedure SetLocationC(const AValue: ILocation);
  strict protected
    function Valid: Boolean;
  public
    property LocationC: ILocation read GetLocationC write SetLocationC;
    property Radius: Double read GetRadius;
  end;

implementation

uses
  System.SysUtils,
  System.Math;

function TArc.GetLocationC: ILocation;
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

procedure TArc.SetLocationC(const AValue: ILocation);
begin
  if System.Length(FLocations) < 2 then
  begin
    SetLength(FLocations, 2);
  end;
  FLocations[1] := AValue;
end;

function TArc.GetRadius: Double;
begin
  Result := Length;
end;

function TArc.Valid: Boolean;
begin
  Result := SameValue(Distance(LocationA, LocationB), Distance(LocationB, LocationC), 0.00005);
end;

end.
