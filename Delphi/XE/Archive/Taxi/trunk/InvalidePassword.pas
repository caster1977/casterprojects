unit InvalidePassword;

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
  TInvalidePasswordForm= class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvalidePasswordForm: TInvalidePasswordForm;

implementation

{$R *.dfm}

procedure TInvalidePasswordForm.FormShow(Sender: TObject);
begin
  Button1.SetFocus;
end;

end.
