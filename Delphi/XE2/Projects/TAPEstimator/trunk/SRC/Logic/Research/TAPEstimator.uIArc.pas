unit TAPEstimator.uIArc;

interface

uses
  TAPEstimator.uILineSegment,
  TAPEstimator.uIPoint,
  TAPEstimator.uILocation;

type
  ///	<summary>
  ///	  Интерфейс "Дуга"
  ///	</summary>
  IArc = interface(ILineSegment)
    ['{EF76CC51-040A-4FDD-9264-800E1454F013}']
    function GetRadius: Double;

    ///	<summary>
    ///	  Радиус (расстояние от точки С до точки A(B))
    ///	</summary>
    property Radius: Double read GetRadius;

    ///	<summary>
    ///	  Проверка на корректность координат точки B (A-&gt;C должно равняться
    ///	  B-&gt;C)
    ///	</summary>
    function Valid: Boolean;
    function GetSkewAngle: Double;

    ///	<summary>
    ///	  Угол отклонения
    ///	</summary>
    property SkewAngle: Double read GetSkewAngle;
    function GetLocationC: ILocation;
    procedure SetLocationC(const AValue: ILocation);

    ///	<summary>
    ///	  Точка C
    ///	</summary>
    property LocationC: ILocation read GetLocationC write SetLocationC;
  end;


implementation

end.
