unit Maintenance;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Main, mysql;

type
  TMaintenanceForm= class(TForm)
    GroupBox1: TGroupBox;
    btnImport: TButton;
    pbImportTotal: TProgressBar;
    sbMaintenance: TStatusBar;
    pbImportDetail: TProgressBar;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaintenanceForm: TMaintenanceForm;

implementation

{$R *.dfm}

procedure TMaintenanceForm.btnImportClick(Sender: TObject);
var
  b: boolean;
  q, s: string;
  i, j: integer;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  slTemp: TStringList;
  GroupGUID: string;
begin
  GroupGUID:='{D82E41A3-8431-441B-B3BF-43C9FB770351}';
  MainForm.Set_Busy(GroupGUID);
  b:=MessageBox(Handle, PChar('ОСТОРОЖНО! При нажатии кнопки "Да" текущие данные, '+'содержащиеся в БД будут безвозвратно утеряны! Вы уверены в том что хотите удалить '+
        'все имеющиеся на текущий момент данные и импортировать содержащиеся в "старой" базе?'), PChar('OA4 - Подтверждение импорта базы данных'), MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES;
  if not b then
    begin
      MainForm.Set_Ready(GroupGUID);
      Exit;
    end;
  ResultSet:=nil;
  btnImport.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  bError:=False;

  pbImportTotal.Position:=pbImportTotal.Min;
  pbImportTotal.Step:=1;
  pbImportTotal.Max:=30;

  pbImportDetail.Position:=pbImportDetail.Min;
  pbImportDetail.Step:=1;

  // удаление таблицы организаций нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка удаления таблицы организаций нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DROP TABLE IF EXISTS '+MainForm.Configuration.sMySQLDatabase+'._org;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Удаление таблицы организаций произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке удаления таблицы организаций!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // удаление таблицы мероприятий нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка удаления таблицы мероприятий нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DROP TABLE IF EXISTS '+MainForm.Configuration.sMySQLDatabase+'._msr;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Удаление таблицы мероприятий произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке удаления таблицы мероприятий!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // удаление таблицы телефонов
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка удаления таблицы телефонов нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DROP TABLE IF EXISTS '+MainForm.Configuration.sMySQLDatabase+'._phn;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Удаление таблицы телефонов произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке удаления таблицы организаций '+MainForm.Configuration.sMySQLDatabase+'._org!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // удаление таблицы событий нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка удаления таблицы событий нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DROP TABLE IF EXISTS '+MainForm.Configuration.sMySQLDatabase+'._evn;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Удаление таблицы событий произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке удаления таблицы событий!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // очистка таблицы фирм от ранее импортированных записей об организациях
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка очистки таблицы фирм от ранее импортированных записей об организациях...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DELETE FROM minsk.firma WHERE city_id=2507 AND oper="0" AND main="!R";';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>=0 then
            begin
              MainForm.LogThis('Очистка таблицы фирм произведена успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при очистке таблицы фирм!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // очистка таблицы отделов от ранее внесённых записей о телефонах
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка очистки таблицы отделов от ранее внесённых записей о телефонах...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DELETE FROM minsk.otdel WHERE type_phone="!R" AND oper="0";';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>=0 then
            begin
              MainForm.LogThis('Очистка таблицы отделов произведена успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при очистке таблицы отделов!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // очистака таблицы групп от ранее импортированных типов органицаций
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка очистки таблицы групп от ранее импортированныз типов организаций...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DELETE FROM minsk.grp WHERE oper="333" AND date="00000000000000";';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>=0 then
            begin
              MainForm.LogThis('Удаление ранее импортированных групп произведено успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке удаления ранее импортированных групп!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // создание таблицы организаций нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка создания таблицы организаций нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='CREATE TABLE '+MainForm.Configuration.sMySQLDatabase+'._org ('+'org_id smallint(5) unsigned NOT NULL auto_increment, '+'org_erased enum("0","1") NOT NULL default "0", '+'_org_type text, '+'_org_name text, '+'_org_address text, '+
        'org_firm_code int(10) unsigned default NULL, '+'org_how_to_reach text, '+'org_work_time text, '+'org_other_info mediumtext, '+'org_other_info_rtf mediumblob, '+'org_created_at datetime NOT NULL default "0000-00-00 00:00:00", '+
        'org_created_by_user_id tinyint(3) unsigned NOT NULL default "0", '+'org_modified_at datetime NOT NULL default "0000-00-00 00:00:00", '+'org_modified_by_user_id tinyint(3) unsigned NOT NULL default "0", '+'PRIMARY KEY  (org_id), '+
        'KEY org_erased (org_erased), '+'KEY org_created_at (org_created_at), '+'KEY org_created_by_user_id (org_created_by_user_id), '+'KEY org_modified_at (org_modified_at), '+'KEY org_modified_by_user_id (org_modified_by_user_id), '+
        'KEY org_firm_code (org_firm_code), '+'FULLTEXT KEY org_work_time (org_work_time) '+') TYPE=MyISAM COMMENT="Таблица организаций для версии 4.0";';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Создание таблицы организаций произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке создания таблицы организаций!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // создание таблицы мероприятий нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка создания таблицы мероприятий нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='CREATE TABLE '+MainForm.Configuration.sMySQLDatabase+'._msr ('+'msr_id smallint(5) unsigned NOT NULL auto_increment, '+'msr_erased enum("0","1") NOT NULL default "0", '+'msr_start_datetime datetime default NULL, '+
        'msr_stop_datetime datetime default NULL, '+'msr_unknown_duration enum("0","1") NOT NULL default "1", '+'_msr_duration time default NULL, '+'msr_organization_id smallint(5) unsigned default NULL, '+
        'msr_is_premier enum("0","1") NOT NULL default "0", '+'msr_is_tour enum("0","1") NOT NULL default "0", '+'msr_for_children enum("0","1") NOT NULL default "0", '+'msr_for_teenagers enum("0","1") NOT NULL default "0", '+
        'msr_for_adults_only enum("0","1") NOT NULL default "0", '+'msr_type text, '+'msr_name text, '+'msr_author text, '+'msr_producer text, '+'msr_performer text, '+'msr_organizer text, '+'msr_ticket_price text, '+'msr_other_info mediumtext, '+
        'msr_other_info_rtf mediumblob, '+'msr_created_at datetime NOT NULL default "0000-00-00 00:00:00", '+'msr_created_by_user_id tinyint(3) unsigned NOT NULL default "0", '+'msr_modified_at datetime NOT NULL default "0000-00-00 00:00:00", '+
        'msr_modified_by_user_id tinyint(3) unsigned NOT NULL default "0", '+'PRIMARY KEY  (msr_id), '+'KEY msr_erased (msr_erased), '+'KEY msr_organization_id (msr_organization_id), '+'KEY msr_created_at (msr_created_at), '+
        'KEY msr_created_by_user_id (msr_created_by_user_id), '+'KEY msr_modified_at (msr_modified_at), '+'KEY msr_modified_by_user_id (msr_modified_by_user_id), '+'KEY msr_is_premier (msr_is_premier), '+'KEY msr_is_tour (msr_is_tour), '+
        'KEY msr_for_children (msr_for_children), '+'KEY msr_for_teenagers (msr_for_teenagers), '+'KEY msr_for_adults_only (msr_for_adults_only), '+'KEY msr_start_datetime (msr_start_datetime), '+'KEY msr_stop_datetime (msr_stop_datetime), '+
        'KEY msr_unknown_duration (msr_unknown_duration), '+'FULLTEXT KEY msr_type (msr_type), '+'FULLTEXT KEY msr_name (msr_name), '+'FULLTEXT KEY msr_author (msr_author), '+'FULLTEXT KEY msr_producer (msr_producer), '+
        'FULLTEXT KEY msr_performer (msr_performer), '+'FULLTEXT KEY msr_organizer (msr_organizer) '+') TYPE=MyISAM COMMENT="Таблица мероприятий для версии 4.0"; ';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Создание таблицы мероприятий произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке создания таблицы мероприятий!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // создание таблицы телефонов нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка создания таблицы организаций нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='CREATE TABLE '+MainForm.Configuration.sMySQLDatabase+'._phn ('+'phn_id int(10) unsigned NOT NULL auto_increment, '+'phn_priority tinyint(3) unsigned NOT NULL default "0", '+'_phn_phone tinytext NOT NULL, '+
        'phn_otdel_id int(10) unsigned default NULL, '+'phn_type enum("", "стационарный", "мобильный", "мобильный (Velcom/МЦС)", '+'"мобильный (МТС)", "мобильный (Diallog/БелСел)", "мобильный (БеСТ)") NOT NULL default "", '+'phn_comments text, '+
        'phn_compared date NOT NULL default "1900-01-01", '+'phn_owner_id smallint(5) unsigned default NULL, '+'phn_owner_is_measure enum("0","1") NOT NULL default "0", '+'phn_modified_at timestamp(14) NOT NULL, '+
        'phn_modified_by_user_id tinyint(3) unsigned default NULL, '+'PRIMARY KEY  (phn_id), '+'KEY phn_priority (phn_priority), '+'KEY phn_owner_is_measure (phn_owner_is_measure), '+'KEY phn_owner_id (phn_owner_id), '+
        'KEY phn_otdel_id (phn_otdel_id), '+'KEY phn_type (phn_type), '+'KEY phn_compared (phn_compared), '+'KEY phn_modified_at (phn_modified_at), '+'KEY phn_modified_by_user_id (phn_modified_by_user_id), '+'FULLTEXT KEY _phn_phone (_phn_phone) '+
        ') TYPE=MyISAM COMMENT="Таблица телефонов для версии 4.0";';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Создание таблицы телефонов произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке создания таблицы телефонов!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // создание таблицы событий нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка создания таблицы событий нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='CREATE TABLE '+MainForm.Configuration.sMySQLDatabase+'._evn ('+'evn_id int(10) unsigned NOT NULL auto_increment, '+'evn_datetime datetime NOT NULL default "0000-00-00 00:00:00", '+'evn_type enum("INS","MOD","DEL","REC") default NULL, '+
        'evn_object enum("usr","phn","org","msr","msg") default NULL, '+'evn_object_id int(10) unsigned default NULL, '+'evn_by_user_id tinyint(3) unsigned NOT NULL default "0", '+'evn_details text NOT NULL, '+'PRIMARY KEY  (evn_id), '+
        'KEY evn_datetime (evn_datetime), '+'KEY evn_type (evn_type), '+'KEY evn_by_user_id (evn_by_user_id), '+'KEY evn_object (evn_object), '+'KEY evn_object_id (evn_object_id)'+') TYPE=MyISAM COMMENT="Таблица событий для версии 4.0";';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Создание таблицы событий произведено успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке создания таблицы событий!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // подготовка таблицы организаций старого формата к экспорту данных
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы организаций старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.organizationnames CHANGE organizationaddress organizationaddress VARCHAR(255) NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы организаций старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы организаций старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы организаций старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.organizationnames CHANGE organizationhowtoreach organizationhowtoreach VARCHAR(255) NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы организаций старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы организаций старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы организаций старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.organizationnames CHANGE organizationphones organizationphones VARCHAR(255) NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы организаций старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы организаций старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы организаций старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.organizationnames CHANGE organizationinfo organizationinfo TEXT NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы организаций старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы организаций старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // подготовка таблицы мероприятий старого формата к экспорту данных
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы мероприятий старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.measures CHANGE measureticketprice measureticketprice TEXT NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы мероприятий старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы мероприятий старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы мероприятий старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.measures CHANGE measureperformer measureperformer VARCHAR(255) NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы мероприятий старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы мероприятий старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы мероприятий старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.measures CHANGE measureorganizer measureorganizer VARCHAR(255) NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы мероприятий старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы мероприятий старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка подготовки таблицы мероприятий старого формата к экспорту данных...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='ALTER TABLE rne2.measures CHANGE measureinfo measureinfo TEXT NOT NULL;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы мероприятий старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке подготовки таблицы мероприятий старого формата к экспорту данных!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // импортирование данных об организациях в таблицу нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка экспорта данных из таблицы организаций старого формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._org '+'SELECT a.id, '+ // org_id
        '"0", '+ // org_erased
        'REPLACE(REPLACE(REPLACE(b.organizationtype,"<B>",""),"</B>",""),"  "," "), '+ // _org_type
        'REPLACE(REPLACE(REPLACE(a.organizationname,"<B>",""),"</B>",""),"  "," "), '+ // _org_name
        'a.organizationaddress, '+ // _org_address
        'NULL, '+ // org_firm_code
        'a.organizationhowtoreach, '+ // org_how_to_reach
        '"", '+ // org_work_time
        'CONCAT("<B> ",a.organizationphones," </B><BR><BR> ",a.organizationinfo), '+ // org_other_info
        'NULL, '+ // org_other_info_rtf
        '"00000000000000", '+ // org_created_at
        '"6", '+ // org_created_by_user_id
        'a.LMTS, '+ // org_modified_at
        '"6" '+ // org_modified_by_user_id
        'FROM rne2.organizationnames a LEFT JOIN rne2.organizationtypes b ON b.id=a.organizationtypeid ORDER BY a.id;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество импортированных строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>0 then
            begin
              MainForm.LogThis('Импортирование данных об организациях произведено успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество импортированных строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке импортирования данных об организациях!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // удаление "пустой" организаций из таблицы организаций
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка удаления "пустой" организации из таблицы нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DELETE FROM '+MainForm.Configuration.sMySQLDatabase+'._org WHERE org_id=25000;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>=0 then
            begin
              MainForm.LogThis('Удаление "пустой" организации произведено успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке удаления "пустой" организации!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // вставка "пустой" организации
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка вставки "пустой" организации в таблицу нового формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._org VALUES(25000, "0", "", "", "", NULL, "", "", "", NULL, "00000000000000", "6", "00000000000000", "6");';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество вставленых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i=1 then
            begin
              MainForm.LogThis('Вставка "пустой" организации произведена успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество вставленных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке вставки "пустой" организации!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // формирование текстов запроса на импорт данных из RNE4 в minsk.firma и выполнение его в случае удачного формирования
  slTemp:=TStringList.Create; // создание списка для помещения туда строк SQL-запросов получаемых в результате выполнения запроса
  try
    if not bError then
      begin
        sbMaintenance.SimpleText:='Попытка создания текста запросов на заполнение таблицы фирм...';
        pbImportDetail.Position:=pbImportDetail.Min;
        Application.ProcessMessages;
        q:='SELECT CONCAT("INSERT INTO minsk.firma(name,main,city_id,street_id,comment,ext_comment) VALUES ('+#39+' ",TRIM(_org_name)," | ",TRIM(_org_type),'+'"'+#39+','+#39+'!R'+#39+',2507,1077,'+#39+'",org_id,"'+#39+','+#39+'",_org_address,"'+#39+
          ');") FROM '+MainForm.Configuration.sMySQLDatabase+'._org;';
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
                    pbImportDetail.Max:=i;
                    for j:=0 to i-1 do
                      begin
                        if not bError then
                          begin
                            // MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',GroupGUID,lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                // MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',GroupGUID,lmtInfo);
                                slTemp.Add(string(ResultRow[0]));
                              end
                            else
                              begin
                                s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                bError:=True;
                              end;
                          end;
                        pbImportDetail.StepIt;
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
          end
        else
          begin
            s:='Возникла ошибка при создании текста запросов на заполнение таблицы фирм!';
            bError:=True;
          end;
        if ResultSet<>nil then
          begin
            MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
            mysql_free_result(ResultSet);
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
            pbImportTotal.StepIt;
            Application.ProcessMessages;
          end;
      end;
    // работа со списком в случае удачного его заполнения
    if not bError then
      begin
        pbImportDetail.Position:=pbImportDetail.Min;
        pbImportDetail.Max:=slTemp.Count;
        for j:=0 to slTemp.Count-1 do
          begin
            if not bError then
              begin
                sbMaintenance.SimpleText:='Попытка заполнения таблицы фирм...';
                Application.ProcessMessages;
                q:=slTemp[j];
                MainForm.LogThis(q, GroupGUID, lmtSQL);
                i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
                if i=0 then
                  begin
                    MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                    i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                    MainForm.LogThis('Количество вставленых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                    if i=1 then
                      begin
                        MainForm.LogThis('Вставка записи в таблицу фирм произведена успешно.', GroupGUID, lmtInfo)
                      end
                    else
                      begin
                        s:='Количество вставленных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                        bError:=True;
                      end
                  end
                else
                  begin
                    s:='Возникла ошибка при попытке вставки записи в таблицу фирм!';
                    bError:=True;
                  end;
              end;
            pbImportDetail.StepIt;
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
            pbImportTotal.StepIt;
            Application.ProcessMessages;
          end;
      end;
  finally
    slTemp.Free;
  end;

  // формирование текста запросов на обновление полей данных RNE4 значениями minsk.firma и выполнение его в случае удачного формирования
  slTemp:=TStringList.Create; // создание списка для помещения туда строк SQL-запросов получаемых в результате выполнения запроса
  try
    if not bError then
      begin
        sbMaintenance.SimpleText:='Попытка создания текста запросов на обновление данных таблицы организаций...';
        pbImportDetail.Position:=pbImportDetail.Min;
        Application.ProcessMessages;
        q:='SELECT CONCAT("UPDATE rne4._org SET org_firm_code=",m.firm_code," '+'WHERE org_id=",m.comment,";") FROM minsk.firma m LEFT JOIN '+MainForm.Configuration.sMySQLDatabase+'._org o ON m.comment=o.org_id '+
          'WHERE main="!R" AND (!(ISNULL(m.comment))) AND m.comment!="";';
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
                    pbImportDetail.Max:=i;
                    for j:=0 to i-1 do
                      begin
                        // MainForm.LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',GroupGUID,lmtInfo);
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            // MainForm.LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',GroupGUID,lmtInfo);
                            slTemp.Add(string(ResultRow[0]));
                          end
                        else
                          begin
                            s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                            bError:=True;
                          end;
                        pbImportDetail.StepIt;
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
          end
        else
          begin
            s:='Возникла ошибка при создании текста запросов на обновление данных таблицы организаций!';
            bError:=True;
          end;
        if ResultSet<>nil then
          begin
            MainForm.LogThis('Освобождение ресурсов, занятых результатом выборки...', GroupGUID, lmtInfo);
            mysql_free_result(ResultSet);
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
            pbImportTotal.StepIt;
            Application.ProcessMessages;
          end;
      end;
    // работа со списком в случае удачного его заполнения
    if not bError then
      begin
        pbImportDetail.Position:=pbImportDetail.Min;
        pbImportDetail.Max:=slTemp.Count;
        for j:=0 to slTemp.Count-1 do
          begin
            if not bError then
              begin
                sbMaintenance.SimpleText:='Попытка обновления данных таблицы организаций...';
                Application.ProcessMessages;
                q:=slTemp[j];
                MainForm.LogThis(q, GroupGUID, lmtSQL);
                i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
                if i=0 then
                  begin
                    MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
                    i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                    MainForm.LogThis('Количество вставленых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
                    if i=1 then
                      begin
                        MainForm.LogThis('Обновление записи таблицы организаций произведена успешно.', GroupGUID, lmtInfo)
                      end
                    else
                      begin
                        s:='Количество вставленных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                        bError:=True;
                      end
                  end
                else
                  begin
                    s:='Возникла ошибка при попытке обновления записи таблицы организаций!';
                    bError:=True;
                  end;
              end;
            pbImportDetail.StepIt;
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
            pbImportTotal.StepIt;
            Application.ProcessMessages;
          end;
      end;
  finally
    slTemp.Free;
  end;

  // импорт словаря типов организаций в таблицу групп
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка импортирования словаря типов организации в таблицу групп...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='INSERT INTO minsk.grp SELECT "0", UCASE(CONCAT(" ",TRIM(_org_type))) AS name,'+'"333","00000000000000" FROM '+MainForm.Configuration.sMySQLDatabase+'._org '+'LEFT JOIN minsk.grp ON UCASE(name)=UCASE(CONCAT(" ",TRIM(_org_type))) '+
        'WHERE TRIM(_org_type)!="" AND ISNULL(name) GROUP BY _org_type ORDER BY _org_type;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество вставленых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>=0 then
            begin
              MainForm.LogThis('Вставка словаря типов организаций в таблицу групп произведена успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество вставленных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке вставки словаря типов организаций в таблицу групп!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // импортирование данных о мероприятии в таблицу нового формата
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка экспорта данных из таблицы мероприятий старого формата...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._msr '+'SELECT '+'NULL, '+'"0", '+'a.measurestartdatetime, '+'a.measurestopdatetime, '+'"1", '+'a.measureduration, '+'a.organizationnameid, '+'IF(a.measurepremier=1,"1","0"), '+'"0", '+
        'IF(a.childrenmeasure=1,"1","0"), '+'IF(a.teenagersmeasure,"1","0"), '+'"0", '+'REPLACE(REPLACE(REPLACE(b.measuretype,"<B>",""),"</B>",""),"  "," "), '+'REPLACE(REPLACE(REPLACE(c.measurename,"<B>",""),"</B>",""),"  "," "), '+
        'd.measureauthor, '+'e.measureproducer, '+'a.measureperformer, '+'a.measureorganizer, '+'a.measureticketprice, '+'a.measureinfo, '+'NULL, '+'"00000000000000", '+'a.ridcreatorid, '+'a.LMTS, '+'a.ridcreatorid '+'FROM rne2.measures a '+
        'LEFT JOIN rne2.measuretypes b ON b.id=a.measuretypeid '+'LEFT JOIN rne2.measurenames c ON c.id=a.measurenameid '+'LEFT JOIN rne2.measureauthors d ON d.id=a.measureauthorid '+'LEFT JOIN rne2.measureproducers e ON e.id=a.measureproducerid '+
        'ORDER BY a.id; ';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество импортированных строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>0 then
            begin
              MainForm.LogThis('Импортирование данных о мероприятиях произведено успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество импортированных строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке импортирования данных о мероприятиях!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // привязка потеряных мероприятий к "пустой" организации
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка привязки потеряных мероприятий к "пустой" организации...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._msr SET msr_organization_id=25000 WHERE msr_organization_id=0;';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Подготовка таблицы организаций старого формата к экспорту данных произведена успешно.', GroupGUID, lmtInfo);
        end
      else
        begin
          s:='Возникла ошибка при попытке привязки потеряных мероприятий к "пустой" организации!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  // очистка таблицы от пустых мероприятий
  if not bError then
    begin
      sbMaintenance.SimpleText:='Попытка очистки таблицы мероприятий от пустых мероприятий...';
      pbImportDetail.Position:=pbImportDetail.Min;
      pbImportDetail.Max:=1;
      Application.ProcessMessages;
      q:='DELETE FROM rne4._msr WHERE (msr_start_datetime="" OR ISNULL(msr_start_datetime)) AND '+'(msr_stop_datetime="" OR ISNULL(msr_stop_datetime)) AND '+'(_msr_duration="" OR ISNULL(_msr_duration)) AND '+
        '(msr_is_premier="0" OR ISNULL(msr_is_premier)) AND '+'(msr_is_tour="0" OR ISNULL(msr_is_tour)) AND '+'(msr_for_children="0" OR ISNULL(msr_for_children)) AND '+'(msr_for_teenagers="0" OR ISNULL(msr_for_teenagers)) AND '+
        '(msr_for_adults_only="0" OR ISNULL(msr_for_adults_only)) AND '+'(msr_type="" OR ISNULL(msr_type)) AND '+'(msr_name="" OR ISNULL(msr_name)) AND '+'(msr_author="" OR ISNULL(msr_author)) AND '+'(msr_producer="" OR ISNULL(msr_producer)) AND '+
        '(msr_performer="" OR ISNULL(msr_performer)) AND '+'(msr_organizer="" OR ISNULL(msr_organizer)) AND '+'(msr_ticket_price="" OR ISNULL(msr_ticket_price)) AND '+'(msr_other_info="" OR ISNULL(msr_other_info)) AND '+
        '(msr_other_info_rtf="" OR ISNULL(msr_other_info_rtf));';
      MainForm.LogThis(q, GroupGUID, lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler, PAnsiChar(AnsiString(q)), Length(q));
      if i=0 then
        begin
          MainForm.LogThis('Запрос выполнен успешно.', GroupGUID, lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          MainForm.LogThis('Количество удалённых строк равно '+IntToStr(i)+'.', GroupGUID, lmtInfo);
          if i>=0 then
            begin
              MainForm.LogThis('Очистка таблицы мероприятий от пустых мероприятий произведена успешно.', GroupGUID, lmtInfo)
            end
          else
            begin
              s:='Количество удалённых строк ('+IntToStr(i)+') не соответствует требуемому!';
              bError:=True;
            end
        end
      else
        begin
          s:='Возникла ошибка при попытке очистки таблицы мероприятий от пустых мероприятий!';
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
          pbImportDetail.StepIt;
          pbImportTotal.StepIt;
          Application.ProcessMessages;
        end;
    end;

  if not bError then
    begin
      sbMaintenance.SimpleText:='Готово!';
      Screen.Cursor:=crDefault;
      Application.ProcessMessages;
      MessageBox(Handle, PChar('Опериция успешно завершена!'), PChar('OA4 - Информация'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
    end;
  pbImportTotal.Position:=pbImportTotal.Min;
  pbImportDetail.Position:=pbImportDetail.Min;
  btnImport.Enabled:=True;
  sbMaintenance.SimpleText:='';
  Application.ProcessMessages;
  MainForm.Set_Ready(GroupGUID);
end;

procedure TMaintenanceForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    ModalResult:=mrCancel;
end;

end.
