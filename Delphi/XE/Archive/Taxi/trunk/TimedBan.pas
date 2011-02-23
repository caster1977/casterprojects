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
var // цифровая маска
  vrPos, vrLength, vrSelStart: byte;
const
  I: byte=1;
  // I+1 = количество знаков после запятой (в данном случае - 2 знака)
begin
  with Sender as TEdit do
    begin
      vrLength:=Length(Text); // определяем длину текста
      vrPos:=Pos(',', Text); // проверяем наличие запятой
      vrSelStart:=SelStart; // определяем положение курсора
    end;
  case Key of
    '0'..'9':
      begin
        // проверяем положение курсора и количество знаков после запятой
        if (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos) then
          Key:=#0; // "погасить" клавишу
      end;
    ',', '.':
      begin
        // если запятая уже есть или запятую пытаются поставить перед
        // числом или никаких цифр в поле ввода еще нет
        if (vrPos>0)or(vrSelStart=0)or(vrLength=0) then
          Key:=#0 // "погасить" клавишу
        else
          Key:=#44; // всегда заменять точку на запятую
      end;
    #8:
      ; // позволить удаление знаков клавишей 'Back Space'
  else
    Key:=#0; // "погасить" все остальные клавиши
  end;
end;

procedure TTimedBanForm.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
