unit Budgeting.Logic.Classes.Models.TAccountingCenterModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IAccountingCenterModel;

type
  TAccountingCenterModel = class(TInterfacedObject, ICustomModel, IAccountingCenterModel)
  strict private
    FId: Integer;
    FCode: string;
    FName: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetName(): string;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;

  public
    constructor Create(const AId: Integer; const ACode, AName, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TAccountingCenterModel.Create(const AId: Integer; const ACode, AName, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FCode := ACode;
  FName := AName;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TAccountingCenterModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TAccountingCenterModel.GetDescription(): string;
begin
  Result := FDescription;
end;

function TAccountingCenterModel.GetCode(): string;
begin
  Result := FCode;
end;

function TAccountingCenterModel.GetId(): Integer;
begin
  Result := FId;
end;

function TAccountingCenterModel.GetName(): string;
begin
  Result := FName;
end;

end.
