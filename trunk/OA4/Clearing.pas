unit Clearing;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Main, mysql;

type
  TClearingForm= class(TForm)
    sbClearing: TStatusBar;
    btnClearing: TButton;
    pbClearingTotal: TProgressBar;
    GroupBox1: TGroupBox;
    chkbxClearingPhoneTable: TCheckBox;
    chkbxClearingMeasureTable: TCheckBox;
    chkbxClearingOrganizationTable: TCheckBox;
    chkbxClearingMessageTable: TCheckBox;
    chkbxClearingEventTable: TCheckBox;
    chkbxClearingUserTable: TCheckBox;
    pbClearingPhonesDetail: TProgressBar;
    pbClearingMeasuresDetail: TProgressBar;
    pbClearingOrganizationsDetail: TProgressBar;
    pbClearingMessagesDetail: TProgressBar;
    pbClearingEventsDetail: TProgressBar;
    pbClearingUsersDetail: TProgressBar;
    procedure chkbxClearingPhoneTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClearingClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure UpdateButtonState;
  public
    { Public declarations }
  end;

var
  ClearingForm: TClearingForm;

implementation

{$R *.dfm}

procedure TClearingForm.btnClearingClick(Sender: TObject);
var
  // b: boolean;
  q, s: string;
  i, j, k: integer;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  slTemp, slTemp2: TStringList;
  GroupGUID: string;
begin
  GroupGUID:='{C2CA7BD9-8DBD-4818-A725-0C69835FC431}';
  MainForm.Set_Busy(GroupGUID);
  btnClearing.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  bError:=False;

  pbClearingTotal.Position:=pbClearingTotal.Min;
  pbClearingTotal.Step:=1;
  pbClearingTotal.Max:=((integer(chkbxClearingMeasureTable.Enabled and chkbxClearingMeasureTable.Checked))*4)+((integer(chkbxClearingOrganizationTable.Enabled and chkbxClearingOrganizationTable.Checked))*8);

  // добавление действий по очистке прочих таблиц делать тут

  // очистка таблицы мероприятий
  if (not bError)and chkbxClearingMeasureTable.Enabled and chkbxClearingMeasureTable.Checked then
    begin
      pbClearingMeasuresDetail.Position:=pbClearingMeasuresDetail.Min;
      pbClearingMeasuresDetail.Step:=1;
      slTemp:=TStringList.Create;
      try
        // сначала выбираем список "пустых" мероприятий и формируем временный список
        // затем в цикле по списку проверяем наличие телефонов, принадлежащих данным мероприятиям
        if not bError then
          begin
            sbClearing.SimpleText:='Попытка получения списка "пустых" удалённых мероприятий...';
            pbClearingMeasuresDetail.Position:=pbClearingMeasuresDetail.Min;
            Application.ProcessMessages;
            q:='SELECT msr_id FROM '+MainForm.Configuration.sMySQLDatabase+'._msr WHERE msr_erased="1" '+'AND ISNULL(msr_start_datetime) '+'AND ISNULL(msr_stop_datetime) '+'AND (msr_is_premier="0") '+'AND (msr_is_tour="0") '+
              'AND (msr_for_children="0") '+'AND (msr_for_teenagers="0") '+'AND (msr_for_adults_only="0") '+'AND (ISNULL(msr_type) OR (TRIM(msr_type)="")) '+'AND (ISNULL(msr_name) OR (TRIM(msr_name)="")) '+
              'AND (ISNULL(msr_author) OR (TRIM(msr_author)="")) '+'AND (ISNULL(msr_producer) OR (TRIM(msr_producer)="")) '+'AND (ISNULL(msr_performer) OR (TRIM(msr_performer)="")) '+'AND (ISNULL(msr_organizer) OR (TRIM(msr_organizer)="")) '+
              'AND (ISNULL(msr_ticket_price) OR (TRIM(msr_ticket_price)="")) '+'AND (ISNULL(msr_other_info) OR (TRIM(msr_other_info)="")) '+'AND (ISNULL(msr_other_info_rtf) OR (TRIM(msr_other_info_rtf)=""));';
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
                        pbClearingMeasuresDetail.Max:=i;
                        for j:=0 to i-1 do
                          begin
                            MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', GroupGUID, lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', GroupGUID, lmtInfo);
                                slTemp.Add(string(ResultRow[0]));
                              end
                            else
                              begin
                                s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                bError:=True;
                              end;
                            pbClearingMeasuresDetail.StepIt;
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка при получении количества строк выборки!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                    bError:=True;
                  end;
                if ResultSet<>nil then
                  begin
                    MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
                    mysql_free_result(ResultSet);
                  end;
              end
            else
              begin
                s:='Возникла ошибка при формировании списка "пустых" удалённых мероприятий!';
                bError:=True;
              end;
            if bError then
              begin
                MainForm.LogThis(s, GroupGUID, lmtError);
                Screen.Cursor:=crDefault;
                Application.ProcessMessages;
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              begin
                pbClearingTotal.StepIt;
                Application.ProcessMessages;
              end;
          end;
        if not bError then
          begin
            pbClearingMeasuresDetail.Position:=pbClearingMeasuresDetail.Min;
            pbClearingMeasuresDetail.Max:=slTemp.Count;
            for j:=0 to slTemp.Count-1 do
              begin
                if not bError then
                  begin
                    sbClearing.SimpleText:='Составление списка помеченных на удаление "пустых" мероприятий на которых не числятся телефонные номера...';
                    Application.ProcessMessages;
                    q:='SELECT COUNT(*) FROM '+MainForm.Configuration.sMySQLDatabase+'._phn WHERE phn_owner_id='+slTemp[j]+' AND phn_owner_is_measure="1";';
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
                            if i=1 then
                              begin
                                MainForm.LogThis('Количество строк выборки соответствует требуемому (1).', GroupGUID, lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    MainForm.LogThis('Операция получения строки выборки прошла успешно.', GroupGUID, lmtInfo);
                                    k:=StrToIntDef(string(ResultRow[0]), -1);
                                    if k>-1 then
                                      begin
                                        if k=0 then
                                          begin
                                            // подмена обработанной строки новым запросом
                                            slTemp[j]:='DELETE FROM '+MainForm.Configuration.sMySQLDatabase+'._msr WHERE msr_id='+slTemp[j]+';';
                                          end
                                        else
                                          begin
                                            // замена пустой строкой для исключения из обработки
                                            slTemp[j]:='';
                                          end;
                                      end
                                    else
                                      begin
                                        s:='Получено некорректное количество номеров ('+IntToStr(k)+') телефонов принадлежащих мероприятию ID#'+slTemp[j]+'!';
                                        bError:=True;
                                      end;
                                  end
                                else
                                  begin
                                    s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                    bError:=True;
                                  end;
                              end
                            else
                              begin
                                s:='Количество полученных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            bError:=True;
                          end;
                        if ResultSet<>nil then
                          begin
                            MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка попытке проверки мероприятия ID#'+slTemp[j]+' на наличие номеров телефонов!';
                        bError:=True;
                      end;
                  end;
                pbClearingMeasuresDetail.StepIt;
              end;
            if bError then
              begin
                MainForm.LogThis(s, GroupGUID, lmtError);
                Screen.Cursor:=crDefault;
                Application.ProcessMessages;
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              begin
                pbClearingTotal.StepIt;
                Application.ProcessMessages;
              end;
          end;
        // очистка списка от пустых строк
        if not bError then
          begin
            pbClearingMeasuresDetail.Position:=pbClearingMeasuresDetail.Min;
            pbClearingMeasuresDetail.Max:=slTemp.Count;
            for j:=slTemp.Count-1 downto 0 do
              begin
                if slTemp[j]='' then
                  slTemp.Delete(j);
                pbClearingMeasuresDetail.StepIt;
              end;
            pbClearingTotal.StepIt;
            Application.ProcessMessages;
          end;
        // удаление удаленных "пустых" мероприятий из таблицы БД при помощи списка запросов
        if not bError then
          begin
            pbClearingMeasuresDetail.Position:=pbClearingMeasuresDetail.Min;
            pbClearingMeasuresDetail.Max:=slTemp.Count;
            for j:=0 to slTemp.Count-1 do
              begin
                if not bError then
                  begin
                    sbClearing.SimpleText:='Попытка удаления записей таблицы организаций...';
                    Application.ProcessMessages;
                    q:=slTemp[j];
                    MainForm.LogThis(q, GroupGUID, lmtSQL);
                    i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
                    if i=0 then
                      begin
                        MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                        i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                        MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                        if i=1 then
                          begin
                            MainForm.LogThis('Удаление записи таблицы мероприятий произведена успешно.', GroupGUID, lmtInfo)
                          end
                        else
                          begin
                            s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                            bError:=True;
                          end
                      end
                    else
                      begin
                        s:='Возникла ошибка при попытке удаления записи таблицы организаций!';
                        bError:=True;
                      end;
                  end;
                pbClearingMeasuresDetail.StepIt;
              end;
            if bError then
              begin
                MainForm.LogThis(s, GroupGUID, lmtError);
                Screen.Cursor:=crDefault;
                Application.ProcessMessages;
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              begin
                pbClearingTotal.StepIt;
                Application.ProcessMessages;
              end;
          end;
      finally
        slTemp.Free;
      end;
    end;

  // очистка таблицы организаций
  if (not bError)and chkbxClearingOrganizationTable.Enabled and chkbxClearingOrganizationTable.Checked then
    begin
      pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
      pbClearingOrganizationsDetail.Step:=1;
      slTemp:=TStringList.Create;
      try
        // сначала выбираем список "пустых" организаций и формируем временный список
        // затем в цикле по списку проверяем наличие телефонов, принадлежащих данным организациям
        // и проверяем наличие мероприятий, принадлежащих данным организациям
        if not bError then
          begin
            sbClearing.SimpleText:='Попытка получения списка "пустых" удалённых организаций...';
            pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
            Application.ProcessMessages;
            q:='SELECT org_id FROM '+MainForm.Configuration.sMySQLDatabase+'._org WHERE org_erased="1" '+'AND (ISNULL(_org_type) OR (TRIM(_org_type)="")) '+'AND (ISNULL(_org_name) OR (TRIM(_org_name)="")) '+
              'AND (ISNULL(_org_address) OR (TRIM(_org_address)="")) '+'AND (ISNULL(org_how_to_reach) OR (TRIM(org_how_to_reach)="")) '+'AND (ISNULL(org_work_time) OR (TRIM(org_work_time)="")) '+
              'AND (ISNULL(org_other_info) OR (TRIM(org_other_info)="")) '+'AND (ISNULL(org_other_info_rtf) OR (TRIM(org_other_info_rtf)=""));';
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
                        pbClearingOrganizationsDetail.Max:=i;
                        for j:=0 to i-1 do
                          begin
                            MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', GroupGUID, lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', GroupGUID, lmtInfo);
                                slTemp.Add(string(ResultRow[0]));
                              end
                            else
                              begin
                                s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                bError:=True;
                              end;
                            pbClearingOrganizationsDetail.StepIt;
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка при получении количества строк выборки!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                    bError:=True;
                  end;
                if ResultSet<>nil then
                  begin
                    MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
                    mysql_free_result(ResultSet);
                  end;
              end
            else
              begin
                s:='Возникла ошибка при формировании списка "пустых" удалённых организаций!';
                bError:=True;
              end;
            if bError then
              begin
                MainForm.LogThis(s, GroupGUID, lmtError);
                Screen.Cursor:=crDefault;
                Application.ProcessMessages;
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              begin
                pbClearingTotal.StepIt;
                Application.ProcessMessages;
              end;
          end;
        if not bError then
          begin
            pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
            pbClearingOrganizationsDetail.Max:=slTemp.Count;
            for j:=0 to slTemp.Count-1 do
              begin
                if not bError then
                  begin
                    sbClearing.SimpleText:='Составление списка помеченных на удаление "пустых" организаций на которых не числятся телефонные номера...';
                    Application.ProcessMessages;
                    q:='SELECT COUNT(*) FROM '+MainForm.Configuration.sMySQLDatabase+'._phn WHERE phn_owner_id='+slTemp[j]+' AND phn_owner_is_measure="0";';
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
                            if i=1 then
                              begin
                                MainForm.LogThis('Количество строк выборки соответствует требуемому (1).', GroupGUID, lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    MainForm.LogThis('Операция получения строки выборки прошла успешно.', GroupGUID, lmtInfo);
                                    k:=StrToIntDef(string(ResultRow[0]), -1);
                                    if k>-1 then
                                      begin
                                        if k>0 then
                                          slTemp[j]:=''; // замена пустой строкой для исключения из обработки
                                      end
                                    else
                                      begin
                                        s:='Получено некорректное количество номеров ('+IntToStr(k)+') телефонов принадлежащих мероприятию ID#'+slTemp[j]+'!';
                                        bError:=True;
                                      end;
                                  end
                                else
                                  begin
                                    s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                    bError:=True;
                                  end;
                              end
                            else
                              begin
                                s:='Количество полученных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            bError:=True;
                          end;
                        if ResultSet<>nil then
                          begin
                            MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка попытке проверки организации ID#'+slTemp[j]+' на наличие номеров телефонов!';
                        bError:=True;
                      end;
                  end;
                pbClearingOrganizationsDetail.StepIt;
              end;
            if bError then
              begin
                MainForm.LogThis(s, GroupGUID, lmtError);
                Screen.Cursor:=crDefault;
                Application.ProcessMessages;
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              begin
                pbClearingTotal.StepIt;
                Application.ProcessMessages;
              end;
          end;
        // очистка списка от пустых строк
        if not bError then
          begin
            pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
            pbClearingOrganizationsDetail.Max:=slTemp.Count;
            for j:=slTemp.Count-1 downto 0 do
              begin
                if slTemp[j]='' then
                  slTemp.Delete(j);
                pbClearingOrganizationsDetail.StepIt;
              end;
            pbClearingTotal.StepIt;
            Application.ProcessMessages;
          end;
        if not bError then
          begin
            pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
            pbClearingOrganizationsDetail.Max:=slTemp.Count;
            for j:=0 to slTemp.Count-1 do
              begin
                if not bError then
                  begin
                    sbClearing.SimpleText:='Составление списка помеченных на удаление "пустых" организаций на которых не числятся мероприятия...';
                    Application.ProcessMessages;
                    q:='SELECT COUNT(*) FROM '+MainForm.Configuration.sMySQLDatabase+'._msr WHERE msr_organization_id='+slTemp[j]+';';
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
                            if i=1 then
                              begin
                                MainForm.LogThis('Количество строк выборки соответствует требуемому (1).', GroupGUID, lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    MainForm.LogThis('Операция получения строки выборки прошла успешно.', GroupGUID, lmtInfo);
                                    k:=StrToIntDef(string(ResultRow[0]), -1);
                                    if k>-1 then
                                      begin
                                        if k>0 then
                                          slTemp[j]:=''; // замена пустой строкой для исключения из обработки
                                      end
                                    else
                                      begin
                                        s:='Получено некорректное количество номеров ('+IntToStr(k)+') телефонов принадлежащих мероприятию ID#'+slTemp[j]+'!';
                                        bError:=True;
                                      end;
                                  end
                                else
                                  begin
                                    s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                    bError:=True;
                                  end;
                              end
                            else
                              begin
                                s:='Количество полученных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            bError:=True;
                          end;
                        if ResultSet<>nil then
                          begin
                            MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка попытке проверки организации ID#'+slTemp[j]+' на наличие мероприятий!';
                        bError:=True;
                      end;
                  end;
                pbClearingOrganizationsDetail.StepIt;
              end;
            if bError then
              begin
                MainForm.LogThis(s, GroupGUID, lmtError);
                Screen.Cursor:=crDefault;
                Application.ProcessMessages;
                MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              begin
                pbClearingTotal.StepIt;
                Application.ProcessMessages;
              end;
          end;
        // очистка списка от пустых строк
        if not bError then
          begin
            pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
            pbClearingOrganizationsDetail.Max:=slTemp.Count;
            for j:=slTemp.Count-1 downto 0 do
              begin
                if slTemp[j]='' then
                  slTemp.Delete(j);
                pbClearingOrganizationsDetail.StepIt;
              end;
            pbClearingTotal.StepIt;
            Application.ProcessMessages;
          end;

        // составление списка записей, которые нужно удалить из таблицы firma
        slTemp2:=TStringList.Create;
        try
          if not bError then
            begin
              pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
              pbClearingOrganizationsDetail.Max:=slTemp.Count;
              for j:=0 to slTemp.Count-1 do
                begin
                  if not bError then
                    begin
                      sbClearing.SimpleText:='Составление списка записей таблицы фирм, подлежащих удалению...';
                      Application.ProcessMessages;
                      q:='SELECT org_firm_code FROM '+MainForm.Configuration.sMySQLDatabase+'._org WHERE org_id='+slTemp[j]+';';
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
                              if i=1 then
                                begin
                                  MainForm.LogThis('Количество строк выборки соответствует требуемому (1).', GroupGUID, lmtInfo);
                                  ResultRow:=mysql_fetch_row(ResultSet);
                                  if ResultRow<>nil then
                                    begin
                                      MainForm.LogThis('Операция получения строки выборки прошла успешно.', GroupGUID, lmtInfo);
                                      slTemp2.Add(string(ResultRow[0]));
                                    end
                                  else
                                    begin
                                      s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                      bError:=True;
                                    end;
                                end
                              else
                                begin
                                  s:='Количество полученных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                  bError:=True;
                                end;
                            end
                          else
                            begin
                              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                              bError:=True;
                            end;
                          if ResultSet<>nil then
                            begin
                              MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
                              mysql_free_result(ResultSet);
                            end;
                        end
                      else
                        begin
                          s:='Возникла ошибка при попытке составления списка записей таблицы фирм, подлежащих удалению!';
                          bError:=True;
                        end;
                    end;
                  pbClearingOrganizationsDetail.StepIt;
                end;
              if bError then
                begin
                  MainForm.LogThis(s, GroupGUID, lmtError);
                  Screen.Cursor:=crDefault;
                  Application.ProcessMessages;
                  MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end
              else
                begin
                  pbClearingTotal.StepIt;
                  Application.ProcessMessages;
                end;
            end;
          // удаление помеченных на удаление удаленных "пустых" организаций из таблицы БД при помощи списка запросов
          if not bError then
            begin
              pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
              pbClearingOrganizationsDetail.Max:=slTemp.Count;
              for j:=0 to slTemp.Count-1 do
                begin
                  // MainForm.LogThis(slTemp[j],lmtWarning);
                  if not bError then
                    begin
                      sbClearing.SimpleText:='Попытка удаления записей таблицы организаций...';
                      Application.ProcessMessages;
                      q:='DELETE FROM '+MainForm.Configuration.sMySQLDatabase+'._org WHERE org_id='+slTemp[j]+';';
                      MainForm.LogThis(q, GroupGUID, lmtSQL);
                      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
                      if i=0 then
                        begin
                          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                          if i=1 then
                            MainForm.LogThis('Удаление записи таблицы организаций произведена успешно.', GroupGUID, lmtInfo)
                          else
                            begin
                              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                              bError:=True;
                            end
                        end
                      else
                        begin
                          s:='Возникла ошибка при попытке удаления записи таблицы организаций!';
                          bError:=True;
                        end;
                    end;
                  pbClearingOrganizationsDetail.StepIt;
                end;
              if bError then
                begin
                  MainForm.LogThis(s, GroupGUID, lmtError);
                  Screen.Cursor:=crDefault;
                  Application.ProcessMessages;
                  MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end
              else
                begin
                  pbClearingTotal.StepIt;
                  Application.ProcessMessages;
                end;
            end;
          // удаление записей таблицы фирм
          if not bError then
            begin
              pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
              pbClearingOrganizationsDetail.Max:=slTemp2.Count;
              for j:=0 to slTemp2.Count-1 do
                begin
                  // MainForm.LogThis(slTemp2[j],lmtWarning);
                  if not bError then
                    begin
                      sbClearing.SimpleText:='Попытка удаления записей таблицы организаций...';
                      Application.ProcessMessages;
                      q:='DELETE FROM minsk.firma WHERE firm_code='+slTemp2[j]+';';
                      MainForm.LogThis(q, GroupGUID, lmtSQL);
                      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
                      if i=0 then
                        begin
                          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                          if i=1 then
                            MainForm.LogThis('Удаление записи таблицы фирм произведена успешно.', GroupGUID, lmtInfo)
                          else
                            begin
                              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                              bError:=True;
                            end
                        end
                      else
                        begin
                          s:='Возникла ошибка при попытке удаления записи таблицы фирм!';
                          bError:=True;
                        end;
                    end;
                  pbClearingOrganizationsDetail.StepIt;
                end;
              if bError then
                begin
                  MainForm.LogThis(s, GroupGUID, lmtError);
                  Screen.Cursor:=crDefault;
                  Application.ProcessMessages;
                  MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end
              else
                begin
                  pbClearingTotal.StepIt;
                  Application.ProcessMessages;
                end;
            end;
        finally
          slTemp2.Free;
        end;
      finally
        slTemp.Free;
      end;
    end;

  // добавление действий по очистке прочих таблиц делать тут

  if not bError then
    begin
      sbClearing.SimpleText:='Готово!';
      Screen.Cursor:=crDefault;
      pbClearingTotal.Position:=pbClearingTotal.Max;
      Application.ProcessMessages;
      MessageBox(Handle, PChar('Опериция успешно завершена!'), PChar('OA4 - Информация'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
    end;
  pbClearingTotal.Position:=pbClearingTotal.Min;
  pbClearingMeasuresDetail.Position:=pbClearingMeasuresDetail.Min;
  pbClearingOrganizationsDetail.Position:=pbClearingOrganizationsDetail.Min;
  btnClearing.Enabled:=True;
  sbClearing.SimpleText:='';
  Application.ProcessMessages;
  MainForm.Update_SearchBar;
  Application.ProcessMessages;
  MainForm.Set_Ready(GroupGUID);
end;

procedure TClearingForm.chkbxClearingPhoneTableClick(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TClearingForm.FormCreate(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TClearingForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    ModalResult:=mrCancel;
end;

procedure TClearingForm.UpdateButtonState;
var
  b: boolean;
begin
  b:=(chkbxClearingPhoneTable.Enabled and chkbxClearingPhoneTable.Checked)or(chkbxClearingOrganizationTable.Enabled and chkbxClearingOrganizationTable.Checked)or(chkbxClearingMeasureTable.Enabled and chkbxClearingMeasureTable.Checked)or
    (chkbxClearingMessageTable.Enabled and chkbxClearingMessageTable.Checked)or(chkbxClearingEventTable.Enabled and chkbxClearingEventTable.Checked)or(chkbxClearingUserTable.Enabled and chkbxClearingUserTable.Checked);
  btnClearing.Enabled:=b;
  btnClearing.default:=b;
  pbClearingPhonesDetail.Visible:=chkbxClearingPhoneTable.Enabled and chkbxClearingPhoneTable.Checked;
  pbClearingOrganizationsDetail.Visible:=chkbxClearingOrganizationTable.Enabled and chkbxClearingOrganizationTable.Checked;
  pbClearingMeasuresDetail.Visible:=chkbxClearingMeasureTable.Enabled and chkbxClearingMeasureTable.Checked;
  pbClearingMessagesDetail.Visible:=chkbxClearingMessageTable.Enabled and chkbxClearingMessageTable.Checked;
  pbClearingEventsDetail.Visible:=chkbxClearingEventTable.Enabled and chkbxClearingEventTable.Checked;
  pbClearingUsersDetail.Visible:=chkbxClearingUserTable.Enabled and chkbxClearingUserTable.Checked;
end;

end.

// запрос на выборку пустых записей организаций
// необходимо добавить проверку на наличие телефонов и наличие мероприятий и их телефонов
// SELECT org_id, org_firm_code FROM rne4._org WHERE
// org_erased="1"
// AND (ISNULL(_org_type) OR (TRIM(_org_type)=""))
// AND (ISNULL(_org_name) OR (TRIM(_org_name)=""))
// AND (ISNULL(_org_address) OR (TRIM(_org_address)=""))
// AND (ISNULL(org_how_to_reach) OR (TRIM(org_how_to_reach)=""))
// AND (ISNULL(org_work_time) OR (TRIM(org_work_time)=""))
// AND (ISNULL(org_other_info) OR (TRIM(org_other_info)=""))
// AND (ISNULL(org_other_info_rtf) OR (TRIM(org_other_info_rtf)=""));

// сначала выбираем список "пустых" мероприятий и формируем временный список
// SELECT
// msr_id, msr_organization_id
// FROM rne4._msr WHERE msr_erased="1"
// AND ISNULL(msr_start_datetime)
// AND ISNULL(msr_stop_datetime)
// AND (msr_is_premier="0")
// AND (msr_is_tour="0")
// AND (msr_for_children="0")
// AND (msr_for_teenagers="0")
// AND (msr_for_adults_only="0")
// AND (ISNULL(msr_type) OR (TRIM(msr_type)=""))
// AND (ISNULL(msr_name) OR (TRIM(msr_name)=""))
// AND (ISNULL(msr_author) OR (TRIM(msr_author)=""))
// AND (ISNULL(msr_producer) OR (TRIM(msr_producer)=""))
// AND (ISNULL(msr_performer) OR (TRIM(msr_performer)=""))
// AND (ISNULL(msr_organizer) OR (TRIM(msr_organizer)=""))
// AND (ISNULL(msr_ticket_price) OR (TRIM(msr_ticket_price)=""))
// AND (ISNULL(msr_other_info) OR (TRIM(msr_other_info)=""))
// AND (ISNULL(msr_other_info_rtf) OR (TRIM(msr_other_info_rtf)=""));
// затем в цикле по списку проверяем наличие телефонов, принадлежащих данным мероприятиям
// SELECT * FROM rne4._phn WHERE phn_owner_id=25000 AND phn_owner_is_measure="1";
// если телефоны не найдены - выполняем удаление данного мероприятия
// если найдены - пропускаем


// можно искать потеряные телефоны и мероприятия

// находим записи в таблице _phn, ссылающиеся на несуществующие записи таблиц _msr и _org
// и удаляем записи из таблицы _phn и otdel

// убрать возможность добавлять мероприятия в помеченную на удаление организацию
