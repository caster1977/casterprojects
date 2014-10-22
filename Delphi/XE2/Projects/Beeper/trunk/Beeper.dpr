program Beeper;

{$R 'Beeper.Waves.res' 'SRC\Resources\Beeper.Waves.rc'}

uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  CastersPackage.uISingletonAppSession,
  CastersPackage.uTSingletonAppSession,
  Beeper.uTConfigurationForm in 'SRC\UI\Beeper.uTConfigurationForm.pas' {ConfigurationForm} ,
  Beeper.uTMainForm in 'SRC\UI\Beeper.uTMainForm.pas' {MainForm} ,
  Beeper.uTSignalForm in 'SRC\UI\Beeper.uTSignalForm.pas' {SignalForm} ,
  Beeper.uConsts in 'SRC\Logic\Other\Beeper.uConsts.pas',
  Beeper.uResourceStrings in 'SRC\Logic\Other\Beeper.uResourceStrings.pas',
  Beeper.uTConfiguration in 'SRC\Logic\Classes\Beeper.uTConfiguration.pas',
  Beeper.uTPeriodTypes in 'SRC\Logic\Types\Beeper.uTPeriodTypes.pas',
  Beeper.uTSignal in 'SRC\Logic\Classes\Beeper.uTSignal.pas',
  Beeper.uTSignalList in 'SRC\Logic\Classes\Beeper.uTSignalList.pas',
  Beeper.uIConfiguration in 'SRC\Logic\Interfaces\Beeper.uIConfiguration.pas',
  Beeper.uISignal in 'SRC\Logic\Interfaces\Beeper.uISignal.pas',
  Beeper.uISignalList in 'SRC\Logic\Interfaces\Beeper.uISignalList.pas',
  Beeper.uTSignalThread in 'SRC\Logic\Classes\Beeper.uTSignalThread.pas',
  Beeper.uESignalThread in 'SRC\Logic\Classes\Beeper.uESignalThread.pas',
  Beeper.uEConfiguration in 'SRC\Logic\Classes\Beeper.uEConfiguration.pas';

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
