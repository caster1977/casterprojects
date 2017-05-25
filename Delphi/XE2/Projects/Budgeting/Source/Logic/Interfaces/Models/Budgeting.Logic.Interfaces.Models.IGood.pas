unit Budgeting.Logic.Interfaces.Models.IGood;

interface

type
  IGood = interface
    ['{962BA86A-228A-4695-942E-BA02AEC90137}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetGoodsTypeId(): Integer;
    property GoodsTypeId: Integer read GetGoodsTypeId;

    function GetCode(): string;
    property Code: string read GetCode;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
