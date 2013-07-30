unit TAPEstimator.uIFigure;

interface

uses
  TAPEstimator.uILocation;

type
  ///	<summary>
  ///	  Интерфейс "Фигура"
  ///	</summary>
  IFigure = interface
    ['{6D1F425D-A14D-46EE-97DD-09519FE6B633}']
    function Distance(const ALocationA, ALocationB: ILocation): Double;
  end;

implementation

end.
