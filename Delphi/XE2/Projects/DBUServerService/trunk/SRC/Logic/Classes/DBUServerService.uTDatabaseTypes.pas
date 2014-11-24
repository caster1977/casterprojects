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
  end;

function GetIDatabaseTypes: IDatabaseTypes;

implementation

resourcestring
  RsCantAddItemToList = 'Не удалось добавить тип БД в список.';
  RsCantRemoveItemFromList = 'Не удалось удалить тип БД из списка.';

function GetIDatabaseTypes: IDatabaseTypes;
begin
  Result := TDatabaseTypes.Create;
end;

procedure TDatabaseTypes.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
