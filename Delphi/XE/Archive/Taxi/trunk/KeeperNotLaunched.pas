unit KeeperNotLaunched;

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
  TKeeperNotLaunchedForm= class(TForm)
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
  KeeperNotLaunchedForm: TKeeperNotLaunchedForm;

implementation

{$R *.dfm}

procedure TKeeperNotLaunchedForm.FormShow(Sender: TObject);
begin
  Button2.SetFocus;
end;

end.
