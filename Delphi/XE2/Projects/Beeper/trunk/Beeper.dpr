program Beeper;

uses
  Vcl.Forms,
  Beeper.uTMainForm in 'Beeper.uTMainForm.pas' {MainForm},
  Beeper.uTConfiguration in 'Beeper.uTConfiguration.pas',
  Beeper.uResourceStrings in 'Beeper.uResourceStrings.pas',
  Beeper.uConsts in 'Beeper.uConsts.pas',
  Beeper.uTSignal in 'Beeper.uTSignal.pas',
  Beeper.uTPeriodType in 'Beeper.uTPeriodType.pas',
  Beeper.uISignal in 'Beeper.uISignal.pas',
  Beeper.uISignalList in 'Beeper.uISignalList.pas',
  Beeper.uTSignalList in 'Beeper.uTSignalList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
