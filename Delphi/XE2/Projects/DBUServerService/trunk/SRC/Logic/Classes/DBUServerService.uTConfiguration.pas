unit DBUServerService.uTConfiguration;

interface

uses
  DBUShared.uISQLActions,
  DBUShared.uISQLSubjects,
  DBUShared.uIDatabaseTypes,
  DBUShared.uIDBUStates,
  ConfigPackage.uTCustomConfiguration;

type
  TConfiguration = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;

  strict private
    FSQLActions: ISQLActions;
    function GetSQLActions: ISQLActions;
  public
    property SQLActions: ISQLActions read GetSQLActions nodefault;

  strict private
    FSQLSubjects: ISQLSubjects;
    function GetSQLSubjects: ISQLSubjects;
  public
    property SQLSubjects: ISQLSubjects read GetSQLSubjects nodefault;

  strict private
    FDatabaseTypes: IDatabaseTypes;
    function GetDatabaseTypes: IDatabaseTypes;
  public
    property DatabaseTypes: IDatabaseTypes read GetDatabaseTypes nodefault;

  strict private
    FDBUStates: IDBUStates;
    function GetDBUStates: IDBUStates;
  public
    property DBUStates: IDBUStates read GetDBUStates nodefault;
  end;

implementation

uses
  System.IniFiles,
  Vcl.SvcMgr,
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Graphics,
  ConfigPackage.uEConfiguration,
  DBUServerService.Configuration.uTConnection,
  DBUShared.uISQLAction,
  DBUShared.uTSQLActions,
  DBUShared.uTSQLAction,
  DBUShared.uISQLSubject,
  DBUShared.uTSQLSubjects,
  DBUShared.uTSQLSubject,
  DBUShared.uIDatabaseType,
  DBUShared.uTDatabaseTypes,
  DBUShared.uTDatabaseType,
  DBUShared.uIDBUState,
  DBUShared.uTDBUStates,
  DBUShared.uTDBUState;

resourcestring
  RsSQLActions = 'Действия SQL';
  RsSQLSubjects = 'Объекты SQL';
  RsDatabaseTypes = 'Типы БД';
  RsDBUStates = 'Состояния DBU';
  RsDBUState = 'Состояние DBU %d';
  RsQuantity = 'Количество';
  RsId = 'Идентификатор';
  RsName = 'Наименование';
  RsFlags = 'Флаги';
  RsIcon = 'Иконка';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

  // type
  // THackBitmap = class(TBitmap);

function TConfiguration.GetDatabaseTypes: IDatabaseTypes;
begin
  if not Assigned(FDatabaseTypes) then
  begin
    FDatabaseTypes := GetIDatabaseTypes;
  end;
  Result := FDatabaseTypes;
end;

function TConfiguration.GetDBUStates: IDBUStates;
begin
  if not Assigned(FDBUStates) then
  begin
    FDBUStates := GetIDBUStates;
  end;
  Result := FDBUStates;
end;

function TConfiguration.GetSQLActions: ISQLActions;
begin
  if not Assigned(FSQLActions) then
  begin
    FSQLActions := GetISQLActions;
  end;
  Result := FSQLActions;
end;

function TConfiguration.GetSQLSubjects: ISQLSubjects;
begin
  if not Assigned(FSQLSubjects) then
  begin
    FSQLSubjects := GetISQLSubjects;
  end;
  Result := FSQLSubjects;
end;

procedure TConfiguration.Initialize;
var
  i: Integer;
  isa: ISQLAction;
  iss: ISQLSubject;
  dbt: IDatabaseType;
  dbus: IDBUState;
  sl: TStringList;
  dbu_states_quantity: Integer;
  ms: TMemoryStream;
  ico: TIcon;
begin
  inherited;
  RegisterSection(TConnection);

  SQLActions.Clear;
  SQLSubjects.Clear;
  DatabaseTypes.Clear;
  DBUStates.Clear;

  if Assigned(FIniFile) then
  begin
    sl := TStringList.Create;
    try
      if FIniFile.SectionExists(RsSQLActions) then
      begin
        FIniFile.ReadSectionValues(RsSQLActions, sl);
      end;

      for i := 0 to Pred(sl.Count) do
      begin
        isa := GetISQLAction;
        if Assigned(isa) then
        begin
          isa.Name := sl.Names[i];
          isa.Abbreviation := sl.Values[isa.Name];
          if (isa.Name <> EmptyStr) and (isa.Abbreviation <> EmptyStr) then
          begin
            SQLActions.Add(isa);
          end;
        end;
      end;

      sl.Clear;

      if FIniFile.SectionExists(RsSQLSubjects) then
      begin
        FIniFile.ReadSectionValues(RsSQLSubjects, sl);
      end;

      for i := 0 to Pred(sl.Count) do
      begin
        iss := GetISQLSubject;
        if Assigned(iss) then
        begin
          iss.Name := sl.Names[i];
          iss.Abbreviation := sl.Values[iss.Name];
          if (iss.Name <> EmptyStr) and (iss.Abbreviation <> EmptyStr) then
          begin
            SQLSubjects.Add(iss);
          end;
        end;
      end;

      sl.Clear;

      if FIniFile.SectionExists(RsDatabaseTypes) then
      begin
        FIniFile.ReadSection(RsDatabaseTypes, sl);
      end;

      for i := 0 to Pred(sl.Count) do
      begin
        dbt := GetIDatabaseType;
        if Assigned(dbt) then
        begin
          dbt.Name := sl[i];
          dbt.Id := FIniFile.ReadInteger(RsDatabaseTypes, dbt.Name, -1);
          if (dbt.Name <> EmptyStr) and (dbt.Id <> -1) then
          begin
            DatabaseTypes.Add(dbt);
          end;
        end;
      end;

      dbu_states_quantity := 0;
      if FIniFile.SectionExists(RsDBUStates) then
      begin
        dbu_states_quantity := FIniFile.ReadInteger(RsDBUStates, RsQuantity, 0);
      end;

      for i := 0 to Pred(dbu_states_quantity) do
      begin
        dbus := GetIDBUState;
        if Assigned(dbus) then
        begin
          dbus.Id := FIniFile.ReadInteger(Format(RsDBUState, [i]), RsId, -1);
          dbus.Name := FIniFile.ReadString(Format(RsDBUState, [i]), RsName, EmptyStr);
          dbus.Flags := FIniFile.ReadInteger(Format(RsDBUState, [i]), RsFlags, 0);

          if FIniFile.ValueExists(Format(RsDBUState, [i]), RsIcon) then
          begin
            ms := TMemoryStream.Create;
            try
              FIniFile.ReadBinaryStream(Format(RsDBUState, [i]), RsIcon, ms);
              ms.Seek(0, soFromBeginning); // обязательно поставить курсор потока на начало !!!
              ico := TIcon.Create;
              try
                ico.LoadFromStream(ms);
                dbus.Icon := ico;
              finally
                FreeAndNil(ico);
              end;
            finally
              FreeAndNil(ms);
            end;
          end;

          if (dbus.Id <> -1) and (dbus.Name <> EmptyStr) then
          begin
            DBUStates.Add(dbus);
          end;
        end;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TConfiguration.Finalize;
var
  i: Integer;
  isa: ISQLAction;
  iss: ISQLSubject;
  dbt: IDatabaseType;
  dbus: IDBUState;
  dbu_states_quantity: Integer;
  ms: TMemoryStream;
begin
  inherited;

  if Assigned(FIniFile) then
  begin
    try
      if FIniFile.SectionExists(RsSQLActions) then
      begin
        FIniFile.EraseSection(RsSQLActions);
      end;

      for i := 0 to Pred(SQLActions.Count) do
      begin
        isa := SQLActions[i];
        if Assigned(isa) then
        begin
          FIniFile.WriteString(RsSQLActions, isa.Name, isa.Abbreviation);
        end;
      end;

      if FIniFile.SectionExists(RsSQLSubjects) then
      begin
        FIniFile.EraseSection(RsSQLSubjects);
      end;

      for i := 0 to Pred(SQLSubjects.Count) do
      begin
        iss := SQLSubjects[i];
        if Assigned(iss) then
        begin
          FIniFile.WriteString(RsSQLSubjects, iss.Name, iss.Abbreviation);
        end;
      end;

      if FIniFile.SectionExists(RsDatabaseTypes) then
      begin
        FIniFile.EraseSection(RsDatabaseTypes);
      end;

      for i := 0 to Pred(DatabaseTypes.Count) do
      begin
        dbt := DatabaseTypes[i];
        if Assigned(dbt) then
        begin
          FIniFile.WriteInteger(RsDatabaseTypes, dbt.Name, dbt.Id);
        end;
      end;

      if FIniFile.SectionExists(RsDBUStates) then
      begin
        dbu_states_quantity := FIniFile.ReadInteger(RsDBUStates, RsQuantity, 0);
        FIniFile.EraseSection(RsDBUStates);
        for i := 0 to Pred(dbu_states_quantity) do
        begin
          FIniFile.EraseSection(Format(RsDBUState, [i]));
        end;
      end;

      if DBUStates.Count > 0 then
      begin
        FIniFile.WriteInteger(RsDBUStates, RsQuantity, DBUStates.Count);
        for i := 0 to Pred(DBUStates.Count) do
        begin
          dbus := DBUStates[i];
          if Assigned(dbus) then
          begin
            FIniFile.WriteInteger(Format(RsDBUState, [i]), RsId, dbus.Id);
            FIniFile.WriteString(Format(RsDBUState, [i]), RsName, dbus.Name);
            FIniFile.WriteInteger(Format(RsDBUState, [i]), RsFlags, dbus.Flags);

            if Assigned(dbus.Icon) then
            begin
              ms := TMemoryStream.Create;
              try
                dbus.Icon.SaveToStream(ms);
                ms.Seek(0, soFromBeginning); // обязательно постaвить курсок потока на начало !!!
                FIniFile.WriteBinaryStream(Format(RsDBUState, [i]), RsIcon, ms);
              finally
                FreeAndNil(ms);
              end;
            end;
          end;
        end;
      end;
    except
      on EIniFileException do
      begin
        raise EConfiguration.Create(RsConfigurationSaveError);
      end;
    end;
  end;
end;

end.
