unit RemoveBan;

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
  TRemoveBanForm= class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RemoveBanForm: TRemoveBanForm;

implementation

{$R *.dfm}

procedure TRemoveBanForm.FormShow(Sender: TObject);
begin
  Button1.SetFocus;
end;

end.
