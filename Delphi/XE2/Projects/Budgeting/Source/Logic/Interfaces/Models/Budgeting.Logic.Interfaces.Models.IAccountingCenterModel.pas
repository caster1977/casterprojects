unit Budgeting.Logic.Interfaces.Models.IAccountingCenterModel;

interface

type
  IAccountingCenterModel = interface
    ['{572B3403-5775-4337-B439-0E32D7916CF9}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetName(): string;
    property Name: string read GetName;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
