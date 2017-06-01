unit Budgeting.Logic.Classes.Models.TActualBudgetModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IActualBudgetModel;

type
  TActualBudgetModel = class(TInterfacedObject, ICustomModel, IActualBudgetModel)
  strict private
    FId: Integer;
    FId_BudgetItem: Integer;
    FId_AccountingCenter: Integer;
    FId_Cosignatory: Integer;
    FId_Product: Integer;
    FId_Currency: Integer;
    FDocument: string;
    FDocumentDate: TDate;
    FDescription: string;
    FAmount: Currency;
//    FCurrentBudgetItemType: Integer;
    function GetId(): Integer;
    function GetId_BudgetItem(): Integer;
    function GetId_AccountingCenter(): Integer;
    function GetId_Cosignatory(): Integer;
    function GetId_Product(): Integer;
    function GetId_Currency(): Integer;
    function GetDocument(): string;
    function GetDocumentDate(): TDate;
    function GetDescription(): string;
    function GetAmount(): Currency;
//    function GetCurrentBudgetItemType(): Integer;

  public
    constructor Create(const AId, AId_BudgetItem, AId_AccountingCenter, AId_Cosignatory, AId_Product, AId_Currency: Integer; const ADocument: string; const ADocumentDate: TDate; const ADescription: string;
    const AAmount: Currency{; const aCurrentBudgetItemType: Integer}); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TActualBudgetModel.Create(const AId, AId_BudgetItem, AId_AccountingCenter, AId_Cosignatory, AId_Product, AId_Currency: Integer; const ADocument: string; const ADocumentDate: TDate; const ADescription: string;
  const AAmount: Currency{; const aCurrentBudgetItemType: Integer});

begin
  inherited Create();
  FId := AId;
  FId_BudgetItem := AId_BudgetItem;
  FId_AccountingCenter := AId_AccountingCenter;
  FId_Cosignatory := AId_Cosignatory;
  FId_Product := AId_Product;
  FId_Currency := AId_Currency;
  FDocument := ADocument;
  FDocumentDate := ADocumentDate;
  FDescription := ADescription;
  FAmount := AAmount;
//  FCurrentBudgetItemType := aCurrentBudgetItemType;
end;

function TActualBudgetModel.GetId_AccountingCenter(): Integer;
begin
  Result := FId_AccountingCenter;
end;

function TActualBudgetModel.GetAmount(): Currency;
begin
  Result := FAmount;
end;

//function TActualBudgetModel.GetCurrentBudgetItemType(): Integer;
//begin
//  Result := FCurrentBudgetItemType;
//end;

function TActualBudgetModel.GetId_BudgetItem(): Integer;
begin
  Result := FId_BudgetItem;
end;

function TActualBudgetModel.GetId_Cosignatory(): Integer;
begin
  Result := FId_Cosignatory;
end;

function TActualBudgetModel.GetId_Currency(): Integer;
begin
  Result := FId_Currency;
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

function TActualBudgetModel.GetId_Product(): Integer;
begin
  Result := FId_Product;
end;

end.
