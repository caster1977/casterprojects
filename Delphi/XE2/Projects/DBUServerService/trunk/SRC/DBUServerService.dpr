program DBUServerService;

uses
  Vcl.SvcMgr,
  DBUServerService.uTDBUServer in 'UI\DBUServerService.uTDBUServer.pas' {DBUServer: TService},
  DBUServerService.uDBUServerUtils in 'Logic\Other\DBUServerService.uDBUServerUtils.pas',
  DBUServerService.uISQLActions in 'Logic\Interfaces\DBUServerService.uISQLActions.pas',
  DBUServerService.uISQLAction in 'Logic\Interfaces\DBUServerService.uISQLAction.pas',
  DBUServerService.uTSQLActions in 'Logic\Classes\DBUServerService.uTSQLActions.pas',
  DBUServerService.uTSQLAction in 'Logic\Classes\DBUServerService.uTSQLAction.pas',
  DBUServerService.uISQLSubject in 'Logic\Interfaces\DBUServerService.uISQLSubject.pas',
  DBUServerService.uISQLSubjects in 'Logic\Interfaces\DBUServerService.uISQLSubjects.pas',
  DBUServerService.uTSQLSubjects in 'Logic\Classes\DBUServerService.uTSQLSubjects.pas',
  DBUServerService.uTSQLSubject in 'Logic\Classes\DBUServerService.uTSQLSubject.pas',
  DBUServerService.Configuration.uTConnection in 'Logic\Classes\DBUServerService.Configuration.uTConnection.pas',
  DBUServerService.uConsts in 'Logic\Other\DBUServerService.uConsts.pas',
  DBUServerService.uTConfiguration in 'Logic\Classes\DBUServerService.uTConfiguration.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
  begin
    Application.Initialize;
  end;
  Application.CreateForm(TDBUServer, DBUServer);
  Application.Run;
end.
