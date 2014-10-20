program DBUServerManager;

uses
  Vcl.Forms,
  DBUServerManager.uTMainForm in 'UI\DBUServerManager.uTMainForm.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
