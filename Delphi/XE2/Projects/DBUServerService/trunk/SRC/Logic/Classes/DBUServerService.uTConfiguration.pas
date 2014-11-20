unit DBUServerService.uTConfiguration;

interface

uses
  DBUServerService.uISQLActions,
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
  end;

implementation

uses
  // CastersPackage.uIModified,
  Vcl.SvcMgr,
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  ConfigPackage.uEConfiguration,
  DBUServerService.uISQLAction,
  DBUServerService.uTSQLActions,
  DBUServerService.uTSQLAction;

resourcestring
  RsSQLActions = 'Действия SQL';
  RsQuantity = 'Количество';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

function TConfiguration.GetSQLActions: ISQLActions;
begin
  if not Assigned(FSQLActions) then
  begin
    FSQLActions := GetISQLActions;
  end;
  Result := FSQLActions;
end;

procedure TConfiguration.Initialize;
var
  i: Integer;
  s: string;
  a: ISQLAction;
  sl: TStringList;
begin
  inherited;
  SQLActions.Clear;
  if Assigned(FIniFile) then
  begin
    sl := TStringList.Create;
    try
      FIniFile.ReadSectionValues(RsSQLActions, sl);
      if sl.Count > 0 then
      begin
        for i := 0 to Pred(sl.Count) do
        begin
          a := GetISQLAction;
          a.Name := sl.Names[i];
          a.Abbreviation := sl.Values[a.Name];
          if a.Name <> EmptyStr then
          begin
            SQLActions.Add(a);
          end;
        end;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TConfiguration.Finalize;
{var
  i: Integer;
  j: Integer;
  a: ISQLAction;}
begin
  inherited;
  // if Assigned(FIniFile) then
  // begin
  // with FIniFile do
  // try
  // if Recents.Count <> RECENTS_DEFAULT_COUNT then
  // begin
  // j := 0;
  // for i := 0 to Pred(Recents.Count) do
  // begin
  // r := Recents.Items[i];
  // if Assigned(r) then
  // begin
  // if r.FullName <> RECENT_DEFAULT_FULL_NAME then
  // begin
  // WriteString(RsRecents, Format(RsRecentProfile, [IntToStr(j)]), r.FullName);
  // Inc(j);
  // end
  // else
  // begin
  // DeleteKey(RsRecents, Format(RsRecentProfile, [IntToStr(j)]));
  // end;
  // end;
  // end;
  // WriteInteger(RsRecents, RsQuantity, j);
  // end;
  // except
  // on EIniFileException do
  // begin
  // raise EConfiguration.Create(RsConfigurationSaveError);
  // end;
  // end;
  // end;
end;

end.
