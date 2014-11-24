unit DBUServerService.uTDBUStates;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUServerService.uIDBUStates,
  DBUServerService.uIDBUState;

type
  TDBUStates = class(TInterfaceListOfGivenType<IDBUState>, IDBUStates)
  strict protected
    procedure Initialize; override;
  end;

function GetIDBUStates: IDBUStates;

implementation

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить состо€ние DBU в список.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить состо€ние DBU из списка.';

function GetIDBUStates: IDBUStates;
begin
  Result := TDBUStates.Create;
end;

procedure TDBUStates.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
