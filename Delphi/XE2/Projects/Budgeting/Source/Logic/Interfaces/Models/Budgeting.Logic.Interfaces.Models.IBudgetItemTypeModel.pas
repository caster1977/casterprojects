unit Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IBudgetItemTypeModel = interface(ICustomModel)
    ['{20882139-1059-4A72-8158-23BEB10FCF91}']
    function GetName(): string;
    property name: string read GetName;

    function GetSign(): Boolean;
    property Sign: Boolean read GetSign;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
