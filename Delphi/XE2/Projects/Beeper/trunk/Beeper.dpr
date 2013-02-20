program Beeper;

{$R 'Beeper.Waves.res' 'SRC\Resources\Beeper.Waves.rc'}

uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  Beeper.uTAboutForm in 'SRC\UI\Beeper.uTAboutForm.pas' {AboutForm},
  Beeper.uTConfigurationForm in 'SRC\UI\Beeper.uTConfigurationForm.pas' {ConfigurationForm},
  Beeper.uTMainForm in 'SRC\UI\Beeper.uTMainForm.pas' {MainForm},
  Beeper.uTSignalForm in 'SRC\UI\Beeper.uTSignalForm.pas' {SignalForm},
  Beeper.uConsts in 'SRC\Logic\Other\Beeper.uConsts.pas',
  Beeper.uResourceStrings in 'SRC\Logic\Other\Beeper.uResourceStrings.pas',
  Beeper.uTBeeper in 'SRC\Logic\Classes\Beeper.uTBeeper.pas',
  Beeper.uTConfiguration in 'SRC\Logic\Classes\Beeper.uTConfiguration.pas',
  Beeper.uTPeriodTypes in 'SRC\Logic\Types\Beeper.uTPeriodTypes.pas',
  Beeper.uTSignal in 'SRC\Logic\Classes\Beeper.uTSignal.pas',
  Beeper.uTSignalList in 'SRC\Logic\Classes\Beeper.uTSignalList.pas',
  Beeper.uIBeeper in 'SRC\Logic\Interfaces\Beeper.uIBeeper.pas',
  Beeper.uIConfiguration in 'SRC\Logic\Interfaces\Beeper.uIConfiguration.pas',
  Beeper.uISignal in 'SRC\Logic\Interfaces\Beeper.uISignal.pas',
  Beeper.uISignalList in 'SRC\Logic\Interfaces\Beeper.uISignalList.pas',
  Beeper.uTSignalThread in 'SRC\Logic\Classes\Beeper.uTSignalThread.pas',
  Beeper.uESignalThread in 'SRC\Logic\Classes\Beeper.uESignalThread.pas',
  Beeper.uEConfiguration in 'SRC\Logic\Classes\Beeper.uEConfiguration.pas';

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
