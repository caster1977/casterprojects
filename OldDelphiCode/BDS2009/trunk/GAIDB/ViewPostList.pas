unit ViewPostList;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, mysql, Main, Grids,
  ImgList;

type
	TViewPostListForm = class(TForm)
		pnlButtons: TPanel;
    btnCreate: TButton;
		btnClose: TButton;
		btnHelp: TButton;
    btnView: TButton;
    btnErase: TButton;
    Panel1: TPanel;
    pnlID: TPanel;
    lblIDCaption: TLabel;
    lblID: TLabel;
    lvMessages: TListView;
    ilPost: TImageList;
    procedure lvMessagesDblClick(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvMessagesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPostListForm: TViewPostListForm;

implementation

{$R *.dfm}

uses CreateViewPost;

procedure TViewPostListForm.btnCreateClick(Sender: TObject);
var
  mr: TModalResult;
  s, q: string;
  bError: boolean;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  TSL: TStringList;
  RTFStream: TMemoryStream;
	pacCaption, pacText: PAnsiChar;
begin
  bError:=False;
  ResultSet:=nil;
  pacCaption:=nil;
  pacText:=nil;
  MainForm.LogThis('Попытка открытия окна отправки сообщения...',lmtInfo);
  with TCreateViewPostForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      MainForm.ImageList2.GetIcon(18,Icon);
      Caption:='OA4 - Новое сообщение';
      Hint:='Окно отправки сообщения';
      pnlID.Visible:=False;
      lblTo.Visible:=True;
      cmbbxTo.Visible:=True;
      edbxCaption.ReadOnly:=False;
      meMessage.ReadOnly:=False;
      pnlCreation.Visible:=False;
      btnClear.Visible:=True;
      btnProcess.Visible:=False;
      btnErase.Visible:=False;
      btnPrevious.Visible:=False;
      btnNext.Visible:=False;
      btnSend.Visible:=True;
      btnHelp.Enabled:=Application.HelpFile<>'';
      ActiveControl:=edbxCaption;
      cmbbxTo.Clear;
      // получение списка пользователей
      MainForm.LogThis('Получение списка пользователей...',lmtInfo);
      q:='SELECT usr_fullname FROM _usr WHERE usr_erased="0" GROUP BY usr_fullname ORDER BY usr_fullname;';
      MainForm.LogThis(q,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.',lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              MainForm.LogThis('Результирующая выборка получена успешно.',lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  MainForm.ProgressBar1.Max:=i;
                  MainForm.ProgressBar1.Step:=1;
                  MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
                  for j:=0 to i-1 do
                    begin
                      MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',lmtInfo);
                          cmbbxTo.Items.Add(ResultRow[0]);
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                      MainForm.ProgressBar1.StepIt;
                    end;
                  MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
                end
              else
                begin
                  s:='В системе не зарегестрироывано ни одного пользователя!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      if ResultSet<>nil then
        begin
          MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.',lmtInfo);
          mysql_free_result(ResultSet);
        end;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else MainForm.LogThis('Список пользователей получен успешно...',lmtInfo);
      if bError=False then
        begin
          cmbbxTo.Items.Add('[ группа администраторов ]');
          cmbbxTo.Items.Add('[ группа операторов ]');
          cmbbxTo.Items.Add('[ группа пользователей ]');
          ShowModal;
        end;
    finally
      mr:=ModalResult;
      if mr=mrOk then
        begin
          // определение id пользователя
          TSL:=TStringList.Create;
          try
            if ((cmbbxTo.Text='[ группа администраторов ]') or (cmbbxTo.Text='[ группа операторов ]') or (cmbbxTo.Text='[ группа пользователей ]')) then
              begin
                if cmbbxTo.Text='[ группа администраторов ]' then
                  begin
                    MainForm.LogThis('Получение списка идентификаторов администраторов...',lmtInfo);
                    q:='SELECT usr_id FROM _usr WHERE usr_erased="0" and usr_is_admin="1" GROUP BY usr_id ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа операторов ]' then
                  begin
                    MainForm.LogThis('Получение списка идентификаторов операторов...',lmtInfo);
                    q:='SELECT usr_id FROM _usr WHERE usr_erased="0" and usr_can_edit_db="1" GROUP BY usr_id ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа пользователей ]' then
                  begin
                    MainForm.LogThis('Получение списка идентификаторов пользователей...',lmtInfo);
                    q:='SELECT usr_id FROM _usr WHERE usr_erased="0" and usr_is_admin="0" GROUP BY usr_id ORDER BY usr_id;';
                  end;
              end
            else
              begin
                MainForm.LogThis('Получение идентификатора указанного пользователя...',lmtInfo);
                q:='SELECT usr_id FROM _usr WHERE usr_fullname="'+cmbbxTo.Text+'" ORDER BY usr_id;';
              end;
            MainForm.LogThis(q,lmtSQL);
            i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
            if i=0 then
              begin
                MainForm.LogThis('Запрос выполнен успешно.',lmtInfo);
                ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                if ResultSet<>nil then
                  begin
                    MainForm.LogThis('Результирующая выборка получена успешно.',lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    if i>0 then
                      begin
                        MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
                        MainForm.ProgressBar1.Max:=i;
                        MainForm.ProgressBar1.Step:=1;
                        for j:=0 to i-1 do
                          begin
                            MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',lmtInfo);
                                TSL.Add(ResultRow[0]);
                              end
                            else
                              begin
                                s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                bError:=True;
                              end;
                            MainForm.ProgressBar1.StepIt;
                          end;
                      end
                    else
                      begin
                        s:='В системе не зарегестрироывано ни одного пользователя с такими правами!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                    bError:=True;
                  end;
              end
            else
              begin
                s:='Возникла ошибка при выполнении запроса!';
                bError:=True;
              end;
            if bError then
              begin
                MainForm.LogThis(s,lmtError);
                MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else MainForm.LogThis('Список идентификаторов получен успешно...',lmtInfo);
            if ResultSet<>nil then
              begin
                MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.',lmtInfo);
                mysql_free_result(ResultSet);
              end;
            MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
            // если в списке имеется один и более элемент, то в цикле выполняем запросы
            if not bError then
              begin
	              RTFStream:=TMemoryStream.Create;
	              try
                  // преобразование темы
                  pacCaption:=GetMemory(Length(edbxCaption.Text)*2+1);
                  mysql_escape_string(pacCaption,PAnsiChar(edbxCaption.Text),Length(edbxCaption.Text));
                  // преобразование сообщения
                  meMessage.Lines.SaveToStream(RTFStream);
                  RTFStream.Seek(0,soFromBeginning);
                  pacText:=GetMemory(RTFStream.Size*2+1);
                  mysql_escape_string(pacText,RTFStream.Memory,RTFStream.Size);
                  MainForm.ProgressBar1.Max:=TSL.Count;
                  MainForm.ProgressBar1.Step:=1;
                  for j:=0 to TSL.Count-1 do
                    begin
                      // добавление сообщения
                      MainForm.LogThis('Добавление нового сообщения...',lmtInfo);
                      q:= 'INSERT INTO _msg (msg_id, msg_erased, msg_processed, msg_for_user_id, '+
                          'msg_caption, msg_text, msg_created_at, msg_created_by_user_id) VALUES '+
                          '(NULL, "0", "0", '+TSL.Strings[j]+', "'+pacCaption+'", "'+pacText+'", Now(), '+MainForm.CurrentUser.sID+');';
                      MainForm.LogThis(q,lmtSQL);
                      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
                      if i=0 then
                        begin
                          MainForm.LogThis('Запрос выполнен успешно.',lmtInfo);
                          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                          if i=1 then
                            begin
                              MainForm.LogThis('Количество строк выборки соответствует требуемому.',lmtInfo);
                              MainForm.LogThis('Сообщение успешно отправлено получателю.',lmtInfo);
                            end
                          else
                            begin
                              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                              bError:=True;
                            end
                        end
                      else
                        begin
                          s:='Возникла ошибка при выполнении запроса!';
                          bError:=True;
                        end;
                      if bError then
                        begin
                          MainForm.LogThis(s,lmtError);
                          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                        end;
                      MainForm.ProgressBar1.StepIt;
                    end;
                  MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
                finally
                  FreeMemory(pacCaption);
                  FreeMemory(pacText);
                  RTFStream.Free;
                end;
              end;
          finally
            TSL.Free;
          end;
        end;
      Free;
    end;
end;

procedure TViewPostListForm.btnEraseClick(Sender: TObject);
var
  s, q: string;
  b, bError: boolean;
  i: integer;
begin
  bError:=False;
  MainForm.LogThis('Попытка удаления сообщения...',lmtInfo);
  b:=MessageBox(Handle,PChar('Вы действительно хотите удалить выделенное сообщение?'),PChar('OA4 - Подтверждение удаления'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if b then
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.LogThis('Удаление сообщения подтверждено пользователем...',lmtInfo);
      // получение ID выделенного сообщения
      s:=lvMessages.Selected.SubItems[2];
      // формирование запроса на удаление сообщения из БД
      MainForm.LogThis('Удаление сообщения...',lmtInfo);
      q:='UPDATE _msg SET msg_erased="1" WHERE msg_id='+s+';';
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
              MainForm.LogThis('Количество удалённых строк соответствует требуемому (1).',lmtInfo);
              MainForm.LogThis('Сообщение успешно удалено.',lmtInfo);
              lvMessages.Selected.Delete;
              btnView.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
              btnErase.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
              MainForm.ProgressBar1.StepIt;
            end
          else
            begin
              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
              bError:=True;
            end
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
end;

procedure TViewPostListForm.btnViewClick(Sender: TObject);
var
  mr: TModalResult;
  s, q: string;
  bError: boolean;
  i: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  bError:=False;
  ResultSet:=nil;
  MainForm.LogThis('Попытка открытия окна просмотра сообщения...',lmtInfo);
  with TCreateViewPostForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      ilPost.GetIcon(lvMessages.Selected.ImageIndex,Icon);
      Caption:='OA4 - Просмотр сообщения';
      Hint:='Окно просмотра сообщения';
      pnlID.Visible:=MainForm.Configuration.bShowID;
      lblTo.Visible:=False;
      cmbbxTo.Visible:=False;
      edbxCaption.ReadOnly:=True;
      meMessage.ReadOnly:=True;
      pnlCreation.Visible:=True;
      btnClear.Visible:=False;
      btnProcess.Visible:=True;
      btnErase.Visible:=True;
      btnSend.Visible:=False;
      edbxCaption.Width:=meMessage.Width;
      btnClose.Default:=True;
      btnHelp.Enabled:=Application.HelpFile<>'';
      if btnNext.Visible then
        ActiveControl:=btnNext
      else
        ActiveControl:=btnClose;
      // получение ID выделенного сообщения
      s:=lvMessages.Selected.SubItems[2];
      // формирование запроса на удаление сообщения из БД
      MainForm.LogThis('Открытие сообщения...',lmtInfo);
      q:='SELECT msg_id, msg_processed, msg_caption, msg_text, msg_created_at, usr_fullname FROM _msg LEFT JOIN _usr ON usr_id=msg_created_by_user_id WHERE msg_id='+s+';';
      MainForm.LogThis(q,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.',lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              MainForm.LogThis('Результирующая выборка получена успешно.',lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>=0 then
                begin
                  MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
                  if i=1 then
                    begin
                      MainForm.ProgressBar1.Max:=i;
                      MainForm.ProgressBar1.Step:=1;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          MainForm.LogThis('Операция получения строки выборки прошла успешно.',lmtInfo);
                          lblPostID.Caption:=ResultRow[0];
                          btnProcess.Enabled:=ResultRow[1]='0';
                          edbxCaption.Text:=ResultRow[2];
                          meMessage.Text:=ResultRow[3];
                          lblPostCreatedAtBy.Caption:=ResultRow[5]+', '+ResultRow[4];
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(i)+')!';
                          bError:=True;
                        end;
                      MainForm.ProgressBar1.StepIt;
                    end
                  else
                    begin
                      s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='В системе не зарегестрироывано ни одного пользователя с такими правами!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      if ResultSet<>nil then
        begin
          MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.',lmtInfo);
          mysql_free_result(ResultSet);
        end;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
      if bError=False then
        ShowModal;
    finally
      if bError=False then
        begin
          mr:=ModalResult;
          if mr=mrOk then // если запись была удалена, значит точно будет результат mrOk
            begin
              MainForm.LogThis('Обновление списка сообщений после успешного удаления открытого сообщения.',lmtInfo);
              lvMessages.Selected.Delete;
              btnView.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
              btnErase.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
            end;
          if mr=mrYes then // если запись была удалена, значит точно будет результат mrOk
            begin
              MainForm.LogThis('Обновление списка сообщений после успешной пометки открытого сообщения как прочитанного.',lmtInfo);
              lvMessages.Selected.ImageIndex:=1;
            end;
        end;
      Free;
    end;
end;

procedure TViewPostListForm.FormCreate(Sender: TObject);
begin
  btnView.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
  btnErase.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
end;

procedure TViewPostListForm.lvMessagesDblClick(Sender: TObject);
begin
  if lvMessages.Selected<>nil then
    begin
      if btnView.Visible and btnView.Enabled and btnView.Default then
        btnView.Click;
    end;
end;

procedure TViewPostListForm.lvMessagesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnView.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
  btnErase.Enabled:=(lvMessages.Items.Count>0) and (lvMessages.ItemIndex>=0);
  if lvMessages.ItemIndex>=0 then
    lblID.Caption:=lvMessages.Selected.SubItems[2]
  else lblID.Caption:='';
  if btnView.Enabled then
    begin
      btnClose.Default:=False;
      btnView.Default:=True;
    end
  else
    begin
      btnView.Default:=False;
      btnClose.Default:=True;
    end;
end;

end.
