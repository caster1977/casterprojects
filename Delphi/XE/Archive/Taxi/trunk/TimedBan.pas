unit TimedBan;

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
  Grids;

type
  TTimedBanForm= class(TForm)
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TimedBanForm: TTimedBanForm;

implementation

{$R *.dfm}

procedure TTimedBanForm.Edit1Change(Sender: TObject);
begin
  Button1.Enabled:=(StrToIntDef(Edit1.Text, -1)>0);
end;

procedure TTimedBanForm.Edit1KeyPress(Sender: TObject; var Key: Char);
var // �������� �����
  vrPos, vrLength, vrSelStart: byte;
const
  I: byte=1;
  // I+1 = ���������� ������ ����� ������� (� ������ ������ - 2 �����)
begin
  with Sender as TEdit do
    begin
      vrLength:=Length(Text); // ���������� ����� ������
      vrPos:=Pos(',', Text); // ��������� ������� �������
      vrSelStart:=SelStart; // ���������� ��������� �������
    end;
  case Key of
    '0'..'9':
      begin
        // ��������� ��������� ������� � ���������� ������ ����� �������
        if (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos) then
          Key:=#0; // "��������" �������
      end;
    ',', '.':
      begin
        // ���� ������� ��� ���� ��� ������� �������� ��������� �����
        // ������ ��� ������� ���� � ���� ����� ��� ���
        if (vrPos>0)or(vrSelStart=0)or(vrLength=0) then
          Key:=#0 // "��������" �������
        else
          Key:=#44; // ������ �������� ����� �� �������
      end;
    #8:
      ; // ��������� �������� ������ �������� 'Back Space'
  else
    Key:=#0; // "��������" ��� ��������� �������
  end;
end;

procedure TTimedBanForm.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
