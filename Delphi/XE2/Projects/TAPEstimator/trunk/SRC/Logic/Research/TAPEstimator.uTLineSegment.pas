unit TAPEstimator.uTLineSegment;

interface

uses
  TAPEstimator.uTPoint,
  TAPEstimator.uILineSegment,
  TAPEstimator.uILocation;

type
  TLineSegment = class(TPoint, ILineSegment)
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

uses
  System.SysUtils,
  System.Math;

function TLineSegment.GetLength: Double;
var
  i: Integer;
  d1: Double;
  d2: Double;
begin
  // ���������� "��������������" ������ ���� �� ������ ���� (������ � ����� �������)
  if System.Length(FLocations) > 1 then
  begin
    // ���������� ��������� ������ ���������
    if LocationA.CoordinatesCount = LocationB.CoordinatesCount then
    begin
      // �������� ����� ��������� ��������� �������
      d1 := 0.0;
      for i := 0 to LocationA.CoordinatesCount - 1 do
      begin
        // ��������� ��������� ���������� �������
        d1 := LocationB.Coordinates[i] - LocationA.Coordinates[i];
        // ��������� ������� ���������� ������� � ����� ��������� ����
        d2 := d2 + (d1 * d1);
      end;
      // �������� ���������� ������ �� �����
      Result := Sqrt(d2);
    end
    else
    begin
      raise ERangeError.Create('Length of coordinate arrays of location A and location B is different.');
    end;
  end
end;

function TLineSegment.GetLocationB: ILocation;
begin
  if System.Length(FLocations) > 1 then
  begin
    Result := FLocations[1];
  end
  else
  begin
    raise ERangeError.Create('Can not get location B: wrong array length.');
  end;
end;

procedure TLineSegment.SetLocationB(const AValue: ILocation);
begin
  if System.Length(FLocations) < 2 then
  begin
    SetLength(FLocations, 2);
  end;
  FLocations[1] := AValue;
end;

end.
