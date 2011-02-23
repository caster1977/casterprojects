program OA4LogClient;

{$R *.dres}

uses
  Forms,
  Windows,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm};

{$R *.res}
begin
	Application.Initialize;
	if (FindWindow('TMainForm','OA4 Log Client')=0) and (FindWindow('TMainForm','OA4')<>0) then
		begin
      //Application.MainFormOnTaskbar:=True;
			Application.Title:='OA4 Log Client';
      Application.HelpFile:='';
      Application.ShowMainForm:=False;
      Application.CreateForm(TMainForm, MainForm);
  Application.Run;
    end
  else Application.Terminate;
end.
