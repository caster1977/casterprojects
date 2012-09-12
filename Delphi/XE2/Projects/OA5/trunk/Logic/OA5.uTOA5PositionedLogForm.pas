unit OA5.uTOA5PositionedLogForm;

interface

uses
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
  TOA5PositionedLogForm = class(TPositionedLogForm)
  strict private
    FConfiguration: IConfiguration;
    FCurrentUser: IAccount;
  protected
    procedure InitializeLog; override;
  public
    constructor Create(AOwner: TComponent; const ADialogPosition: TDialogPosition; ABusyCounter: PInteger = nil;
      ARefreshBusyStateMethod: TRefreshBusyStateMethod = nil; AProgressBar: TProgressBar = nil;
      const AConfiguration: IConfiguration = nil; const ACurrentUser: IAccount = nil); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

constructor TOA5PositionedLogForm.Create(AOwner: TComponent; const ADialogPosition: TDialogPosition; ABusyCounter: PInteger;
  ARefreshBusyStateMethod: TRefreshBusyStateMethod; AProgressBar: TProgressBar; const AConfiguration: IConfiguration;
  const ACurrentUser: IAccount);
begin
  inherited Create(AOwner, ADialogPosition, ABusyCounter, ARefreshBusyStateMethod, AProgressBar);
  FConfiguration := AConfiguration;
  FCurrentUser := FCurrentUser;
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
