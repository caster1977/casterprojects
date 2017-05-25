unit Budgeting.Logic.Classes.TAccountingCenter;

interface

uses
  Budgeting.Logic.Interfaces.IAccountingCenter;

type
  TAccountingCenter = class(TInterfacedObject, IAccountingCenter)
  strict private
    FId: Integer;
    FName: string;
    FCode: string;
    FDescription: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetCode(): string;
    function GetName(): string;
    function GetDescription(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId: Integer; const ACode, AName, ADescription: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TAccountingCenter.Create(const AId: Integer; const ACode, AName, ADescription: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FCode := ACode;
  FName := AName;
  FDescription := ADescription;
  FActivity := AActivity;
end;

function TAccountingCenter.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TAccountingCenter.GetDescription(): string;
begin
  Result := FDescription;
end;

function TAccountingCenter.GetCode(): string;
begin
  Result := FCode;
end;

function TAccountingCenter.GetId(): Integer;
begin
  Result := FId;
end;

function TAccountingCenter.GetName(): string;
begin
  Result := FName;
end;

end.

