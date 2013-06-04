unit TAPEstimator.Temp;

interface

uses
  CastersPackage.uICustomized;

type
  ICustomCoordinate<T> = interface(ICustomized)
  ['{EA09FF1B-3083-4EA6-B56D-C91683D98F25}']
    function GetAbsoluteValue: T;
    procedure SetAbsoluteValue(const AValue: T);
    property AbsoluteValue: T read GetAbsoluteValue write SetAbsoluteValue;

    function GetRelativeValue: T;
    procedure SetRelativeValue(const AValue: T);
    property RelativeValue: T read GetRelativeValue write SetRelativeValue;
  end;

  TCustomCoordinate<T> = class(TInterfacedObject, ICustomCoordinate<T>)
  strict private
    function GetAbsoluteValue: T;
  strict private
    function GetRelativeValue: T;
  strict protected
    FAbsoluteValue: T;
    FRelativeValue: T;
    procedure SetAbsoluteValue(const AValue: T); virtual; abstract;
    procedure SetRelativeValue(const AValue: T); virtual; abstract;
    function AbsoluteToRelative(const AValue: T): T; virtual; abstract;
    function RelativeToAbsolute(const AValue: T): T; virtual; abstract;
  strict protected
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual; abstract;
  public
    property AbsoluteValue: T read GetAbsoluteValue write SetAbsoluteValue nodefault;
    property RelativeValue: T read GetRelativeValue write SetRelativeValue nodefault;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override; final;
  end;
//
  TIntegerCoordinate = class(TCustomCoordinate<Integer>)
  strict protected
    procedure SetAbsoluteValue(const AValue: Integer); override;
    procedure SetRelativeValue(const AValue: Integer); override;
    function AbsoluteToRelative(const AValue: Integer): Integer; override;
    function RelativeToAbsolute(const AValue: Integer): Integer; override;
  end;

  TInt64Coordinate = class(TCustomCoordinate<Int64>)
  strict protected
    procedure SetAbsoluteValue(const AValue: Int64); override;
    procedure SetRelativeValue(const AValue: Int64); override;
    function AbsoluteToRelative(const AValue: Int64): Int64; override;
    function RelativeToAbsolute(const AValue: Int64): Int64; override;
  end;

  //
//
//
//
//  ICustomFigure<T1, T2> = interface
//  ['{7BAD1648-41FF-4446-AE7A-03694B717BEB}']
//    function GetX: T1;
//    procedure SetX(const AValue: T1);
//    property X: ICustomCoordinate<T1> read GetX write SetX;
//
//    function GetY: T1;
//    procedure SetY(const AValue: T1);
//    property Y: ICustomCoordinate<T1> read GetY write SetY;
//
//    function GetProperties: T2;
//    procedure SetProperties(const AValue: T2);
//    property Properties: T2 read GetProperties write SetProperties;
//  end;
//
//  ICustomVisualFigure<T1, T2> = interface(ICustomFigure<T1, T2>)
//  ['{8BEFFC2E-5256-4147-9DA1-10D83BAF7EBC}']
//    procedure Draw; virtual;
//  end;
//
//  TCustom<T1, T2> = class(TInterfacedObject, ICustomFigure<T1, T2>)
//  public
//    FX: ICustomCoordinate<T1>;
//    FY: ICustomCoordinate<T1>;
//  public
//    function GetX: T1;
//    procedure SetX(const AValue: T1);
//    property X: ICustomCoordinate<T1> read GetX write SetX nodefault;
//
//    function GetY: T1;
//    procedure SetY(const AValue: T1);
//    property Y: ICustomCoordinate<T1> read GetY write SetY nodefault;
//
//    function GetProperties: T2;
//    procedure SetProperties(const AValue: T2);
//    property Properties: T2 read GetProperties write SetProperties nodefault;
//  public
//    procedure Draw; virtual; abstract;
//  public
//    constructor Create; virtual;
//    destructor Destroy; override;
//  end;

implementation

constructor TCustomCoordinate<T>.Create;
begin
  Initialize;
  FRelativeValue := AbsoluteTORelative(AbsoluteValue);
end;

destructor TCustomCoordinate<T>.Destroy;
begin
  Finalize;
  inherited;
end;

function TCustomCoordinate<T>.GetAbsoluteValue: T;
begin
  Result := FAbsoluteValue;
end;

function TCustomCoordinate<T>.GetRelativeValue: T;
begin
  Result := FRelativeValue;
end;

{ TIntegerCoordinate }

function TIntegerCoordinate.AbsoluteToRelative(const AValue: Integer): Integer;
begin

end;

function TIntegerCoordinate.RelativeToAbsolute(const AValue: Integer): Integer;
begin

end;

procedure TIntegerCoordinate.SetAbsoluteValue(const AValue: Integer);
begin
  inherited;
  if FAbsoluteValue <> AValue then
  begin
    FAbsoluteValue := AValue;
  end;
end;

procedure TIntegerCoordinate.SetRelativeValue(const AValue: Integer);
begin
  inherited;
  if FRelativeValue <> AValue then
  begin
    FRelativeValue := AValue;
  end;
end;

{ TInt64Coordinate }

function TInt64Coordinate.AbsoluteToRelative(const AValue: Int64): Int64;
begin

end;

function TInt64Coordinate.RelativeToAbsolute(const AValue: Int64): Int64;
begin

end;

procedure TInt64Coordinate.SetAbsoluteValue(const AValue: Int64);
begin
  inherited;
  if FAbsoluteValue <> AValue then
  begin
    FAbsoluteValue := AValue;
  end;
end;

procedure TInt64Coordinate.SetRelativeValue(const AValue: Int64);
begin
  inherited;
  if FRelativeValue <> AValue then
  begin
    FRelativeValue := AValue;
  end;
end;

end.
