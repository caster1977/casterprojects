program UniversalExport.Service.Exporter;

uses
  CodeSiteLogging,
  System.SysUtils,
  System.StrUtils,
  Vcl.SvcMgr,
  UniversalExport.Service.Exporter.TUniversalExportExporter in 'UI\UniversalExport.Service.Exporter.TUniversalExportExporter.pas' {UniversalExportExporter: TService},
  UniversalExport.Service.Exporter.Logic.Classes.Configuration.TConfiguration in 'Logic\Classes\Configuration\UniversalExport.Service.Exporter.Logic.Classes.Configuration.TConfiguration.pas',
  UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TDatabaseConnection in 'Logic\Classes\Configuration\UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TDatabaseConnection.pas',
  UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TGeneral in 'Logic\Classes\Configuration\UniversalExport.Service.Exporter.Logic.Classes.Configuration.Section.TGeneral.pas',
  UniversalExport.Service.Exporter.Logic.TTaskInfo in 'Logic\UniversalExport.Service.Exporter.Logic.TTaskInfo.pas',
  UniversalExport.Service.Exporter.Logic.Classes.TMainThread in 'Logic\Classes\UniversalExport.Service.Exporter.Logic.Classes.TMainThread.pas',
  UniversalExport.Service.Exporter.Logic.Classes.TTaskThread in 'Logic\Classes\UniversalExport.Service.Exporter.Logic.Classes.TTaskThread.pas';

{$R *.RES}

var
  CodeSiteDestination: TCodeSiteDestination;

begin
  CodeSiteManager.ConnectUsingTcp();
  CodeSiteDestination := TCodeSiteDestination.Create(nil);
  if Assigned(CodeSiteDestination) then
  begin
    CodeSiteDestination.LogFile.filename := ChangeFileExt(ExtractFileName(IfThen(ModuleIsLib, GetModuleName(HInstance), ParamStr(0))),
      '.' + FormatDateTime('yyyymmddhhnnss', Now(), TFormatSettings.Create('ru-ru')) + '.csl');
    CodeSiteDestination.LogFile.FilePath := ExtractFilePath(IfThen(ModuleIsLib, GetModuleName(HInstance), ParamStr(0))).Replace('\\?\', EmptyStr);
    CodeSiteDestination.LogFile.MaxSize := 5120; // 5 לודאבאיע םא פאיכ כמדא
    CodeSiteDestination.LogFile.Active := True;
    CodeSiteDestination.Viewer.Active := False;
    CodeSite.Destination := CodeSiteDestination;
  end;

  if not Application.DelayInitialize or Application.Installing then
  begin
    Application.Initialize();
  end;
  Application.CreateForm(TUniversalExportExporter, UniversalExportExporter);
  Application.Run();

end.
