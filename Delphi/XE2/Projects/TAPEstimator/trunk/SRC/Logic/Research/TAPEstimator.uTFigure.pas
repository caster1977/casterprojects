unit TAPEstimator.uTFigure;

interface

uses
  CastersPackage.uIInitializable,
  TAPEstimator.uIFigure,
  TAPEstimator.uILocation;

type
  TFigure = class(TInterfacedObject, IFigure, IInitializable)
  strict protected
    FLocations: TArray<ILocation>;
  strict protected
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual; abstract;
  public
    constructor Create; reintroduce; overload; virtual;
    constructor Create(const ALocations: TArray<ILocation>); overload; virtual;
    destructor Destroy; override;
  end;


implementation

constructor TFigure.Create;
var
  a: TArray<ILocation>;
begin
  a := [0, 0, 0];
  Create(a);
end;

constructor TFigure.Create(const ALocations: TArray<ILocation>);
begin
  inherited;

end;

destructor TFigure.Destroy;
begin

  inherited;
end;

end.
