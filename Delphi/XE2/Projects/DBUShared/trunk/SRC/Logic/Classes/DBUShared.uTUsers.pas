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
  end;

function GetIUsers: IUsers; overload;
function GetIUsers(const AList: TStrings; const ASeparators: array of string): IUsers; overload;

implementation

uses
  System.SysUtils,
  CastersPackage.uRoutines,
  DBUShared.uTUser;

resourcestring
  RsCantAddItemToList = '�� ������� �������� ������������ � ������.';
  RsCantRemoveItemFromList = '�� ������� ������� ������������ �� ������.';

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
  Assert(Length(ASeparators) > 0, '�� ������ �� ���� ����������� ����� ������� �������������');
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

procedure TUsers.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
