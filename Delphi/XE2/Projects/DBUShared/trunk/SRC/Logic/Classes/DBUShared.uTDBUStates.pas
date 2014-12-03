unit DBUShared.uTDBUStates;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uIDBUStates,
  DBUShared.uIDBUState;

type
  TDBUStates = class(TInterfaceListOfGivenType<IDBUState>, IDBUStates)
  strict protected
    procedure Initialize; override;
  end;

function GetIDBUStates: IDBUStates;

implementation

resourcestring
  RsCantAddItemToList = '�� ������� �������� ��������� DBU � ������.';
  RsCantRemoveItemFromList = '�� ������� ������� ��������� DBU �� ������.';

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
