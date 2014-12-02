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
function GetIDBUServerLogRecords(const AList: TStrings; const ASeparator: string = '^^'): IDBUServerLogRecords;
  overload;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs,
  DBUShared.uTDBUServerLogRecord,
  CastersPackage.uConsts;

resourcestring
  RsCantAddItemToList = 'Не удалось добавить запись в лог.';
  RsCantRemoveItemFromList = 'Не удалось удалить запись из лога.';

function GetIDBUServerLogRecords: IDBUServerLogRecords;
begin
  Result := TDBUServerLogRecords.Create;
end;

function GetIDBUServerLogRecords(const AList: TStrings; const ASeparator: string = '^^'): IDBUServerLogRecords;
var
  i: Integer;
  j: Integer;
  sl: TStrings;
  separator: string;
  s: string;
  s1: string;
  rec: IDBUServerLogRecord;
begin
  separator := Trim(ASeparator);
  Assert(Length(separator) > 0, 'Не указан разделитель строк записей лога');
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

  sl := TStringList.Create;
  try
    for i := 1 to Pred(AList.Count) do
    begin
      sl.Clear;
      s := AList[i];
      while Length(s) > 0 do
      begin
        j := Pos(separator, s);
        if j = 0 then
        begin
          sl.Append(s);
          Break;
        end
        else
        begin
          s1 := Copy(s, 0, j - 1);
          sl.Append(s1);
          s1 := Copy(s, j + 2, Length(s));
          s := s1;
        end;
      end;
      if sl.Count = 5 then
      begin
        rec := GetIDBUServerLogRecord(sl[1], StrToInt(sl[2]), StrToInt(sl[4]), sl[3],
          StrToDateTime(sl[0], TFormatSettings.Create('ru-RU')));
        if Assigned(rec) then
        begin
          Result.Add(rec);
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TDBUServerLogRecords.ToStringList(var AList: TStrings; const ADatabaseType: string = '';
  const ASeparator: string = '^^');
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
        AList.Append(Format('%s^^%s^^%d^^%s^^%d^^', [FormatDateTime(DATE_TIME_FORMAT_RU, Items[i].DateTime),
          Items[i].DatabaseType, Items[i].FirstNumber, Items[i].Creator, Items[i].Quantity]));
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
