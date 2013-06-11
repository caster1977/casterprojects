unit TAPEstimator.uIGenericFigure;

interface

type
  IGenericFigure<T> = interface
    ['{000A8D06-5EBE-4DC5-8407-77204433CE6A}']
    function GetRawCoordinate(AIndex: Int64): T;
    procedure SetRawCoordinate(AIndex: Int64; const AValue: T);
    property RawCoordinates[AIndex: Int64]: T read GetRawCoordinate write SetRawCoordinate;

    function GetDimensionCount: Integer;
    property DimensionCount: Integer read GetDimensionCount;
  end;

implementation

end.
