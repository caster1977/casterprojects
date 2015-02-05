unit DBUServerManager.uTConfiguration;

interface

uses
  ConfigPackage.uTCustomConfiguration,
  DBUServerManager.uConsts,
  System.Classes;

type
  TConfiguration = class(TCustomConfiguration)
  strict protected
    procedure Initialize; override;
    procedure Finalize; override;

  strict private
    FCurrentPage: Integer;
    function GetCurrentPage: Integer;
    procedure SetCurrentPage(const AValue: Integer);
  public
    property CurrentPage: Integer read GetCurrentPage write SetCurrentPage default CONFIGURATION_DEFAULT_ACTIVE_PAGE;

  strict private
    FHosts: TStrings;
    function GetHosts: TStrings;
  public
    property Hosts: TStrings read GetHosts nodefault;
  end;

implementation

uses
  DBUServerManager.Configuration.uTInterface,
  DBUServerManager.Configuration.uTConnection,
  ConfigPackage.uEConfiguration,
  System.SysUtils,
  System.IniFiles;

resourcestring
  RsHosts = 'Список хостов';
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

function TConfiguration.GetCurrentPage: Integer;
begin
  Result := FCurrentPage;
end;

function TConfiguration.GetHosts: TStrings;
begin
  if not Assigned(FHosts) then
  begin
    FHosts := TStringList.Create;
  end;
  Result := FHosts;
end;

procedure TConfiguration.SetCurrentPage(const AValue: Integer);
begin
  if FCurrentPage <> AValue then
  begin
    FCurrentPage := AValue;
  end;
end;

procedure TConfiguration.Initialize;
var
  i: Integer;
  sl: TStrings;
begin
  inherited;
  RegisterSection(TInterface);
  RegisterSection(TConnection);
  Hosts.Clear;

  if Assigned(FIniFile) then
  begin
    if FIniFile.SectionExists(RsHosts) then
    begin
      sl := TStringList.Create;
      try
        FIniFile.ReadSectionValues(RsHosts, sl);
        for i := 0 to Pred(sl.Count) do
        begin
          Hosts.Append(sl.ValueFromIndex[i]);
        end;
      finally
        sl.Free;
      end;
    end;
  end;
end;

procedure TConfiguration.Finalize;
var
  i: Integer;
begin
  inherited;
  if Assigned(FIniFile) then
  begin
    try
      if FIniFile.SectionExists(RsHosts) then
      begin
        FIniFile.EraseSection(RsHosts);
      end;

      for i := 0 to Pred(Hosts.Count) do
      begin
        FIniFile.WriteString(RsHosts, IntToStr(i), Hosts[i]);
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
