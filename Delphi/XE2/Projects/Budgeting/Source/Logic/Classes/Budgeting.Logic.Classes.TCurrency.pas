unit Budgeting.Logic.Classes.TCurrency;

interface

uses
  Budgeting.Logic.Interfaces.ICurrency;

type
  TCurrency = class(TInterfacedObject, ICurrency)
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

constructor TCurrency.Create(const AId: Integer; const ACode, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FCode := ACode;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TCurrency.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TCurrency.GetDescription(): string;
begin
  Result := FDescription;
end;

function TCurrency.GetCode(): string;
begin
  Result := FCode;
end;

function TCurrency.GetId(): Integer;
begin
  Result := FId;
end;

end.

