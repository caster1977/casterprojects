unit PopUp;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls;

type
  TPopUpForm= class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    LABEL_ApplicationVersion: TLabel;
    LABEL_ApplicationCopyright: TLabel;
    LABEL_ApplicationTitle: TLabel;
    IMAGE_ApplicationIcon: TImage;
    procedure Timer1Timer(Sender: TObject);
  end;

var
  PopUpForm: TPopUpForm;

implementation

{$R *.DFM}

procedure TPopUpForm.Timer1Timer(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.
