unit KeeperConnected;

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
  TKeeperConnectedForm= class(TForm)
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
  KeeperConnectedForm: TKeeperConnectedForm;

implementation

{$R *.dfm}

procedure TKeeperConnectedForm.FormShow(Sender: TObject);
begin
  Button1.SetFocus;
end;

end.
