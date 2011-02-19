<?
$DEBUG="off";

function PrintMessage($at, $as, $bs)
{
  global $DEBUG;
  if ($DEBUG=="on"):
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
    <TABLE STYLE="margin: 3px 5px; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">
      <TR>
        <TD WIDTH="100" ALIGN="CENTER" STYLE="padding: 3px 5px; border-color: black; border-width: 1px; color: <?echo $cf;?>; background: <?echo $cb;?>; font-weight: bold;"><?echo $as;?></TD>
        <TD STYLE="padding: 3px 5px;"><?echo $bs;?></TD>
      </TR>
    </TABLE>
<?
  endif;
}

function ShowErrorMessage($as, $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC)
{
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
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
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
  if ($maker!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?print $maker;?>">
<?
  endif;
  if ($makerstate!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?print $makerstate;?>">
<?
  endif;
  if ($makerphone!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?print $makerphone;?>">
<?
  endif;
  if ($action!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="action" VALUE="<?print $action;?>">
<?
  endif;
  if ($EMAIL1Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL1Addr" VALUE="<?print $EMAIL1Addr;?>">
<?
  endif;
  if ($EMAIL1Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL1Name" VALUE="<?print $EMAIL1Name;?>">
<?
  endif;
  if ($EMAIL2Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL2Addr" VALUE="<?print $EMAIL2Addr;?>">
<?
  endif;
  if ($EMAIL2Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL2Name" VALUE="<?print $EMAIL2Name;?>">
<?
  endif;
  if ($EMAIL3Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL3Addr" VALUE="<?print $EMAIL3Addr;?>">
<?
  endif;
  if ($EMAIL3Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL3Name" VALUE="<?print $EMAIL3Name;?>">
<?
  endif;
  if ($RECALC!=""):
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
    <TITLE><?echo $reports[5]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <!--LINK REL="previous" HREF="<?echo $base_url;?>?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;?><?if ($aqq!=""): echo "&amp;aqq=$aqq"; endif;?><?if ($aqy!=""): echo "&amp;aqy=$aqy"; endif;?><?if ($maker!=""): echo "&amp;maker=$maker"; endif;?><?if ($makerstate!=""): echo "&amp;makerstate=$makerstate"; endif;?><?if ($makerphone!=""): echo "&amp;makerphone=$makerphone"; endif;?><?if ($action!=""): echo "&amp;action=$action"; endif;?><?if ($EMAIL1Addr!=""): echo "&amp;EMAIL1Addr=$EMAIL1Addr"; endif;?><?if ($EMAIL1Name!=""): echo "&amp;EMAIL1Name=$EMAIL1Name"; endif;?><?if ($EMAIL2Addr!=""): echo "&amp;EMAIL2Addr=$EMAIL2Addr"; endif;?><?if ($EMAIL2Name!=""): echo "&amp;EMAIL2Name=$EMAIL2Name"; endif;?><?if ($EMAIL3Addr!=""): echo "&amp;EMAIL3Addr=$EMAIL3Addr"; endif;?><?if ($EMAIL3Name!=""): echo "&amp;EMAIL3Name=$EMAIL3Name"; endif;?><?if ($RECALC=="on"): echo "&amp;RECALC=$RECALC"; endif;?>"-->
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
      TABLE, TD {
        border-style: solid;
      }
    </STYLE>
  </HEAD>
  <BODY<?if (($DEBUG=="on")||($action=="email")):?> BGCOLOR="gainsboro"<?endif;?>>
<?
      if ($time=="lastquart"):
        $quartbd=$lqbd;
        $quarted=$lqed;
        $quartbm=$lqbm;
        $quartem=$lqem;
        $quart=$lqq;
        $year=$lqy;
      elseif ($time=="anotherquart"):
        $quartbd=$aqbd;
        $quarted=$aqed;
        $quartbm=$aqbm;
        $quartem=$aqem;
        $quart=$aqq;
        $year=$aqy;
      endif;
      PrintMessage("INFORMATION", "Info", "Выбранный Вами квартал - <B>".$quartals[$quart]."&nbsp;квартал&nbsp;$year&nbsp;года</B>.");
      switch ($action):
        case "print": $s="визуальный просмотр, подготовка к сохранению на диск либо к печати"; break;
        case "email": $s="отправка по электронной почте"; break;
        default: $s=""; break;
      endswitch;
      if ($s!=""):
        PrintMessage("INFORMATION", "Info", "Выбранное Вами действие - <B>$s</B>.");
      else:
        ShowErrorMessage("Выбрано некорректое действие!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if ($action=="email"):
        if ((($EMAIL1Addr!="")||($EMAIL1Name!=""))&&($DEBUG=="on")):
          PrintMessage("INFORMATION", "Info", "Выбранные Вами параметры адресата #1 - <I>Куда:</I> <B>$EMAIL1Addr</B>, <I>Кому:</I> <B>$EMAIL1Name</B>.");
        endif;
        if ((($EMAIL2Addr!="")||($EMAIL2Name!=""))&&($DEBUG=="on")):
          PrintMessage("INFORMATION", "Info", "Выбранные Вами параметры адресата #2 - <I>Куда:</I> <B>$EMAIL2Addr</B>, <I>Кому:</I> <B>$EMAIL2Name</B>.");
        endif;
        if ((($EMAIL3Addr!="")||($EMAIL3Name!=""))&&($DEBUG=="on")):
          PrintMessage("INFORMATION", "Info", "Выбранные Вами параметры адресата #3 - <I>Куда:</I> <B>$EMAIL3Addr</B>, <I>Кому:</I> <B>$EMAIL3Name</B>.");
        endif;
        if (($EMAIL1Addr=="")&&($EMAIL2Addr=="")&&($EMAIL3Addr=="")):
          ShowErrorMessage("Не задано ни одного адресата! Вы должны указать адрес(а) электронной почты (e-mail) в поле(ях) &laquo;Кому&raquo;.<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // получение наименований необходимых помесячных таблиц
      $irda_names=array();
      $i=($quart*3)-2; if ($i<10): $irda_names[]="irda_".$year."0$i"; else: $irda_names[]="irda_".$year."$i"; endif;
      $i=($quart*3)-1; if ($i<10): $irda_names[]="irda_".$year."0$i"; else: $irda_names[]="irda_".$year."$i"; endif;
      $i=($quart*3); if ($i<10): $irda_names[]="irda_".$year."0$i"; else: $irda_names[]="irda_".$year."$i"; endif;
      PrintMessage("INFORMATION", "Info", "Список помесячных таблиц данных, необходимых для формирования отчёта - <B>".$irda_names[0]."</B>, <B>".$irda_names[1]."</B>, <B>".$irda_names[2]."</B>.");
      // подключение к MySQL-серверу
      $HostName="10.1.1.240";
      $UserName="overseer";
      $Passwird="";
      $DBName="irda";
      $MySQLConnection=@mysql_connect($HostName,$UserName,$Passwird);
      if ($MySQLConnection==FALSE):
        PrintMessage("ERROR","My-SQL","Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!");
        die("  </BODY>\n</HTML>");
      endif;
      if (@mysql_select_db("$DBName")==FALSE):
        PrintMessage("ERROR","My-SQL","Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!");
        die("  </BODY>\n</HTML>");
      endif;
      PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>.");
      // проверка наличия таблицы данных отчёта
      $q="SHOW TABLES FROM overseer LIKE 'rep5';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>overseer.rep5</B> найдена успешно.");
      elseif ($num_rows==0):
        PrintMessage("ERROR", "My-SQL", "Таблица данных <B>overseer.rep5</B> не найдена!");
        // попытка создания таблицы overseer.rep5
        PrintMessage("INFORMATION", "Info", "Попытка создания таблица данных <B>overseer.rep5</B>...");
        $q="CREATE TABLE overseer.rep5 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, call_middletime decimal(13,2) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL, allowed_call_middletime decimal(13,2) default NULL, nonallowed_call_percent decimal(5,2) default NULL) TYPE=MyISAM;";
        PrintMessage("QUERY", "SQL", $q);
        mysql_query($q);
        // повторная проверка наличия таблицы данных отчёта
        $q="SHOW TABLES FROM overseer LIKE 'rep5';";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>overseer.rep5</B> найдена успешно.");
        else:
          ShowErrorMessage("Сбой при попытке создания таблицы данных <B>overseer.rep5</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      else:
        ShowErrorMessage("Сбой при попытке поиска таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>".$irda_names[$i]."</B>) в базе данных <B>$DBName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // если установлен флаг пересчёта данных - нужно удалить всю имеющуюся (возможно) информацию за указанный период из таблицы overseer.rep5
      if ($RECALC=="on"):
        for ($i=0;$i<3;$i++):
          PrintMessage("INFORMATION", "Info", "Попытка удаления данных за <B>".$months[$quart*3-(2-$i)]." $year года</B>...");
          $j=$quart*3-(2-$i); if ($j<10) $j="0$j";
          $q="DELETE FROM overseer.rep5 WHERE yearmonth='$year$j';";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          PrintMessage("INFORMATION", "Info", "Проверка наличия записей за <B>".$months[$quart*3-(2-$i)]." $year года</B>...");
          $q="SELECT COUNT(*) AS f1 FROM overseer.rep5 WHERE yearmonth='$year$j';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows!=1):
            ShowErrorMessage("Сбой при получении количества подлежащих удалению записей за <B>".$months[$quart*3-(2-$i)]." $year года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $f1=mysql_result($table, 0, "f1"); // получаем количество строк в таблице
          if ($f1==0):
            PrintMessage("SUCCESS", "My-SQL", "Данные за <B>".$months[$quart*3-(2-$i)]." $year года</B> из таблицы <B>overseer.rep5</B> удалены успешно.");
          else:
            ShowErrorMessage("Сбой при попытке удаления записей за <B>".$months[$quart*3-(2-$i)]." $year года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endfor;
      else:
        PrintMessage("INFORMATION", "Info", "Флаг пересчёта данных <B>не установлен</B> - ранее расчитанные данные из таблицы <B>overseer.rep5</B> удаляться не будут.");
      endif;
      for ($i=0;$i<3;$i++):
        // поиск готовых данных за требуемый период в таблице overseer.rep5
        // и если данные найдены - пересчёт выполнять не нужно - достаточно выдать готовый результат
        PrintMessage("INFORMATION", "Info", "Поиск ранее расчитанных данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> в таблице <B>overseer.rep5</B>...");
        $j=$quart*3-(2-$i); if ($j<10) $j="0$j";
        $q="SELECT COUNT(*) AS f1 FROM overseer.rep5 WHERE yearmonth='$year$j';";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows!=1):
          ShowErrorMessage("Сбой при получении количества ранее расчитанных записей за <B>".$months[$quart*3-(2-$i)]." $year года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $f1=mysql_result($table, 0, "f1"); // получаем количество строк в таблице
        if ($f1==1):
          PrintMessage("SUCCESS", "My-SQL", "Данные за <B>".$months[$quart*3-(2-$i)]." $year года</B> в таблице <B>overseer.rep5</B> найдены успешно.");
        elseif ($f1==0):
          PrintMessage("ERROR", "My-SQL", "Данные за <B>".$months[$quart*3-(2-$i)]." $year года</B> в таблице <B>overseer.rep5</B> найдены не были!");
        else:
          ShowErrorMessage("Сбой при попытке получения количества записей за <B>".$months[$quart*3-(2-$i)]." $year года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ($f1!=1): // если данные не были успешно найдены в таблице - проверить наличие всех таблиц за требующиеся месяцы
          // проверка наличия всех необходимых файлов
          PrintMessage("INFORMATION", "Info", "Проверка наличия таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>".$irda_names[$i]."</B>)...");
          $q="SHOW TABLES FROM irda LIKE '".$irda_names[$i]."';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows==0):
            ShowErrorMessage("Отчёт не может быть сформирован по причине отсутствия таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>".$irda_names[$i]."</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          elseif ($num_rows==1):
            PrintMessage("SUCCESS", "My-SQL", "Таблица данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>".$irda_names[$i]."</B>) найдена успешно.");
          else:
            ShowErrorMessage("Сбой при попытке поиска таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>".$irda_names[$i]."</B>) в базе данных <B>$DBName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
// проведение расчётов за месяц с занесением данных в таблицу
          // удаляем все временные таблицы, использующиеся при формировании отчётов
          PrintMessage("INFORMATION", "Info", "Удаление временных таблиц данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)...");
          $q="DROP TABLE IF EXISTS overseer.rep5_1, overseer.rep5_2, overseer.rep5_3;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          // проверяем, удалены ли все перечисленные таблицы
          PrintMessage("INFORMATION", "Info", "Проверка наличия временных таблиц данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)...");
          $q="SHOW TABLES FROM overseer LIKE 'rep5_%';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows==0):
            PrintMessage("SUCCESS", "My-SQL", "Временные таблицы данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>) удалены успешно.");
          else:
            ShowErrorMessage("Сбой при попытке удаления временных таблиц данных, используемых при расчётах (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          // создаём временные таблицы
          PrintMessage("INFORMATION", "Info", "Создание временных таблиц данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)...");
          $q="CREATE TABLE overseer.rep5_1 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL) TYPE=MyISAM COMMENT='выборка по поступившим абонентам';";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          $q="CREATE TABLE overseer.rep5_2 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL) TYPE=MyISAM COMMENT='выборка по обслуженным абонентам';";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          $q="CREATE TABLE overseer.rep5_3 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, call_middletime decimal(13,2) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL, allowed_call_middletime decimal(13,2) default NULL, nonallowed_call_percent decimal(5,2) default NULL) TYPE=MyISAM COMMENT='суммарная выборка';";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          // проверка наличия созданных таблиц
          PrintMessage("INFORMATION", "Info", "Проверка наличия временных таблиц данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)...");
          $q="SHOW TABLES FROM overseer LIKE 'rep5_%';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows==3):
            PrintMessage("SUCCESS", "My-SQL", "Временные таблицы данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>) созданы успешно.");
          else:
            ShowErrorMessage("Сбой при попытке создания временных таблиц данных, используемых при расчётах (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $q="INSERT INTO overseer.rep5_1 SELECT ddi AS 'Номер услуги', '$year$j', COUNT(*) AS 'Количество поступивших звонков', SUM(dur) AS 'Общая продолжительность звонков', '' AS 'Количество обслуженных звонков', '' AS 'Общая продолжительность обслуженных звонков' FROM irda.".$irda_names[$i]." WHERE ddi='109' GROUP BY ddi;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          if (mysql_affected_rows()==1):
            PrintMessage("SUCCESS", "My-SQL", "Результат выборки был успешно помещён во временную таблицу данных (<B>overseer.rep5_1</B>.");
          else:
            ShowErrorMessage("Сбой при попытке помещения результатов запроса во временную таблицу <B>overseer.rep5_1</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $q="INSERT INTO overseer.rep5_2 SELECT ddi AS 'Номер услуги', '$year$j', '' AS 'Количество поступивших звонков', '' AS 'Общая продолжительность звонков', COUNT(*) AS 'Количество обслуженных звонков', SUM(dur) AS 'Общая продолжительность обслуженных звонков' FROM irda.".$irda_names[$i]." WHERE ddi='109' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          if (mysql_affected_rows()==1):
            PrintMessage("SUCCESS", "My-SQL", "Результат выборки был успешно помещён во временную таблицу данных <B>overseer.rep5_2</B>.");
          else:
            ShowErrorMessage("Сбой при попытке помещения результатов запроса во временную таблицу <B>overseer.rep5_2</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $q="INSERT INTO overseer.rep5_3 SELECT a.ddi AS 'Номер услуги', '$year$j', a.call_quantity AS 'Количество поступивших звонков', a.call_sumtime AS 'Общая продолжительность поступивших звонков', a.call_sumtime/a.call_quantity AS 'Среднее время поступившего звонка', b.allowed_call_quantity AS 'Количество обслуженных звонков', b.allowed_call_sumtime AS 'Общая продолжительность обслуженных звонков', b.allowed_call_sumtime/b.allowed_call_quantity AS 'Среднее время обслуженного звонка', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS 'Процент отказов' FROM overseer.rep5_1 AS a, overseer.rep5_2 AS b WHERE a.ddi=b.ddi;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          if (mysql_affected_rows()==1):
            PrintMessage("SUCCESS", "My-SQL", "Результат выборки был успешно помещён во временную таблицу данных (<B>overseer.rep5_3</B>.");
          else:
            ShowErrorMessage("Сбой при попытке помещения результатов запроса во временную таблицу <B>overseer.rep5_3</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          PrintMessage("INFORMATION", "My-SQL", "Помещение результата выборки в таблицу данных <B>overseer.rep5</B>...");
          $q="INSERT INTO overseer.rep5 SELECT * FROM overseer.rep5_3 WHERE yearmonth='$year$j';";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          if (mysql_affected_rows()==1):
            PrintMessage("SUCCESS", "My-SQL", "Результат выборки был успешно помещён в таблицу данных <B>overseer.rep5</B>.");
          else:
            ShowErrorMessage("Сбой при попытке помещения результатов запроса в таблицу <B>overseer.rep5</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          // удаляем все временные таблицы, использующиеся при формировании отчётов
          PrintMessage("INFORMATION", "Info", "Удаление временных таблиц данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)...");
          $q="DROP TABLE IF EXISTS overseer.rep5_1, overseer.rep5_2, overseer.rep5_3;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          // проверяем, удалены ли все перечисленные таблицы
          PrintMessage("INFORMATION", "Info", "Проверка наличия временных таблиц данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)...");
          $q="SHOW TABLES FROM overseer LIKE 'rep5_%';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows==0):
            PrintMessage("SUCCESS", "My-SQL", "Временные таблицы данных (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>) удалены успешно.");
          else:
            ShowErrorMessage("Сбой при попытке удаления временных таблиц данных, используемых при расчётах (<B>overseer.rep5_1</B>, <B>overseer.rep5_2</B>, <B>overseer.rep5_3</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
      endfor;
      // получение всех данных, необходимых для составления формы, из таблицы overseer.rep5 и заполнение результирующего массива значениями
      $result_array=array();
      for ($i=$quartbm;$i<=$quartem;$i++):
        $j=$i; if ($j<10) $j="0".$j;
        $j1[]=$j;
        $q="SELECT RIGHT(yearmonth,2) AS f1, LEFT(yearmonth,4) AS f2, call_quantity AS f3, call_sumtime AS f4, allowed_call_quantity AS f5, allowed_call_sumtime AS f6, nonallowed_call_percent AS f7 FROM overseer.rep5 WHERE ddi='109' AND yearmonth='$year$j' ORDER BY yearmonth;";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Данные за <B>".$months[$j+0]." $year года</B> были успешно найдены в таблице <B>overseer.rep5</B>.");
        else:
          ShowErrorMessage("Сбой при попытке получения данных за <B>".$month[$j+0]." $year года</B> из таблицы <B>overseer.rep5</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $tmp_array=mysql_fetch_assoc($table);
        $result_array[]=$tmp_array;
      endfor;
      $q="SELECT '' AS f1, '' AS f2, SUM(call_quantity) AS f3, SUM(call_sumtime) AS f4, SUM(allowed_call_quantity) AS f5, SUM(allowed_call_sumtime) AS f6, (100-((SUM(allowed_call_quantity)/SUM(call_quantity))*100)) AS f7 FROM overseer.rep5 WHERE ddi='109' AND (yearmonth='$year".$j1[0]."' OR yearmonth='$year".$j1[1]."' OR yearmonth='$year".$j1[2]."') GROUP BY ddi;";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Данные за <B>".$quartals[$quart]." квартал $year года</B> были успешно найдены в таблице <B>overseer.rep5</B>.");
      else:
        ShowErrorMessage("Сбой при попытке получения данных за <B>".$quartals[$quart]." квартал $year года</B> из таблицы <B>overseer.rep5</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      $tmp_array=mysql_fetch_assoc($table);
      $result_array[]=$tmp_array;

      // всё - к этому моменту есть все данные для вывода результатов в документ:
      // в ассоциативном массиве $result_array[] содержатся данные за три месяца квартала (элементы 0,1,2) и итоговые значения за весь квартал (элемент 3)
      // в переменных $maker, $makerstate, $makerphone содержатся данные об исполнителе
      // в переменных $quartbd, $quartbm, $year - начальная дата квартала, в переменных $quarted, $quartem, $year - конечная дата квартала
      $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"95px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"105px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"130px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"105px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"130px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"6\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"6\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 50px 0px 3px 0px;\">Статистика по услуге &laquo;109&raquo; за период<BR>с ".$quartbd." ".$months2[$quartbm]." $year года по $quarted ".$months2[$quartem]." $year года</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Период<BR>(месяц,<BR>год)</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Количество<BR>поступивших<BR>звонков</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Общая<BR>длительность<BR>поступивших<BR>звонков, сек.</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Количество<BR>обслуженных<BR>звонков</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Общая<BR>длительность<BR>обслуженных<BR>звонков, сек.</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Отказы<BR>по<BR>услуге,<BR>%</TD>
        </TR>";
        for ($i=0;$i<(count($result_array)-1);$i++):
          $bodymessage.="
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1-($i==(count($result_array)-2)))."px 2px; border-color: black; padding: 1px 2px;\">".$months[$result_array[$i]["f1"]+0]."&nbsp;".$result_array[$i]["f2"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 0px 2px ".(1-($i==(count($result_array)-2)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f3"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 0px 2px ".(1-($i==(count($result_array)-2)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f4"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 0px 2px ".(1-($i==(count($result_array)-2)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f5"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 0px 2px ".(1-($i==(count($result_array)-2)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f6"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1-($i==(count($result_array)-2)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f7"]."</TD>
        </TR>";
        endfor;
        $bodymessage.="
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Итого:</TD>
          <TD STYLE=\"text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">".$result_array[count($result_array)-1]["f3"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">".$result_array[count($result_array)-1]["f4"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">".$result_array[count($result_array)-1]["f5"]."</TD>
          <TD STYLE=\"text-align:  right; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">".$result_array[count($result_array)-1]["f6"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">".$result_array[count($result_array)-1]["f7"]."</TD>
        </TR>
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"6\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 40px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"6\" HEIGHT=\"680\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"6\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      if ($action=="print"):
        PrintMessage("INFORMATION", "Info", "Выполняется вывод отчёта на экран для просмотра/печати. Рабочая область отчёта закрашена белым цветом.");
        echo $bodymessage;
      elseif ($action=="email"):
        PrintMessage("INFORMATION", "Info", "Выполняется отправка отчёта указанным адресатам (см. выше).");
        $message="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<HTML>
  <HEAD>
    <TITLE>".$reports[$rep]["Наименование"]."</TITLE>
    <META CONTENT=\"no-cache\" HTTP-EQUIV=\"pragma\">
    <META CONTENT=\"no-cache\" HTTP-EQUIV=\"cache-control\">
    <META CONTENT=\"Dynamic\" NAME=\"Document-state\">
    <META CONTENT=\"text/html; charset=Windows-1251\" HTTP-EQUIV=\"Content-Type\">
    <LINK REL=\"author\" HREF=\"http://vladracoola.by.ru/index1.html\">
    <STYLE MEDIA=\"screen, print\" TYPE=\"text/css\">
      * {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 8pt;
        padding: 0;
        margin: 0;
        border-color: transparent;
        border-width: 0;
        border-style: solid;
        }
      TABLE, TD {
        border-style: solid;
      }
    </STYLE>
  </HEAD>
  <BODY>
".$bodymessage."
  </BODY>
</HTML>";
        $s="";
        // отправка писем адресатам в случае если был выбран соответствующий пункт и заполнены поля адресатов
        if (($EMAIL1Addr!="")&&($action=="email")&&($message!="")):
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <caster@mgts.by>\nTo: ";
          if ($EMAIL1Name!=""): $Headers.="\"$EMAIL1Name\" "; endif;
          $Headers.="<$EMAIL1Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL1Addr",$Subject,$message,$Headers)):
            if ($EMAIL1Name!=""): $s=" <B>$EMAIL1Name</B>"; endif;
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL1Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL1Name!=""): $s=" <B>$EMAIL1Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL1Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
        if (($EMAIL2Addr!="")&&($action=="email")&&($message!="")):
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <caster@mgts.by>\nTo: ";
          if ($EMAIL2Name!=""): $Headers.="\"$EMAIL2Name\" "; endif;
          $Headers.="<$EMAIL2Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL2Addr",$Subject,$message,$Headers)):
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL2Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL2Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
        if (($EMAIL3Addr!="")&&($action=="email")&&($message!="")):
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <caster@mgts.by>\nTo: ";
          if ($EMAIL3Name!=""): $Headers.="\"$EMAIL3Name\" "; endif;
          $Headers.="<$EMAIL3Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL3Addr",$Subject,$message,$Headers)):
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL3Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL3Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
      endif;
?>
  </BODY>
</HTML>
