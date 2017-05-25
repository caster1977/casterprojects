unit UE.Modules.FakeItemsManager.Logic.Classes.TFake;

interface

uses
  UE.Modules.FakeItemsManager.Logic.Interfaces.IFake;

type
  TFake = class(TInterfacedObject, IFake)
  strict private
    FCustomerId: Integer;
    FItemDomainId: Integer;
    FItemNo: string;
    FQuantity: Integer;
    function GetCustomerId(): Integer;
    function GetItemDomainId(): Integer;
    function GetItemNo(): string;
    function GetQuantity(): Integer;

  public
    constructor Create(const aCustomerId, aItemDomainId: Integer; const aItemNo: string; const aQuantity: Integer); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TFake.Create(const aCustomerId, aItemDomainId: Integer; const aItemNo: string; const aQuantity: Integer);
begin
  inherited Create();
  FCustomerId := aCustomerId;
  FItemDomainId := aItemDomainId;
  FItemNo := aItemNo.Trim();
  FQuantity := aQuantity;
end;

function TFake.GetCustomerId(): Integer;
begin
  Result := FCustomerId;
end;

function TFake.GetItemDomainId(): Integer;
begin
  Result := FItemDomainId;
end;

function TFake.GetItemNo(): string;
begin
  Result := FItemNo;
end;

function TFake.GetQuantity(): Integer;
begin
  Result := FQuantity;
end;

end.
