<?
$conn_id=ftp_connect("10.1.1.2");
$login_result=ftp_login($conn_id, "root", "kron");
if ((!$conn_id)||(!$login_result)) die("�� 㤠���� ��⠭����� ᮥ������� � FTP �ࢥ஬ $ftp_server ��� ������ $ftp_user_name!\r\n"); else print "�ᯥ譮 ��⠭������ ᮥ������� � FTP �ࢥ஬ DBSERVER.\r\n";
// ����� ⥪�饣� ���
$ldd=date("d")+0; // ��।������ �᫠ ����
if ($ldd<10): $ldd="0".$ldd; endif;
$ldm=date("m")+0; // ��।������ ����� ����
if ($ldm<10): $ldm="0".$ldm; endif;
$ldy=date("Y")+0; // ��।������ ���� ����

//  ����஢���� ��娢� 䠩��� ⠡���� test �� ��襤訩 ���� � DBSERVER-� �� STATSERVER
if (ftp_chdir($conn_id, "/backup/day_backup/")) print "�믮���� ���室 � ��४��� '" . ftp_pwd($conn_id) . "'.\r\n"; else print "�� 㤠���� ᬥ���� ��४���!\r\n";
if (ftp_get($conn_id, "D:\\backup\\day_backup\\backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz", "backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz", FTP_BINARY)) print "���� 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz' �ᯥ譮 ᪮��஢�� � 䠩� 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz'.\r\n"; else die("�� 㤠���� ᪮��஢��� 䠩� 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz' � 䠩� 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz'.\r\n");
ftp_quit($conn_id);

print "�� ����樨 �믮�����.\r\n";
?>
