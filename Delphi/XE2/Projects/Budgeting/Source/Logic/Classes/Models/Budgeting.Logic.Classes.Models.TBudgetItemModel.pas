unit Budgeting.Logic.Classes.Models.TBudgetItemModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IBudgetItemModel;

type
  TBudgetItemModel = class(TInterfacedObject, ICustomModel, IBudgetItemModel)
  strict private
    FId: Integer;
    FId_BudgetItemType: Integer;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetId_BudgetItemType(): Integer;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;

  public
    constructor Create(const AId, AId_BudgetItemType: Integer; const ACode, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TBudgetItemModel.Create(const AId, AId_BudgetItemType: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FId_BudgetItemType := AId_BudgetItemType;
  FCode := ACode;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TBudgetItemModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TBudgetItemModel.GetDescription(): string;
begin
  Result := FDescription;
end;

function TBudgetItemModel.GetCode(): string;
begin
  Result := FCode;
end;

function TBudgetItemModel.GetId(): Integer;
begin
  Result := FId;
end;

function TBudgetItemModel.GetId_BudgetItemType(): Integer;
begin
  Result := FId_BudgetItemType;
end;

end.
