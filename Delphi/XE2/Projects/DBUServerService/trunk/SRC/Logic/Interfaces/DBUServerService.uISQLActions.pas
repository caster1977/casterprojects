unit DBUServerService.uISQLActions;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUServerService.uISQLAction;

type
  ISQLActions = interface(IInterfaceListOfGivenType<ISQLAction>)
    ['{8144C538-32BA-45B3-BA2B-612F0FB4C2AF}']
  end;

implementation

end.
