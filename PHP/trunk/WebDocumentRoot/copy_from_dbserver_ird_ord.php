<?
$conn_id=ftp_connect("10.1.1.2");
$login_result=ftp_login($conn_id, "root", "kron");
if ((!$conn_id)||(!$login_result)) die("Не удалось установить соединение с FTP сервером $ftp_server под именем $ftp_user_name!\r\n"); else print "Успешно установлено соединение с FTP сервером DBSERVER.\r\n";
// расчёт прошлого дня
$ldd=date("d",mktime(0,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // определение числа вчерашней даты
$ldm=date("m",mktime(0,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // определение месяца вчерашней даты
$ldy=date("Y",mktime(0,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // определение года вчерашней даты
/*
$ldd="31"; 
$ldm="01"; 
$ldy="2011";
*/
//  копирование файлов таблицы ird_ за прошедший день с DBSERVER-а на FILESERVER
if (ftp_chdir($conn_id, "shared_disk/usr/mysql32356/data/statistika/")) print "Выполнен переход в директорию '" . ftp_pwd($conn_id) . "'.\r\n"; else print "Не удалось сменить директорию!\r\n";
if (ftp_get($conn_id, "D:\\mysql\\data\\ird\\oldformat_ird_$ldy$ldm$ldd.frm", "ird_$ldy$ldm$ldd.frm", FTP_BINARY)) print "Файл 'ird_$ldy$ldm$ldd.frm' успешно скопирован в файл 'oldformat_ird_$ldy$ldm$ldd.frm'.\r\n"; else die("Не удалось скопировать файл 'ird_$ldy$ldm$ldd.frm' в файл 'oldformat_ird_$ldy$ldm$ldd.frm'.\r\n");
if (ftp_get($conn_id, "D:\\mysql\\data\\ird\\oldformat_ird_$ldy$ldm$ldd.MYD", "ird_$ldy$ldm$ldd.MYD", FTP_BINARY)) print "Файл 'ird_$ldy$ldm$ldd.MYD' успешно скопирован в файл 'oldformat_ird_$ldy$ldm$ldd.MYD'.\r\n"; else die("Не удалось скопировать файл 'ird_$ldy$ldm$ldd.MYD' в файл 'oldformat_ird_$ldy$ldm$ldd.MYD'.\r\n");
if (ftp_get($conn_id, "D:\\mysql\\data\\ird\\oldformat_ird_$ldy$ldm$ldd.MYI", "ird_$ldy$ldm$ldd.MYI", FTP_BINARY)) print "Файл 'ird_$ldy$ldm$ldd.MYI' успешно скопирован в файл 'oldformat_ird_$ldy$ldm$ldd.MYI'.\r\n"; else die("Не удалось скопировать файл 'ird_$ldy$ldm$ldd.MYI' в файл 'oldformat_ird_$ldy$ldm$ldd.MYI'.\r\n");
if (ftp_get($conn_id, "D:\\mysql\\data\\ord\\oldformat_ord_$ldy$ldm$ldd.frm", "ord_$ldy$ldm$ldd.frm", FTP_BINARY)) print "Файл 'ord_$ldy$ldm$ldd.frm' успешно скопирован в файл 'oldformat_ord_$ldy$ldm$ldd.frm'.\r\n"; else die("Не удалось скопировать файл 'ord_$ldy$ldm$ldd.frm' в файл 'oldformat_ord_$ldy$ldm$ldd.frm'.\r\n");
if (ftp_get($conn_id, "D:\\mysql\\data\\ord\\oldformat_ord_$ldy$ldm$ldd.MYD", "ord_$ldy$ldm$ldd.MYD", FTP_BINARY)) print "Файл 'ord_$ldy$ldm$ldd.MYD' успешно скопирован в файл 'oldformat_ord_$ldy$ldm$ldd.MYD'.\r\n"; else die("Не удалось скопировать файл 'ord_$ldy$ldm$ldd.MYD' в файл 'oldformat_ord_$ldy$ldm$ldd.MYD'.\r\n");
if (ftp_get($conn_id, "D:\\mysql\\data\\ord\\oldformat_ord_$ldy$ldm$ldd.MYI", "ord_$ldy$ldm$ldd.MYI", FTP_BINARY)) print "Файл 'ord_$ldy$ldm$ldd.MYI' успешно скопирован в файл 'oldformat_ord_$ldy$ldm$ldd.MYI'.\r\n"; else die("Не удалось скопировать файл 'ord_$ldy$ldm$ldd.MYI' в файл 'oldformat_ord_$ldy$ldm$ldd.MYI'.\r\n");
ftp_quit($conn_id);
//  преобразование файлов в новый формат при помощи серии MySQL-запросов
$MYSQLCON=MYSQL_CONNECT("10.1.1.240","root","sqladmin") or die("Can't create connection");
//  преобразование файлов ird_ и ord_ за прошедший день
MYSQL_SELECT_DB("ird") or die("Не удалось установить подключение к БД ird на MySQL-сервере STATSERVER");
print "Установлено подключение к БД ird на MySQL-сервере STATSERVER.\r\n";
MYSQL_QUERY("DROP TABLE IF EXISTS ird.ird_$ldy$ldm$ldd, ird_original.ird_$ldy$ldm$ldd;");
MYSQL_QUERY("CREATE TABLE ird.ird_$ldy$ldm$ldd (ani char(32) NOT NULL default '', ddi char(32) NOT NULL default '', datum date default NULL, vrijeme time default NULL, dur decimal(11,0) NOT NULL default '0', rc decimal(3,0) NOT NULL default '0', srv decimal(3,0) NOT NULL default '0', rm decimal(3,0) NOT NULL default '0', izg decimal(3,0) NOT NULL default '0', izgnum char(32) NOT NULL default '', druga_info decimal(3,0) NOT NULL default '0', v_oper char(8) default NULL, v_mreza char(8) default NULL, qid decimal(3,0) default NULL, ccid decimal(3,0) default NULL, d_qid decimal(3,0) default NULL, d_ccid decimal(3,0) default NULL, qdur decimal(11,0) NOT NULL default '0', KEY ani (ani(4)), KEY ddi (ddi(4))) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("INSERT INTO ird.ird_$ldy$ldm$ldd SELECT * FROM ird.oldformat_ird_$ldy$ldm$ldd GROUP BY ani, ddi, datum, vrijeme, dur, rc, srv, rm, izg, izgnum, druga_info, v_oper, v_mreza, qid, ccid, d_qid, d_ccid, qdur;");

/*
// строки закомментированы всвязи с переходом на новую версию программы overseer, которая сама выполняет валидацию перед выводом данных в форму
// таким образом пропадает необходимость в резервировании оригинальных данных таблиц ird
MYSQL_QUERY("CREATE TABLE ird_original.ird_$ldy$ldm$ldd (ani char(32) NOT NULL default '', ddi char(32) NOT NULL default '', datum date default NULL, vrijeme time default NULL, dur decimal(11,0) NOT NULL default '0', rc decimal(3,0) NOT NULL default '0', srv decimal(3,0) NOT NULL default '0', rm decimal(3,0) NOT NULL default '0', izg decimal(3,0) NOT NULL default '0', izgnum char(32) NOT NULL default '', druga_info decimal(3,0) NOT NULL default '0', v_oper char(8) default NULL, v_mreza char(8) default NULL, qid decimal(3,0) default NULL, ccid decimal(3,0) default NULL, d_qid decimal(3,0) default NULL, d_ccid decimal(3,0) default NULL, qdur decimal(11,0) NOT NULL default '0', KEY ani (ani(4)), KEY ddi (ddi(4))) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("INSERT INTO ird_original.ird_$ldy$ldm$ldd SELECT * FROM ird.oldformat_ird_$ldy$ldm$ldd;");
*/

MYSQL_QUERY("DROP TABLE IF EXISTS ird.oldformat_ird_$ldy$ldm$ldd;");

/*
// строки закомментированы всвязи с переходом на новую версию программы overseer, которая сама выполняет валидацию перед выводом данных в форму
// таким образом пропадает необходимость в "порче" оригинальных данных таблиц ird
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='109' WHERE (LEFT(ddi,3)='109');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='130' WHERE (LEFT(ddi,3)='130');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='175' WHERE (LEFT(ddi,3)='175');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='188' WHERE (LEFT(ddi,3)='188');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='190' WHERE (LEFT(ddi,3)='190');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='191' WHERE (LEFT(ddi,3)='191');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='192' WHERE (LEFT(ddi,3)='192');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='193' WHERE (LEFT(ddi,3)='193');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='194' WHERE (LEFT(ddi,3)='194');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='195' WHERE (LEFT(ddi,3)='195');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='196' WHERE (LEFT(ddi,3)='196');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='197' WHERE (LEFT(ddi,3)='197');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='198' WHERE (LEFT(ddi,3)='198');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='199' WHERE (LEFT(ddi,4)='1111');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='9910911' WHERE (LEFT(ddi,4)='2222') OR (LEFT(ddi,7)='9910911');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99175' WHERE (LEFT(ddi,5)='99175');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99188' WHERE (LEFT(ddi,5)='99188');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99190' WHERE (LEFT(ddi,5)='99190');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99191' WHERE (LEFT(ddi,5)='99191');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99192' WHERE (LEFT(ddi,5)='99192');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99193' WHERE (LEFT(ddi,5)='99193');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99194' WHERE (LEFT(ddi,5)='99194');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99195' WHERE (LEFT(ddi,5)='99195');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99196' WHERE (LEFT(ddi,5)='99196');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='99197' WHERE (LEFT(ddi,5)='99197');");
MYSQL_QUERY("UPDATE ird.ird_$ldy$ldm$ldd SET ddi='9919911' WHERE (LEFT(ddi,7)='9919911');");
*/


MYSQL_SELECT_DB("ord") or die("Не удалось установить подключение к БД ord на MySQL-сервере STATSERVER");
MYSQL_QUERY("DROP TABLE IF EXISTS ord.ord_$ldy$ldm$ldd;");
MYSQL_QUERY("CREATE TABLE ord.ord_$ldy$ldm$ldd (ani char(32) NOT NULL default '', ddi char(32) NOT NULL default '', datum date default NULL, vrijeme time default NULL, dur decimal(11,0) NOT NULL default '0', rc decimal(3,0) NOT NULL default '0', srv decimal(3,0) NOT NULL default '0', rm decimal(3,0) NOT NULL default '0', izg decimal(3,0) NOT NULL default '0', izgnum char(32) NOT NULL default '', druga_info decimal(3,0) NOT NULL default '0', v_oper char(8) default NULL, v_mreza char(8) default NULL, qid decimal(3,0) default NULL, ccid decimal(3,0) default NULL, d_qid decimal(3,0) default NULL, d_ccid decimal(3,0) default NULL, qdur decimal(11,0) NOT NULL default '0', KEY ani (ani(4)), KEY ddi (ddi(4))) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("INSERT INTO ord.ord_$ldy$ldm$ldd SELECT * FROM ord.oldformat_ord_$ldy$ldm$ldd GROUP BY ani, ddi, datum, vrijeme, dur, rc, srv, rm, izg, izgnum, druga_info, v_oper, v_mreza, qid, ccid, d_qid, d_ccid, qdur;");
MYSQL_QUERY("DROP TABLE IF EXISTS ord.oldformat_ord_$ldy$ldm$ldd;");

MYSQL_CLOSE($MYSQLCON);
print "Все операции выполнены.\r\n";
?>
