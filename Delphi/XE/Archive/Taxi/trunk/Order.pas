unit Order;

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
  Mask;

type
  TOrderForm= class(TForm)
    MaskEdit1: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrderForm: TOrderForm;

implementation

{$R *.dfm}

procedure TOrderForm.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
