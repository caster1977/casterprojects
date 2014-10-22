unit DBUServerManager.uIRecents;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUServerManager.uIRecent;

type
  IRecents = interface(IInterfaceListOfGivenType<IRecent>)
    ['{F24ADE3E-6FD5-4D97-901E-905892BD42C4}']
  end;

implementation

end.
