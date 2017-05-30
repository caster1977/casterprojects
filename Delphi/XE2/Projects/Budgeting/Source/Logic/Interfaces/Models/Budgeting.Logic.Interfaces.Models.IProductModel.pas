unit Budgeting.Logic.Interfaces.Models.IProductModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IProductModel = interface(ICustomModel)
    ['{962BA86A-228A-4695-942E-BA02AEC90137}']
    function GetId_ProductType(): Integer;
    property Id_ProductType: Integer read GetId_ProductType;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
