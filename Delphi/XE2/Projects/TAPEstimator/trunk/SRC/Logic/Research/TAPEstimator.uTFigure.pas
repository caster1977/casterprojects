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
    constructor Create(const ALocations: TArray<ILocation>); virtual;
    destructor Destroy; override;
  end;

implementation

constructor TFigure.Create(const ALocations: TArray<ILocation>);
var
  i : Integer;
begin
  inherited Create;
  SetLength(FLocations, Length(ALocations));
  for i := 0 to Length(ALocations) - 1 do
  begin
    FLocations[i] := ALocations[i];
  end;
end;

destructor TFigure.Destroy;
var
  i: Integer;
begin
  if Length(FLocations) > 0 then
  begin
    for i := 0 to Length(FLocations) - 1 do
    begin
      FLocations[i] := nil;
    end;
    SetLength(FLocations, 0);
  end;
  inherited;
end;

end.
