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

implementation

function TArc.GetLocationC: ILocation;
begin

end;

function TArc.GetRadius: Double;
begin

end;

function TArc.GetSkewAngle: Double;
begin

end;

procedure TArc.SetLocationC(const AValue: ILocation);
begin

end;

function TArc.Valid: Boolean;
begin

end;

end.
