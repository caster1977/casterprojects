<?
//$DEBUG="on";
$ird_founded = array();
$ird_failed = array();
$ird_must =  array();
if ($startmonth<10) $startmonth="0$startmonth";

function PrintMessage($at, $as, $bs)
{
  switch ($at):
    case "ERROR":
      $cf="white";
      $cb="red";
      break;
    case "INFORMATION":
      $cf="black";
      $cb="yellow";
      break;
    case "QUERY":
      $cf="black";
      $cb="white";
      break;
    case "SUCCESS":
      $cf="black";
      $cb="green";
      break;
    default:
      $cf="black";
      $cb="gray";
  endswitch;
?>
    <TABLE STYLE="margin: 3px 5px;">
      <TR>
        <TD WIDTH="100" ALIGN="CENTER" STYLE="padding: 3px 5px; border-color: black; border-width: 1px; color: <?echo $cf;?>; background: <?echo $cb;?>; font-weight: bold;"><?echo $as;?></TD>
        <TD STYLE="padding: 3px 5px;"><?echo $bs;?></TD>
      </TR>
    </TABLE>
<?
}

function ShowErrorMessage($as, $rep, $time, $amm, $amy)
{
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
            <TD HEIGHT="15"></TD>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD HEIGHT="15" COLSPAN="5"></TD>
          </TR>
          <TR>
            <TD COLSPAN="5">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="2">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    if ($RECALC=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Для возврата к шагу выбора параметров отчёта нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="5"></TD>
          </TR>
        </TFOOT>
        <TBODY ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD ROWSPAN="5"></TD>
            <TD WIDTH="13" ROWSPAN="5" BGCOLOR="red"></TD>
            <TD HEIGHT="15" BGCOLOR="red"></TD>
            <TD WIDTH="13" ROWSPAN="5" BGCOLOR="red"></TD>
            <TD ROWSPAN="5"></TD>
          </TR>          
          <TR>
            <TD ALIGN="CENTER" BGCOLOR="red" STYLE="color: white;"><B>Ошибка!</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="red"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;"><?echo $as;?><BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="red"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM> 
<?
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Формирование таблицы arj.irda_<?echo "$year$month";?> на сервере MAINSERVER</TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="http://10.1.1.250/ns2/">
    <LINK REL="first" HREF="http://10.1.1.250/ns2/">
    <LINK REL="previous" HREF="http://10.1.1.250/ns2/?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;?>&amp;amm=<?echo $amm;?>&amp;amy=<?echo $amy;?><?if ($RECALC=="on"): echo "&amp;RECALC=$RECALC"; endif;?>">
    <LINK REL="author" HREF="http://vladracoola.by.ru/index1.html">
    <STYLE MEDIA="screen, print" TYPE="text/css">
      * {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 8pt;
        padding: 0;
        margin: 0;
        border-color: transparent;
        border-width: 0;
        }
      TABLE, TD, TH {
        border-style: solid;
      }
      TABLE {
        table-layout: fixed;
        empty-cells: show;
        float: none;
        clear: both;
        border-collapse: collapse;
        }
    </STYLE>
  </HEAD>
  <BODY BGCOLOR="gainsboro">
<?
    if (($startyear>=$y)&&($startmonth>$m)): // если расчётный месяц выбран более поздний чем текущий месяц, вывести сообщение об ошибке и остановить программу
      ShowErrorMessage("Разрешается формирование таблиц <B>только за прошедший период</B> (за текущий и все предыдущие месяцы)!<BR>Сегодня только <B>$d $months2[$m] $y года</B>, а вы пытаетесь сформировать сводную таблицу за <B>$months[$startmonth] $startyear года</B>.", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    // производим подключение к серверу 10.1.1.250 - по умолчанию данные берутся на сервере MAINSERVER, а уже в случае неудачи - с DBSERVER
    $HostName="10.1.1.250";
    $UserName="root";
    $Passwird="sqladmin";
    $DBName="arj";
    $MySQLConnection=@mysql_connect($HostName,$UserName,$Passwird);
    if ($MySQLConnection==FALSE):
      PrintMessage("ERROR","My-SQL","Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!");
      die("  </BODY>\n</HTML>");
    endif;
    if (@mysql_select_db("$DBName")==FALSE):
      PrintMessage("ERROR","My-SQL","Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!");
      die("  </BODY>\n</HTML>");
    endif;
    if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>."); endif;
    // подсчитываем количество дней, входящий в период и помещаем его в переменную $daycount
    $i=mktime(1,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth+0,$startday+0,$startyear+0);
    $daycount=0;
    while ($i>=0):
      $daycount++;
      $i=$i-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
    endwhile;
    if ($DEBUG=="on"): PrintMessage("SUCCESS", "Инфо", "Количество дней входящих в расчётный период: <B>$daycount</B>."); endif;
    // теперь нужно будет найти все требующиеся таблицы ird_$year$month$day за указанный период, для того,
    // чтобы подсчитать количество записей в этих файлах и сравнить с полученным количеством записей (с переменной $fullmonthtable_recird_counter)
    // если таблицы не удастся найти ни на одном из серверов - нужно выдать предупреждение
    // если таблица была найдена на сервере DBSERVER, необходимо скопировать её файлы по FTP и преобразовать их в новый формат

    // первоначальная инициализация переменной
    $b=TRUE;
    // заполнение массива НЕОБХОДИМЫХ файлов
    for ($i=1; $i<=$daycount; $i++):
      if ($i<10): $j="0$i"; else: $j=$i; endif;
      $ird_must[]="ird_$startyear$startmonth$j";
    endfor;
    // получаем количество таблиц ird_$year$month$day за указанный месяц, содержащихся в БД arj на MAINSERVER
    if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Получение количества таблиц <B>arj.ird_$startyear$startmonth%</B>..."); endif;
    $q="SHOW TABLES FROM arj LIKE 'ird_$startyear$startmonth"."__';";
    if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    $s="В базе данных <B>arj</B> найдены таблицы данных за <B>".$months[$startmonth+0]." $startyear года</B> в количестве <B>$num_rows</B>:";
    for ($i=0; $i<$num_rows;$i++):
      $s1=mysql_result($table, $i, 0); 
      if ($s1!=""): 
        $ird_founded[]=$s1;
        $s.="<BR>&nbsp;&nbsp;$s1";
      endif;
    endfor;
     
    // формирование массива недостающих таблиц 
    foreach ($ird_must as $i):
      if (!(in_array($i, $ird_founded))):
        $ird_failed[]=$i;
        $b=FALSE;
      endif;
    endforeach;
    if ($num_rows>0):
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", $s); endif;
    else:
      if ($DEBUG=="on"): PrintMessage("ERROR", "My-SQL", "В базе данных <B>arj</B> не найдено ни одной таблицы данных за <B>".$months[$startmonth+0]." $startyear года</B>!"); endif;
    endif;

    if (($daycount==$num_rows)&&($b==TRUE)):
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "Инфо", "В БД <B>arj</B> содержатся все подневные таблицы (<B>ird_$startyear$startmonth%</B>) в количестве <B>$num_rows</B>, необходимые для формирования месячной таблицы (<B>arj.irda_$startyear$startmonth</B>)."); endif;
    endif;

    // вывод списка для формирования полного отчёта недостающих таблиц

    $s="Список таблиц, отсутствующих в базе данных <B>arj</B> на MySQL-сервере <B>$HostName</B>:";
    foreach ($ird_failed as $i):
      $s.="<BR>&nbsp;&nbsp;".$i;
    endforeach;
    if (((count($ird_failed))>0)&&($DEBUG=="on")): PrintMessage("ERROR", "My-SQL", $s); endif;
    // в $daycount содержится количество дней в указанном месяце
    // в $fullmonthtable_recird_counter содержится количество записей в таблице arj.irda_$startyear$startmonth
    // в $b - флаг присутствия всех подневных файлов за указанный месяц
    // в $ird_failed[] содержатся наименования отсутствующих подневных таблиц

    // соединение по FTP и попытка копирования и преобразования необходимых файлов
    if (count($ird_failed)!=0):
      $ftp_server="10.1.1.2";
      $conn_id=ftp_connect($ftp_server);
      if ($conn_id<1):
        ShowErrorMessage("Не удалось установить соединение с FTP-сервером <B>$ftp_server</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      $login_result=@ftp_login($conn_id, "root", "kron");
      if ((!$conn_id)||(!$login_result)):
        ShowErrorMessage("Не удалось подключиться к FTP-серверу <B>$ftp_server</B> под указанным логином и паролем! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      else:
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "FTP", "Успешно установлено соединение с FTP-сервером <B>$ftp_server</B>."); endif;
      endif;
/* работает только в PHP>=4.2.0
      if (ftp_set_option($conn_id, FTP_TIMEOUT_SEC, 5*60)!=TRUE): // устанавливаем таймаут сетевых операций по FTP в 5 минут
        ShowErrorMessage("Не удалось установить время таймаута на FTP-сервере <B>$ftp_server</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
*/
      // переход в нужный каталог
      if (@ftp_chdir($conn_id, "shared_disk/usr/local/var/statistika/")): 
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "FTP", "Выполнен переход в директорию <B>" . ftp_pwd($conn_id) . "/</B>."); endif;
      else:
        ShowErrorMessage("Не удалось сменить директорию на FTP-сервере <B>$ftp_server</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // поочерёдно пытаемся скопировать файлы, необходимые для каждой из недостающих таблиц и преобразовать их из формата ISAM в формат MyISAM
      $ext[]="frm"; $ext[]="ISD"; $ext[]="ISM";
      for ($i=0; $i<(count($ird_failed));$i++):
        // копирование трёх файлов для каждой из таблиц
        for ($j=0;$j<count($ext);$j++):
          // формирование имени файла за текущий день
          $thisdayfilename="ird_".$y;
          if ($m<10) $thisdayfilename.="0";
          $thisdayfilename.="$m";
          if ($d<10) $thisdayfilename.="0";
          $thisdayfilename.="$d";
          // проверка на копирование файлов за текущую дату
          if ($ird_failed[$i]==$thisdayfilename):
            ShowErrorMessage("Во избежание получения некорректных данных, запрещается копирование файлов данных за текущий день (<B>$thisdayfilename.*</B>)! Повторите попытку завтра или обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;

          $fn="$ird_failed[$i].$ext[$j]";
          if (!(@ftp_size($conn_id, $fn)>0)):
            ShowErrorMessage("Требуемый файл <B>$fn</B> не был найден на FTP-сервере <B>$ftp_server</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          if (@ftp_get($conn_id, "d:\\WWW\mysql\\data\\ARJ\\$fn", $fn, FTP_BINARY)):
            if ($DEBUG=="on"): PrintMessage("SUCCESS", "FTP", "Файл <B>$fn</B> с FTP-сервера <B>$ftp_server</B> успешно скопирован на сервер <B>$HostName</B>."); endif;
          else:
            ShowErrorMessage("Не удалось скопировать файл <B>$fn</B> с FTP-сервера <B>$ftp_server</B> на сервер <B>$HostName</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endfor;
        // преобразование созданных файлов в формат MyISAM
        $q="ALTER TABLE arj.".$ird_failed[$i]." TYPE=MyISAM;";
        if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
        mysql_query($q);
        // проверка на корректность выполнения операции конвертации
        if (mysql_affected_rows()>=0):
          if ($DEBUG=="on"): PrintMessage("SUCCESS", "MySQL", "Таблица <B>arj.".$ird_failed[$i]."</B> была успешно преобразована в формат MyISAM."); endif;
        else:
          ShowErrorMessage("Возникла ошибка при преобразовании таблицы <B>arj.".$ird_failed[$i]."</B> в формат MyISAM! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endfor;
      ftp_quit($conn_id);
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "FTP", "Соединение с FTP-сервером <B>$ftp_server</B> разорвано."); endif;
      // первоначальная инициализация переменной
      $b=TRUE;
      // получаем количество таблиц ird_$year$month$day за указанный месяц, содержащихся в БД arj на MAINSERVER
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Получение количества таблиц <B>arj.ird_$startyear$startmonth%</B>..."); endif;
      $q="SHOW TABLES FROM arj LIKE 'ird_$startyear$startmonth"."__';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      $s="В базе данных <B>arj</B> найдены таблицы данных за <B>".$months[$startmonth+0]." $startyear года</B> в количестве <B>$num_rows</B>:";
      for ($i=0; $i<$num_rows;$i++):
        $s1=mysql_result($table, $i, 0); 
        if ($s1!=""): 
          $ird_founded[]=$s1;
          $s.="<BR>&nbsp;&nbsp;$s1";
        endif;
      endfor;
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", $s); endif;
      // формирование массива недостающих таблиц 
      foreach ($ird_must as $i):
        if (!(in_array($i, $ird_founded))):
          $ird_failed1[]=$i;
          $b=FALSE;
        endif;
      endforeach;
      if (($daycount==$num_rows)&&($b==TRUE)):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "Инфо", "В БД <B>arj</B> содержатся все подневные таблицы (<B>ird_$startyear$startmonth%</B>) в количестве <B>$num_rows</B>, необходимые для формирования месячной таблицы (<B>arj.irda_$startyear$startmonth</B>)."); endif;
      else:
        $s="Не удалось найти и получить доступ к следующим таблицам базы данных <B>arj</B> на MySQL-сервере <B>$HostName</B>:";
        foreach ($ird_failed1 as $i):
          $s.="<BR>&nbsp;&nbsp;$ird_failed1[$i]";
        endforeach;
        ShowErrorMessage("$s<BR>Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endif;
    // если мы дошли до этого места, то в базе arj уже должны быть все необходимые таблицы для формирования сводной таблицы за месяц
    // теперь нужно будет подсчитать количество записей в таблицы ird_$year$month$day за указанный период, и сравнить с полученным количеством записей (с переменной $fullmonthtable_recird_counter)
    $perdatemonthtables_recird_counter=0;
    foreach ($ird_must as $i):
      $q="SELECT COUNT(*) AS f1 FROM arj.$i;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        $i1=mysql_result($table, 0, "f1"); // получаем количество строк в таблице
        $perdatemonthtables_recird_counter=$perdatemonthtables_recird_counter+$i1;
        if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Найдено строк в таблице <B>arj.$i</B>: $i1."); endif;
      else:
        ShowErrorMessage("Сбой при выполнении запроса! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endforeach;
    if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Всего записей в подневных таблицах за <B>$months[$startmonth] $startyear года</B>: $perdatemonthtables_recird_counter."); endif;

















    // производим поиск таблицы irda_$year$minth за указанный месяц
    if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Проверка наличия таблицы <B>arj.irda_$startyear$startmonth</B>..."); endif;
    $q="SHOW TABLES FROM arj LIKE 'irda_$startyear$startmonth';";
    if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($num_rows!=0):
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Таблица <B>arj.irda_$startyear$startmonth</B> успешно найдена."); endif;
      // получение количества строк таблицы
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Получение количества строк таблицы <B>arj.irda_$startyear$startmonth</B>..."); endif;
      $q="SELECT COUNT(*) AS f1 FROM arj.irda_$startyear$startmonth;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        $fullmonthtable_recird_counter=mysql_result($table, 0, "f1"); // получаем количество строк в таблице
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Найдено строк в таблице <B>arj.irda_$startyear$startmonth</B>: $fullmonthtable_recird_counter."); endif;
      else:
        ShowErrorMessage("Сбой при выполнении запроса! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    else:
      if ($DEBUG=="on"): PrintMessage("ERROR", "My-SQL", "Таблица <B>arj.irda_$startyear$startmonth</B> не найдена!"); endif;
    endif;

    if (($fullmonthtable_recird_counter!=$perdatemonthtables_recird_counter)||($RECALC=="on")): // если количество записей в таблице за месяц не совпадает с количеством записей за месяц из таблиц по дням - значит таблицу можно в принципе сразу убить и создать новую
      // удаление таблицы arj.irda_$startyear$startmonth в случае её наличия
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Удаление таблицы <B>arj.irda_$startyear$startmonth</B> при её наличии..."); endif;
      $q="DROP TABLE IF EXISTS arj.irda_$startyear$startmonth;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      mysql_query($q);
      // проверка корректности удаления таблицы
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Проверка наличия таблицы <B>arj.irda_$startyear$startmonth</B>..."); endif;
      $q="SHOW TABLES FROM arj LIKE 'irda_$startyear$startmonth';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Таблица <B>arj.irda_$startyear$startmonth</B> успешно удалена."); endif;
      else:
        ShowErrorMessage("Сбой при выполнении запроса! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // создание таблицы arj.irda_$startyear$startmonth
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Создание таблицы <B>arj.irda_$startyear$startmonth</B>..."); endif;
      $q="CREATE TABLE arj.irda_$startyear$startmonth (ani char(32) NOT NULL default '', ddi char(32) NOT NULL default '', datum date NOT NULL default '0000-00-00', vrijeme time default NULL, dur decimal(11,0) NOT NULL default '0', rc decimal(3,0) NOT NULL default '0', srv decimal(3,0) NOT NULL default '0', rm decimal(3,0) NOT NULL default '0', izg decimal(3,0) NOT NULL default '0', izgnum char(32) NOT NULL default '', druga_info decimal(3,0) NOT NULL default '0', v_oper char(8) default NULL, v_mreza char(8) default NULL, qid decimal(3,0) default NULL, ccid decimal(3,0) default NULL, d_qid decimal(3,0) default NULL, d_ccid decimal(3,0) default NULL, qdur decimal(11,0) NOT NULL default '0', KEY datum (datum), KEY ddi (ddi), KEY ani (ani)) TYPE=MyISAM;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      mysql_query($q);
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Проверка наличия таблицы <B>arj.irda_$startyear$startmonth</B>..."); endif;
      $q="SHOW TABLES FROM arj LIKE 'irda_$startyear$startmonth';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows!=0):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Таблица <B>arj.irda_$startyear$startmonth</B> успешно найдена."); endif;
        $fullmonthtable_recird_counter=0; // количество строк в таблице равно 0 - т.к. создали новую таблицу
      else:
        ShowErrorMessage("Не удалось создать таблицу <B>arj.irda_$startyear$startmonth</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Найдено строк в таблице <B>arj.irda_$startyear$startmonth</B>: $fullmonthtable_recird_counter."); endif;
    endif;
    if ($fullmonthtable_recird_counter==$perdatemonthtables_recird_counter): // если количество строк совпадает - вывести сообщение о том, что таблица уже сформирована
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
            <TD HEIGHT="15"></TD>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD HEIGHT="15" COLSPAN="5"></TD>
          </TR>
          <TR>
            <TD COLSPAN="5">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="2">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    if ($RECALC=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Для возврата к шагу выбора параметров отчёта нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="5"></TD>
          </TR>
        </TFOOT>
        <TBODY ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD ROWSPAN="5"></TD>
            <TD WIDTH="13" ROWSPAN="5" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="5" BGCOLOR="#339999"></TD>
            <TD ROWSPAN="5"></TD>
          </TR>          
          <TR>
            <TD ALIGN="CENTER" BGCOLOR="#339999"><B>Операция выполнена успешно!</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">Таблица <B>arj.irda_<?echo "$startyear$startmonth";?></B> уже была сформирована ранее.<BR>При необходимости полного переформирования таблицы, вернитесь к предыдущему шагу создания отчёта и установите галочку &laquo;Провести полный пересчёт данных таблицы за указанный период&raquo;, после чего сформируйте отчёт вновь.<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM> 
  </BODY>
</HTML>
<?
      die("");
    endif;
    foreach ($ird_must as $i):
      $q="INSERT INTO arj.irda_$startyear$startmonth SELECT * FROM arj.$i;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      mysql_query($q);
      // проверка на корректность выполнения операции конвертации
      if (mysql_affected_rows()>=0):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "MySQL", "Записи из таблицы <B>arj.$i</B> в количестве ".mysql_affected_rows()." были успешно добавлены в таблицу <B>arj.irda_$startyear$startmonth</B>."); endif;
      else:
        ShowErrorMessage("Возникла ошибка при добавлении записей из таблицы <B>arj.$i</B> в таблицу <B>arj.irda_$startyear$startmonth</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endforeach;
    // финальная проверка на совпадение количества записей в подневных файлах за месяц и в месячном файле
    if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Получение количества строк таблицы <B>arj.irda_$startyear$startmonth</B>..."); endif;
    $q="SELECT COUNT(*) AS f1 FROM arj.irda_$startyear$startmonth;";
    if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($num_rows==1):
      $fullmonthtable_recird_counter=mysql_result($table, 0, "f1"); // получаем количество строк в таблице
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Найдено строк в таблице <B>arj.irda_$startyear$startmonth</B>: $fullmonthtable_recird_counter."); endif;
    else:
      ShowErrorMessage("Сбой при выполнении запроса! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    if ($fullmonthtable_recird_counter==$perdatemonthtables_recird_counter): // если количество строк совпадает - вывести сообщение о том, что таблица уже сформирована
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
            <TD HEIGHT="15"></TD>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD HEIGHT="15" COLSPAN="5"></TD>
          </TR>
          <TR>
            <TD COLSPAN="5">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="2">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    if ($RECALC=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Для возврата к шагу выбора параметров отчёта нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="5"></TD>
          </TR>
        </TFOOT>
        <TBODY ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD ROWSPAN="5"></TD>
            <TD WIDTH="13" ROWSPAN="5" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="5" BGCOLOR="#339999"></TD>
            <TD ROWSPAN="5"></TD>
          </TR>          
          <TR>
            <TD ALIGN="CENTER" BGCOLOR="#339999"><B>Операция выполнена успешно!</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">Таблица <B>arj.irda_<?echo "$startyear$startmonth";?></B> была успешно сформирована.<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM> 
<?
    else:
        ShowErrorMessage("Сбой при добавлении записей в таблицу <B>arj.irda_$startyear$startmonth</B>! Обратитесь к системному администратору!", $rep, $time, $amm, $amy);
    endif;
?>
  </BODY>
</HTML>
