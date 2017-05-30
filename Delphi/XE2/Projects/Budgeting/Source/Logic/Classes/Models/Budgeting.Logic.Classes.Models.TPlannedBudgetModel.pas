unit Budgeting.Logic.Classes.Models.TPlannedBudgetModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel;

type
  TPlannedBudgetModel = class(TInterfacedObject, ICustomModel, IPlannedBudgetModel)
  strict private
    FId: Integer;
    FId_BudgetItem: Integer;
    FId_AccountingCenter: Integer;
    FId_Currency: Integer;
    FYear: Integer;
    FMonth: Integer;
    FAmount: Currency;
    function GetId(): Integer;
    function GetId_BudgetItem(): Integer;
    function GetId_AccountingCenter(): Integer;
    function GetId_Currency(): Integer;
    function GetYear(): Integer;
    function GetMonth(): Integer;
    function GetAmount(): Currency;

  public
    constructor Create(const AId, AId_BudgetItem, AId_AccountingCenter, AId_Currency, AYear, AMonth: Integer; const AAmount: Currency); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TPlannedBudgetModel.Create(const AId, AId_BudgetItem, AId_AccountingCenter, AId_Currency, AYear, AMonth: Integer; const AAmount: Currency);

begin
  inherited Create();
  FId := AId;
  FId_BudgetItem := AId_BudgetItem;
  FId_AccountingCenter := AId_AccountingCenter;
  FId_Currency := AId_Currency;
  FYear := AYear;
  FMonth := AMonth;
  FAmount := AAmount;
end;

function TPlannedBudgetModel.GetId_AccountingCenter(): Integer;
begin
  Result := FId_AccountingCenter;
end;

function TPlannedBudgetModel.GetAmount(): Currency;
begin
  Result := FAmount;
end;

function TPlannedBudgetModel.GetId_BudgetItem(): Integer;
begin
  Result := FId_BudgetItem;
end;

function TPlannedBudgetModel.GetId_Currency(): Integer;
begin
  Result := FId_Currency;
end;

function TPlannedBudgetModel.GetYear(): Integer;
begin
  Result := FYear;
end;

function TPlannedBudgetModel.GetMonth(): Integer;
begin
  Result := FMonth;
end;

function TPlannedBudgetModel.GetId(): Integer;
begin
  Result := FId;
end;

end.
