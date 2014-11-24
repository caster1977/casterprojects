unit DBUServerService.uIDatabaseTypes;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUServerService.uIDatabaseType;

type
  IDatabaseTypes = interface(IInterfaceListOfGivenType<IDatabaseType>)
    ['{B7EEDB27-AFDD-4F60-96CB-F67FA2EC0D9E}']
  end;

implementation

end.
