program Beeper_old;



uses
  Forms,
  Beeper.uMainForm in 'UI\Beeper.uMainForm.pas' {MainForm},
  Beeper.uAboutForm in 'UI\Beeper.uAboutForm.pas' {AboutForm},
  Beeper.uSignalForm in 'UI\Beeper.uSignalForm.pas' {SignalForm},
  Beeper.uConfigurationForm in 'UI\Beeper.uConfigurationForm.pas' {ConfigurationForm},
  Beeper.uTooltipForm in 'UI\Beeper.uTooltipForm.pas' {ToolTipForm},
  Vcl.Themes,
  Vcl.Styles,
  Beeper.uSignalClass in 'Logic\Classes\Beeper.uSignalClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Beeper';
  Application.HelpFile:='';
  Application.ShowMainForm:=False;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
