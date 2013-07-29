unit TAPEstimator.uTPoint;

interface

uses
  TAPEstimator.uTFigure,
  TAPEstimator.uIPoint,
  TAPEstimator.uIFigure,
  TAPEstimator.uILocation;

type
  TPoint = class(TFigure, IPoint, IFigure)
  strict private
    FLocationA: ILocation;
    function GetLocationA: ILocation;
    procedure SetLocationA(const AValue: ILocation);
  public
    property LocationA: ILocation read GetLocationA write SetLocationA;
  end;

implementation

end.
