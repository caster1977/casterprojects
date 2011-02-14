# создание таблицы организаций формата RNE4
DROP TABLE IF EXISTS rne4._org;
CREATE TABLE rne4._org (
  org_id smallint(5) unsigned NOT NULL auto_increment,
  org_erased enum('0','1') NOT NULL default '0',
  _org_type text,
  _org_name text,
  _org_address text,
  org_firm_code int(10) unsigned default NULL,
  org_how_to_reach text,
  org_work_time text,
  org_other_info mediumtext,
  org_other_info_rtf mediumblob,
  org_created_at datetime NOT NULL default '0000-00-00 00:00:00',
  org_created_by_user_id tinyint(3) unsigned NOT NULL default '0',
  org_modified_at datetime NOT NULL default '0000-00-00 00:00:00',
  org_modified_by_user_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (org_id),
  UNIQUE KEY org_id (org_id),
  KEY org_erased (org_erased),
  KEY org_created_at (org_created_at),
  KEY org_created_by_user_id (org_created_by_user_id),
  KEY org_modified_at (org_modified_at),
  KEY org_modified_by_user_id (org_modified_by_user_id)
) TYPE=MyISAM COMMENT='Таблица организаций для версии 4.0';

# экспорт данных из RNE2
UPDATE rne.organizationnames SET organizationaddress=' нет адреса' WHERE ISNULL(organizationaddress);
INSERT INTO rne4._org SELECT a.id, "0", REPLACE(REPLACE(REPLACE(b.organizationtype,"<B>",""),"</B>",""),"  "," "), REPLACE(REPLACE(REPLACE(a.organizationname,"<B>",""),"</B>",""),"  "," "), a.organizationaddress, NULL, a.organizationhowtoreach, '', CONCAT(" <B> ",a.organizationphones," </B> <BR> <BR> ",a.organizationinfo), NULL, "00000000000000", "6", a.LMTS, "6" FROM rne.organizationnames a LEFT JOIN rne.organizationtypes b ON b.id=a.organizationtypeid ORDER BY a.id;
# вставка "пустой" организации
DELETE FROM rne4._org WHERE org_id=25000;
INSERT INTO rne4._org VALUES(25000, "0", "", "", "", NULL, "", "", "", NULL, "00000000000000", "6", "00000000000000", "6");

# очистка таблицы minsk.firma от предыдущих импортированных из RNE4 записей
DELETE FROM minsk.firma WHERE city_id=2507 AND oper='0' AND main="!R";
# очистка таблицы minsk.otdel от предыдущих добавленных через RNE4 записей
DELETE FROM minsk.otdel WHERE type_phone='!R' AND oper='0';
# создание таблицы телефонов формата RNE4
DROP TABLE IF EXISTS rne4._phn;
CREATE TABLE rne4._phn (
  phn_id int(10) unsigned NOT NULL auto_increment,
  _phn_phone tinytext NOT NULL,
  phn_otdel_id int(10) unsigned default NULL,
  phn_type enum('','стационарный','мобильный') NOT NULL default '',
  phn_comments text,
  phn_compared date NOT NULL default '1900-01-01',
  phn_owner_id smallint(5) unsigned default NULL,
  phn_owner_is_measure enum('0','1') NOT NULL default '0',
  phn_modified_at timestamp(14) NOT NULL,
  phn_modified_by_user_id tinyint(3) unsigned default NULL,
  PRIMARY KEY  (phn_id)
) TYPE=MyISAM COMMENT='Таблица телефонов для версии 4.0';
# формирование текстов запроса на импорт данных из RNE4 в minsk.firma
SELECT  CONCAT('INSERT INTO minsk.firma(name,main,city_id,street_id,comment,ext_comment) VALUES (\' ', TRIM(_org_name),' | ',TRIM(_org_type),'\',\'!R\',',2507,',',1077,',\'',org_id,'\',\'',_org_address,'\');') AS '#текст запроса' FROM rne4._org;
# тут необходимо выполнить полученный текст запроса
#.....
# обновление таблицы rne4._org значениями minsk.firma
SELECT CONCAT('UPDATE rne4._org SET org_firm_code=',m.firm_code,' WHERE org_id=',m.comment,';') AS '#текст запроса' FROM minsk.firma m LEFT JOIN rne4._org o ON m.comment=o.org_id WHERE main="!R" AND (!(ISNULL(m.comment))) AND m.comment!="";
# тут необходимо выполнить полученный текст запроса
#.....



# очистка таблицы minsk.grp от предыдущих импортированных из RNE4 записей 
DELETE FROM minsk.grp WHERE oper="333" AND date='00000000000000';
# импорт словаря типов организаций в таблицу групп minsk.grp
INSERT INTO minsk.grp SELECT "0", UCASE(CONCAT(' ',TRIM(_org_type))) AS name, "333", '00000000000000' FROM rne4._org LEFT JOIN minsk.grp ON UCASE(name)=UCASE(CONCAT(' ',TRIM(_org_type))) WHERE TRIM(_org_type)!='' AND ISNULL(name) GROUP BY _org_type ORDER BY _org_type;


# создание таблицы мероприятий формата RNE4
DROP TABLE IF EXISTS rne4._msr;
CREATE TABLE rne4._msr (
  msr_id smallint(5) unsigned NOT NULL auto_increment,
  msr_erased enum('0','1') NOT NULL default '0',
  msr_start_datetime datetime default NULL,
  msr_stop_datetime datetime default NULL,
  _msr_duration time default NULL,
  msr_organization_id smallint(5) unsigned default NULL,
  msr_is_premier enum('0','1') NOT NULL default '0',
  msr_is_tour enum('0','1') NOT NULL default '0',
  msr_for_children enum('0','1') NOT NULL default '0',
  msr_for_teenagers enum('0','1') NOT NULL default '0',
  msr_for_adults_only enum('0','1') NOT NULL default '0',
  msr_type text,
  msr_name text,
  msr_author text,
  msr_producer text,
  msr_performer text,
  msr_organizer text,
  msr_ticket_price text,
  msr_other_info mediumtext,
  msr_other_info_rtf mediumblob,
  msr_created_at datetime NOT NULL default '0000-00-00 00:00:00',
  msr_created_by_user_id tinyint(3) unsigned NOT NULL default '0',
  msr_modified_at datetime NOT NULL default '0000-00-00 00:00:00',
  msr_modified_by_user_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (msr_id),
  UNIQUE KEY msr_id (msr_id),
  KEY msr_erased (msr_erased),
  KEY msr_organization_id (msr_organization_id),
  KEY msr_created_at (msr_created_at),
  KEY msr_created_by_user_id (msr_created_by_user_id),
  KEY msr_modified_at (msr_modified_at),
  KEY msr_modified_by_user_id (msr_modified_by_user_id),
  KEY msr_is_premier (msr_is_premier),
  KEY msr_is_tour (msr_is_tour),
  KEY msr_for_children (msr_for_children),
  KEY msr_for_teenagers (msr_for_teenagers),
  KEY msr_for_adults_only (msr_for_adults_only),
  KEY msr_start_datetime (msr_start_datetime),
  KEY msr_stop_datetime (msr_stop_datetime)
) TYPE=MyISAM COMMENT='Таблица мероприятий для версии 4.0';
# экспорт данных из RNE2
INSERT INTO rne4._msr
SELECT
	NULL,
	"0",
	a.measurestartdatetime,
	a.measurestopdatetime,
	a.measureduration,
	a.organizationnameid,
	IF(a.measurepremier=1,"1","0"),
	"0",
	IF(a.childrenmeasure=1,"1","0"),
	IF(a.teenagersmeasure,"1","0"),
	"0",
	REPLACE(REPLACE(REPLACE(b.measuretype,"<B>",""),"</B>",""),"  "," "),
	REPLACE(REPLACE(REPLACE(c.measurename,"<B>",""),"</B>",""),"  "," "),
	d.measureauthor,
	e.measureproducer,
	a.measureperformer,
	a.measureorganizer,
	a.measureticketprice,
	a.measureinfo,
	NULL,
	"00000000000000",
	a.ridcreatorid,
	a.LMTS,
	a.ridcreatorid
FROM rne.measures a 
	LEFT JOIN rne.measuretypes b ON b.id=a.measuretypeid
	LEFT JOIN rne.measurenames c ON c.id=a.measurenameid
	LEFT JOIN rne.measureauthors d ON d.id=a.measureauthorid
	LEFT JOIN rne.measureproducers e ON e.id=a.measureproducerid
ORDER BY a.id;
UPDATE rne4._msr SET msr_organization_id=25000 WHERE msr_organization_id=0;
# удаление пустых мероприятий из базы
DELETE FROM rne4._msr WHERE (msr_start_datetime="" OR ISNULL(msr_start_datetime)) AND 
(msr_stop_datetime="" OR ISNULL(msr_stop_datetime)) AND 
(_msr_duration="" OR ISNULL(_msr_duration)) AND 
(msr_is_premier="0" OR ISNULL(msr_is_premier)) AND 
(msr_is_tour="0" OR ISNULL(msr_is_tour)) AND 
(msr_for_children="0" OR ISNULL(msr_for_children)) AND 
(msr_for_teenagers="0" OR ISNULL(msr_for_teenagers)) AND 
(msr_for_adults_only="0" OR ISNULL(msr_for_adults_only)) AND 
(msr_type="" OR ISNULL(msr_type)) AND 
(msr_name="" OR ISNULL(msr_name)) AND 
(msr_author="" OR ISNULL(msr_author)) AND 
(msr_producer="" OR ISNULL(msr_producer)) AND 
(msr_performer="" OR ISNULL(msr_performer)) AND 
(msr_organizer="" OR ISNULL(msr_organizer)) AND 
(msr_ticket_price="" OR ISNULL(msr_ticket_price)) AND 
(msr_other_info="" OR ISNULL(msr_other_info)) AND 
(msr_other_info_rtf="" OR ISNULL(msr_other_info_rtf));



# получение словаря типов организаций из minsk.firma
SELECT TRIM(SUBSTRING_INDEX(name,'|',-1)) AS x1 FROM minsk.firma GROUP BY x1;
# получение списка наименований организаций из minsk.firma
SELECT TRIM(SUBSTRING_INDEX(name,'|',1)) FROM minsk.firma;

# добавление нового телефона в таблицу minsk.otdel
#INSERT INTO otdel (otdel_id, firm_code, name, phone, state, type_phone, city_id, street_id, sort_level, grp, house_num, house_sym, subhouse_num, subhouse_sym, flat_num, flat_sym, comment, ext_comment, work, oper, date) VALUES (NULL, 9999999, NULL, '9999999', '1', '', 0, 0, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, NULL, 0, NULL);


SELECT CONCAT(' ',UCASE(TRIM(SUBSTRING_INDEX(name,'|',-1)))) AS x1 FROM rne4._org LEFT JOIN minsk.firma ON firm_code=org_firm_code GROUP BY x1;

UPDATE rne.organizationnames SET organizationaddress=' нет адреса' WHERE ISNULL(organizationaddress);

#чистка таблицы rne4._org от полностью удалённых записей 
DELETE FROM rne4._org WHERE 
org_erased="1" AND 
(_org_type="" OR ISNULL(_org_type)) AND 
(_org_name="" OR ISNULL(_org_name)) AND 
(_org_address="" OR ISNULL(_org_address)) AND 
(org_how_to_reach="" OR ISNULL(org_how_to_reach)) AND 
(org_work_time="" OR ISNULL(org_work_time)) AND 
(org_other_info="" OR ISNULL(org_other_info)) AND 
(org_other_info_rtf="" OR ISNULL(org_other_info_rtf));

# запрос на поиск номера телефона без учёта дополнительных разделительных символов
SELECT * FROM minsk.otdel WHERE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(phone),"-","")," ",""),"+",""),"(",""),")","") LIKE '%2853813';
