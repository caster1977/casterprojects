unit Budgeting.Logic.Classes.Models.TBudgetItemTypeModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel;

type
  TBudgetItemTypeModel = class(TInterfacedObject, ICustomModel, IBudgetItemTypeModel)
  strict private
    FId: Integer;
    FName: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetName(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId: Integer; const AName: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TBudgetItemTypeModel.Create(const AId: Integer; const AName: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FActivity := AActivity;
end;

function TBudgetItemTypeModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TBudgetItemTypeModel.GetId(): Integer;
begin
  Result := FId;
end;

function TBudgetItemTypeModel.GetName(): string;
begin
  Result := FName;
end;

end.

