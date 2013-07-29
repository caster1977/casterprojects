unit TAPEstimator.uTLineSegment;

interface

uses
  TAPEstimator.uTPoint,
  TAPEstimator.uILineSegment,
  TAPEstimator.uIPoint,
  TAPEstimator.uIFigure,
  TAPEstimator.uILocation;

type
  TLineSegment = class(TPoint, ILineSegment, IPoint, IFigure)
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

end.
