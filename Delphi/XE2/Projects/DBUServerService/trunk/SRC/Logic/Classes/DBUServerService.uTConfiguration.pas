unit DBUServerService.uTConfiguration;

interface

uses
  DBUServerService.uISQLActions,
  DBUServerService.uISQLSubjects,
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
  end;

implementation

uses
  System.IniFiles,
  Vcl.SvcMgr,
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  ConfigPackage.uEConfiguration,
  DBUServerService.Configuration.uTConnection,
  DBUServerService.uISQLAction,
  DBUServerService.uTSQLActions,
  DBUServerService.uTSQLAction,
  DBUServerService.uISQLSubject,
  DBUServerService.uTSQLSubjects,
  DBUServerService.uTSQLSubject;

resourcestring
  RsSQLActions = 'Действия SQL';
  RsSQLSubjects = 'Объекты SQL';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

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
  sl: TStringList;
begin
  inherited;
  RegisterSection(TConnection);

  SQLActions.Clear;
  SQLSubjects.Clear;

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
          if isa.Name <> EmptyStr then
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
          if iss.Name <> EmptyStr then
          begin
            SQLSubjects.Add(iss);
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
    except
      on EIniFileException do
      begin
        raise EConfiguration.Create(RsConfigurationSaveError);
      end;
    end;
  end;
end;

end.
