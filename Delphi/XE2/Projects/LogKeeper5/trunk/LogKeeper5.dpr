program LogKeeper5;

uses
  Forms,
  LogKeeper5.uMainForm in 'LogKeeper5.uMainForm.pas' {MainForm},
  LogKeeper5.uConsts in 'LogKeeper5.uConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
