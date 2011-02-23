unit CreateViewPost;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, mysql, Main, Grids;

type
	TCreateViewPostForm = class(TForm)
		pnlButtons: TPanel;
    btnSend: TButton;
		btnClose: TButton;
		btnHelp: TButton;
    btnClear: TButton;
    Panel1: TPanel;
    pnlID: TPanel;
    lblPostIDCaption: TLabel;
    lblPostID: TLabel;
    Bevel4: TBevel;
    pnlCreation: TPanel;
    lblPostCreatedAtByCaption: TLabel;
    lblPostCreatedAtBy: TLabel;
    Bevel1: TBevel;
    meMessage: TMemo;
    Panel3: TPanel;
    lblCaption: TLabel;
    edbxCaption: TEdit;
    lblTo: TLabel;
    cmbbxTo: TComboBox;
    lblMessage: TLabel;
    btnProcess: TButton;
    btnPrevious: TButton;
    btnNext: TButton;
    btnErase: TButton;
    procedure btnProcessClick(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateViewPostForm: TCreateViewPostForm;

implementation

{$R *.dfm}

procedure TCreateViewPostForm.btnClearClick(Sender: TObject);
begin
  edbxCaption.Clear;
  cmbbxTo.ItemIndex:=-1;
  meMessage.Clear;
end;

procedure TCreateViewPostForm.btnEraseClick(Sender: TObject);
var
  s, q: string;
  b, b1, bError: boolean;
  i: integer;
begin
  bError:=False;
  b1:=False;
  MainForm.LogThis('Попытка удаления сообщения...',lmtInfo);
  b:=MessageBox(Handle,PChar('Вы действительно хотите удалить текущее сообщение?'),PChar('OA4 - Подтверждение удаления'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if b then
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.LogThis('Удаление сообщения подтверждено пользователем...',lmtInfo);
      // получение ID выделенного сообщения
      s:=lblPostID.Caption;
      // формирование запроса на удаление сообщения из БД
      MainForm.LogThis('Удаление сообщения...',lmtInfo);
      q:='UPDATE _msg SET msg_erased="1" WHERE msg_id='+s+';';
      MainForm.LogThis(q,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.ProgressBar1.Max:=i;
          MainForm.ProgressBar1.Step:=1;
          MainForm.LogThis('Запрос выполнен успешно.',lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.LogThis('Количество удалённых строк соответствует требуемому (1).',lmtInfo);
              MainForm.LogThis('Сообщение успешно удалено.',lmtInfo);
              b1:=True;
            end
          else
            begin
              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
              bError:=True;
            end;
          MainForm.ProgressBar1.StepIt;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end
  else MainForm.LogThis('Удаление сообщения отменено пользователем...',lmtInfo);
  if b1 then
    ModalResult:=mrOk;
end;

procedure TCreateViewPostForm.btnProcessClick(Sender: TObject);
var
  s, q: string;
  b1, bError: boolean;
  i: integer;
begin
  Screen.Cursor:=crHourGlass;
  bError:=False;
  b1:=False;
  MainForm.LogThis('Попытка пометки сообщения как прочитанного...',lmtInfo);
  // получение ID выделенного сообщения
  s:=lblPostID.Caption;
  // формирование запроса на удаление сообщения из БД
  MainForm.LogThis('Пометкаа сообщения...',lmtInfo);
  MainForm.ProgressBar1.Max:=1;
  MainForm.ProgressBar1.Step:=1;
  q:='UPDATE _msg SET msg_processed="1" WHERE msg_id='+s+';';
  MainForm.LogThis(q,lmtSQL);
  i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
    begin
      MainForm.LogThis('Запрос выполнен успешно.',lmtInfo);
      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
      if i=1 then
        begin
          MainForm.ProgressBar1.Max:=i;
          MainForm.ProgressBar1.Step:=1;
          MainForm.LogThis('Количество обработанных строк соответствует требуемому (1).',lmtInfo);
          MainForm.LogThis('Сообщение успешно удалено.',lmtInfo);
          b1:=True;
          MainForm.ProgressBar1.StepIt;
        end
      else
        begin
          s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
          bError:=True;
        end;
    end
  else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      MainForm.LogThis(s,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  if b1 then
    ModalResult:=mrYes;
end;

procedure TCreateViewPostForm.FormShow(Sender: TObject);
begin
  btnSend.Enabled:=((edbxCaption.Text<>'') and (cmbbxTo.ItemIndex>-1) and (meMessage.Text<>''));
  if btnSend.Enabled then
    begin
      btnSend.Hint:='Нажмите для отправки сообщения';
      btnSend.Default:=True;
    end
  else
    begin
      btnSend.Hint:='Вы должны заполнить поля "Тема сообщения", "Адресат" и "Текст сообщения" перед отправкой сообщения';
      btnSend.Default:=False;
    end;
end;

end.
