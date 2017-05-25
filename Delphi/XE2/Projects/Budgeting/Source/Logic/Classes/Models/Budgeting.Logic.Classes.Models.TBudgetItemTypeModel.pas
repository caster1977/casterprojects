unit Budgeting.Logic.Classes.Models.TBudgetItemTypeModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.IBudgetItemTypeModel;

type
  TBudgetItemType = class(TInterfacedObject, IBudgetItemTypeModel)
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

constructor TBudgetItemType.Create(const AId: Integer; const AName: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FActivity := AActivity;
end;

function TBudgetItemType.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TBudgetItemType.GetId(): Integer;
begin
  Result := FId;
end;

function TBudgetItemType.GetName(): string;
begin
  Result := FName;
end;

end.

