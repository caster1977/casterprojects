unit RemoveBanPass;

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
  StdCtrls;

type
  TRemoveBanPassForm= class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RemoveBanPassForm: TRemoveBanPassForm;

implementation

{$R *.dfm}

procedure TRemoveBanPassForm.FormShow(Sender: TObject);
begin
  ActiveControl:=Edit1;
end;

end.
