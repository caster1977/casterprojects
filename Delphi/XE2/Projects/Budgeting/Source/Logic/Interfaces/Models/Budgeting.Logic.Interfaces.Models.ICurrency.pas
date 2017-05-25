unit Budgeting.Logic.Interfaces.Models.ICurrency;

interface

type
  ICurrency = interface
    ['{F1A5F7C4-C26D-4893-8B79-76EC505F8DFF}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
