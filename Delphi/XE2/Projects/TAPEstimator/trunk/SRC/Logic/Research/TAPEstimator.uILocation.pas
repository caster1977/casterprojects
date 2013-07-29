unit TAPEstimator.uILocation;

interface

type
  ///	<summary>
  ///	  Интерфейс "Местоположение"
  ///	</summary>
  ILocation = interface
    ['{B98C78E3-A7BB-4437-AB3E-4A57E915B1B9}']
    function GetCoordinate(AIndex: Integer): Double;
    procedure SetCoordinate(AIndex: Integer; const AValue: Double);
    property Coordinates[AIndex: Integer]: Double read GetCoordinate write SetCoordinate;

    function GetCoordinatesCount: Integer;
    property CoordinatesCount: Integer read GetCoordinatesCount;
  end;

implementation

end.
