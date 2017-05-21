unit Budgeting.Logic.Classes.Configuration.TConfiguration;

interface

uses
  ConfigPackage.Logic.TCustomConfiguration,
  System.Classes;

type
  TConfiguration = class(TCustomConfiguration)
  strict protected
    procedure Initialize(); override;

  strict private
    FCurrentPage: Integer;
    function GetCurrentPage(): Integer;
    procedure SetCurrentPage(const AValue: Integer);

  public
    property CurrentPage: Integer read GetCurrentPage write SetCurrentPage nodefault;
  end;

implementation

uses
  Budgeting.Logic.Classes.Configuration.Section.TGeneral,
  Budgeting.Logic.Classes.Configuration.Section.TInterface,
  Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection,
  Budgeting.Logic.Classes.Configuration.Section.TOther,
  System.SysUtils,
  System.IniFiles;

resourcestring
  RsConfigurationSaveError = 'Произошла ошибка при попытке записи настроек программы в файл.';

function TConfiguration.GetCurrentPage(): Integer;
begin
  Result := FCurrentPage;
end;

procedure TConfiguration.Initialize();
begin
  inherited;
  RegisterSection(TGeneral);
  RegisterSection(TInterface);
  RegisterSection(TDatabaseConnection);
  RegisterSection(TOther);
end;

procedure TConfiguration.SetCurrentPage(const AValue: Integer);
begin
  if FCurrentPage <> AValue then
  begin
    FCurrentPage := AValue;
  end;
end;

end.


