unit DBUShared.uIUsers;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUShared.uIUser;

type
  IUsers = interface(IInterfaceListOfGivenType<IUser>)
    ['{156D0C80-6009-41D7-B100-E207D0A19A7F}']
    function GetUserByLogin(const ALogin: string): IUser;
    function GetIndexByLogin(const ALogin: string): Integer;
  end;

implementation

end.
