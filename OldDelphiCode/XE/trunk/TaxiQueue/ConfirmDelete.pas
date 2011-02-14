unit ConfirmDelete;

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
  TConfirmDeleteForm= class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  end;

var
  ConfirmDeleteForm: TConfirmDeleteForm;

implementation

{$R *.dfm}

procedure TConfirmDeleteForm.FormShow(Sender: TObject);
begin
  Button1.SetFocus;
end;

end.
