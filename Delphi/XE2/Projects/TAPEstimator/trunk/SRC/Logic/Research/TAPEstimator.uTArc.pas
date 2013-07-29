unit TAPEstimator.uTArc;

interface

uses
  TAPEstimator.uTLineSegment,
  TAPEstimator.uIArc,
  TAPEstimator.uILineSegment,
  TAPEstimator.uIPoint,
  TAPEstimator.uIFigure,
  TAPEstimator.uILocation;

type
  TArc = class(TLineSegment, IArc, ILineSegment, IPoint, IFigure)
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

end.
