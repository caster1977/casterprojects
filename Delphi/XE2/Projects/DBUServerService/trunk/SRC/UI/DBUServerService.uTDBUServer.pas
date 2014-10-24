unit DBUServerService.uTDBUServer;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.SvcMgr,
  Vcl.Dialogs,
  IdContext,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdTCPServer,
  IdCmdTCPServer,
  IdCommandHandlers;

type
  TDBUServer = class(TService)
    IdCmdTCPServer: TIdCmdTCPServer;
    procedure IdCmdTCPServerConnect(AContext: TIdContext);
    procedure IdCmdTCPServerDisconnect(AContext: TIdContext);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure CmdTCPServerCommandHandlers0Command(ASender: TIdCommand);
  public
    function GetServiceController: TServiceController; override;
  end;

var
  DBUServer: TDBUServer;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  DBUServer.Controller(CtrlCode);
end;

procedure TDBUServer.CmdTCPServerCommandHandlers0Command(ASender: TIdCommand);
begin
  ASender.Context.Connection.IOHandler.WriteLnRFC('CONNECTION_TEST_OK');
end;

procedure TDBUServer.IdCmdTCPServerConnect(AContext: TIdContext);
begin
  LogMessage('DBU client connected', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.IdCmdTCPServerDisconnect(AContext: TIdContext);
begin
  LogMessage('DBU client disconnected', EVENTLOG_INFORMATION_TYPE);
end;

function TDBUServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TDBUServer.ServiceBeforeUninstall(Sender: TService);
begin
  IdCmdTCPServer.Active := False;
end;

procedure TDBUServer.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  IdCmdTCPServer.Active := True;
end;

procedure TDBUServer.ServicePause(Sender: TService; var Paused: Boolean);
begin
  IdCmdTCPServer.Active := False;
end;

procedure TDBUServer.ServiceShutdown(Sender: TService);
begin
  IdCmdTCPServer.Active := False;
end;

procedure TDBUServer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  IdCmdTCPServer.Active := True;
  LogMessage('DBU Server started', EVENTLOG_INFORMATION_TYPE);
end;

procedure TDBUServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  IdCmdTCPServer.Active := False;
  LogMessage('DBU Server stopped', EVENTLOG_INFORMATION_TYPE);
end;

end.
