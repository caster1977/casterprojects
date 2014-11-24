unit DBUServerService.uTDBUServerLogRecords;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUServerService.uIDBUServerLogRecords,
  DBUServerService.uIDBUServerLogRecord;

type
  TDBUServerLogRecords = class(TInterfaceListOfGivenType<IDBUServerLogRecord>, IDBUServerLogRecords)
  strict protected
    procedure Initialize; override;
  end;

function GetIDBUServerLogRecords: IDBUServerLogRecords;

implementation

resourcestring
  RsCantAddItemToList = 'Не удалось добавить запись в лог.';
  RsCantRemoveItemFromList = 'Не удалось удалить запись из лога.';

function GetIDBUServerLogRecords: IDBUServerLogRecords;
begin
  Result := TDBUServerLogRecords.Create;
end;

procedure TDBUServerLogRecords.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
