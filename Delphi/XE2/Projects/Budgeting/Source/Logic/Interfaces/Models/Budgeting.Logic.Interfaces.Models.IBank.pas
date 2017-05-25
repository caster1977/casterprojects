unit Budgeting.Logic.Interfaces.Models.IBank;

interface

type
  IBank = interface
    ['{A9DC8C39-E9DA-48BD-A17E-347217AE614F}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetName(): string;
    property Name: string read GetName;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetAddress(): string;
    property Address: string read GetAddress;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
