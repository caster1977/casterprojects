unit OA5.uIOA5Form;

interface

uses
  OA5.uIConfiguration,
  OA5.uIAccount;

type
  IOA5Form = interface
    ['{68AD8D48-2CEF-4ECC-9AC4-3A6689C76F67}']
    function GetConfiguration: IConfiguration;
    function GetCurrentUser: IAccount;
    property Configuration: IConfiguration read GetConfiguration;
    property CurrentUser: IAccount read GetCurrentUser;
  end;

implementation

end.
