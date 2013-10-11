unit uTArchivingBoxCapacityConfigBusinessLogic;

interface

uses
  DB,
  ValEdit,
  uTCustomBusinessLogic,
  uIArchivingBoxCapacityConfigBusinessLogic,
  uTOnDisplayMessage,
  uIArchiveBoxTypeList;

type
  TArchivingBoxCapacityConfigBusinessLogic = class {$IFNDEF VER150} sealed
{$ENDIF}(TCustomBusinessLogic, IArchivingBoxCapacityConfigBusinessLogic)
  private
    FValueListEditor: TValueListEditor;
    function GetValueListEditor: TValueListEditor;
    property ValueListEditor: TValueListEditor read GetValueListEditor nodefault;
  private
    FArchiveBoxTypes: IArchiveBoxTypeList;
    function GetArchiveBoxTypes: IArchiveBoxTypeList;
    property ArchiveBoxTypes: IArchiveBoxTypeList read GetArchiveBoxTypes nodefault;
  private
    procedure SetDocumentArchiving(const AValue: Boolean);
    function CapacityChanged(const ARow: Integer): Boolean;
    function GetCurrentMinimumArchiveBoxCapacity(const AArchiveBoxTypeId: Integer): Integer;
  public
    procedure EnableDocumentArchiving;
    procedure DisableDocumentArchiving;
    procedure LoadData;
    function SaveData: Boolean;
    function DataWasChanged: Boolean;
    constructor Create(const AConnection: TCustomConnection; const AValueListEditor: TValueListEditor;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce;
  end;

const
  SP_SYS_SET_FLAG_VALUE_INT = 'sys_set_FlagValueInt';

implementation

uses
  SysUtils,
  Forms,
  Controls,
  uArchivingCommonRoutines,
  uIArchiveBoxTypeItem,
  uTArchiveBoxTypeList;

const
  FIELD_ID = 'Id';
  FIELD_NAME = 'Name';
  FIELD_CAPACITY = 'Capacity';
  FIELD_RESULT = 'Result';

  EDIT_MASK = '9999;0; ';

resourcestring
  RsAConnectionIsNil = 'AConnection is nil';
  RsAValueListEditorIsNil = 'AValueListEditor is nil';
  RsCantSaveCapacity = 'Не удалось сохранить объём архивного короба для типа "%s"';
  RsSuccessfullySaved = 'Изменения сохранены';

constructor TArchivingBoxCapacityConfigBusinessLogic.Create(const AConnection: TCustomConnection;
  const AValueListEditor: TValueListEditor; const AOnDisplayMessage: TOnDisplayMessage);
begin
  Assert(Assigned(AConnection), RsAConnectionIsNil);
  Assert(Assigned(AValueListEditor), RsAValueListEditorIsNil);
  inherited Create(AConnection, AOnDisplayMessage);
  FValueListEditor := AValueListEditor;
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.DisableDocumentArchiving;
begin
  SetDocumentArchiving(False);
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.EnableDocumentArchiving;
begin
  SetDocumentArchiving(True);
end;

function TArchivingBoxCapacityConfigBusinessLogic.GetArchiveBoxTypes: IArchiveBoxTypeList;
begin
  if not Assigned(FArchiveBoxTypes) then
  begin
    FArchiveBoxTypes := TArchiveBoxTypeList.Create(Connection);
    if Assigned(FArchiveBoxTypes) then
    begin
      FArchiveBoxTypes.Load;
    end;
  end;
  Result := FArchiveBoxTypes;
end;

function TArchivingBoxCapacityConfigBusinessLogic.GetValueListEditor: TValueListEditor;
begin
  Result := FValueListEditor;
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.SetDocumentArchiving(const AValue: Boolean);
var
  b: Boolean;
  s: string;
  old_cursor: TCursor;
begin
  s := EmptyStr;
  b := False;
  old_cursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  try
    SetSQLForQuery(Query, Format(SP_SYS_SET_FLAG_VALUE_INT + ' %d, %d', [79, Integer(AValue)]), True);
    try
      if not Query.Eof then
      begin
        if not Query.Eof then
        begin
          s := Query.Fields[0].AsString;
          b := Query.Fields[1].AsInteger = 0;
        end;
      end;
    finally
      Query.Close;
    end;
  finally
    Screen.Cursor := old_cursor;
    if not b then
    begin
      DisplayErrorMessage(s);
    end;
  end;
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.LoadData;
var
  old_cursor: TCursor;
  i: Integer;
  j: Integer;
  a: IArchiveBoxTypeItem;
begin
  old_cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ValueListEditor.Strings.BeginUpdate;
    try
      ValueListEditor.Strings.Clear;
      Screen.Cursor := crSQLWait;
      try
        for i := 0 to ArchiveBoxTypes.Count - 1 do
        begin
          if Supports(ArchiveBoxTypes[i], IArchiveBoxTypeItem, a) then
          begin
            j := ValueListEditor.Strings.AddObject(a.name + '=' + IntToStr(a.Capacity), Pointer(a.Id));
            if j > -1 then
            begin
              ValueListEditor.ItemProps[j].EditMask := EDIT_MASK;
            end;
          end;
        end;
      finally
        Screen.Cursor := crHourGlass;
      end;
    finally
      ValueListEditor.Strings.EndUpdate;
    end;
  finally
    Screen.Cursor := old_cursor;
  end;
end;

function TArchivingBoxCapacityConfigBusinessLogic.SaveData: Boolean;
var
  old_cursor: TCursor;
  i: Integer;
  s: string;
  min_capacity: Integer;
  archive_box_type_id: Integer;
  a: IArchiveBoxTypeItem;
  new_capacity: Integer;
begin
  Result := True;
  s := EmptyStr;
  old_cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if ValueListEditor.Strings.Count - 1 > 0 then
    begin
      for i := 0 to ValueListEditor.Strings.Count - 1 do
      begin
        if CapacityChanged(i) then
        begin
          archive_box_type_id := Integer(ValueListEditor.Strings.Objects[i]);
          min_capacity := GetCurrentMinimumArchiveBoxCapacity(archive_box_type_id);
          if min_capacity > -1 then
          begin
            a := ArchiveBoxTypes.GetItemById(archive_box_type_id);
            if Assigned(a) then
            begin
              new_capacity := StrToInt(Trim(ValueListEditor.Values[ValueListEditor.Keys[i + 1]]));
              if min_capacity <= new_capacity then
              begin
                a.Capacity := new_capacity;
                Screen.Cursor := crSQLWait;
                try
                  if not a.Save then
                  begin
                    s := Format(RsCantSaveCapacity, [a.name]);
                    Break;
                  end;
                finally
                  Screen.Cursor := crHourGlass;
                end;
              end
              else
              begin
                s := Format('Минимальное количество документов' + sLineBreak + 'для типа короба ''%d'' равно %d',
                  [a.name, min_capacity]);
              end;
            end;
          end
          else
          begin
            s := Format('Произошла ошибка при попытке получения' + sLineBreak +
              'минимального количества документов для типа короба ''%s''', [a.name]);
            Break;
            Result := False;
          end;
        end;
      end;
    end;
  finally
    Screen.Cursor := old_cursor;
    if s <> EmptyStr then
    begin
      DisplayErrorMessage(s);
    end
    else
    begin
      DisplaySuccessMessage(RsSuccessfullySaved);
    end;
  end;
end;

function TArchivingBoxCapacityConfigBusinessLogic.DataWasChanged: Boolean;
var
  i: Integer;
begin
  Result := False;
  if ValueListEditor.Strings.Count - 1 > 0 then
  begin
    for i := 0 to ValueListEditor.Strings.Count - 1 do
    begin
      if CapacityChanged(i) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TArchivingBoxCapacityConfigBusinessLogic.CapacityChanged(const ARow: Integer): Boolean;
begin
  Result := ArchiveBoxTypes.GetItemById(Integer(ValueListEditor.Strings.Objects[ARow])).Capacity <>
    StrToIntDef(Trim(ValueListEditor.Values[ValueListEditor.Keys[ARow + 1]]), 0);
end;

function TArchivingBoxCapacityConfigBusinessLogic.GetCurrentMinimumArchiveBoxCapacity(const AArchiveBoxTypeId
  : Integer): Integer;
var
  b: Boolean;
  s: string;
  old_cursor: TCursor;
begin
  Result := -1;
  old_cursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  try
    SetSQLForQuery(Query, Format('Archiving_sel_CurrentMinimumArchiveBoxCapacity %d', [AArchiveBoxTypeId]), True);
    try
      if not Query.Eof then
      begin
        if not Query.Eof then
        begin
          Result := Query.Fields[0].AsInteger;
        end;
      end;
    finally
      Query.Close;
    end;
  finally
    Screen.Cursor := old_cursor;
  end;
end;

end.
