program Beeper;

{$R 'Beeper.Waves.res' 'Resources\Beeper.Waves.rc'}

uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  CastersPackage.uISingletonAppSession,
  CastersPackage.uTSingletonAppSession,
  Beeper.uTConfigurationForm in 'UI\Beeper.uTConfigurationForm.pas' {ConfigurationForm},
  Beeper.uTMainForm in 'UI\Beeper.uTMainForm.pas' {MainForm},
  Beeper.uTSignalForm in 'UI\Beeper.uTSignalForm.pas' {SignalForm},
  Beeper.uConsts in 'Logic\Other\Beeper.uConsts.pas',
  Beeper.uResourceStrings in 'Logic\Other\Beeper.uResourceStrings.pas',
  Beeper.uTConfiguration in 'Logic\Classes\Beeper.uTConfiguration.pas',
  Beeper.uTPeriodTypes in 'Logic\Types\Beeper.uTPeriodTypes.pas',
  Beeper.uTSignal in 'Logic\Classes\Beeper.uTSignal.pas',
  Beeper.uTSignalList in 'Logic\Classes\Beeper.uTSignalList.pas',
  Beeper.uIConfiguration in 'Logic\Interfaces\Beeper.uIConfiguration.pas',
  Beeper.uISignal in 'Logic\Interfaces\Beeper.uISignal.pas',
  Beeper.uISignalList in 'Logic\Interfaces\Beeper.uISignalList.pas',
  Beeper.uTSignalThread in 'Logic\Classes\Beeper.uTSignalThread.pas',
  Beeper.uESignalThread in 'Logic\Classes\Beeper.uESignalThread.pas';

{$R *.res}

var
  AppSession: ISingletonAppSession;

begin
  Application.Initialize;
  Application.Title := APPLICATION_NAME;
  AppSession := GetISingletonAppSession;
  if not Assigned(AppSession) then
  begin
    Exit;
  end;

  if not AppSession.Start then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      AppSession.Activate;
    end
    else
    begin
      AppSession.ShowError;
    end;
    Exit;
  end;

  Application.HelpFile := EmptyStr;
  Application.ShowMainForm := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
  if not AppSession.Stop then
  begin
    AppSession.ShowError;
  end;
end.
