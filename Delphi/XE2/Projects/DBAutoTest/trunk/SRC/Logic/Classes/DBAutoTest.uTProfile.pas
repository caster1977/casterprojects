unit DBAutoTest.uTProfile;

interface

uses
  DBAutoTest.uITasks,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  System.IniFiles,
  ConfigPackage.uTIniFileSerilizator;

type
  TProfile = class(TIniFileSerilizator)
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
  CastersPackage.uIModified,
  System.SysUtils,
  DBAutoTest.uTTasks,
  DBAutoTest.uTConnectionOptions,
  DBAutoTest.uTTaskSavingOptions,
  DBAutoTest.uEProfile;

resourcestring
  RsProfileSaveError = 'Произошла ошибка при попытке записи настроек профиля в файл!';

procedure TProfile.Finalize;
//var
//  i: Integer;
//  j: Integer;
//  r: IRecent;
begin
  inherited;
//  if Assigned(FIniFile) then
//  begin
//    with FIniFile do
//      try
//        if Recents.Count <> RECENTS_DEFAULT_QUANTITY then
//        begin
//          j := 0;
//          for i := 0 to Recents.Count - 1 do
//          begin
//            r := Recents.Items[i];
//            if Assigned(r) then
//            begin
//              if r.FullName <> RECENT_DEFAULT_FULL_NAME then
//              begin
//                WriteString(RsRecents, Format(RsRecentProfile, [IntToStr(j)]), r.FullName);
//                Inc(j);
//              end;
//            end;
//          end;
//          WriteInteger(RsRecents, RsQuantity, j);
//        end;
//      except
//        on EIniFileException do
//        begin
//          raise EConfiguration.Create(RsConfigurationSaveError);
//        end;
//      end;
//  end;
end;

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
//var
//  i: Integer;
//  s: string;
//  r: IRecent;
begin
  inherited;
  RegisterOptions(TConnectionOptions);
  RegisterOptions(TTaskSavingOptions);
  FTasks := GetITasks;
//  if Assigned(FIniFile) then
//  begin
//    with FIniFile do
//    begin
//      Recents.Clear;
//      for i := 0 to ReadInteger(RsRecents, RsQuantity, RECENTS_DEFAULT_QUANTITY) - 1 do
//      begin
//        s := Format(RsRecentProfile, [IntToStr(i)]);
//        r := GetIRecent;
//        r.FullName := ReadString(RsRecents, s, RECENT_DEFAULT_FULL_NAME);
//        if r.FullName <> RECENT_DEFAULT_FULL_NAME then
//        begin
//          Recents.Add(r);
//        end;
//      end;
//    end;
//  end;
end;

end.
