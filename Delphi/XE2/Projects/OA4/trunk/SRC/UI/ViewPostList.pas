unit ViewPostList;

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
  Grids,
  ImgList;

type
  TViewPostListForm=class(TForm)
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
    Bevel4: TBevel;
    procedure lvMessagesDblClick(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvMessagesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
  end;

var
  ViewPostListForm: TViewPostListForm;

implementation

{$R *.dfm}

uses
  CreateViewPost;

procedure TViewPostListForm.btnCreateClick(Sender: TObject);
const
  GroupGUID: string='{C95816A0-63F7-41D3-B844-EBFB321799BE}';
var
  mr: TModalResult;
  s, q: string;
  bError: boolean;
  i, j, iLastID: integer;
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
  iLastID:=-1;
  MainForm.LogThis('Попытка открытия окна отправки сообщения...', GroupGUID, lmtInfo);
  with TCreateViewPostForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      MainForm.ImageList2.GetIcon(18, Icon);
      Caption:='OA4 - Новое сообщение';
      Hint:='Окно отправки сообщения';
      pnlID.Visible:=False;
      lblTo.Visible:=True;
      cmbbxTo.Visible:=True;
      edbxCaption.readonly:=False;
      meMessage.readonly:=False;
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
      MainForm.LogThis('Получение списка пользователей...', GroupGUID, lmtInfo);
      q:='SELECT usr_fullname FROM '+MainForm.Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" GROUP BY usr_fullname ORDER BY usr_fullname;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              MainForm.LogThis('Результирующая выборка получена успешно.', GroupGUID, lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  MainForm.ProgressBar1.Max:=i;
                  MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                  for j:=0 to i-1 do
                    begin
                      MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', GroupGUID, lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', GroupGUID, lmtInfo);
                          cmbbxTo.Items.Add(string(ResultRow[0]));
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
          MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.', GroupGUID, lmtInfo);
          mysql_free_result(ResultSet);
        end;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s, GroupGUID, lmtError);
          MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else
        MainForm.LogThis('Список пользователей получен успешно...', GroupGUID, lmtInfo);
      if MainForm.Configuration.fpCreateViewPostForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=MainForm.Configuration.fpCreateViewPostForm.y;
          Left:=MainForm.Configuration.fpCreateViewPostForm.x;
        end;
      if bError=False then
        begin
          cmbbxTo.Items.Add('[ группа администраторов ]');
          cmbbxTo.Items.Add('[ группа операторов ]');
          cmbbxTo.Items.Add('[ группа пользователей ]');
          ShowModal;
        end;
    finally
      mr:=ModalResult;
      MainForm.Configuration.fpCreateViewPostForm.y:=Top;
      MainForm.Configuration.fpCreateViewPostForm.x:=Left;
      if mr=mrOk then
        begin
          // определение id пользователя
          TSL:=TStringList.Create;
          try
            if ((cmbbxTo.Text='[ группа администраторов ]')or(cmbbxTo.Text='[ группа операторов ]')or(cmbbxTo.Text='[ группа пользователей ]')) then
              begin
                if cmbbxTo.Text='[ группа администраторов ]' then
                  begin
                    MainForm.LogThis('Получение списка идентификаторов администраторов...', GroupGUID, lmtInfo);
                    q:='SELECT usr_id FROM '+MainForm.Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" and usr_is_admin="1" GROUP BY usr_id ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа операторов ]' then
                  begin
                    MainForm.LogThis('Получение списка идентификаторов операторов...', GroupGUID, lmtInfo);
                    q:='SELECT usr_id FROM '+MainForm.Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" and usr_can_edit_db="1" GROUP BY usr_id ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа пользователей ]' then
                  begin
                    MainForm.LogThis('Получение списка идентификаторов пользователей...', GroupGUID, lmtInfo);
                    q:='SELECT usr_id FROM '+MainForm.Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" and usr_is_admin="0" GROUP BY usr_id ORDER BY usr_id;';
                  end;
              end
            else
              begin
                MainForm.LogThis('Получение идентификатора указанного пользователя...', GroupGUID, lmtInfo);
                q:='SELECT usr_id FROM '+MainForm.Configuration.sMySQLDatabase+'._usr WHERE usr_fullname="'+cmbbxTo.Text+'" ORDER BY usr_id;';
              end;
            MainForm.LogThis(q, GroupGUID, lmtSQL);
            i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
            if i=0 then
              begin
                MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                if ResultSet<>nil then
                  begin
                    MainForm.LogThis('Результирующая выборка получена успешно.', GroupGUID, lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    if i>0 then
                      begin
                        MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                        MainForm.ProgressBar1.Max:=i;
                        for j:=0 to i-1 do
                          begin
                            MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', GroupGUID, lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', GroupGUID, lmtInfo);
                                TSL.Add(string(ResultRow[0]));
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
                MainForm.LogThis(s, GroupGUID, lmtError);
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              MainForm.LogThis('Список идентификаторов получен успешно...', GroupGUID, lmtInfo);
            if ResultSet<>nil then
              begin
                MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.', GroupGUID, lmtInfo);
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
                  mysql_escape_string(pacCaption, PAnsiChar(AnsiString(edbxCaption.Text)), Length(edbxCaption.Text));
                  // преобразование сообщения
                  meMessage.Lines.SaveToStream(RTFStream);
                  RTFStream.Seek(0, soFromBeginning);
                  pacText:=GetMemory(RTFStream.Size*2+1);
                  mysql_escape_string(pacText, RTFStream.Memory, RTFStream.Size);
                  MainForm.ProgressBar1.Max:=TSL.Count*2;
                  Screen.Cursor:=crHourGlass;
                  for j:=0 to TSL.Count-1 do
                    begin
                      if not bError then
                        begin
                          // добавление сообщения
                          MainForm.LogThis('Добавление нового сообщения...', GroupGUID, lmtInfo);
                          q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._msg (msg_id, msg_erased, msg_processed, msg_for_user_id, '+'msg_caption, msg_text, msg_created_at, msg_created_by_user_id) VALUES '+'(NULL, "0", "0", '+
                            TSL.Strings[j]+', "'+string(pacCaption)+'", "'+string(pacText)+'", Now(), '+MainForm.CurrentUser.sID+');';
                          MainForm.LogThis(q, GroupGUID, lmtSQL);
                          i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
                          if i=0 then
                            begin
                              MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                              iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
                              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                              if i=1 then
                                begin
                                  MainForm.LogThis('Количество строк выборки соответствует требуемому.', GroupGUID, lmtInfo);
                                  MainForm.LogThis('Сообщение успешно отправлено получателю.', GroupGUID, lmtInfo);
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
                          MainForm.ProgressBar1.StepIt;
                          Application.ProcessMessages;
                          // запись статистики в БД
                          if not bError then
                            begin
                              MainForm.LogThis('Внесение записи в таблицу событий.', GroupGUID, lmtInfo);
                              q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"INS","msg",'+IntToStr(iLastID)+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
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
                          if bError then
                            begin
                              Screen.Cursor:=crDefault;
                              MainForm.LogThis(s, GroupGUID, lmtError);
                              MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                            end;
                        end;
                    end;
                  MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
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
const
  GroupGUID: string='{BB095F24-C157-4D43-8062-5178B5C31CDB}';
var
  s, s_msg_id, q: string;
  b, bError: boolean;
  i: integer;
begin
  bError:=False;
  MainForm.LogThis('Попытка удаления сообщения...', GroupGUID, lmtInfo);
  b:=MessageBox(Handle, PChar('Вы действительно хотите удалить выделенное сообщение?'), PChar('OA4 - Подтверждение удаления'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if b then
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.ProgressBar1.Max:=2;
      MainForm.LogThis('Удаление сообщения подтверждено пользователем...', GroupGUID, lmtInfo);
      // получение ID выделенного сообщения
      s_msg_id:=lvMessages.Selected.SubItems[2];
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
        end
      else
        begin
          lvMessages.Selected.Delete;
          btnView.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
          btnErase.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
        end;
    end
  else
    MainForm.LogThis('Удаление сообщения отменено пользователем...', GroupGUID, lmtInfo);
end;

procedure TViewPostListForm.btnViewClick(Sender: TObject);
const
  GroupGUID: string='{A7A88547-1E24-443E-A15D-A40C837214C7}';
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
  MainForm.LogThis('Попытка открытия окна просмотра сообщения...', GroupGUID, lmtInfo);
  with TCreateViewPostForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      ilPost.GetIcon(lvMessages.Selected.ImageIndex, Icon);
      Caption:='OA4 - Просмотр сообщения';
      Hint:='Окно просмотра сообщения';
      pnlID.Visible:=MainForm.Configuration.bShowID;
      lblTo.Visible:=False;
      cmbbxTo.Visible:=False;
      edbxCaption.readonly:=True;
      meMessage.readonly:=True;
      pnlCreation.Visible:=True;
      btnClear.Visible:=False;
      btnProcess.Visible:=True;
      btnErase.Visible:=True;
      btnSend.Visible:=False;
      edbxCaption.Width:=meMessage.Width;
      btnClose.default:=True;
      btnHelp.Enabled:=Application.HelpFile<>'';
      if btnNext.Visible then
        ActiveControl:=btnNext
      else
        ActiveControl:=btnClose;
      // получение ID выделенного сообщения
      s:=lvMessages.Selected.SubItems[2];
      MainForm.LogThis('Открытие сообщения...', GroupGUID, lmtInfo);
      q:='SELECT msg_id, msg_processed, msg_caption, msg_text, msg_created_at, usr_fullname FROM '+MainForm.Configuration.sMySQLDatabase+'._msg LEFT JOIN '+MainForm.Configuration.sMySQLDatabase+
        '._usr ON usr_id=msg_created_by_user_id WHERE msg_id='+s+';';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              MainForm.LogThis('Результирующая выборка получена успешно.', GroupGUID, lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>=0 then
                begin
                  MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                  if i=1 then
                    begin
                      MainForm.ProgressBar1.Max:=i;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          MainForm.LogThis('Операция получения строки выборки прошла успешно.', GroupGUID, lmtInfo);
                          lblPostID.Caption:=string(ResultRow[0]);
                          btnProcess.Enabled:=string(ResultRow[1])='0';
                          edbxCaption.Text:=string(ResultRow[2]);
                          meMessage.Text:=string(ResultRow[3]);
                          lblPostCreatedAtBy.Caption:=string(ResultRow[5])+', '+string(ResultRow[4]);
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
          MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.', GroupGUID, lmtInfo);
          mysql_free_result(ResultSet);
        end;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s, GroupGUID, lmtError);
          MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
      if MainForm.Configuration.fpCreateViewPostForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=MainForm.Configuration.fpCreateViewPostForm.y;
          Left:=MainForm.Configuration.fpCreateViewPostForm.x;
        end;
      if bError=False then
        ShowModal;
    finally
      MainForm.Configuration.fpCreateViewPostForm.y:=Top;
      MainForm.Configuration.fpCreateViewPostForm.x:=Left;
      if bError=False then
        begin
          mr:=ModalResult;
          if mr=mrOk then // если запись была удалена, значит точно будет результат mrOk
            begin
              MainForm.LogThis('Обновление списка сообщений после успешного удаления открытого сообщения.', GroupGUID, lmtInfo);
              lvMessages.Selected.Delete;
              btnView.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
              btnErase.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
            end;
          if mr=mrYes then // если запись было прочитано, значит точно будет результат mrYes
            begin
              MainForm.LogThis('Обновление списка сообщений после успешной пометки открытого сообщения как прочитанного.', GroupGUID, lmtInfo);
              lvMessages.Selected.ImageIndex:=1;
            end;
        end;
      Free;
    end;
end;

procedure TViewPostListForm.FormCreate(Sender: TObject);
begin
  btnHelp.Enabled:=Application.HelpFile<>'';
  btnView.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
  btnErase.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
end;

procedure TViewPostListForm.lvMessagesDblClick(Sender: TObject);
begin
  if lvMessages.Selected<>nil then
    begin
      if btnView.Visible and btnView.Enabled and btnView.default then
        btnView.Click;
    end;
end;

procedure TViewPostListForm.lvMessagesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnView.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
  btnErase.Enabled:=(lvMessages.Items.Count>0)and(lvMessages.ItemIndex>=0);
  if lvMessages.ItemIndex>=0 then
    lblID.Caption:=lvMessages.Selected.SubItems[2]
  else
    lblID.Caption:='';
  pnlID.Visible:=MainForm.Configuration.bShowID and(lvMessages.Items.Count>0)and(lvMessages.Selected<>nil);
  if btnView.Enabled then
    begin
      btnClose.default:=False;
      btnView.default:=True;
    end
  else
    begin
      btnView.default:=False;
      btnClose.default:=True;
    end;
end;

end.
