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
function GetISQLActions(const AList: TStrings; const ASeparator: string = ':')
  : ISQLActions; overload;

implementation

uses
  DBUShared.uTSQLAction;

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить действие SQL в список.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить действие SQL из списка.';

function GetISQLActions: ISQLActions;
begin
  Result := TSQLActions.Create;
end;

function GetISQLActions(const AList: TStrings; const ASeparator: string): ISQLActions;
var
  i: Integer;
  j: Integer;
  a: ISQLAction;
  sl: TStrings;
  s: string;
  s1: string;
begin
  Assert(Length(ASeparator) > 0, 'Ќе указан разделитель строк записей действий SQL');
  Result := GetISQLActions;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  if not Assigned(AList) then
  begin
    Exit;
  end;

  sl := TStringList.Create;
  try
    for i := 0 to Pred(AList.Count) do
    begin
      sl.Clear;
      s := AList[i];
      while Length(s) > 0 do
      begin
        j := Pos(ASeparator, s);
        if j = 0 then
        begin
          sl.Append(s);
          Break;
        end
        else
        begin
          s1 := Copy(s, 0, Pred(j));
          sl.Append(s1);
          s1 := Copy(s, j + Length(ASeparator), Length(s));
          s := s1;
        end;
      end;
      if sl.Count = 2 then
      begin
        a := GetISQLAction(sl[0], sl[1]);
        if Assigned(a) then
        begin
          Result.Add(a);
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TSQLActions.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
