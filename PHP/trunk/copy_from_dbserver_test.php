<?
$conn_id=ftp_connect("10.1.1.2");
$login_result=ftp_login($conn_id, "root", "kron");
if ((!$conn_id)||(!$login_result)) die("Не удалось установить соединение с FTP сервером $ftp_server под именем $ftp_user_name!\r\n"); else print "Успешно установлено соединение с FTP сервером DBSERVER.\r\n";
// расчёт текущего дня
$ldd=date("d")+0; // определение числа даты
if ($ldd<10): $ldd="0".$ldd; endif;
$ldm=date("m")+0; // определение месяца даты
if ($ldm<10): $ldm="0".$ldm; endif;
$ldy=date("Y")+0; // определение года даты

//  копирование архива файлов таблицы test за прошедший день с DBSERVER-а на STATSERVER
if (ftp_chdir($conn_id, "/backup/day_backup/")) print "Выполнен переход в директорию '" . ftp_pwd($conn_id) . "'.\r\n"; else print "Не удалось сменить директорию!\r\n";
if (ftp_get($conn_id, "D:\\backup\\day_backup\\backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz", "backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz", FTP_BINARY)) print "Файл 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz' успешно скопирован в файл 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz'.\r\n"; else die("Не удалось скопировать файл 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz' в файл 'backup.HPDBS2.db_test.$ldy$ldm$ldd.tar.gz'.\r\n");
ftp_quit($conn_id);

print "Все операции выполнены.\r\n";
?>
