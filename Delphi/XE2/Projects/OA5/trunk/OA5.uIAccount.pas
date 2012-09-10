unit OA5.uIAccount;

interface

uses
  OA5.uIPrivilegies;

type
  IAccount = interface
    ['{1D74197E-59C0-4A84-AAA2-BFFD74A84FA3}']
    function GetLogged: boolean;
    function GetFullname: string;
    function GetID: integer;
    function GetLogin: string;
    function GetPassword: string;
    function GetPhone: string;
    function GetPosition: string;
    function GetPrivilegies: IPrivilegies;
    procedure SetFullname(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetLogged(const Value: boolean);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetPosition(const Value: string);
    procedure SetPrivilegies(const Value: IPrivilegies);
    property Logged: boolean read GetLogged write SetLogged;
    property ID: integer read GetID write SetID;
    property Login: string read GetLogin write SetLogin;
    property Password: string read GetPassword write SetPassword;
    property Fullname: string read GetFullname write SetFullname;
    property Position: string read GetPosition write SetPosition;
    property Phone: string read GetPhone write SetPhone;
    property Privilegies: IPrivilegies read GetPrivilegies write SetPrivilegies;
  end;

implementation

end.
