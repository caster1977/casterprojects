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
  RsCantAddItemToList = '�� ������� �������� ������ � ���.';
  RsCantRemoveItemFromList = '�� ������� ������� ������ �� ����.';

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
