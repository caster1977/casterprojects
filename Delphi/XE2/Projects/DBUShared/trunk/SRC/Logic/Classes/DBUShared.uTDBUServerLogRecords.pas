unit DBUShared.uTDBUServerLogRecords;

interface

uses
  DBUShared.uIDBUServerLogRecords,
  DBUShared.uIDBUServerLogRecord,
  CastersPackage.uTInterfaceListOfGivenType,
  System.Classes;

type
  TDBUServerLogRecords = class(TInterfaceListOfGivenType<IDBUServerLogRecord>, IDBUServerLogRecords)
  strict protected
    procedure Initialize; override;
  public
    procedure ToStringList(var AList: TStrings; const ADatabaseType: string = ''; const ASeparator: string = '^^');
  end;

function GetIDBUServerLogRecords: IDBUServerLogRecords; overload;
function GetIDBUServerLogRecords(const AList: TStrings; const ASeparators: array of string): IDBUServerLogRecords; overload;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs,
  DBUShared.uTDBUServerLogRecord,
  CastersPackage.uConsts,
  CastersPackage.uRoutines;

resourcestring
  RsCantAddItemToList = 'Ќе удалось добавить запись в лог.';
  RsCantRemoveItemFromList = 'Ќе удалось удалить запись из лога.';

function GetIDBUServerLogRecords: IDBUServerLogRecords;
begin
  Result := TDBUServerLogRecords.Create;
end;

function GetIDBUServerLogRecords(const AList: TStrings; const ASeparators: array of string): IDBUServerLogRecords;
var
  i: Integer;
  sl: TStrings;
  a: IDBUServerLogRecord;
begin
  Assert(Length(ASeparators) > 0, 'Ќе указан ни один разделитель строк записей лога');
  Result := GetIDBUServerLogRecords;
  if not Assigned(Result) then
  begin
    Exit;
  end;

  if not Assigned(AList) then
  begin
    Exit;
  end;

  if AList.Count < 2 then
  begin
    Exit;
  end;

  for i := 1 to Pred(AList.Count) do
  begin
    sl := Routines.Explode(AList[i], ASeparators);
    try
      if sl.Count = 5 then
      begin
        a := GetIDBUServerLogRecord(sl[1], StrToIntDef(sl[2], -1), StrToIntDef(sl[4], -1), sl[3], StrToDateTime(sl[0], TFormatSettings.Create('ru-RU')));
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

procedure TDBUServerLogRecords.ToStringList(var AList: TStrings; const ADatabaseType: string = ''; const ASeparator: string = '^^');
var
  i: Integer;
  s: string;
begin
  s := Trim(ADatabaseType);
  if not Assigned(AList) then
  begin
    AList := TStringList.Create;
  end;

  if not Assigned(AList) then
  begin
    Exit;
  end;

  AList.Append('Date Time^^DB Type^^New Number^^Person^^DB Count^^');

  for i := 0 to Pred(Count) do
  begin
    if Assigned(Items[i]) then
    begin
      if (s = EmptyStr) or (Items[i].DatabaseType = s) then
      begin
        AList.Append(Format('%s^^%s^^%d^^%s^^%d^^', [FormatDateTime(DATE_TIME_FORMAT_RU, Items[i].DateTime), Items[i].DatabaseType, Items[i].FirstNumber, Items[i].Creator, Items[i].Quantity]));
      end;
    end;
  end;
end;

procedure TDBUServerLogRecords.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddItemToList;
  RemoveItemErrorString := RsCantRemoveItemFromList;
end;

end.
