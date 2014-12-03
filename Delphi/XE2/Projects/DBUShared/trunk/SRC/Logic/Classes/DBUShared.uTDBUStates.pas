unit DBUShared.uTDBUStates;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUShared.uIDBUStates,
  DBUShared.uIDBUState,
  System.Classes,
  Vcl.Controls;

type
  TDBUStates = class(TInterfaceListOfGivenType<IDBUState>, IDBUStates)
  strict protected
    procedure Initialize; override;
  end;

function GetIDBUStates: IDBUStates; overload;
function GetIDBUStates(const AList: TStrings; const AImages: TImageList;
  const ASeparators: array of string): IDBUStates; overload;

implementation

uses
  System.SysUtils,
  DBUShared.uTDBUState,
  Vcl.Graphics,
  CastersPackage.uRoutines;

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить состо€ние DBU в список.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить состо€ние DBU из списка.';

function GetIDBUStates: IDBUStates;
begin
  Result := TDBUStates.Create;
end;

function GetIDBUStates(const AList: TStrings; const AImages: TImageList;
  const ASeparators: array of string): IDBUStates;
var
  i: Integer;
  j: Integer;
  a: IDBUState;
  sl: TStrings;
  icon: TIcon;
begin
  Assert(Length(ASeparators) > 0, 'Ќе указан ни один разделитель строк записей состо€ний');
  Result := GetIDBUStates;

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
      if sl.Count = 3 then
      begin
        icon := TIcon.Create;
        try
          j := StrToIntDef(sl[0], -1);
          if (j > -1) and (j < AImages.Count) then
          begin
            AImages.GetIcon(j, icon);
            a := GetIDBUState(j, sl[1], StrToIntDef(sl[2], -1), icon);
          end
          else
          begin
            a := GetIDBUState(j, sl[1], StrToIntDef(sl[2], -1));
          end;
        finally
          icon.Free;
        end;
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

procedure TDBUStates.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
