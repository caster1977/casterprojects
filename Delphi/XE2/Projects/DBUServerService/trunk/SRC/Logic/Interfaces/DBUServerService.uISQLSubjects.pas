unit DBUServerService.uISQLSubjects;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUServerService.uISQLSubject;

type
  ISQLSubjects = interface(IInterfaceListOfGivenType<ISQLSubject>)
    ['{32868921-081A-4EC0-ADE3-0024334B2593}']
  end;

implementation

end.
