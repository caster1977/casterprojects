unit Budgeting.Logic.Interfaces.Models.IBudgetItemModel;

interface

type
  IBudgetItemModel = interface
    ['{6155AE97-D425-48F7-B2EA-04C7017E57A9}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetBudgetItemTypeId(): Integer;
    property BudgetItemTypeId: Integer read GetBudgetItemTypeId;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
