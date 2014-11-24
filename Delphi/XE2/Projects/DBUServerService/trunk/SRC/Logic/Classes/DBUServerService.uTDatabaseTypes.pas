unit DBUServerService.uTDatabaseTypes;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUServerService.uIDatabaseTypes,
  DBUServerService.uIDatabaseType;

type
  TDatabaseTypes = class(TInterfaceListOfGivenType<IDatabaseType>, IDatabaseTypes)
  strict protected
    procedure Initialize; override;
  public
    function GetItemByName(const AName: string): IDatabaseType;
  end;

function GetIDatabaseTypes: IDatabaseTypes;

implementation

uses
  System.SysUtils;

resourcestring
  RsCantAddItemToList = 'Не удалось добавить тип БД в список.';
  RsCantRemoveItemFromList = 'Не удалось удалить тип БД из списка.';

function GetIDatabaseTypes: IDatabaseTypes;
begin
  Result := TDatabaseTypes.Create;
end;

function TDatabaseTypes.GetItemByName(const AName: string): IDatabaseType;
var
  i: Integer;
  s: string;
begin
  Result := nil;
  s := Trim(AName);
  for i := 0 to Pred(Count) do
  begin
    if Assigned(Items[i]) then
    begin
      if Items[i].Name = s then
      begin
        Result := Items[i];
        Exit;
      end;
    end;
  end;
end;

procedure TDatabaseTypes.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
