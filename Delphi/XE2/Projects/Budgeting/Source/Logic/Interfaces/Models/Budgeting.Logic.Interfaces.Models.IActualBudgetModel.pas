unit Budgeting.Logic.Interfaces.Models.IActualBudgetModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IActualBudgetModel = interface(ICustomModel)
    ['{820D9CE4-7C36-43B2-92DB-C1B33DC5CC29}']
    function GetId_BudgetItem(): Integer;
    property Id_BudgetItem: Integer read GetId_BudgetItem;

    function GetId_AccountingCenter(): Integer;
    property Id_AccountingCenter: Integer read GetId_AccountingCenter;

    function GetId_Cosignatory(): Integer;
    property Id_Cosignatory: Integer read GetId_Cosignatory;

    function GetId_Product(): Integer;
    property Id_Product: Integer read GetId_Product;

    function GetId_Currency(): Integer;
    property Id_Currency: Integer read GetId_Currency;

    function GetDocument(): string;
    property Document: string read GetDocument;

    function GetDocumentDate(): TDate;
    property DocumentDate: TDate read GetDocumentDate;

    function GetDescription(): string;
    property Description: string read GetDescription;

    function GetAmount(): Currency;
    property Amount: Currency read GetAmount;
  end;

implementation

end.
