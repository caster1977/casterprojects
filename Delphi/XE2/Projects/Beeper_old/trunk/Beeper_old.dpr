program Beeper_old;

{$R 'Beeper.Waves.res' 'Beeper.Waves.rc'}

uses
  Forms,
  Beeper.uMainForm in 'Beeper.uMainForm.pas' {MainForm},
  Beeper.uAboutForm in 'Beeper.uAboutForm.pas' {AboutForm},
  Beeper.uSignalForm in 'Beeper.uSignalForm.pas' {SignalForm},
  Beeper.uConfigurationForm in 'Beeper.uConfigurationForm.pas' {ConfigurationForm},
  Beeper.uTooltipForm in 'Beeper.uTooltipForm.pas' {ToolTipForm},
  Vcl.Themes,
  Vcl.Styles,
  Beeper.uSignalClass in 'Beeper.uSignalClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Beeper';
  Application.HelpFile:='';
  Application.ShowMainForm:=False;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
