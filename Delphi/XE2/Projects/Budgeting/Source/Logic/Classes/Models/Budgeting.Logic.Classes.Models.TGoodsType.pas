unit Budgeting.Logic.Classes.Models.TGoodsType;

interface

uses
  Budgeting.Logic.Interfaces.IGoodsType;

type
  TGoodsType = class(TInterfacedObject, IGoodsType)
  strict private
    FId: Integer;
    FName: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetName(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId: Integer; const AName: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TGoodsType.Create(const AId: Integer; const AName: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FActivity := AActivity;
end;

function TGoodsType.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TGoodsType.GetId(): Integer;
begin
  Result := FId;
end;

function TGoodsType.GetName(): string;
begin
  Result := FName;
end;

end.

