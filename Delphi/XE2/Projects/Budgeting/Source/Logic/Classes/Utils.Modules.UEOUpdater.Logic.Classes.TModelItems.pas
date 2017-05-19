unit Utils.Modules.UEOUpdater.Logic.Classes.TModelItems;

interface

uses
  System.SysUtils, System.Generics.Collections, Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItems,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItem;

type
  TModelItems = class(TInterfacedObject, IModelItems)
  strict private
    FFileName: string;
    function GetFileName(): string;
    procedure SetFileName(const aValue: string);

  strict private
    FItems: TDictionary<string, TArray<IModelItem>>;
    function GetItems(): TDictionary<string, TArray<IModelItem>>;

  public
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

constructor TModelItems.Create;
begin
  inherited;
  FItems := TDictionary<string, TArray<IModelItem>>.Create();
end;

destructor TModelItems.Destroy;
begin
  try
    if Assigned(FItems) then
    begin
      FItems.Free();
    end;
  finally
    inherited;
  end;
end;

function TModelItems.GetFileName: string;
begin
  Result := FFileName;
end;

function TModelItems.GetItems: TDictionary<string, TArray<IModelItem>>;
begin
  Result := FItems;
end;

procedure TModelItems.SetFileName(const aValue: string);
var
  s: string;
begin
  s := aValue.Trim();
  if FFileName <> s then
  begin
    FFileName := s;
  end;
end;

end.
