unit TAPEstimator.uIPoint;

interface

uses
  TAPEstimator.uIFigure,
  TAPEstimator.uILocation;

type
  ///	<summary>
  ///	  Интерфейс "Точка"
  ///	</summary>
  IPoint = interface(IFigure)
    ['{DAC078D9-E632-4CC3-BDEE-8CDCFE47AF5F}']
    function GetLocationA: ILocation;
    procedure SetLocationA(const AValue: ILocation);

    ///	<summary>
    ///	  Точка A
    ///	</summary>
    property LocationA: ILocation read GetLocationA write SetLocationA;
  end;

implementation

end.
