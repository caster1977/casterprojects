unit DBUShared.uTSQLSubjects;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uISQLSubjects,
  DBUShared.uISQLSubject;

type
  TSQLSubjects = class(TInterfaceListOfGivenType<ISQLSubject>, ISQLSubjects)
  strict protected
    procedure Initialize; override;
  end;

function GetISQLSubjects: ISQLSubjects;

implementation

resourcestring
  RsCantAddItemToList = 'Не удалось добавить объект SQL в список.';
  RsCantRemoveItemFromList = 'Не удалось удалить объект SQL из списка.';

function GetISQLSubjects: ISQLSubjects;
begin
  Result := TSQLSubjects.Create;
end;

procedure TSQLSubjects.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
