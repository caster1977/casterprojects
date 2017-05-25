unit Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel;

interface

type
  IBudgetItemTypeModel = interface
    ['{20882139-1059-4A72-8158-23BEB10FCF91}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetName(): string;
    property Name: string read GetName;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
