<?
$conn_id=ftp_connect("10.1.1.2");
$login_result=ftp_login($conn_id, "root", "kron");
if ((!$conn_id)||(!$login_result)) die("�� 㤠���� ��⠭����� ᮥ������� � FTP �ࢥ஬ $ftp_server ��� ������ $ftp_user_name!\r\n"); else print "�ᯥ譮 ��⠭������ ᮥ������� � FTP �ࢥ஬ DBSERVER.\r\n";
//  ����஢���� 䠩��� ⠡��� prijave, prijave_q � DBSERVER-� �� FILESERVER
if (ftp_chdir($conn_id, "shared_disk/usr/local/var/test/")) print "�믮���� ���室 � ��४��� '" . ftp_pwd($conn_id) . "'.\r\n"; else print "�� 㤠���� ᬥ���� ��४���!\r\n";
if (ftp_get($conn_id, "d:\\WWW\\mysql\\data\\ARJ\\oldformat_prijave.frm", "prijave.frm", FTP_BINARY)) print "���� 'prijave.frm' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_prijave.frm'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'prijave.frm' � 䠩� 'oldformat_prijave.frm'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\\mysql\\data\\ARJ\\oldformat_prijave.ISD", "prijave.ISD", FTP_BINARY)) print "���� 'prijave.ISD' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_prijave.ISD'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'prijave.ISD' � 䠩� 'oldformat_prijave.ISD'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\\mysql\\data\\ARJ\\oldformat_prijave.ISM", "prijave.ISM", FTP_BINARY)) print "���� 'prijave.ISM' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_prijave.ISM'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'prijave.ISM' � 䠩� 'oldformat_prijave.ISM'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\\mysql\\data\\ARJ\\oldformat_prijave_q.frm", "prijave_q.frm", FTP_BINARY)) print "���� 'prijave_q.frm' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_prijave_q.frm'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'prijave.frm' � 䠩� 'oldformat_prijave_q.frm'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\\mysql\\data\\ARJ\\oldformat_prijave_q.ISD", "prijave_q.ISD", FTP_BINARY)) print "���� 'prijave_q.ISD' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_prijave_q.ISD'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'prijave.ISD' � 䠩� 'oldformat_prijave_q.ISD'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\\mysql\\data\\ARJ\\oldformat_prijave_q.ISM", "prijave_q.ISM", FTP_BINARY)) print "���� 'prijave_q.ISM' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_prijave_q.ISM'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'prijave.ISM' � 䠩� 'oldformat_prijave_q.ISM'.\r\n");
// ����� ��諮�� ���
$ldd="26"; // ��।������ �᫠ ���譥� ����
$ldm="03"; // ��।������ ����� ���譥� ����
$ldy="2006"; // ��।������ ���� ���譥� ����
//  ����஢���� 䠩��� ⠡���� ird_ �� ��襤訩 ���� � DBSERVER-� �� FILESERVER
/*
if (ftp_chdir($conn_id, "../statistika/")) print "�믮���� ���室 � ��४��� '" . ftp_pwd($conn_id) . "'.\r\n"; else print "�� 㤠���� ᬥ���� ��४���!\r\n";
if (ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\oldformat_ird_$ldy$ldm$ldd.frm", "ird_$ldy$ldm$ldd.frm", FTP_BINARY)) print "���� 'ird_$ldy$ldm$ldd.frm' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_ird_$ldy$ldm$ldd.frm'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'ird_$ldy$ldm$ldd.frm' � 䠩� 'oldformat_ird_$ldy$ldm$ldd.frm'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\oldformat_ird_$ldy$ldm$ldd.ISD", "ird_$ldy$ldm$ldd.ISD", FTP_BINARY)) print "���� 'ird_$ldy$ldm$ldd.ISD' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_ird_$ldy$ldm$ldd.ISD'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'ird_$ldy$ldm$ldd.ISD' � 䠩� 'oldformat_ird_$ldy$ldm$ldd.ISD'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\oldformat_ird_$ldy$ldm$ldd.ISM", "ird_$ldy$ldm$ldd.ISM", FTP_BINARY)) print "���� 'ird_$ldy$ldm$ldd.ISM' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_ird_$ldy$ldm$ldd.ISM'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'ird_$ldy$ldm$ldd.ISM' � 䠩� 'oldformat_ird_$ldy$ldm$ldd.ISM'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\oldformat_ord_$ldy$ldm$ldd.frm", "ord_$ldy$ldm$ldd.frm", FTP_BINARY)) print "���� 'ord_$ldy$ldm$ldd.frm' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_ord_$ldy$ldm$ldd.frm'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'ord_$ldy$ldm$ldd.frm' � 䠩� 'oldformat_ord_$ldy$ldm$ldd.frm'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\oldformat_ord_$ldy$ldm$ldd.ISD", "ord_$ldy$ldm$ldd.ISD", FTP_BINARY)) print "���� 'ord_$ldy$ldm$ldd.ISD' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_ord_$ldy$ldm$ldd.ISD'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'ord_$ldy$ldm$ldd.ISD' � 䠩� 'oldformat_ord_$ldy$ldm$ldd.ISD'.\r\n");
if (ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\oldformat_ord_$ldy$ldm$ldd.ISM", "ord_$ldy$ldm$ldd.ISM", FTP_BINARY)) print "���� 'ord_$ldy$ldm$ldd.ISM' �ᯥ譮 ᪮��஢�� � 䠩� 'oldformat_ord_$ldy$ldm$ldd.ISM'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'ord_$ldy$ldm$ldd.ISM' � 䠩� 'oldformat_ord_$ldy$ldm$ldd.ISM'.\r\n");
*/
ftp_quit($conn_id);
//  �८�ࠧ������ 䠩��� � ���� �ଠ� �� ����� �ਨ MySQL-����ᮢ
$MYSQLCON=MYSQL_CONNECT("10.1.1.250","root","sqladmin") or die("Can't create connection");
MYSQL_SELECT_DB("ARJ") or die("�� 㤠���� ��⠭����� ������祭�� � �� ARJ �� MySQL-�ࢥ� FILESERVER");
print "��⠭������ ������祭�� � �� ARJ �� MySQL-�ࢥ� FILESERVER.\r\n";
//  �८�ࠧ������ 䠩��� prijave, prijave_q
MYSQL_QUERY("DROP TABLE IF EXISTS ARJ.prijave, ARJ.prijave_q;");
MYSQL_QUERY("CREATE TABLE ARJ.prijave (rbr int(11) NOT NULL auto_increment, sifra char(20) NOT NULL default '', rm char(6) default NULL, datpoc date NOT NULL default '0000-00-00', vripoc char(8) default NULL, datzav date default NULL, vrizav char(8) default NULL, stiglo decimal(4,0) default NULL, obradio decimal(4,0) default NULL, tsred decimal(4,0) default NULL, kratki decimal(4,0) default NULL, orgset decimal(4,0) default NULL, connack decimal(4,0) default NULL, orgdur decimal(4,0) default NULL, paused decimal(7,0) default NULL, wait decimal(7,0) default NULL, trans decimal(4,0) default '0', wrap decimal(7,0) default NULL, nums char(30) default NULL, closed decimal(0,0) default '1', ccid decimal(3,0) default '1', PRIMARY KEY  (rbr), KEY sifra (sifra), KEY datpoc (datpoc), KEY rm (rm), KEY vripoc (vripoc), KEY datzav (datzav), KEY vrizav (vrizav)) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("CREATE TABLE ARJ.prijave_q (sifra char(20) NOT NULL default '', rm char(6) default NULL, datpoc date NOT NULL default '0000-00-00', vripoc char(8) default NULL, datzav date default NULL, vrizav char(8) default NULL, stiglo decimal(4,0) default NULL, obradio decimal(4,0) default NULL, tsred decimal(4,0) default NULL, kratki decimal(4,0) default NULL, wait decimal(4,0) default NULL, odbio decimal(4,0) default NULL, trans decimal(4,0) default NULL, qid decimal(4,0) default NULL, ccid decimal(3,0) NOT NULL default '0', priority decimal(3,0) NOT NULL default '0', rbr int(11) NOT NULL auto_increment, PRIMARY KEY  (rbr), KEY sifra (sifra), KEY datpoc (datpoc), KEY rm (rm), KEY vripoc (vripoc), KEY datzav (datzav), KEY vrizav (vrizav)) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("INSERT INTO ARJ.prijave SELECT * FROM ARJ.oldformat_prijave;");
MYSQL_QUERY("INSERT INTO ARJ.prijave_q SELECT * FROM ARJ.oldformat_prijave_q;");
MYSQL_QUERY("DROP TABLE IF EXISTS ARJ.oldformat_prijave, ARJ.oldformat_prijave_q, ARJ.prijave_$ldy$ldm$ldd, ARJ.prijave_q_$ldy$ldm$ldd;");
MYSQL_QUERY("CREATE TABLE prijaves.prijave_$ldy$ldm$ldd (PRIMARY KEY (rbr), KEY sifra (sifra), KEY datpoc (datpoc), KEY rm (rm), KEY vripoc (vripoc), KEY datzav (datzav), KEY vrizav (vrizav)) SELECT * FROM prijave WHERE datpoc BETWEEN ADDDATE('$ldy$ldm$ldd', INTERVAL -1 DAY) AND '$ldy$ldm$ldd' AND datzav BETWEEN '$ldy$ldm$ldd' AND ADDDATE('$ldy$ldm$ldd', INTERVAL 1 DAY);");
MYSQL_QUERY("CREATE TABLE prijaves.prijave_q_$ldy$ldm$ldd (PRIMARY KEY (rbr), KEY sifra (sifra), KEY datpoc (datpoc), KEY rm (rm), KEY vripoc (vripoc), KEY datzav (datzav), KEY vrizav (vrizav)) SELECT * FROM prijave_q WHERE datpoc BETWEEN ADDDATE('$ldy$ldm$ldd', INTERVAL -1 DAY) AND '$ldy$ldm$ldd' AND datzav BETWEEN '$ldy$ldm$ldd' AND ADDDATE('$ldy$ldm$ldd', INTERVAL 1 DAY);");
//  �८�ࠧ������ 䠩��� ird_ � ord_ �� ��襤訩 ����
/*
MYSQL_QUERY("DROP TABLE IF EXISTS ARJ.ird_$ldy$ldm$ldd, ARJ.ord_$ldy$ldm$ldd;");
MYSQL_QUERY("CREATE TABLE ARJ.ird_$ldy$ldm$ldd (ani char(32) NOT NULL default '', ddi char(32) NOT NULL default '', datum date default NULL, vrijeme time default NULL, dur decimal(11,0) NOT NULL default '0', rc decimal(3,0) NOT NULL default '0', srv decimal(3,0) NOT NULL default '0', rm decimal(3,0) NOT NULL default '0', izg decimal(3,0) NOT NULL default '0', izgnum char(32) NOT NULL default '', druga_info decimal(3,0) NOT NULL default '0', v_oper char(8) default NULL, v_mreza char(8) default NULL, qid decimal(3,0) default NULL, ccid decimal(3,0) default NULL, d_qid decimal(3,0) default NULL, d_ccid decimal(3,0) default NULL, qdur decimal(11,0) NOT NULL default '0', KEY ani (ani(4)), KEY ddi (ddi(4))) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("CREATE TABLE ARJ.ord_$ldy$ldm$ldd (ani char(32) NOT NULL default '', ddi char(32) NOT NULL default '', datum date default NULL, vrijeme time default NULL, dur decimal(11,0) NOT NULL default '0', rc decimal(3,0) NOT NULL default '0', srv decimal(3,0) NOT NULL default '0', rm decimal(3,0) NOT NULL default '0', izg decimal(3,0) NOT NULL default '0', izgnum char(32) NOT NULL default '', druga_info decimal(3,0) NOT NULL default '0', v_oper char(8) default NULL, v_mreza char(8) default NULL, qid decimal(3,0) default NULL, ccid decimal(3,0) default NULL, d_qid decimal(3,0) default NULL, d_ccid decimal(3,0) default NULL, qdur decimal(11,0) NOT NULL default '0', KEY ani (ani(4)), KEY ddi (ddi(4))) TYPE=MyISAM PACK_KEYS=1;");
MYSQL_QUERY("INSERT INTO ARJ.ird_$ldy$ldm$ldd SELECT * FROM ARJ.oldformat_ird_$ldy$ldm$ldd;");
MYSQL_QUERY("INSERT INTO ARJ.ord_$ldy$ldm$ldd SELECT * FROM ARJ.oldformat_ord_$ldy$ldm$ldd;");
MYSQL_QUERY("DROP TABLE IF EXISTS ARJ.oldformat_ird_$ldy$ldm$ldd, ARJ.oldformat_ord_$ldy$ldm$ldd;");
*/
MYSQL_CLOSE($MYSQLCON);
print "�� ����樨 �믮�����.\r\n";
?>
