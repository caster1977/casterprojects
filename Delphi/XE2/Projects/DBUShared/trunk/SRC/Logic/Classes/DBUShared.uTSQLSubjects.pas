unit DBUShared.uTSQLSubjects;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uISQLSubjects,
  DBUShared.uISQLSubject,
  System.Classes;

type
  TSQLSubjects = class(TInterfaceListOfGivenType<ISQLSubject>, ISQLSubjects)
  strict protected
    procedure Initialize; override;
  end;

function GetISQLSubjects: ISQLSubjects; overload;
function GetISQLSubjects(const AList: TStrings; const ASeparators: array of string)
  : ISQLSubjects; overload;

implementation

uses
  System.SysUtils,
  CastersPackage.uRoutines,
  DBUShared.uTSQLSubject;

resourcestring
  RsCantAddItemToList = 'Не удалось добавить объект SQL в список.';
  RsCantRemoveItemFromList = 'Не удалось удалить объект SQL из списка.';

function GetISQLSubjects: ISQLSubjects;
begin
  Result := TSQLSubjects.Create;
end;

function GetISQLSubjects(const AList: TStrings; const ASeparators: array of string): ISQLSubjects;
var
  i: Integer;
  a: ISQLSubject;
  sl: TStrings;
begin
  Assert(Length(ASeparators) > 0, 'Не указан ни один разделитель строк записей объектов SQL');
  Result := GetISQLSubjects;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  if not Assigned(AList) then
  begin
    Exit;
  end;

  for i := 0 to Pred(AList.Count) do
  begin
    sl := Routines.Explode(AList[i], ASeparators);
    try
      if sl.Count = 2 then
      begin
        a := GetISQLSubject(sl[0], sl[1]);
        if Assigned(a) then
        begin
          Result.Add(a);
        end;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TSQLSubjects.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
