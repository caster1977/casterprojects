unit Budgeting.Logic.Interfaces.Models.IProductTypeModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IProductTypeModel = interface(ICustomModel)
    ['{6257A8D9-9A1D-4861-A4FC-C52D42E3C927}']
    function GetName(): string;
    property name: string read GetName;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
