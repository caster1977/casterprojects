unit Users;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, CommCtrl, Main, mysql, ImgList;

type
  TUsersForm = class(TForm)
    TreeView1: TTreeView;
    Panel2: TPanel;
    pnlButtons: TPanel;
    btnEraseUser: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnSaveUser: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    btnAddUser: TButton;
    TabSheet2: TTabSheet;
    chkbxDBEdition: TCheckBox;
    chkbxDBBackup: TCheckBox;
    chkbxDBCleaning: TCheckBox;
    chkbxDBDefragmentation: TCheckBox;
    chkbxDBMaintenance: TCheckBox;
    chkbxDBUsersEdition: TCheckBox;
    edbxName: TEdit;
    Label1: TLabel;
    edbxLogin: TEdit;
    Label2: TLabel;
    Splitter1: TSplitter;
    lblCreationDetails: TLabel;
    lblModificationDetails: TLabel;
    btnCancelAddingUser: TButton;
    lblHint: TLabel;
    ImageList1: TImageList;
    btnRestoreUser: TButton;
    edbxID: TEdit;
    lblID: TLabel;
    btnSetPassword: TButton;
    lblCreation: TLabel;
    lblModification: TLabel;
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btnSetPasswordClick(Sender: TObject);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure btnRestoreUserClick(Sender: TObject);
    procedure btnEraseUserClick(Sender: TObject);
    procedure btnSaveUserClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelAddingUserClick(Sender: TObject);
    procedure btnAddUserClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure UserDataChange(Sender: TObject);
  private
    bUserModified: boolean;
    procedure UpdateButtons;
  public
  end;

var
  UsersForm: TUsersForm;

implementation

{$R *.dfm}

uses SetPassword;

procedure TUsersForm.FormCreate(Sender: TObject);
var
  s, q: string;
  i, j, k: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  Node, Child: TTreeNode;
  bError: boolean;
  GroupGUID: string;
begin
  GroupGUID:='{8B3EEF9F-88B3-41E1-A0B9-DCDC97478765}';
  Screen.Cursor:=crHourGlass;
  bError:=False;
  ResultSet:=nil;
  Node:=nil;
  btnHelp.Enabled:=Application.HelpFile<>'';
  lblID.Visible:=MainForm.Configuration.bShowID or MainForm.bParamShowID;
  edbxID.Visible:=MainForm.Configuration.bShowID or MainForm.bParamShowID;
	MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
	MainForm.LogThis('Получение списка пользователей...',GroupGUID,lmtInfo);
	q:='SELECT usr_login, usr_is_admin, usr_erased FROM '+MainForm.Configuration.sMySQLDatabase+'._usr;';
	MainForm.LogThis(q,GroupGUID,lmtSQL);
	i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					MainForm.LogThis('Результирующая выборка получена успешно.',GroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if i>0 then
						begin
							MainForm.LogThis('Количество строк выборки равно '+IntToStr(i)+'.',GroupGUID,lmtInfo);
							MainForm.ProgressBar1.Max:=i;
							for j:=0 to i-1 do
								begin
									MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',GroupGUID,lmtInfo);
									ResultRow:=mysql_fetch_row(ResultSet);
									if ResultRow<>nil then
										begin
											MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',GroupGUID,lmtInfo);
											if ResultRow[1]='1' then
												begin
													for k:=0 to TreeView1.Items.Count-1 do
														begin
															if TreeView1.Items.Item[k].Text='Администраторы' then
																Node:=TreeView1.Items.Item[k];
														end;
													if Node<>nil then
														begin
															Child:=TreeView1.Items.AddChild(Node,ResultRow[0]);
															Child.ImageIndex:=StrToInt(ResultRow[2]);
															Child.SelectedIndex:=StrToInt(ResultRow[2]);
															Child.StateIndex:=StrToInt(ResultRow[2]);
														end;
												end;
											if ResultRow[1]='0' then
												begin
													for k:=0 to TreeView1.Items.Count-1 do
														begin
															if TreeView1.Items.Item[k].Text='Пользователи' then
																Node:=TreeView1.Items.Item[k];
														end;
													if Node<>nil then
														begin
															Child:=TreeView1.Items.AddChild(Node,ResultRow[0]);
															Child.ImageIndex:=StrToInt(ResultRow[2]);
															Child.SelectedIndex:=StrToInt(ResultRow[2]);
															Child.StateIndex:=StrToInt(ResultRow[2]);
														end;
												end;
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
      MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.',GroupGUID,lmtInfo);
      mysql_free_result(ResultSet);
		end;
	MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      MainForm.LogThis(s,GroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
	TreeView1.Selected:=TreeView1.Items.GetFirstNode;
  TreeView1.FullExpand;
  SendMessage(TreeView1.Handle, WM_VSCROLL, SB_TOP, 0);
  bUserModified:=False;
  UpdateButtons;
end;

procedure TUsersForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  SendMessage(TreeView1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TUsersForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  SendMessage(TreeView1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

procedure TUsersForm.UserDataChange(Sender: TObject);
begin
  bUserModified:=True;
  UpdateButtons;
end;

procedure TUsersForm.btnSetPasswordClick(Sender: TObject);
var
  q, s: string;
  i: integer;
  bError: boolean;
  Node: TTreeNode;
  GroupGUID: string;
begin
  GroupGUID:='{0E4DC519-F972-4C86-9E09-3806DF9C62F3}';
  bError:=False;
  with TSetPasswordForm.Create(Self) do
    try
      if MainForm.Configuration.fpSetPasswordForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=MainForm.Configuration.fpSetPasswordForm.y;
          Left:=MainForm.Configuration.fpSetPasswordForm.x;
        end;
      ShowModal;
    finally
      MainForm.Configuration.fpSetPasswordForm.y:=Top;
      MainForm.Configuration.fpSetPasswordForm.x:=Left;
      if ModalResult=mrOk then
        begin
          Screen.Cursor:=crHourGlass;
          MainForm.ProgressBar1.Max:=1;
          MainForm.LogThis('Смена пароля для учётной записи ID="'+edbxID.Text+'"...',GroupGUID,lmtInfo);
          q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._usr SET usr_password_md5=md5("'+edbxPassword.Text+'"), usr_modified_at=Now(), usr_modified_by_user_id='+MainForm.CurrentUser.sID+' WHERE usr_id="'+edbxID.Text+'";';
          MainForm.LogThis(q,GroupGUID,lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              if i=1 then
                begin
                  MainForm.LogThis('Количество строк выборки соответствует требуемому.',GroupGUID,lmtInfo);
                  MainForm.LogThis('Смена пароля для учётной записи ID="'+edbxID.Text+'" прошла успешно.',GroupGUID,lmtInfo);
                  MessageBox(Handle,PChar('Пароль для выбранной учётной записи успешно сменён.'),PChar('OA3 - Информация'),MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
                  if edbxID.Text=MainForm.CurrentUser.sID then
                    MainForm.CurrentUser.sPassword:=edbxPassword.Text;
                  if TreeView1.Selected<>nil then
                    begin
                      Node:=TreeView1.Selected;
                      TreeView1.Select(Node.Parent);
                      TreeView1.Select(Node);
                    end;
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
          MainForm.ProgressBar1.StepIt;
          Application.ProcessMessages;
	        MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          if bError then
            begin
              MainForm.LogThis(s,GroupGUID,lmtError);
              MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;
      Free;
    end;
end;

procedure TUsersForm.btnEraseUserClick(Sender: TObject);
var
  Node: TTreeNode;
  s, q: string;
  i: integer;
  bError: boolean;
  GroupGUID: string;
begin
  GroupGUID:='{063B7EE2-7421-41B6-8620-87D586C2F5F4}';
  Node:=TreeView1.Selected;
  bError:=False;
  if MessageBox(Handle, PChar('Вы действительно хотите пометить данную учётную запись на удаление?'), PChar('OA3 - Внимание!'), MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDYES then
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.LogThis('Пометка учётной записи ID="'+edbxID.Text+'" на удаление...',GroupGUID,lmtInfo);
      MainForm.ProgressBar1.Max:=2;
      q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._usr SET usr_erased="1", usr_modified_at=Now(), usr_modified_by_user_id='+MainForm.CurrentUser.sID+' WHERE usr_id="'+edbxID.Text+'";';
      MainForm.LogThis(q,GroupGUID,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.LogThis('Количество строк выборки соответствует требуемому.',GroupGUID,lmtInfo);
              Node.ImageIndex:=1;
              Node.SelectedIndex:=1;
              Node.StateIndex:=1;
              MainForm.LogThis('Учётная запись ID="'+edbxID.Text+'" успешно помечена на удаление.',GroupGUID,lmtInfo);
              UpdateButtons;
              TreeView1.Select(Node.Parent);
              TreeView1.Select(Node);
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
      MainForm.ProgressBar1.StepIt;
      // запись статистики в БД
      if not bError then
        begin
          MainForm.LogThis('Внесение записи в таблицу событий.',GroupGUID,lmtInfo);
          q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"DEL","usr",'+edbxID.Text+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
          MainForm.LogThis(q,GroupGUID,lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              MainForm.LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',GroupGUID,lmtInfo);
              if (i=1) then
                MainForm.LogThis('Запись в таблицу событий внесена успешно',GroupGUID,lmtInfo)
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
          MainForm.LogThis(s,GroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end;
end;

procedure TUsersForm.btnRestoreUserClick(Sender: TObject);
var
  Node: TTreeNode;
  s, q: string;
  i: integer;
  bError: boolean;
  GroupGUID: string;
begin
  GroupGUID:='{D4F81056-C0D6-4CE4-B180-7F2F9C6DCC45}';
  Node:=TreeView1.Selected;
  bError:=False;
  if MessageBox(Handle, PChar('Вы действительно хотите снять пометку об удалении с текущей учётной записи?'), PChar('OA3 - Внимание!'), MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)=IDYES then
    begin
 	    Screen.Cursor:=crHourGlass;
      MainForm.LogThis('Снятие пометки об удалении с учётной записи ID="'+edbxID.Text+'"...',GroupGUID,lmtInfo);
      MainForm.ProgressBar1.Max:=2;
      q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._usr SET usr_erased="0", usr_modified_at=Now(), usr_modified_by_user_id='+MainForm.CurrentUser.sID+' WHERE usr_id="'+edbxID.Text+'";';
      MainForm.LogThis(q,GroupGUID,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.LogThis('Количество строк выборки соответствует требуемому.',GroupGUID,lmtInfo);
              Node.ImageIndex:=0;
              Node.SelectedIndex:=0;
              Node.StateIndex:=0;
              MainForm.LogThis('Снятие пометки об удалении с учётной pfgbcb ID="'+edbxID.Text+'" прошло успешно.',GroupGUID,lmtInfo);
              UpdateButtons;
              TreeView1.Select(Node.Parent);
              TreeView1.Select(Node);
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
      MainForm.ProgressBar1.StepIt;
      // запись статистики в БД
      if not bError then
        begin
          MainForm.LogThis('Внесение записи в таблицу событий.',GroupGUID,lmtInfo);
          q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"REC","usr",'+edbxID.Text+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
          MainForm.LogThis(q,GroupGUID,lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              MainForm.LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',GroupGUID,lmtInfo);
              if (i=1) then
                MainForm.LogThis('Запись в таблицу событий внесена успешно',GroupGUID,lmtInfo)
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
          MainForm.LogThis(s,GroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end;
end;

procedure TUsersForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  bUserNode: boolean;
  s, q: string;
  i: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  bError: boolean;
  GroupGUID: string;
begin
  GroupGUID:='{13D7491D-7A04-47BA-8A22-0F704B45AEA6}';
  bUserNode:=(Node.Text<>'Администраторы') and (Node.Text<>'Пользователи');
  PageControl1.ActivePageIndex:=Integer(not bUserNode);
  if bUserNode then
    begin
      if Node.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>' then
        begin
          Screen.Cursor:=crHourGlass;
          bError:=False;
          ResultSet:=nil;
          MainForm.LogThis('Получение данных по выбранному пользователю...',GroupGUID,lmtInfo);
          q:='SELECT a.usr_id, a.usr_login, a.usr_fullname, '+
          'a.usr_can_edit_db, a.usr_can_backup_db, a.usr_can_clear_db, a.usr_can_defrag_db, '+
          'a.usr_can_maintain_db, a.usr_can_edit_db_users, b.usr_fullname, '+
          'date_format(a.usr_created_at,"%d.%m.%Y %T"), '+
          'f.usr_fullname, date_format(a.usr_modified_at,"%d.%m.%Y %T") '+
          'FROM '+MainForm.Configuration.sMySQLDatabase+'._usr a '+
          'LEFT JOIN '+MainForm.Configuration.sMySQLDatabase+'._usr b ON b.usr_id=a.usr_created_by_user_id '+
          'LEFT JOIN '+MainForm.Configuration.sMySQLDatabase+'._usr f ON f.usr_id=a.usr_modified_by_user_id '+
          'WHERE a.usr_login="'+Node.Text+'";';
          MainForm.LogThis(q,GroupGUID,lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
              ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
              if ResultSet<>nil then
                begin
                  MainForm.LogThis('Результирующая выборка получена успешно.',GroupGUID,lmtInfo);
                  i:=mysql_num_rows(ResultSet);
                  if i=1 then
                    begin
					            MainForm.ProgressBar1.Max:=i;
                      MainForm.LogThis('Количество строк выборки соответствует требуемому.',GroupGUID,lmtInfo);
                      MainForm.LogThis('Получение очередной строки выборки.',GroupGUID,lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          MainForm.LogThis('Данные строки выборки получены успешно.',GroupGUID,lmtInfo);
                          MainForm.LogThis('Получение данных и прав доступа указанного пользователя произведено успешно.',GroupGUID,lmtInfo);
                          edbxID.Text:=ResultRow[0];
                          edbxLogin.Text:=ResultRow[1];
                          edbxName.Text:=ResultRow[2];
                          chkbxDBEdition.Checked:=ResultRow[3]='1';
                          chkbxDBBackup.Checked:=ResultRow[4]='1';
                          chkbxDBCleaning.Checked:=ResultRow[5]='1';
                          chkbxDBDefragmentation.Checked:=ResultRow[6]='1';
                          chkbxDBMaintenance.Checked:=ResultRow[7]='1';
                          chkbxDBUsersEdition.Checked:=ResultRow[8]='1';
                          lblCreationDetails.Caption:=ResultRow[9]+', '+ResultRow[10];
                          lblModificationDetails.Caption:=ResultRow[11]+', '+ResultRow[12];
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки!';
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
              MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки.',GroupGUID,lmtInfo);
              mysql_free_result(ResultSet);
            end;
	        MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          if bError then
            begin
              MainForm.LogThis(s,GroupGUID,lmtError);
              MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;
      if Node.Parent.Text='Администраторы' then
        begin
          chkbxDBBackup.Enabled:=True;
          chkbxDBCleaning.Enabled:=True;
          chkbxDBDefragmentation.Enabled:=True;
          chkbxDBMaintenance.Enabled:=True;
          chkbxDBUsersEdition.Enabled:=True;
          chkbxDBBackup.Enabled:=True;
        end;
      if Node.Parent.Text='Пользователи' then
        begin
          chkbxDBBackup.Enabled:=False;
          chkbxDBBackup.Checked:=False;
          chkbxDBCleaning.Enabled:=False;
          chkbxDBCleaning.Checked:=False;
          chkbxDBDefragmentation.Enabled:=False;
          chkbxDBDefragmentation.Checked:=False;
          chkbxDBMaintenance.Enabled:=False;
          chkbxDBMaintenance.Checked:=False;
          chkbxDBUsersEdition.Enabled:=False;
          chkbxDBUsersEdition.Checked:=False;
        end;
    end
  else lblHint.Caption:='Нажмите кнопку "Добавить" для добавления нового пользователя в группу "'+Node.Text+'".';
  bUserModified:=False;
  UpdateButtons;
end;

procedure TUsersForm.btnSaveUserClick(Sender: TObject);
var
  Node: TTreeNode;
  s, q: string;
  i, iLastID: integer;
  bError: boolean;
  GroupGUID: string;
begin
  GroupGUID:='{4ED7B6DE-2FA8-4CB9-9F2F-E557C92DA372}';
  iLastID:=-1;
  Node:=TreeView1.Selected;
  bError:=False;
  if btnCancelAddingUser.Visible then
    begin
      Screen.Cursor:=crHourGlass;
      Node.Text:=edbxLogin.Text;
      TreeView1.Color:=clWindow;
      TreeView1.Enabled:=True;
      MainForm.ProgressBar1.Max:=2;
      MainForm.LogThis('Добавление новой учётной записи с группу "'+Node.Parent.Text+'"...',GroupGUID,lmtInfo);
      q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._usr (usr_id, usr_erased, usr_login, usr_password_md5, '+
      'usr_fullname, usr_is_admin, usr_can_edit_db, usr_can_backup_db, '+
      'usr_can_clear_db, usr_can_defrag_db, usr_can_maintain_db, '+
      'usr_can_edit_db_users, usr_created_at, usr_created_by_user_id, '+
      'usr_modified_at, usr_modified_by_user_id) VALUES '+
      '(NULL, "'+IntToStr(integer(Node.ImageIndex=1))+
      '", "'+edbxLogin.Text+
      '", md5(""), "'+edbxName.Text+
      '", "'+IntToStr(integer(Node.Parent.Text='Администраторы'))+
      '", "'+IntToStr(integer(chkbxDBEdition.Checked))+
      '", "'+IntToStr(integer(chkbxDBBackup.Checked and chkbxDBBackup.Enabled))+
      '", "'+IntToStr(integer(chkbxDBCleaning.Checked and chkbxDBCleaning.Enabled))+
      '", "'+IntToStr(integer(chkbxDBDefragmentation.Checked and chkbxDBDefragmentation.Enabled))+
      '", "'+IntToStr(integer(chkbxDBMaintenance.Checked and chkbxDBMaintenance.Enabled))+
      '", "'+IntToStr(integer(chkbxDBUsersEdition.Checked and chkbxDBUsersEdition.Enabled))+
      '", Now(), '+MainForm.CurrentUser.sID+
      ', Now(), '+MainForm.CurrentUser.sID+')';
      MainForm.LogThis(q,GroupGUID,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
          iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.LogThis('Количество строк выборки соответствует требуемому.',GroupGUID,lmtInfo);
              if TreeView1.Selected.Text<>edbxLogin.Text then
                TreeView1.Selected.Text:=edbxLogin.Text;
              bUserModified:=False;
              UpdateButtons;
              TreeView1.Select(Node.Parent);
              TreeView1.Select(Node);
              MainForm.LogThis('Учётная запись ID="'+IntToStr(iLastID)+'" добавлена успешно.',GroupGUID,lmtInfo);
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
      MainForm.ProgressBar1.StepIt;
      Application.ProcessMessages;
      if not bError then
        begin
          // запись статистики в БД
          MainForm.LogThis('Внесение записи в таблицу событий.',GroupGUID,lmtInfo);
          q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"INS","usr",'+IntToStr(iLastID)+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
          MainForm.LogThis(q,GroupGUID,lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              MainForm.LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',GroupGUID,lmtInfo);
              if (i=1) then
                MainForm.LogThis('Запись в таблицу событий внесена успешно',GroupGUID,lmtInfo)
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
          MainForm.LogThis(s,GroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else
        begin
          MessageBox(Handle,PChar('Для данной учётной записи задан пустой пароль.'+#10#13+
          'Не забудьте сменить его!'),PChar('OA4 - Внимание!'),MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
          btnSetPassword.SetFocus;
        end;
    end
  else
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.LogThis('Внесение изменений в учётную запись "'+Node.Text+'"...',GroupGUID,lmtInfo);
      q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._usr SET '+
      'usr_login="'+edbxLogin.Text+'", '+
      'usr_erased="'+IntToStr(integer(Node.ImageIndex=1))+'", '+
      'usr_fullname="'+edbxName.Text+'", '+
      'usr_is_admin="'+IntToStr(integer(Node.Parent.Text='Администраторы'))+'", '+
      'usr_can_edit_db="'+IntToStr(integer(chkbxDBEdition.Checked))+'", '+
      'usr_can_backup_db="'+IntToStr(integer(chkbxDBBackup.Checked and chkbxDBBackup.Enabled))+'", '+
      'usr_can_clear_db="'+IntToStr(integer(chkbxDBCleaning.Checked and chkbxDBCleaning.Enabled))+'", '+
      'usr_can_defrag_db="'+IntToStr(integer(chkbxDBDefragmentation.Checked and chkbxDBDefragmentation.Enabled))+'", '+
      'usr_can_maintain_db="'+IntToStr(integer(chkbxDBMaintenance.Checked and chkbxDBMaintenance.Enabled))+'", '+
      'usr_can_edit_db_users="'+IntToStr(integer(chkbxDBUsersEdition.Checked and chkbxDBUsersEdition.Enabled))+'", '+
      'usr_modified_at=Now(), '+
      'usr_modified_by_user_id="'+MainForm.CurrentUser.sID+'" '+
      'WHERE usr_id="'+edbxID.Text+'";';
      MainForm.LogThis(q,GroupGUID,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.ProgressBar1.Max:=i;
              MainForm.LogThis('Количество строк выборки соответствует требуемому.',GroupGUID,lmtInfo);
              if TreeView1.Selected.Text<>edbxLogin.Text then
                TreeView1.Selected.Text:=edbxLogin.Text;
              MainForm.LogThis('Изменения в учётную запись ID="'+edbxID.Text+'" внесены успешно.',GroupGUID,lmtInfo);
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
      MainForm.ProgressBar1.StepIt;
      Application.ProcessMessages;
      if not bError then
        begin
          // запись статистики в БД
         MainForm.LogThis('Внесение записи в таблицу событий.',GroupGUID,lmtInfo);
         q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"MOD","usr",'+edbxID.Text+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
         MainForm.LogThis(q,GroupGUID,lmtSQL);
         i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
         if i=0 then
           begin
             MainForm.LogThis('Запрос выполнен успешно.',GroupGUID,lmtInfo);
             i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
             MainForm.LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',GroupGUID,lmtInfo);
             if (i=1) then
               MainForm.LogThis('Запись в таблицу событий внесена успешно',GroupGUID,lmtInfo)
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
          MainForm.LogThis(s,GroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA3 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else
        begin
          bUserModified:=False;
          UpdateButtons;
          TreeView1.Select(Node.Parent);
          TreeView1.Select(Node);
          if edbxID.Text=MainForm.CurrentUser.sID then
            begin
              MainForm.CurrentUser.sLogin:=edbxLogin.Text;
              MainForm.CurrentUser.sFullName:=edbxName.Text;
              MainForm.CurrentUser.bDBEdition:=chkbxDBEdition.Checked;
              MainForm.CurrentUser.bDBBackup:=chkbxDBBackup.Checked;
              MainForm.CurrentUser.bDBCleaning:=chkbxDBCleaning.Checked;
              MainForm.CurrentUser.bDBDefragmentation:=chkbxDBDefragmentation.Checked;
              MainForm.CurrentUser.bDBMaintenance:=chkbxDBMaintenance.Checked;
              MainForm.CurrentUser.bDBUsersEdition:=chkbxDBUsersEdition.Checked;
              MainForm.Update_Actions;
            end;
        end;
    end;
end;

procedure TUsersForm.btnAddUserClick(Sender: TObject);
var
  N, P: TTreeNode;
begin
  Screen.Cursor:=crHourGlass;
  P:=TreeView1.Selected;
  N:=TreeView1.Items.AddChild(P,'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>');
  N.ImageIndex:=0;
  N.SelectedIndex:=0;
  N.StateIndex:=0;
  TreeView1.Select(N);
  TreeView1.Enabled:=False;
  TreeView1.ParentColor:=True;
  edbxLogin.Text:='';
  edbxName.Text:='';
  edbxID.Text:='';
  chkbxDBEdition.Checked:=True;
  chkbxDBBackup.Checked:=P.Text='Администраторы';
  chkbxDBCleaning.Checked:=P.Text='Администраторы';
  chkbxDBDefragmentation.Checked:=P.Text='Администраторы';
  chkbxDBMaintenance.Checked:=P.Text='Администраторы';
  chkbxDBUsersEdition.Checked:=P.Text='Администраторы';
  edbxLogin.SetFocus;
  bUserModified:=False;
  UpdateButtons;
  Screen.Cursor:=crDefault;
end;

procedure TUsersForm.TreeView1Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if bUserModified then
    if MessageBox(Handle,PChar('Вы внесли изменения в учётную запись "'+TreeView1.Selected.Text+'".'+#10#13+'Сохранить изменения?'),PChar('OA3 - Внимание!'),MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON1)=mrOk then
      btnSaveUserClick(Sender);
end;

procedure TUsersForm.btnCancelAddingUserClick(Sender: TObject);
var
  N, P: TTreeNode;
begin
  Screen.Cursor:=crHourGlass;
  bUserModified:=False;
  N:=TreeView1.Selected;
  P:=N.Parent;
  TreeView1.Select(P);
  N.Delete;
  TreeView1.Color:=clWindow;
  TreeView1.Enabled:=True;
  UpdateButtons;
  Screen.Cursor:=crDefault;
end;

procedure TUsersForm.UpdateButtons;
var
  i: integer;
  b: boolean;
  bUserNode: boolean;
begin
  b:=False;
  bUserNode:=(TreeView1.Selected.Text<>'Администраторы') and (TreeView1.Selected.Text<>'Пользователи');
  for i:=0 to TreeView1.Items.Count-1 do
    if (TreeView1.Items.Item[i].Text=edbxLogin.Text) and (TreeView1.Items.Item[i]<>TreeView1.Selected) then
      b:=True;
  btnSaveUser.Enabled:=bUserModified and
  (edbxLogin.Text<>'Администраторы') and
  (edbxLogin.Text<>'Пользователи') and
  (edbxLogin.Text<>'') and
  (edbxLogin.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>') and
  (not b);
  btnAddUser.Enabled:=(not bUserNode) and (TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>');
  btnEraseUser.Visible:=(not boolean(TreeView1.Selected.ImageIndex)) and bUserNode and (TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>');
  btnEraseUser.Enabled:=(not boolean(TreeView1.Selected.ImageIndex)) and bUserNode and (TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>');
  btnRestoreUser.Visible:=boolean(TreeView1.Selected.ImageIndex) and bUserNode and (TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>');
  btnRestoreUser.Enabled:=boolean(TreeView1.Selected.ImageIndex) and bUserNode and (TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>');
  btnCancelAddingUser.Visible:=TreeView1.Selected.Text='<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>';
  btnCancelAddingUser.Enabled:=TreeView1.Selected.Text='<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>';
  btnClose.Enabled:=TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>';
  lblCreation.Visible:=TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>';
  lblCreationDetails.Visible:=lblCreation.Visible;
  lblModification.Visible:=lblCreation.Visible;
  lblModificationDetails.Visible:=lblCreation.Visible;
  btnSetPassword.Enabled:=TreeView1.Selected.Text<>'<НОВЫЙ ПОЛЬЗОВАТЕЛЬ>';
end;

end.
