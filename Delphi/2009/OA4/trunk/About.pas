unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPI, getFVI, Main;

type
  TAboutForm = class(TForm)
    Timer1: TTimer;
    Shape1: TShape;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Timer2: TTimer;
    Label4: TLabel;
    gsFileVersionInfo1: TgsFileVersionInfo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
	ModalResult:=mrOk;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  gsFileVersionInfo1.Filename:=Application.ExeName;
end;

procedure TAboutForm.FormShow(Sender: TObject);
var
  s: string;
  p: integer;
begin
  if Button1.Visible then
    begin
      Timer1.Enabled:=False;
      AlphaBlendValue:=222;
      Timer2.Enabled:=False;
    end
  else
    begin
      Timer1.Enabled:=True;
      AlphaBlendValue:=0;
      Timer2.Enabled:=True;
    end;
  s:=gsFileVersionInfo1.FileVersion;
  p:=LastDelimiter('.',s);
  s:=copy(s,1,p-1);
  Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
  Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
end;

procedure TAboutForm.Label5Click(Sender: TObject);
begin
  ShellExecute(Application.Handle,'open',PChar('mailto:vlad_dracula@tut.by'),nil,nil,SW_MAXIMIZE);
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
	if ((AlphaBlendValue+17)<=222) then
  	AlphaBlendValue:=AlphaBlendValue+17;
end;

end.
