unit TAPEstimator.uILocation;

interface

type
  ///	<summary>
  ///	  Интерфейс "Местоположение"
  ///	</summary>
  ILocation = interface
    ['{B98C78E3-A7BB-4437-AB3E-4A57E915B1B9}']
    function GetCoordinate(AIndex: Int64): Double;
    procedure SetCoordinate(AIndex: Int64; const AValue: Double);
    property Coordinates[AIndex: Int64]: Double read GetCoordinate write SetCoordinate;
  end;

implementation

end.
