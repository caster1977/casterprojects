unit Budgeting.Logic.Classes.Models.TCurrencyModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICurrencyModel;

type
  TCurrencyModel = class(TInterfacedObject, ICurrencyModel)
  strict private
    FId: Integer;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetCode(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId: Integer; const ACode, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TCurrencyModel.Create(const AId: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FCode := ACode;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TCurrencyModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TCurrencyModel.GetDescription(): string;
begin
  Result := FDescription;
end;

function TCurrencyModel.GetCode(): string;
begin
  Result := FCode;
end;

function TCurrencyModel.GetId(): Integer;
begin
  Result := FId;
end;

end.

