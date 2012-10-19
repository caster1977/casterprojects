program Beeper;

{$R 'Beeper.Waves.res' 'Resources\Beeper.Waves.rc'}

uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  Beeper.uTAboutForm in 'UI\Beeper.uTAboutForm.pas' {AboutForm} ,
  Beeper.uTConfigurationForm in 'UI\Beeper.uTConfigurationForm.pas' {ConfigurationForm} ,
  Beeper.uTMainForm in 'UI\Beeper.uTMainForm.pas' {MainForm} ,
  Beeper.uTSignalForm in 'UI\Beeper.uTSignalForm.pas' {SignalForm} ,
  Beeper.uConsts in 'Logic\Other\Beeper.uConsts.pas',
  Beeper.uResourceStrings in 'Logic\Other\Beeper.uResourceStrings.pas',
  Beeper.uTBeeper in 'Logic\Classes\Beeper.uTBeeper.pas',
  Beeper.uTConfiguration in 'Logic\Classes\Beeper.uTConfiguration.pas',
  Beeper.uTPeriodType in 'Logic\Classes\Beeper.uTPeriodType.pas',
  Beeper.uTSignal in 'Logic\Classes\Beeper.uTSignal.pas',
  Beeper.uTSignalList in 'Logic\Classes\Beeper.uTSignalList.pas',
  Beeper.uIBeeper in 'Logic\Interfaces\Beeper.uIBeeper.pas',
  Beeper.uIConfiguration in 'Logic\Interfaces\Beeper.uIConfiguration.pas',
  Beeper.uISignal in 'Logic\Interfaces\Beeper.uISignal.pas',
  Beeper.uISignalList in 'Logic\Interfaces\Beeper.uISignalList.pas';

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
      begin
        BeeperInstance.ShowError;
      end;
    end;
  end;

end.
