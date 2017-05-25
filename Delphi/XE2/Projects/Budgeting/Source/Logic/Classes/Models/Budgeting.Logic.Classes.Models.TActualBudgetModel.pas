unit Budgeting.Logic.Classes.Models.TActualBudgetModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.IActualBudgetModel;

type
  TActualBudgetModel = class(TInterfacedObject, IActualBudgetModel)
  strict private
    FId: Integer;
    FBudgetItemId: Integer;
    FAccountingCenterId: Integer;
    FCosignatoryId: Integer;
    FProductId: Integer;
    FCurrencyId: Integer;
    FDocument: string;
    FDocumentDate: TDate;
    FDescription: string;
    FAmount: Currency;
    function GetId(): Integer;
    function GetBudgetItemId(): Integer;
    function GetAccountingCenterId(): Integer;
    function GetCosignatoryId(): Integer;
    function GetProductId(): Integer;
    function GetCurrencyId(): Integer;
    function GetDocument(): string;
    function GetDocumentDate(): TDate;
    function GetDescription(): string;
    function GetAmount(): Currency;

  public
    constructor Create(const AId, ABudgetItemId, AAccountingCenterId, ACosignatoryId, AProductId, ACurrencyId: Integer; const ADocument: string;
      const ADocumentDate: TDate; const ADescription: string; const AAmount: Currency); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TActualBudgetModel.Create(const AId, ABudgetItemId, AAccountingCenterId, ACosignatoryId, AProductId, ACurrencyId: Integer; const ADocument: string;
  const ADocumentDate: TDate; const ADescription: string; const AAmount: Currency);

begin
  inherited Create();
  FId := AId;
  FBudgetItemId := ABudgetItemId;
  FAccountingCenterId := AAccountingCenterId;
  FCosignatoryId := ACosignatoryId;
  FProductId := AProductId;
  FCurrencyId := ACurrencyId;
  FDocument := ADocument;
  FDocumentDate := ADocumentDate;
  FDescription := ADescription;
  FAmount := AAmount;
end;

function TActualBudgetModel.GetAccountingCenterId(): Integer;
begin
  Result := FAccountingCenterId;
end;

function TActualBudgetModel.GetAmount(): Currency;
begin
  Result := FAmount;
end;

function TActualBudgetModel.GetBudgetItemId(): Integer;
begin
  Result := FBudgetItemId;
end;

function TActualBudgetModel.GetCosignatoryId(): Integer;
begin
  Result := FCosignatoryId;
end;

function TActualBudgetModel.GetCurrencyId(): Integer;
begin
  Result := FCurrencyId;
end;

function TActualBudgetModel.GetDescription(): string;
begin
  Result := FDescription;
end;

function TActualBudgetModel.GetDocument(): string;
begin
  Result := FDocument;
end;

function TActualBudgetModel.GetDocumentDate(): TDate;
begin
  Result := FDocumentDate;
end;

function TActualBudgetModel.GetId(): Integer;
begin
  Result := FId;
end;

function TActualBudgetModel.GetProductId(): Integer;
begin
  Result := FProductId;
end;

end.
