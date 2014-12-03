unit DBUShared.uIUser;

interface

uses
  System.Classes;

type
  IUser = interface
    ['{FDC4C5E5-A886-4573-8D0E-869BC71EF138}']
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
    property Login: string read GetLogin write SetLogin;

    function GetPasswordHash: string;
    procedure SetPasswordHash(const AValue: string);
    property PasswordHash: string read GetPasswordHash write SetPasswordHash;

    function GetFullName: string;
    procedure SetFullName(const AValue: string);
    property FullName: string read GetFullName write SetFullName;

    function GetBlocked: Boolean;
    procedure SetBlocked(const AValue: Boolean);
    property Blocked: Boolean read GetBlocked write SetBlocked;

    function GetAdministrator: Boolean;
    procedure SetAdministrator(const AValue: Boolean);
    property Administrator: Boolean read GetAdministrator write SetAdministrator;

    function ToString: string;
  end;

implementation

end.
