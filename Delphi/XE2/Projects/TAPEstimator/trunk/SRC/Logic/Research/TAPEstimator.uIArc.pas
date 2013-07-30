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
    function GetLocationC: ILocation;
    procedure SetLocationC(const AValue: ILocation);

    ///	<summary>
    ///	  ����� C
    ///	</summary>
    property LocationC: ILocation read GetLocationC write SetLocationC;

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
  end;


implementation

end.
