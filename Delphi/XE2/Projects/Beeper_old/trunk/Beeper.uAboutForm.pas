unit Beeper.uAboutForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  ShellAPI,
  CastersPackage.getFVI,
  Beeper.uMainForm;

type
  TAboutForm=class(TForm)
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
    procedure Timer2Timer(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAboutForm.Label5Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
  if ((AlphaBlendValue+17)<=222) then
    AlphaBlendValue:=AlphaBlendValue+17;
end;

end.
