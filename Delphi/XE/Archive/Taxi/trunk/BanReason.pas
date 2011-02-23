unit BanReason;

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
  Grids;

type
  TBanReasonForm= class(TForm)
    StringGrid1: TStringGrid;
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BanReasonForm: TBanReasonForm;

implementation

{$R *.dfm}

procedure TBanReasonForm.StringGrid1DblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TBanReasonForm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    ModalResult:=mrOk;
end;

end.
