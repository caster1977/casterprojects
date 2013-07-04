unit DBAutoTest.uTConfiguration;

interface

uses
  System.IniFiles,
  DBAutoTest.uConsts,
  DBAutoTest.uIRecents,
  ConfigPackage.uTCustomConfiguration;

type
  TConfiguration = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
  strict private
    FRecents: IRecents;
    function GetRecents: IRecents;
  strict private
    function GetADOConnectionString: string;
  public
    property ADOConnectionString: string read GetADOConnectionString;
  public
    property Recents: IRecents read GetRecents nodefault;
  end;

implementation

uses
  CastersPackage.uIModified,
  System.SysUtils,
  DBAutoTest.uEConfiguration,
  DBAutoTest.Configuration.uTInterface,
  DBAutoTest.Configuration.uTReports,
  DBAutoTest.Configuration.uTConnection,
  DBAutoTest.uTOtherOptions,
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent,
  DBAutoTest.uTRecent;

resourcestring
  RsInterface = 'Интерфейс';
  RsRecents = 'Ранее открытые профили';
  RsRecentProfile = 'Профиль %s';
  RsOther = 'Прочие';
  RsReports = 'Отчёты';
  RsQuantity = 'Количество';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

function TConfiguration.GetADOConnectionString: string;
begin
  Result := Format(ADO_CONNECTION_STRING_PREFIX, [Section<TConnection>.Server]);

  if Section<TConnection>.WinNTSecurity then
  begin
    Result := Result + ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY;
  end
  else
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_USER_ID, [Section<TConnection>.Login]);
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO, [BoolToStr(Section<TConnection>.EnableStorePassword, True)]);
    if Section<TConnection>.EnableStorePassword then
    begin
      Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_PASSWORD, [Section<TConnection>.Password]);
    end;
  end;
  if Section<TConnection>.Database > EmptyStr then
  begin
    Result := Result + Format(ADO_CONNECTION_STRING_SUFFIX_INITIAL_CATALOG, [Section<TConnection>.Database]);
  end;
end;

function TConfiguration.GetRecents: IRecents;
begin
  if not Assigned(FRecents) then
  begin
    FRecents := GetIRecents;
  end;
  Result := FRecents;
end;

procedure TConfiguration.Initialize;
var
  i: Integer;
  s: string;
  r: IRecent;
begin
  inherited;
  RegisterSection(TInterface);
  RegisterSection(TReports);
  RegisterSection(TConnection);
  RegisterSection(TOtherOptions);
  Recents.Clear;
  if Assigned(FIniFile) then
  begin
    with FIniFile do
    begin
      Recents.Clear;
      for i := 0 to ReadInteger(RsRecents, RsQuantity, RECENTS_DEFAULT_COUNT) - 1 do
      begin
        s := Format(RsRecentProfile, [IntToStr(i)]);
        r := GetIRecent;
        r.FullName := ReadString(RsRecents, s, RECENT_DEFAULT_FULL_NAME);
        if r.FullName <> RECENT_DEFAULT_FULL_NAME then
        begin
          Recents.Add(r);
        end;
      end;
    end;
  end;
end;

procedure TConfiguration.Finalize;
var
  i: Integer;
  j: Integer;
  r: IRecent;
begin
  inherited;
  if Assigned(FIniFile) then
  begin
    with FIniFile do
      try
        if Recents.Count <> RECENTS_DEFAULT_COUNT then
        begin
          j := 0;
          for i := 0 to Recents.Count - 1 do
          begin
            r := Recents.Items[i];
            if Assigned(r) then
            begin
              if r.FullName <> RECENT_DEFAULT_FULL_NAME then
              begin
                WriteString(RsRecents, Format(RsRecentProfile, [IntToStr(j)]), r.FullName);
                Inc(j);
              end
              else
              begin
                DeleteKey(RsRecents, Format(RsRecentProfile, [IntToStr(j)]));
              end;
            end;
          end;
          WriteInteger(RsRecents, RsQuantity, j);
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
