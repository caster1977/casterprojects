unit Budgeting.Logic.Classes.Models.TBudgetItemModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.IBudgetItemModel;

type
  TBudgetItemModel = class(TInterfacedObject, IBudgetItemModel)
  strict private
    FId: Integer;
    FBudgetItemTypeId: Integer;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetBudgetItemTypeId(): Integer;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId, ABudgetItemTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TBudgetItemModel.Create(const AId, ABudgetItemTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FBudgetItemTypeId := ABudgetItemTypeId;
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

function TBudgetItemModel.GetBudgetItemTypeId(): Integer;
begin
  Result := FBudgetItemTypeId;
end;

end.

