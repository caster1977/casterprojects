program Beeper;

{$R 'waves.res' 'waves.rc'}

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  Signal in 'Signal.pas' {SignalForm},
  Configuration in 'Configuration.pas' {ConfigurationForm},
  Tooltip in 'Tooltip.pas' {ToolTipForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Beeper';
  Application.HelpFile:='';
  Application.ShowMainForm:=False;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
