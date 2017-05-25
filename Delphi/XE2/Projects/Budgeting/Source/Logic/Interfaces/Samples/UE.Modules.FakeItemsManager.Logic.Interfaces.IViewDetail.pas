unit UE.Modules.FakeItemsManager.Logic.Interfaces.IViewDetail;

interface

uses
  UE.Modules.FakeItemsManager.Logic.Interfaces.IView,
  System.Classes,
  System.Generics.Collections;

type
  IViewDetail = interface(IView)
    ['{F2DFF6A8-2595-486D-BBD4-8D1359FB37E0}']
    procedure SetCustomers(const aValue: TStringList);
    property Customers: TStringList write SetCustomers;

    procedure SetDomains(const aValue: TStringList);
    property Domains: TStringList write SetDomains;

    procedure SetItems(const aValue: TStringList);
    property Items: TStringList write SetItems;

    function GetItem(): IInterface;
    procedure SetItem(const aValue: IInterface);
    property Item: IInterface read GetItem write SetItem;
  end;

implementation

end.
