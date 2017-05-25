unit Budgeting.Logic.Classes.Models.TBudgetItem;

interface

uses
  Budgeting.Logic.Interfaces.IBudgetItem;

type
  TBudgetItem = class(TInterfacedObject, IBudgetItem)
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

constructor TBudgetItem.Create(const AId, ABudgetItemTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FBudgetItemTypeId := ABudgetItemTypeId;
  FCode := ACode;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TBudgetItem.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TBudgetItem.GetDescription(): string;
begin
  Result := FDescription;
end;

function TBudgetItem.GetCode(): string;
begin
  Result := FCode;
end;

function TBudgetItem.GetId(): Integer;
begin
  Result := FId;
end;

function TBudgetItem.GetBudgetItemTypeId(): Integer;
begin
  Result := FBudgetItemTypeId;
end;

end.

