unit TAPEstimator.uICoordinateConverter;

interface

type
  ICoordinateConverter<T, F> = interface
    ['{AD9965B3-CFA3-41BA-B972-1BE2F50547BA}']
    function AbsoluteToRelative(const AValue: T): T;
    function RelativeToAbsolute(const AValue: T): T;

    function GetOnAbsoluteToRelative: F;
    procedure SetOnAbsoluteToRelative(const AValue: F);
    property OnAbsoluteToRelative: F read GetOnAbsoluteToRelative write SetOnAbsoluteToRelative;

    function GetOnRelativeToAbsolute: F;
    procedure SetOnRelativeToAbsolute(const AValue: F);
    property OnRelativeToAbsolute: F read GetOnRelativeToAbsolute write SetOnRelativeToAbsolute;

    function ToString: string;
  end;

implementation

end.
