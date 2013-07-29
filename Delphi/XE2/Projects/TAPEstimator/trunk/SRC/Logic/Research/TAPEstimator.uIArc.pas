unit TAPEstimator.uIArc;

interface

uses
  TAPEstimator.uILineSegment,
  TAPEstimator.uIPoint,
  TAPEstimator.uILocation;

type
  ///	<summary>
  ///	  ��������� "����"
  ///	</summary>
  IArc = interface(ILineSegment)
    ['{EF76CC51-040A-4FDD-9264-800E1454F013}']
    function GetRadius: Double;

    ///	<summary>
    ///	  ������ (���������� �� ����� � �� ����� A(B))
    ///	</summary>
    property Radius: Double read GetRadius;

    ///	<summary>
    ///	  �������� �� ������������ ��������� ����� B (A-&gt;C ������ ���������
    ///	  B-&gt;C)
    ///	</summary>
    function Valid: Boolean;
    function GetSkewAngle: Double;

    ///	<summary>
    ///	  ���� ����������
    ///	</summary>
    property SkewAngle: Double read GetSkewAngle;
    function GetLocationC: ILocation;
    procedure SetLocationC(const AValue: ILocation);

    ///	<summary>
    ///	  ����� C
    ///	</summary>
    property LocationC: ILocation read GetLocationC write SetLocationC;
  end;


implementation

end.
