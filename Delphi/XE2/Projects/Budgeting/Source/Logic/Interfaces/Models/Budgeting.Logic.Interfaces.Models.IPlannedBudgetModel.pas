unit Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  IPlannedBudgetModel = interface(ICustomModel)
    ['{4C19D77A-AD0C-4D9C-B59D-16D514E17212}']
    function GetId_BudgetItem(): Integer;
    property Id_BudgetItem: Integer read GetId_BudgetItem;

    function GetId_AccountingCenter(): Integer;
    property Id_AccountingCenter: Integer read GetId_AccountingCenter;

    function GetId_Currency(): Integer;
    property Id_Currency: Integer read GetId_Currency;

    function GetYear(): Integer;
    property Year: Integer read GetYear;

    function GetMonth(): Integer;
    property Month: Integer read GetMonth;

    function GetAmount(): Currency;
    property Amount: Currency read GetAmount;
  end;

implementation

end.
