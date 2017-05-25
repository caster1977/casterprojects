unit Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel;

interface

type
  IPlannedBudgetModel = interface
    ['{4C19D77A-AD0C-4D9C-B59D-16D514E17212}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetBudgetItemId(): Integer;
    property BudgetItemId: Integer read GetBudgetItemId;

    function GetAccountingCenterId(): Integer;
    property AccountingCenterId: Integer read GetAccountingCenterId;

    function GetCurrencyId(): Integer;
    property CurrencyId: Integer read GetCurrencyId;

    function GetYear(): Integer;
    property Year: Integer read GetYear;

    function GetMonth(): Integer;
    property Month: Integer read GetMonth;

    function GetAmount(): Currency;
    property Amount: Currency read GetAmount;
  end;

implementation

end.
