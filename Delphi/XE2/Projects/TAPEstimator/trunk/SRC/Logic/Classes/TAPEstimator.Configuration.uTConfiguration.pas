unit TAPEstimator.Configuration.uTConfiguration;

interface

uses
  System.IniFiles,
  TAPEstimator.uConsts,
  ConfigPackage.uTCustomConfiguration,
  TAPEstimator.Configuration.uIRecents;

type
  TConfiguration = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;
  strict private
    FRecents: IRecents;
    function GetRecents: IRecents;
  public
    property Recents: IRecents read GetRecents nodefault;
  end;

implementation

uses
  System.SysUtils,
  TAPEstimator.Configuration.uEConfiguration,
  TAPEstimator.Configuration.uTInterfaceSection,
  TAPEstimator.Configuration.uTOtherSection,
  TAPEstimator.Configuration.uTMainFormStateSection,
  TAPEstimator.Configuration.uTRecents,
  TAPEstimator.Configuration.uIRecent,
  TAPEstimator.Configuration.uTRecent;

resourcestring
  RsInterface = 'Интерфейс';
  RsRecents = 'Ранее открытые профили';
  RsRecentProfile = 'Профиль %s';
  RsOther = 'Прочие';
  RsReports = 'Отчёты';
  RsQuantity = 'Количество';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

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
  RegisterSection(TInterfaceSection);
  RegisterSection(TOtherSection);
  RegisterSection(TMainFormStateSection);
  Recents.Clear;
  if Assigned(FIniFile) then
  begin
    Recents.Clear;
    for i := 0 to FIniFile.ReadInteger(RsRecents, RsQuantity, RECENTS_DEFAULT_COUNT) - 1 do
    begin
      s := Format(RsRecentProfile, [IntToStr(i)]);
      r := GetIRecent;
      r.FullName := FIniFile.ReadString(RsRecents, s, RECENT_DEFAULT_FULL_NAME);
      if r.FullName <> RECENT_DEFAULT_FULL_NAME then
      begin
        Recents.Add(r);
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
              FIniFile.WriteString(RsRecents, Format(RsRecentProfile, [IntToStr(j)]), r.FullName);
              Inc(j);
            end;
          end;
        end;
        FIniFile.WriteInteger(RsRecents, RsQuantity, j);
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
