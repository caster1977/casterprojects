program Taxi;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  KeeperNotLaunched in 'KeeperNotLaunched.pas' {KeeperNotLaunchedForm},
  KeeperConnected in 'KeeperConnected.pas' {KeeperConnectedForm},
  Login in 'Login.pas' {LoginForm},
  RemoveBan in 'RemoveBan.pas' {RemoveBanForm},
  InvalidePassword in 'InvalidePassword.pas' {InvalidePasswordForm},
  Order in 'Order.pas' {OrderForm},
  BannedAutosList in 'BannedAutosList.pas' {BannedAutosForm},
  AddOrder in 'AddOrder.pas' {AddOrderForm},
  OrderList in 'OrderList.pas' {OrderListForm},
  TimedBan in 'TimedBan.pas' {TimedBanForm},
  BanReason in 'BanReason.pas' {BanReasonForm},
  Logoff in 'Logoff.pas' {LogoffForm},
  RemoveBanPass in 'RemoveBanPass.pas' {RemoveBanPassForm},
  mysql in 'mysql.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Taxi 2.51';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
