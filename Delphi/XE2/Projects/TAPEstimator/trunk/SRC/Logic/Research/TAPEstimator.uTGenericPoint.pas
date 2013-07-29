unit TAPEstimator.uTGenericPoint;

interface

uses
  System.Classes,
  CastersPackage.uICustomized,
  TAPEstimator.uTGenericFigure,
  Generics.Collections;

type
  TGenericPoint<T> = class(TGenericFigure<T>)
  strict private
    function GetCoordinate(AIndex: Int64): T; virtual; abstract;
    procedure SetCoordinate(AIndex: Int64; const AValue: T); virtual; abstract;
    property Coordinates[AIndex: Int64]: T read GetCoordinate write SetCoordinate nodefault;
  end;

  TIntegerPoint = class(TGenericPoint<Integer>)
    // function GetCoordinate(AIndex: Int64): Integer; override;
    // procedure SetCoordinate(AIndex: Int64; const AValue: Integer); override;
  end;

implementation

end.
