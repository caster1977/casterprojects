unit DBAutoTest.uTProfile;

interface

uses
  DBAutoTest.uITasks,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  System.IniFiles,
  ConfigPackage.uTCustomConfiguration;

type
  TProfile = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
  strict private
    function GetADOConnectionString: string;
  public
    property ADOConnectionString: string read GetADOConnectionString;

  strict private
    FTasks: ITasks;
    function GetTasks: ITasks;
  public
    property Tasks: ITasks read GetTasks nodefault;
  end;

implementation

uses
  System.Classes,
  CastersPackage.uIModified,
  System.SysUtils,
  DBAutoTest.uITask,
  DBAutoTest.uTTask,
  DBAutoTest.uTTasks,
  DBAutoTest.uEConfiguration,
  DBAutoTest.uTConnectionOptions,
  DBAutoTest.uTTaskSavingOptions,
  DBAutoTest.uEProfile;

resourcestring
  RsProfileSaveError = 'Произошла ошибка при попытке записи настроек профиля в файл!';

  RsTasks = 'Тесты';
  RsQuantity = 'Количество';
  RsTask = 'Тест %s';

function TProfile.GetADOConnectionString: string;
begin
  Result := Format(ADO_CONNECTION_STRING_PREFIX, [Section<TConnectionOptions>.Server]);

  if Section<TConnectionOptions>.WinNTSecurity then
  begin
    Result := Result + ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY;
  end
  else
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_USER_ID, [Section<TConnectionOptions>.Login]);
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO, [BoolToStr(Section<TConnectionOptions>.EnableStorePassword, True)]);
    if Section<TConnectionOptions>.EnableStorePassword then
    begin
      Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PASSWORD, [Section<TConnectionOptions>.Password]);
    end;
  end;
  if Section<TConnectionOptions>.Database > EmptyStr then
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_INITIAL_CATALOG, [Section<TConnectionOptions>.Database]);
  end;
end;

function TProfile.GetTasks: ITasks;
begin
  if not Assigned(FTasks) then
  begin
    FTasks := GetITasks;
  end;
  Result := FTasks;
end;

procedure TProfile.Initialize;
var
  i: Integer;
  s: string;
  t: ITask;
  ms: TMemoryStream;
begin
  inherited;
  RegisterSection(TConnectionOptions);
  RegisterSection(TTaskSavingOptions);
  FTasks := GetITasks;
  if Assigned(FIniFile) then
  begin
    with FIniFile do
    begin
      Tasks.Clear;
      for i := 0 to ReadInteger(RsTasks, RsQuantity, 0) - 1 do
      begin
        s := Format(RsTask, [IntToStr(i)]);
        t := GetITask;
        t.Enabled := ReadBool(s, 'Enabled', TASK_DEFAULT_ENABLED);
        t.Group := ReadString(s, 'Group', TASK_DEFAULT_GROUP);
        t.Name := ReadString(s, 'Name', TASK_DEFAULT_NAME);

        ms := TMemoryStream.Create;
        try
          ReadBinaryStream(s, 'SQL', ms);
          ms.Seek(0, soFromBeginning); // обязательно постувить курсок потока на начало !!!
          t.SQL.LoadFromStream(ms);
        finally
          ms.Free;
        end;
        EraseSection(s);

        if ((t.Enabled <> TASK_DEFAULT_ENABLED) or (t.Group <> TASK_DEFAULT_GROUP) or (t.Name <> TASK_DEFAULT_NAME) or (t.SQL.Text <> TASK_DEFAULT_SQL)) then
        begin
          Tasks.Add(t);
        end;
      end;
    end;
  end;
end;

procedure TProfile.Finalize;
var
  i: Integer;
  j: Integer;
  t: ITask;
  ms: TMemoryStream;
begin
  inherited;
  if Assigned(FIniFile) then
  begin
    with FIniFile do
      try
        if Tasks.Count > 0 then
        begin
          j := 0;
          for i := 0 to Tasks.Count - 1 do
          begin
            t := Tasks.Items[i];
            if Assigned(t) then
            begin
              if t.Enabled <> TASK_DEFAULT_ENABLED then
              begin
                WriteBool(Format(RsTask, [IntToStr(j)]), 'Enabled', t.Enabled);
              end
              else
              begin
                DeleteKey(Format(RsTask, [IntToStr(j)]), 'Enabled');
              end;
              if t.Group <> TASK_DEFAULT_GROUP then
              begin
                WriteString(Format(RsTask, [IntToStr(j)]), 'Group', t.Group);
              end
              else
              begin
                DeleteKey(Format(RsTask, [IntToStr(j)]), 'Group');
              end;
              if t.Name <> TASK_DEFAULT_NAME then
              begin
                WriteString(Format(RsTask, [IntToStr(j)]), 'Name', t.Name);
              end
              else
              begin
                DeleteKey(Format(RsTask, [IntToStr(j)]), 'Name');
              end;

              if t.SQL.Text <> TASK_DEFAULT_SQL then
              begin
                ms := TMemoryStream.Create;
                try
                  t.SQL.SaveToStream(ms);
                  ms.Seek(0, soFromBeginning); // обязательно постувить курсок потока на начало !!!
                  WriteBinaryStream(Format(RsTask, [IntToStr(j)]), 'SQL', ms);
                finally
                  ms.Free;
                end;
              end
              else
              begin
                DeleteKey(Format(RsTask, [IntToStr(j)]), 'SQL');
              end;
              if ((t.Enabled <> TASK_DEFAULT_ENABLED) or (t.Group <> TASK_DEFAULT_GROUP) or (t.Name <> TASK_DEFAULT_NAME) or (t.SQL.Text <> TASK_DEFAULT_SQL)) then
              begin
                Inc(j);
              end;
            end;
          end;
          if j <> 0 then
          begin
            WriteInteger(RsTasks, RsQuantity, j)
          end
          else
          begin
            DeleteKey(RsTasks, RsQuantity);
            EraseSection(RsTasks);
          end;
        end
        else
        begin
          DeleteKey(RsTasks, RsQuantity);
          EraseSection(RsTasks);
        end;
      except
        on EIniFileException do
        begin
          raise EConfiguration.Create(RsProfileSaveError);
        end;
      end;
  end;
end;

end.
