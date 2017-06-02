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
    FSign: Boolean;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetName(): string;
    function GetSign(): Boolean;
    function GetActivity(): Boolean;

  public
    constructor Create(const AId: Integer; const AName: string; const ASign, AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TBudgetItemTypeModel.Create(const AId: Integer; const AName: string; const ASign, AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FSign := ASign;
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

function TBudgetItemTypeModel.GetSign(): Boolean;
begin
  Result := FSign;
end;

end.
