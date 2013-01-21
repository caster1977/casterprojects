unit DBAutoTest.uIRecentList;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBAutoTest.uIRecent;

type
  IRecentList = interface(IInterfaceListOfGivenType<IRecent>)
    ['{7B89ACD4-CC43-4FB2-86E0-3566D3448BA5}']
  end;

implementation

end.
