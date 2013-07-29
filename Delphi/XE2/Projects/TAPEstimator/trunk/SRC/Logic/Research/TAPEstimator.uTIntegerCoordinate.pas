unit TAPEstimator.uTIntegerCoordinate;

interface

uses
  TAPEstimator.uTIntegerFunction,
  TAPEstimator.uTGenericCoordinate,
  TAPEstimator.uIIntegerCoordinate;

type
  TIntegerCoordinate = class(TGenericCoordinate<Integer, TIntegerFunction>, IIntegerCoordinate)
  strict protected
    procedure Initialize; override;
  strict protected
    function AbsoluteToRelative(const AValue: Integer): Integer; override; final;
    function RelativeToAbsolute(const AValue: Integer): Integer; override; final;
  public
    function ToString: string; override;
  end;

function GetIIntegerCoordinate: IIntegerCoordinate;

implementation

uses
  System.SysUtils;

function GetIIntegerCoordinate: IIntegerCoordinate;
begin
  Result := TIntegerCoordinate.Create;
end;

procedure TIntegerCoordinate.Initialize;
begin
  inherited;
  AbsoluteValue := 0;
end;

function TIntegerCoordinate.AbsoluteToRelative(const AValue: Integer): Integer;
begin
  if Assigned(OnAbsoluteToRelative) then
  begin
    Result := OnAbsoluteToRelative(AValue);
  end
  else
  begin
    Result := AValue;
  end;
end;

function TIntegerCoordinate.RelativeToAbsolute(const AValue: Integer): Integer;
begin
  if Assigned(OnRelativeToAbsolute) then
  begin
    Result := OnRelativeToAbsolute(AValue);
  end
  else
  begin
    Result := AValue;
  end;
end;

function TIntegerCoordinate.ToString: string;
begin
  Result := 'Absolute: ' + IntToStr(AbsoluteValue) + ', Relative: ' + IntToStr(RelativeValue);
end;

end.
