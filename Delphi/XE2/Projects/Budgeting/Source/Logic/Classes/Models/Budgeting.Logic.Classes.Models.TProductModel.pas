unit Budgeting.Logic.Classes.Models.TProductModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.IProductModel;

type
  TProductModel = class(TInterfacedObject, IProductModel)
  strict private
    FId: Integer;
    FProductTypeId: Integer;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetProductTypeId(): Integer;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId, AProductTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TProductModel.Create(const AId, AProductTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FProductTypeId := AProductTypeId;
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

function TProductModel.GetProductTypeId(): Integer;
begin
  Result := FProductTypeId;
end;

end.

