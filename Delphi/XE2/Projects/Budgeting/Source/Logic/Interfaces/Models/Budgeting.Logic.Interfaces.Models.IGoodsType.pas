unit Budgeting.Logic.Interfaces.Models.IGoodsType;

interface

type
  IGoodsType = interface
    ['{6257A8D9-9A1D-4861-A4FC-C52D42E3C927}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetName(): string;
    property Name: string read GetName;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
