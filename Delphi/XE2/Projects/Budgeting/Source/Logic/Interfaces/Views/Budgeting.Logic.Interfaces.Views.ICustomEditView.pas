unit Budgeting.Logic.Interfaces.Views.ICustomEditView;

interface

uses
  Budgeting.Logic.Interfaces.Views.ICustomView;

type
  ICustomEditView = interface(ICustomView)
    ['{3D134B0D-264C-45A0-A572-52ADC19DECD7}']
    function GetItem(): IInterface;
    procedure SetItem(const aValue: IInterface);
    property Item: IInterface read GetItem write SetItem;

    function ShowModal(): Integer;
  end;

implementation

end.
