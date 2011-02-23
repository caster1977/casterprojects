unit AddOrder;

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
  Mask,
  ComCtrls,
  mysql;

type
  TAddOrderForm= class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RichEdit1: TRichEdit;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ListBox1: TListBox;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadStreets;
  end;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);

var
  AddOrderForm: TAddOrderForm;

implementation

{$R *.dfm}

uses
  Main;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  s:=Source;
  if Destination=nil then
    Destination:=TStringList.Create
  else
    Destination.Clear;
  Destination.Sorted:=False;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if i=0 then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s, 0, i-1);
          Destination.Add(s1);
          s1:=Copy(s, i+1, Length(s));
          s:=s1;
        end;
    end;
end;

procedure TAddOrderForm.FormCreate(Sender: TObject);
begin
  LoadStreets;
end;

procedure TAddOrderForm.FormShow(Sender: TObject);
begin
  MaskEdit1.SetFocus;
  MaskEdit1.SelStart:=1;
  MaskEdit1.SelLength:=1;
end;

procedure TAddOrderForm.LoadStreets;
var
  s, q: string;
  i, j, l: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  // bError: boolean;
  slA: TStringList;
begin
  //
  ListBox1.Clear;
  ListBox1.Items.Append('<неизвестная улица>');
  slA:=TStringList.Create;
  try
    slA.Duplicates:=dupIgnore;
    q:='SELECT id_street, streetname FROM streets WHERE Active=1 ORDER BY streetname';
    i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
    if i=0 then
      begin
        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
        if ResultSet<>nil then
          begin
            i:=mysql_num_rows(ResultSet);
            if i>0 then
              begin
                s:='Количество строк выборки равно '+IntToStr(i)+'.';
                for j:=0 to i-1 do
                  begin
                    s:='Получение очередной строки выборки ('+IntToStr(j)+').';
                    ResultRow:=mysql_fetch_row(ResultSet);
                    if ResultRow<>nil then
                      begin
                        s:='Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.';
                        CutStringByLimiterToStringList(string(ResultRow[1]), slA, ';');
                        for l:=0 to slA.Count-1 do
                          begin
                            ListBox1.Items.Add(Trim(slA[l]));
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                        // bError:=True;
                      end;
                  end;
              end
            else
              begin
                s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                // bError:=True;
              end;
          end
        else
          begin
            // s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          end;
      end
    else
      begin
        // s:='Возникла ошибка при выполнении запроса!';
      end;
  finally
    slA.Free;
  end;
end;

end.
