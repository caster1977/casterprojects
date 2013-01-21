unit DBAutoTest.uIProfileList;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBAutoTest.uIProfile;

type
  IProfileList = interface(IInterfaceListOfGivenType<IProfile>)
    ['{700412B7-A057-4988-9E3B-685881E3C86A}']
  end;

implementation

end.
