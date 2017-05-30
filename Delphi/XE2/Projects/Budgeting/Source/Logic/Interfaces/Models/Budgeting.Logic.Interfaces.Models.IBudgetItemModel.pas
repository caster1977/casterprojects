unit Budgeting.Logic.Interfaces.Models.IBudgetItemModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IBudgetItemModel = interface(ICustomModel)
    ['{BF8C7C0F-39E6-4A83-8746-4BC2DEC9C3DC}']
    function GetId_BudgetItemType(): Integer;
    property Id_BudgetItemType: Integer read GetId_BudgetItemType;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
