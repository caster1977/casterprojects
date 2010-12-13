program OA4LogServer;



uses
  Forms,
  Windows,
  Main in 'Main.pas' {MainForm},
  mysql in 'mysql.pas',
  About in 'About.pas' {AboutForm};

{$R *.res}

begin
	Application.Initialize;
	if (FindWindow('TMainForm','OA4 Log Server')=0)
   then
		begin
      //Application.MainFormOnTaskbar:=True;
			Application.Title:='OA4 Log Server';
      Application.HelpFile:='';
      Application.ShowMainForm:=False;
      Application.CreateForm(TMainForm, MainForm);
  Application.Run;
    end
  else Application.Terminate;
end.
