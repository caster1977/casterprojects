unit Budgeting.Logic.Interfaces.Views.IBank;

interface

uses
  Budgeting.Logic.Interfaces.View.ICustomView,
  Data.DB,
  System.Generics.Collections;

type
  IBank = interface(ICustomView)
    ['{3DF049C9-9F77-4FB2-96C5-26747A3936AB}']
    function GetItem(): IInterface;
    procedure SetItem(const aValue: IInterface);
    property Item: IInterface read GetItem write SetItem;
  end;

implementation

end.
