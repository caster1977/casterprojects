unit Budgeting.Logic.Classes.Models.TBankModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IBankModel;

type
  TBankModel = class(TInterfacedObject, ICustomModel, IBankModel)
  strict private
    FId: Integer;
    FName: string;
    FCode: string;
    FAddress: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetName(): string;
    function GetCode(): string;
    function GetAddress(): string;
    function GetActivity(): Boolean;

  public
    constructor Create(const AId: Integer; const AName, ACode, AAddress: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TBankModel.Create(const AId: Integer; const AName, ACode, AAddress: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FCode := ACode;
  FAddress := AAddress;
  FActivity := AActivity;
end;

function TBankModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TBankModel.GetAddress(): string;
begin
  Result := FAddress;
end;

function TBankModel.GetCode(): string;
begin
  Result := FCode;
end;

function TBankModel.GetId(): Integer;
begin
  Result := FId;
end;

function TBankModel.GetName(): string;
begin
  Result := FName;
end;

end.
