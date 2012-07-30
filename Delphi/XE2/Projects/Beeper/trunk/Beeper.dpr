program Beeper;

{$R 'Beeper.Waves.res' 'Beeper.Waves.rc'}

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
  Beeper.uTSignalList in 'Beeper.uTSignalList.pas',
  Beeper.uIConfiguration in 'Beeper.uIConfiguration.pas',
  Beeper.uTSignalForm in 'Beeper.uTSignalForm.pas' {SignalForm},
  Beeper.uTAboutForm in 'Beeper.uTAboutForm.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Beeper';
  Application.HelpFile:='';
  Application.ShowMainForm:=False;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
