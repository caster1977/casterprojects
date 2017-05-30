unit Budgeting.Logic.Classes.Models.TProductModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel,
  Budgeting.Logic.Interfaces.Models.IProductModel;

type
  TProductModel = class(TInterfacedObject, ICustomModel, IProductModel)
  strict private
    FId: Integer;
    FId_ProductType: Integer;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetId_ProductType(): Integer;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId, AId_ProductType: Integer; const ACode, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TProductModel.Create(const AId, AId_ProductType: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FId_ProductType := AId_ProductType;
  FCode := ACode;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TProductModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TProductModel.GetDescription(): string;
begin
  Result := FDescription;
end;

function TProductModel.GetCode(): string;
begin
  Result := FCode;
end;

function TProductModel.GetId(): Integer;
begin
  Result := FId;
end;

function TProductModel.GetId_ProductType(): Integer;
begin
  Result := FId_ProductType;
end;

end.

