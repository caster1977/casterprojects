unit Budgeting.Logic.Classes.Models.TPlannedBudgetModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.IPlannedBudgetModel;

type
  TPlannedBudgetModel = class(TInterfacedObject, IPlannedBudgetModel)
  strict private
    FId: Integer;
    FBudgetItemId: Integer;
    FAccountingCenterId: Integer;
    FCurrencyId: Integer;
    FYear: Integer;
    FMonth: Integer;
    FAmount: Currency;
    function GetId(): Integer;
    function GetBudgetItemId(): Integer;
    function GetAccountingCenterId(): Integer;
    function GetCurrencyId(): Integer;
    function GetYear(): Integer;
    function GetMonth(): Integer;
    function GetAmount(): Currency;

  public
    constructor Create(const AId, ABudgetItemId, AAccountingCenterId, ACurrencyId, AYear, AMonth: Integer; const AAmount: Currency); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TPlannedBudgetModel.Create(const AId, ABudgetItemId, AAccountingCenterId, ACurrencyId, AYear, AMonth: Integer; const AAmount: Currency);

begin
  inherited Create();
  FId := AId;
  FBudgetItemId := ABudgetItemId;
  FAccountingCenterId := AAccountingCenterId;
  FCurrencyId := ACurrencyId;
  FYear := AYear;
  FMonth := AMonth;
  FAmount := AAmount;
end;

function TPlannedBudgetModel.GetAccountingCenterId(): Integer;
begin
  Result := FAccountingCenterId;
end;

function TPlannedBudgetModel.GetAmount(): Currency;
begin
  Result := FAmount;
end;

function TPlannedBudgetModel.GetBudgetItemId(): Integer;
begin
  Result := FBudgetItemId;
end;

function TPlannedBudgetModel.GetCurrencyId(): Integer;
begin
  Result := FCurrencyId;
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
