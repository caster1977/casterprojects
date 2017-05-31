unit Budgeting.Logic.Interfaces.Models.IAccountingCenterModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IAccountingCenterModel = interface(ICustomModel)
    ['{572B3403-5775-4337-B439-0E32D7916CF9}']
    function GetCode(): string;
    property Code: string read GetCode;

    function GetName(): string;
    property name: string read GetName;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
