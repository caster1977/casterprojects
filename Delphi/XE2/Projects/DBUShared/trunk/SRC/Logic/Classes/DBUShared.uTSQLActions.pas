unit DBUShared.uTSQLActions;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uISQLActions,
  DBUShared.uISQLAction,
  System.Classes;

type
  TSQLActions = class(TInterfaceListOfGivenType<ISQLAction>, ISQLActions)
  strict protected
    procedure Initialize; override;
  end;

function GetISQLActions: ISQLActions; overload;
function GetISQLActions(const AList: TStrings; const ASeparators: array of string)
  : ISQLActions; overload;

implementation

uses
  DBUShared.uTSQLAction,
  CastersPackage.uRoutines;

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить действие SQL в список.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить действие SQL из списка.';

function GetISQLActions: ISQLActions;
begin
  Result := TSQLActions.Create;
end;

function GetISQLActions(const AList: TStrings; const ASeparators: array of string): ISQLActions;
var
  i: Integer;
  a: ISQLAction;
  sl: TStrings;
begin
  Assert(Length(ASeparators) > 0, 'Ќе указан ни один разделитель строк записей действий SQL');
  Result := GetISQLActions;

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
        a := GetISQLAction(sl[0], sl[1]);
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

procedure TSQLActions.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
