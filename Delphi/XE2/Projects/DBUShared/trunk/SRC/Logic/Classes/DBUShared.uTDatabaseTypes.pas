unit DBUShared.uTDatabaseTypes;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uIDatabaseTypes,
  DBUShared.uIDatabaseType,
  System.Classes,
  Vcl.Controls;

type
  TDatabaseTypes = class(TInterfaceListOfGivenType<IDatabaseType>, IDatabaseTypes)
  strict protected
    procedure Initialize; override;
  public
    function GetItemByName(const AName: string): IDatabaseType;
  end;

function GetIDatabaseTypes: IDatabaseTypes; overload;
function GetIDatabaseTypes(const AList: TStrings; const ASeparators: array of string): IDatabaseTypes; overload;

implementation

uses
  System.SysUtils,
  CastersPackage.uRoutines,
  DBUShared.uTDatabaseType;

resourcestring
  RsCantAddItemToList = 'Не удалось добавить тип БД в список.';
  RsCantRemoveItemFromList = 'Не удалось удалить тип БД из списка.';

function GetIDatabaseTypes: IDatabaseTypes;
begin
  Result := TDatabaseTypes.Create;
end;

function GetIDatabaseTypes(const AList: TStrings; const ASeparators: array of string): IDatabaseTypes;
var
  i: Integer;
  j: Integer;
  a: IDatabaseType;
  sl: TStrings;
begin
  Assert(Length(ASeparators) > 0, 'Не указан ни один разделитель строк записей типов БД');
  Result := GetIDatabaseTypes;

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
        j := StrToIntDef(sl[1], -1);
        a := GetIDatabaseType(j, sl[0]);
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

function TDatabaseTypes.GetItemByName(const AName: string): IDatabaseType;
var
  i: Integer;
  s: string;
begin
  Result := nil;
  s := Trim(AName);
  for i := 0 to Pred(Count) do
  begin
    if Assigned(Items[i]) then
    begin
      if Items[i].Name = s then
      begin
        Result := Items[i];
        Exit;
      end;
    end;
  end;
end;

procedure TDatabaseTypes.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
