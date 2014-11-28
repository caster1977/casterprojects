unit CreateViewPost;

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
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  CheckLst,
  Buttons,
  CastersPackage.uMysql,
  Main,
  Grids;

type
  TCreateViewPostForm=class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure meMessageKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnProcessClick(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TCreateViewPostForm.btnClearClick(Sender: TObject);
begin
  edbxCaption.Clear;
  cmbbxTo.ItemIndex:=-1;
  meMessage.Clear;
end;

procedure TCreateViewPostForm.btnEraseClick(Sender: TObject);
const
  GroupGUID: string='{A1431DB8-7ED1-4A16-9929-13D2D805AD40}';
var
  s, s_msg_id, q: string;
  b, b1, bError: boolean;
  i: integer;
begin
  bError:=False;
  b1:=False;
  MainForm.LogThis('Попытка удаления сообщения...', GroupGUID, lmtInfo);
  b:=MessageBox(Handle, PChar('Вы действительно хотите удалить текущее сообщение?'), PChar('OA4 - Подтверждение удаления'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if b then
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.ProgressBar1.Max:=2;
      MainForm.LogThis('Удаление сообщения подтверждено пользователем...', GroupGUID, lmtInfo);
      // получение ID выделенного сообщения
      s_msg_id:=lblPostID.Caption;
      // формирование запроса на удаление сообщения из БД
      MainForm.LogThis('Удаление сообщения...', GroupGUID, lmtInfo);
      q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._msg SET msg_erased="1" WHERE msg_id='+s_msg_id+';';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.LogThis('Количество удалённых строк соответствует требуемому (1).', GroupGUID, lmtInfo);
              MainForm.LogThis('Сообщение успешно удалено.', GroupGUID, lmtInfo);
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
      MainForm.ProgressBar1.StepIt;
      Application.ProcessMessages;
      // запись статистики в БД
      if not bError then
        begin
          MainForm.LogThis('Внесение записи в таблицу событий.', GroupGUID, lmtInfo);
          q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"DEL","msg",'+s_msg_id+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
          MainForm.LogThis(q, GroupGUID, lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
          if i=0 then
            begin
              MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              MainForm.LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
              if (i=1) then
                MainForm.LogThis('Запись в таблицу событий внесена успешно', GroupGUID, lmtInfo)
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
        end;
      MainForm.ProgressBar1.StepIt;
      Application.ProcessMessages;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s, GroupGUID, lmtError);
          MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end
  else
    MainForm.LogThis('Удаление сообщения отменено пользователем...', GroupGUID, lmtInfo);
  if b1 then
    ModalResult:=mrOk;
end;

procedure TCreateViewPostForm.btnProcessClick(Sender: TObject);
const
  GroupGUID: string='{47B42EC0-B65C-43DD-A297-D1FAEB94D9EC}';
var
  s, q: string;
  b1, bError: boolean;
  i: integer;
begin
  Screen.Cursor:=crHourGlass;
  bError:=False;
  b1:=False;
  MainForm.LogThis('Попытка пометки сообщения как прочитанного...', GroupGUID, lmtInfo);
  // получение ID выделенного сообщения
  s:=lblPostID.Caption;
  // формирование запроса на удаление сообщения из БД
  MainForm.LogThis('Пометка сообщения...', GroupGUID, lmtInfo);
  MainForm.ProgressBar1.Max:=1;
  q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._msg SET msg_processed="1" WHERE msg_id='+s+';';
  MainForm.LogThis(q, GroupGUID, lmtSQL);
  i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
  if i=0 then
    begin
      MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
      if i=1 then
        begin
          MainForm.ProgressBar1.Max:=i;
          MainForm.LogThis('Количество обработанных строк соответствует требуемому (1).', GroupGUID, lmtInfo);
          MainForm.LogThis('Сообщение успешно удалено.', GroupGUID, lmtInfo);
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
      MainForm.LogThis(s, GroupGUID, lmtError);
      MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  if b1 then
    ModalResult:=mrYes;
end;

procedure TCreateViewPostForm.FormCreate(Sender: TObject);
begin
  btnHelp.Enabled:=Application.HelpFile<>'';
end;

procedure TCreateViewPostForm.FormShow(Sender: TObject);
begin
  btnSend.Enabled:=((edbxCaption.Text<>'')and(cmbbxTo.ItemIndex>-1)and(meMessage.Text<>''));
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

procedure TCreateViewPostForm.meMessageKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    ModalResult:=mrCancel;
end;

end.
