program Beeper;

{$R 'Beeper.Waves.res' 'Beeper.Waves.rc'}

uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  Beeper.uTMainForm in 'Beeper.uTMainForm.pas' {MainForm} ,
  Beeper.uTConfiguration in 'Beeper.uTConfiguration.pas',
  Beeper.uResourceStrings in 'Beeper.uResourceStrings.pas',
  Beeper.uConsts in 'Beeper.uConsts.pas',
  Beeper.uTSignal in 'Beeper.uTSignal.pas',
  Beeper.uTPeriodType in 'Beeper.uTPeriodType.pas',
  Beeper.uISignal in 'Beeper.uISignal.pas',
  Beeper.uISignalList in 'Beeper.uISignalList.pas',
  Beeper.uTSignalList in 'Beeper.uTSignalList.pas',
  Beeper.uIConfiguration in 'Beeper.uIConfiguration.pas',
  Beeper.uTSignalForm in 'Beeper.uTSignalForm.pas' {SignalForm} ,
  Beeper.uTAboutForm in 'Beeper.uTAboutForm.pas' {AboutForm} ,
  Beeper.uTConfigurationForm in 'Beeper.uTConfigurationForm.pas' {ConfigurationForm} ,
  Beeper.uTBeeper in 'Beeper.uTBeeper.pas',
  Beeper.uIBeeper in 'Beeper.uIBeeper.pas';

{$R *.res}

var
  BeeperInstance: IBeeper;

begin
  Application.Initialize;
  Application.Title := APPLICATION_NAME;
  BeeperInstance := GetIBeeper;
  if Assigned(BeeperInstance) then
  begin
    if not BeeperInstance.StartSession then
    begin
      if GetLastError = ERROR_ALREADY_EXISTS then
      begin
        BeeperInstance.SendActivationSignal;
      end
      else
      begin
        BeeperInstance.ShowError;
      end;
    end
    else
    begin
      Application.HelpFile := EmptyStr;
      Application.ShowMainForm := True;
      Application.MainFormOnTaskbar := True;
      Application.CreateForm(TMainForm, MainForm);
      Application.Run;
      if not BeeperInstance.StopSession then
        BeeperInstance.ShowError;
    end;
  end;

end.
