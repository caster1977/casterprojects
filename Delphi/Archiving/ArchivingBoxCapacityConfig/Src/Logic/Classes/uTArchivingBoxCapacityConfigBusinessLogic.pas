unit uTArchivingBoxCapacityConfigBusinessLogic;

interface

uses
  uTCustomBusinessLogic,
  uIArchivingBoxCapacityConfigBusinessLogic,
  ValEdit,
  DB,
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
    FNewArchiveBoxTypes: IArchiveBoxTypeList;
    function GetNewArchiveBoxTypes: IArchiveBoxTypeList;
    property NewArchiveBoxTypes: IArchiveBoxTypeList read GetNewArchiveBoxTypes nodefault;
  private
    procedure SetDocumentArchiving(const AValue: Boolean);
  public
    procedure EnableDocumentArchiving;
    procedure DisableDocumentArchiving;
    procedure LoadData;
    procedure SaveData;
    function DataWasChanged: Boolean;
    constructor Create(const AConnection: TCustomConnection; const AValueListEditor: TValueListEditor;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce;
  end;

implementation

uses
  SysUtils,
  Forms,
  Controls,
  uArchivingCommonRoutines,
  uTArchiveBoxTypeList;

const
  LIB_GUID = '{7EE9065F-E757-435C-B7EA-08CC70025DE4}';

  SP_ARCHIVING_SEL_ARHIVE_BOX_TYPE = 'Archiving_sel_ArchiveBoxType';
  SP_ARCHIVING_UPD_ARHIVE_BOX_TYPE_CAPACITY = 'Archiving_upd_ArchiveBoxType_Capacity';
  SP_SYS_SET_FLAG_VALUE_INT = 'sys_set_FlagValueInt';

  FIELD_ID = 'Id';
  FIELD_NAME = 'Name';
  FIELD_CAPACITY = 'Capacity';
  FIELD_RESULT = 'Result';

  EDIT_MASK = '9999;0; ';

resourcestring
  RsAConnectionIsNil = 'AConnection is nil';
  RsAValueListEditorIsNil = 'AValueListEditor is nil';

constructor TArchivingBoxCapacityConfigBusinessLogic.Create(const AConnection: TCustomConnection;
  const AValueListEditor: TValueListEditor; const AOnDisplayMessage: TOnDisplayMessage);
begin
  Assert(Assigned(AConnection), RsAConnectionIsNil);
  Assert(Assigned(AValueListEditor), RsAValueListEditorIsNil);
  inherited Create(AConnection, AOnDisplayMessage);
  FValueListEditor := AValueListEditor;
  FArchiveBoxTypes := TArchiveBoxTypeList.Create(Connection);
  if Assigned(FArchiveBoxTypes) then
  begin
    FArchiveBoxTypes.Load;
    FNewArchiveBoxTypes := TArchiveBoxTypeList.Create(Connection);
    if Assigned(NewArchiveBoxTypes) then
    begin
      NewArchiveBoxTypes.Assign(ArchiveBoxTypes);
    end;
  end;
end;

function TArchivingBoxCapacityConfigBusinessLogic.DataWasChanged: Boolean;
begin
  Result := True;
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
  Result := FArchiveBoxTypes;
end;

function TArchivingBoxCapacityConfigBusinessLogic.GetNewArchiveBoxTypes: IArchiveBoxTypeList;
begin
  Result := FNewArchiveBoxTypes;
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
          j := ValueListEditor.Strings.AddObject(ArchiveBoxTypes[i].name + '=' + IntToStr(ArchiveBoxTypes[i].Capacity),
            Pointer(ArchiveBoxTypes[i].Id));
          if j > -1 then
          begin
            ValueListEditor.ItemProps[j].EditMask := EDIT_MASK;
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

procedure TArchivingBoxCapacityConfigBusinessLogic.SaveData;
var
  old_cursor: TCursor;
  i: Integer;
//  b: Boolean;
//  s: string;
begin
  old_cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if ValueListEditor.Strings.Count - 1 > 0 then
    begin
      for i := 0 to ValueListEditor.Strings.Count - 1 do
      begin
        ArchiveBoxTypes.GetItemById(Integer(ValueListEditor.Strings.Objects[i])).Capacity :=
          StrToInt(Trim(ValueListEditor.Values[ValueListEditor.Keys[i + 1]]));
        ArchiveBoxTypes.Item[i].Save;
      end;
    end;
  finally
    Screen.Cursor := old_cursor;
  end;
end;

{Screen.Cursor := crSQLWait;
try
  if vleArchiveBoxCapacity.Strings.Count - 1 > 0 then
  begin
    for i := 0 to vleArchiveBoxCapacity.Strings.Count - 1 do
    begin
      if vleArchiveBoxCapacity.Strings[i] <> FOriginalValues.Strings[i] then
      begin
        try
          b := False;
          afSetCommandText(Query, SP_ARCHIVING_UPD_ARHIVE_BOX_TYPE_CAPACITY,
            [Integer(vleArchiveBoxCapacity.Strings.Objects[i]),
            StrToInt(Trim(vleArchiveBoxCapacity.Values[vleArchiveBoxCapacity.Keys[i + 1]]))], True);
          if not Query.Eof then
          begin
            s := Query.Fields[0].AsString;
            b := Query.Fields[1].AsInteger = 0;
          end;
          if not b then
          begin
            raise Exception.Create(Format(RsCantSaveCapacity, [vleArchiveBoxCapacity.Keys[i]]) + sLineBreak + s);
          end;
        finally
          Query.Close;
          Query.SQL.Clear;
        end;
      end;
    end;
    if s <> EmptyStr then
    begin
      ShowMes(s);
    end;
  end;
end;}

end.
