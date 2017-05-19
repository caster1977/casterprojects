unit Budgeting.Logic.Interfaces.IModelItems;

interface

uses
  System.SysUtils, System.Generics.Collections, Budgeting.Logic.Interfaces.IModelItem;

type
  IModelItems = interface
    ['{04D73072-F188-45CF-85F5-8933B6D67941}']
    function GetFileName(): string;
    procedure SetFileName(const aValue: string);
    property FileName: string read GetFileName write SetFileName;

    function GetItems(): TDictionary<string, TArray<IModelItem>>;
    property Items: TDictionary<string, TArray<IModelItem>> read GetItems;
  end;

implementation

end.
