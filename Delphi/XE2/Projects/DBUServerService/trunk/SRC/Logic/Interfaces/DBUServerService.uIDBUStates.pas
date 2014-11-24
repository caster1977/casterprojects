unit DBUServerService.uIDBUStates;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUServerService.uIDBUState;

type
  IDBUStates = interface(IInterfaceListOfGivenType<IDBUState>)
    ['{F7DD0E4E-7D93-4D5E-BA93-FFF7F66FA6D5}']
  end;

implementation

end.
