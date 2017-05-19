unit RoutinesPackage.Logic.IDataSetWriter;

interface

type
  IDataSetWriter = interface
    ['{1B139A21-AA30-462E-910C-ECC06846C9EC}']
    function Save(): Boolean;
    function GetExtension(): string;
    function GetDestinationFileName(): string;
    property DestinationFileName: string read GetDestinationFileName;
  end;

implementation

end.
