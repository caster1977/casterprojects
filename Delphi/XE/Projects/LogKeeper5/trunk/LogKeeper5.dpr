program LogKeeper5;

uses
  Forms,
  uLogKeeper_MainForm in 'uLogKeeper_MainForm.pas' {MainForm} ,
  uLogKeeper_Consts in 'uLogKeeper_Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
