unit Budgeting.Logic.Classes.Models.TProductTypeModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.IProductTypeModel;

type
  TProductTypeModel = class(TInterfacedObject, IProductTypeModel)
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

constructor TProductTypeModel.Create(const AId: Integer; const AName: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FName := AName;
  FActivity := AActivity;
end;

function TProductTypeModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TProductTypeModel.GetId(): Integer;
begin
  Result := FId;
end;

function TProductTypeModel.GetName(): string;
begin
  Result := FName;
end;

end.

