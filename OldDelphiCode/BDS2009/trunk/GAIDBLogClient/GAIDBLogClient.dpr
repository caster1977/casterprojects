program GAIDBLogClient;

uses
	Forms,
	Windows,
	Main in 'Main.pas' {MainForm},
	About in 'About.pas' {AboutForm};

{$R *.res}
begin
	Application.Initialize;
	if (FindWindow('TMainForm','GAIDB Log Client')=0) and (FindWindow('TMainForm','GAIDB')<>0) then
		begin
			Application.Title:='GAIDB Log Client';
      Application.HelpFile:='';
      Application.ShowMainForm:=False;
      Application.CreateForm(TMainForm, MainForm);
			Application.Run;
    end
  else Application.Terminate;
end.
