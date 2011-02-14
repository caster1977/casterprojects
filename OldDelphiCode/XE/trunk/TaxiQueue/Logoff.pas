unit Logoff;

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
  StdCtrls,
  ExtCtrls;

type
  TLogoffForm= class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  end;

var
  LogoffForm: TLogoffForm;

implementation

{$R *.dfm}

procedure TLogoffForm.FormShow(Sender: TObject);
begin
  Button1.SetFocus;
end;

end.
