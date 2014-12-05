unit DBUShared.uTUsers;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uIUsers,
  DBUShared.uIUser,
  System.Classes;

type
  TUsers = class(TInterfaceListOfGivenType<IUser>, IUsers)
  strict protected
    procedure Initialize; override;
  public
    function GetUserByLogin(const ALogin: string): IUser;
    function GetIndexByByLogin(const ALogin: string): Integer;
  end;

function GetIUsers: IUsers; overload;
function GetIUsers(const AList: TStrings; const ASeparators: array of string): IUsers; overload;

implementation

uses
  System.SysUtils,
  CastersPackage.uRoutines,
  DBUShared.uTUser;

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить пользовател€ в список.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить пользовател€ из списка.';

function GetIUsers: IUsers;
begin
  Result := TUsers.Create;
end;

function GetIUsers(const AList: TStrings; const ASeparators: array of string): IUsers;
var
  i: Integer;
  a: IUser;
  sl: TStrings;
begin
  Assert(Length(ASeparators) > 0, 'Ќе указан ни один разделитель строк записей пользователей');
  Result := GetIUsers;

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
      if sl.Count = 5 then
      begin
        a := GetIUser(sl[0], sl[1], sl[2], Boolean(StrToIntDef(sl[3], 1)),
          Boolean(StrToIntDef(sl[4], 0)));
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

function TUsers.GetIndexByByLogin(const ALogin: string): Integer;
var
  i: Integer;
  s: string;
begin
  Result := -1;
  s := Trim(ALogin);

  for i := 0 to Pred(Count) do
  begin
    if Assigned(Items[i]) then
    begin
      if Items[i].Login = s then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
end;

function TUsers.GetUserByLogin(const ALogin: string): IUser;
var
  i: Integer;
  s: string;
begin
  Result := nil;

  i := GetIndexByByLogin(ALogin);
  if i > -1 then
  begin
    Result := Items[i];
  end;
end;

procedure TUsers.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
