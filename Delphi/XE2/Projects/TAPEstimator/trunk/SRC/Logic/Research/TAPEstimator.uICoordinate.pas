unit TAPEstimator.uICoordinate;

interface

uses
  CastersPackage.uICustomized;

type
  ICoordinate<T> = interface
    ['{EA09FF1B-3083-4EA6-B56D-C91683D98F25}']
    function GetAbsoluteValue: T;
    procedure SetAbsoluteValue(const AValue: T);
    property AbsoluteValue: T read GetAbsoluteValue write SetAbsoluteValue;

    function GetRelativeValue: T;
    procedure SetRelativeValue(const AValue: T);
    property RelativeValue: T read GetRelativeValue write SetRelativeValue;
  end;

implementation

end.
