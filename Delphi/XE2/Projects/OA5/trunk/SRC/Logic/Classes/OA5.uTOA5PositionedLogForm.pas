unit OA5.uTOA5PositionedLogForm;

interface

uses
  OA5.uIOA5Form,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  CastersPackage.uTPositionedLogForm,
  CastersPackage.uTRefreshBusyStateMethod,
  CastersPackage.uTDialogPosition,
  Vcl.ComCtrls,
  OA5.uIConfiguration,
  OA5.uIAccount;

type
  TOA5PositionedLogForm = class(TPositionedLogForm, IOA5Form)
  strict private
    FConfiguration: IConfiguration;
    FCurrentUser: IAccount;
  protected
    procedure InitializeLog; override;
    function GetConfiguration: IConfiguration; virtual;
    function GetCurrentUser: IAccount; virtual;
    property Configuration: IConfiguration read GetConfiguration nodefault;
    property CurrentUser: IAccount read GetCurrentUser nodefault;
  public
    constructor Create(AOwner: TComponent; const ADialogPosition: TDialogPosition;
      ABusyCounter: PInteger = nil; ARefreshBusyStateMethod: TRefreshBusyStateMethod = nil;
      AProgressBar: TProgressBar = nil; const AConfiguration: IConfiguration = nil;
      const ACurrentUser: IAccount = nil); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

constructor TOA5PositionedLogForm.Create(AOwner: TComponent; const ADialogPosition: TDialogPosition;
  ABusyCounter: PInteger; ARefreshBusyStateMethod: TRefreshBusyStateMethod;
  AProgressBar: TProgressBar; const AConfiguration: IConfiguration; const ACurrentUser: IAccount);
begin
  inherited Create(AOwner, ADialogPosition, ABusyCounter, ARefreshBusyStateMethod, AProgressBar);
  FConfiguration := AConfiguration;
  FCurrentUser := FCurrentUser;
end;

function TOA5PositionedLogForm.GetConfiguration: IConfiguration;
begin
  Result := FConfiguration;
end;

function TOA5PositionedLogForm.GetCurrentUser: IAccount;
begin
  Result := FCurrentUser;
end;

procedure TOA5PositionedLogForm.InitializeLog;
begin
  inherited;
  if Assigned(FCurrentUser) then
  begin
    Log.UserName := FCurrentUser.Login;
  end;
  if Assigned(FConfiguration) then
  begin
    Log.AllowedTypes := FConfiguration.KeepLogTypes;
    Log.Enabled := FConfiguration.EnableLog;
  end;
end;

end.
