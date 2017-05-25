unit Budgeting.Logic.Interfaces.Models.IActualBudgetModel;

interface

type
  IActualBudgetModel = interface
    ['{820D9CE4-7C36-43B2-92DB-C1B33DC5CC29}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetBudgetItemId(): Integer;
    property BudgetItemId: Integer read GetBudgetItemId;

    function GetAccountingCenterId(): Integer;
    property AccountingCenterId: Integer read GetAccountingCenterId;

    function GetCosignatoryId(): Integer;
    property CosignatoryId: Integer read GetCosignatoryId;

    function GetProductId(): Integer;
    property ProductId: Integer read GetProductId;

    function GetCurrencyId(): Integer;
    property CurrencyId: Integer read GetCurrencyId;

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
