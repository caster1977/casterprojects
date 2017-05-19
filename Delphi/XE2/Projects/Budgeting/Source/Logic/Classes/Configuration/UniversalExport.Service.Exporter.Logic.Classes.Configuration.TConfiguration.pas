unit UniversalExport.Service.Exporter.Logic.Classes.Configuration.TConfiguration;

interface

uses
  ConfigPackage.Logic.TCustomConfiguration;

type
  TConfiguration = class(TCustomConfiguration)
  strict protected
    procedure Initialize(); override;
  end;

implementation

uses
  System.SysUtils,
  UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TGeneral,
  UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TDatabaseConnection;

procedure TConfiguration.Initialize();
begin
  inherited;
  RegisterSection(TGeneral);
  RegisterSection(TDatabaseConnection);
end;

end.
