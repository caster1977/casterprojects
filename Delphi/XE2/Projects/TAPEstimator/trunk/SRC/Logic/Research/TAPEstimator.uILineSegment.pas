unit TAPEstimator.uILineSegment;

interface

uses
  TAPEstimator.uIPoint,
  TAPEstimator.uILocation;

type
  ///	<summary>
  ///	  ��������� "������� ������"
  ///	</summary>
  ILineSegment = interface(IPoint)
    ['{6D95B53A-58F9-4C08-BE07-5F16FB10AF76}']
    function GetLength: Double;

    ///	<summary>
    ///	  ����� ������
    ///	</summary>
    property Length: Double read GetLength;

    function GetLocationB: ILocation;
    procedure SetLocationB(const AValue: ILocation);

    ///	<summary>
    ///	  ����� B
    ///	</summary>
    property LocationB: ILocation read GetLocationB write SetLocationB;
  end;


implementation

end.
