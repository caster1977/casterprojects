unit DBUServerService.uTDBUServerLogRecords;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUServerService.uIDBUServerLogRecords,
  DBUServerService.uIDBUServerLogRecord,
  System.Classes;

type
  TDBUServerLogRecords = class(TInterfaceListOfGivenType<IDBUServerLogRecord>, IDBUServerLogRecords)
  strict protected
    procedure Initialize; override;
  public
    procedure ToStringList(var AList: TStrings; const ADatabaseType: string = ''; const ASeparator: string = '^^');
  end;

function GetIDBUServerLogRecords: IDBUServerLogRecords; overload;
function GetIDBUServerLogRecords(const AList: TStrings; const ASeparator: string = '^^'): IDBUServerLogRecords; overload;

implementation

uses
  System.SysUtils,
  DBUServerService.uConsts;

resourcestring
  RsCantAddItemToList = 'Не удалось добавить запись в лог.';
  RsCantRemoveItemFromList = 'Не удалось удалить запись из лога.';

function GetIDBUServerLogRecords: IDBUServerLogRecords;
begin
  Result := TDBUServerLogRecords.Create;
end;

function GetIDBUServerLogRecords(const AList: TStrings; const ASeparator: string = '^^'): IDBUServerLogRecords;
begin
  Result := GetIDBUServerLogRecords;
  if not Assigned(Result) then
  begin
    Exit;
  end;

  if not Assigned(AList) then
  begin
    Exit;
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
