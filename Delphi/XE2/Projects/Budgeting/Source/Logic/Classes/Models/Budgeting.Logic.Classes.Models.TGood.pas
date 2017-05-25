unit Budgeting.Logic.Classes.Models.TGood;

interface

uses
  Budgeting.Logic.Interfaces.IGood;

type
  TGood = class(TInterfacedObject, IGood)
  strict private
    FId: Integer;
    FGoodsTypeId: Integer;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetGoodsTypeId(): Integer;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId, AGoodsTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TGood.Create(const AId, AGoodsTypeId: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FGoodsTypeId := AGoodsTypeId;
  FCode := ACode;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TGood.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TGood.GetDescription(): string;
begin
  Result := FDescription;
end;

function TGood.GetCode(): string;
begin
  Result := FCode;
end;

function TGood.GetId(): Integer;
begin
  Result := FId;
end;

function TGood.GetGoodsTypeId(): Integer;
begin
  Result := FGoodsTypeId;
end;

end.

