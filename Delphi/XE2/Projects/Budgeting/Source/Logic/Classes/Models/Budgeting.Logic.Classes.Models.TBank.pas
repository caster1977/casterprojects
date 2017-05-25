unit Budgeting.Logic.Classes.Models.TBank;

interface

uses
  Budgeting.Logic.Interfaces.IBank;

type
  TBank = class(TInterfacedObject, IBank)
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

constructor TBank.Create(const AId: Integer; const AName, ACode, AAddress: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FCode := ACode;
  FAddress := AAddress;
  FActivity := AActivity;
end;

function TBank.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TBank.GetAddress(): string;
begin
  Result := FAddress;
end;

function TBank.GetCode(): string;
begin
  Result := FCode;
end;

function TBank.GetId(): Integer;
begin
  Result := FId;
end;

function TBank.GetName(): string;
begin
  Result := FName;
end;

end.

