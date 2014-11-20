unit DBUServerService.uTSQLActions;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUServerService.uISQLActions,
  DBUServerService.uISQLAction;

type
  TSQLActions = class(TInterfaceListOfGivenType<ISQLAction>, ISQLActions)
  strict protected
    procedure Initialize; override;
  end;

function GetISQLActions: ISQLActions;

implementation

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить действие SQL в список.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить действие SQL из списка.';

function GetISQLActions: ISQLActions;
begin
  Result := TSQLActions.Create;
end;

procedure TSQLActions.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
