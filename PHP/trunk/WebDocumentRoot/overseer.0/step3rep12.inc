<?
// CREATE TABLE overseer.rep14 (id int(10) unsigned NOT NULL auto_increment, yearmonth char(6) NOT NULL default '', connections_quantity int(10) unsigned NOT NULL default '0', succesful_connections_quantity int(10) unsigned NOT NULL default '0', created timestamp(14) NOT NULL, PRIMARY KEY  (`id`), UNIQUE KEY `id` (`id`)) TYPE=MyISAM COMMENT='Статистика по количеству соединений по наведенной справке';
$DEBUG="off";
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
    <TABLE STYLE="margin: 3px 5px; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">
      <TR>
        <TD WIDTH="100" ALIGN="CENTER" STYLE="padding: 3px 5px; border-color: black; border-width: 1px; color: <?echo $cf;?>; background: <?echo $cb;?>; font-weight: bold;"><?echo $as;?></TD>
        <TD STYLE="padding: 3px 5px;"><?echo $bs;?></TD>
      </TR>
    </TABLE>
<?
}

function ShowErrorMessage($as, $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR)
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
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?echo $time;?>">
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?echo $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?echo $amy;?>">
<?
  if ($maker!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?echo $maker;?>">
<?
  endif;
  if ($makerstate!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?echo $makerstate;?>">
<?
  endif;
  if ($makerphone!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?echo $makerphone;?>">
<?
  endif;
  if ($action!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="action" VALUE="<?echo $action;?>">
<?
  endif;
  if ($EMAIL1Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL1Addr" VALUE="<?echo $EMAIL1Addr;?>">
<?
  endif;
  if ($EMAIL1Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL1Name" VALUE="<?echo $EMAIL1Name;?>">
<?
  endif;
  if ($EMAIL2Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL2Addr" VALUE="<?echo $EMAIL2Addr;?>">
<?
  endif;
  if ($EMAIL2Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL2Name" VALUE="<?echo $EMAIL2Name;?>">
<?
  endif;
  if ($EMAIL3Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL3Addr" VALUE="<?echo $EMAIL3Addr;?>">
<?
  endif;
  if ($EMAIL3Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL3Name" VALUE="<?echo $EMAIL3Name;?>">
<?
  endif;
  if ($RECALC!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?echo $RECALC;?>">
<?
  endif;
  if ($FROMSTARTOFYEAR!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="FROMSTARTOFYEAR" VALUE="<?echo $FROMSTARTOFYEAR;?>">
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
    <TITLE><?echo $reports[12]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <LINK REL="previous" HREF="<?echo $base_url;?>?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;
      if ($amm!=""): echo "&amp;amm=$amm"; endif;
      if ($amy!=""): echo "&amp;amy=$amy"; endif;
      if ($maker!=""): echo "&amp;maker=$maker"; endif;
      if ($makerstate!=""): echo "&amp;makerstate=$makerstate"; endif;
      if ($makerphone!=""): echo "&amp;makerphone=$makerphone"; endif;
      if ($action!=""): echo "&amp;action=$action"; endif;
      if ($EMAIL1Addr!=""): echo "&amp;EMAIL1Addr=$EMAIL1Addr"; endif;
      if ($EMAIL1Name!=""): echo "&amp;EMAIL1Name=$EMAIL1Name"; endif;
      if ($EMAIL2Addr!=""): echo "&amp;EMAIL2Addr=$EMAIL2Addr"; endif;
      if ($EMAIL2Name!=""): echo "&amp;EMAIL2Name=$EMAIL2Name"; endif;
      if ($EMAIL3Addr!=""): echo "&amp;EMAIL3Addr=$EMAIL3Addr"; endif;
      if ($EMAIL3Name!=""): echo "&amp;EMAIL3Name=$EMAIL3Name"; endif;
      if ($RECALC!=""): echo "&amp;RECALC=$RECALC"; endif;
      if ($FROMSTARTOFYEAR!=""): echo "&amp;FROMSTARTOFYEAR=$FROMSTARTOFYEAR"; endif;?>">
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
      // валидация временного промежутка
      if (($time!="lastmonth")&&($time!="anothermonth")): // если временной промежуток не попадает ни под один из дозволенных - вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // вывод отладочной информации в случае необходимости
      if ($DEBUG=="on"):
        PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - <B>$months[$startmonth]&nbsp;$startyear&nbsp;года</B>.");
      endif;
      // если был выбран произвольный месяц, проводим валидацию даты
      if ($time=="anothermonth"):
        if (checkdate($startmonth,$startday,$startyear)<>1): // если была выбрана несуществующая дата
          ShowErrorMessage("Задан несуществующий месяц! Пожалуйста, вернитесь к предыдущему шагу и повторите ввод.<BR>Если ошибка будет повторяться, обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))>0): // если начальная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Дата начала выбранного Вами месяца (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$m,$d,$y))>0): // если конечная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Дата окончания выбранного Вами месяца (<B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // валидация выбранного действия
      switch ($action):
        case "print": $s="визуальный просмотр, подготовка к сохранению на диск либо к печати"; break;
        case "email": $s="отправка по электронной почте"; break;
        default: $s=""; break;
      endswitch;
      if ($s!=""):
        if ($DEBUG=="on"):
          PrintMessage("INFORMATION", "Info", "Выбранное Вами действие - <B>$s</B>.");
        endif;
      else:
        ShowErrorMessage("Выбрано некорректое действие!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // валидация адресов электронной почты, если выбранное действие - отправка на E-Mail
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
          ShowErrorMessage("Не задано ни одного адресата! Вы должны указать адрес(а) электронной почты (e-mail) в поле(ях) &laquo;<B>Кому</B>&raquo;.<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // подключение к MySQL-серверу
      $HostName="10.1.1.240";
      $UserName="overseer";
      $Password="";
      $DBName="orda";
      $MySQLConnection=@mysql_connect($HostName,$UserName,$Password);
      if ($MySQLConnection==FALSE):
        ShowErrorMessage("Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if (@mysql_select_db("$DBName")==FALSE):
        ShowErrorMessage("Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>."); endif;
      // проверка наличия таблиц БД
      $q="SHOW TABLES FROM orda LIKE 'orda_%';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows<1):
        ShowErrorMessage("Не найдено ни одной таблицы данных в БД <B>orda</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // первоначальная инициализация переменной
      $b=TRUE;
      $orda_founded=array();
      $orda_failed=array();
      // помещаем в нумерованный массив $result_array список всех найденых таблиц ord_ггггммдд
      for ($i=0;$i<($num_rows);$i++):
        $tmp_array=mysql_fetch_array($table, MYSQL_NUM);
        $orda_founded[]=$tmp_array[0];
      endfor;
      $orda_must=array();
      // заполнение массива НЕОБХОДИМЫХ файлов
      if ($FROMSTARTOFYEAR=="on"):
        $cm=1;
      else:
        $cm=$startmonth+0;
      endif;
      $cy=$startyear+0;
      while ((mktime(0,0,0,$stopmonth,1,$startyear)-mktime(0,0,0,$cm,1,$cy))>=0):
        if ($cm<10):
          $orda_must[]="orda_".$cy."0".$cm;
        else:
          $orda_must[]="orda_".$cy.$cm;
        endif;
        if ($cm==12):
          $cm=1;
          $cy++;
        else:
          $cm++;
        endif;
      endwhile;
      //var_dump($orda_must);
      // формирование массива недостающих таблиц
      foreach ($orda_must as $j):
        if (!(in_array($j, $orda_founded))):
          if (!(in_array($j, $orda_failed))):
            $orda_failed[]=$j;
          endif;
          $b=FALSE;
        endif;
      endforeach;
      if ($b==FALSE):
        // вывод ошибки при отсутствии некоторых таблиц БД
        $s="Не удалось найти следующие таблицы базы данных <B>orda</B> на MySQL-сервере <B>$HostName</B>:";
        sort($orda_failed);
        foreach ($orda_failed as $i):
          $s.="<BR>".$i;
        endforeach;
        ShowErrorMessage("$s<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // к этому моменту все проверки выполнены, все необходимые файлы найдены
      // можно заняться получением результатов запросов и формированием тела отчёта
      // составляем текст запроса
      $q="";
      $result_array=array();
      for ($j=0;$j<count($orda_must);$j++):
        $q="SELECT CONCAT(LEFT(RIGHT('".$orda_must[$j]."',6),4),'         ') UNION SELECT RIGHT('".$orda_must[$j]."',2) UNION SELECT COUNT(*) FROM orda.".$orda_must[$j]." UNION SELECT COUNT(*) FROM orda.".$orda_must[$j]." WHERE dur>0 AND v_mreza!='';";
        if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows!=4):
          ShowErrorMessage("Сбой при попытке получения данных из таблицы <B>".$orda_must[$j]."</B> базы данных <B>orda</B></B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $result_array[]=array("Год"=>(mysql_result($table, 0)+0),"Месяц"=>mysql_result($table, 1),"Количество звонков"=>(mysql_result($table, 2)+0),"Количество подключеннных звонков"=>(mysql_result($table, 3)+0));
      endfor;
      //var_dump($result_array);
      if ($FROMSTARTOFYEAR=="on"):
        $s="Статистика по количеству соединений по наведенной справке, оказанных справочно-информационным цехом в период<BR>с 1&nbsp;".$months2[1]."&nbsp;$startyear&nbsp;года по ".$stopday."&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года";
      else:
        $s="Статистика по количеству соединений по наведенной справке, оказанных справочно-информационным цехом в период<BR>с $startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года по ".$stopday."&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года";
      endif;
      $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"82px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"145px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"349px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"3\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"3\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 50px 0px 10px 0px;\">".$s."</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Месяц, год</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Количество соединений</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Количество соединений, закончившихся ответом абонента</TD>
        </TR>";
      for ($i=0;$i<(count($result_array));$i++):
        $bodymessage.="
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 2px; border-color: black; padding: 1px 2px;\">".ucfirst($months[$result_array[$i]["Месяц"]+0])." ".$result_array[$i]["Год"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["Количество звонков"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["Количество подключеннных звонков"]."</TD>
        </TR>";
      endfor;
      $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"3\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"3\" HEIGHT=\"".(702-(count($result_array)*13))."\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"3\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      if ($action=="print"):
        if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Выполняется вывод отчёта на экран для просмотра/печати. Рабочая область отчёта закрашена белым цветом."); endif;
        echo $bodymessage;
      elseif ($action=="email"):
        if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Выполняется отправка отчёта указанным адресатам (см. выше)."); endif;
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
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
          if ($EMAIL1Name!=""): $Headers.="\"$EMAIL1Name\" "; endif;
          $Headers.="<$EMAIL1Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL1Addr",$Subject,$message,$Headers)):
            if ($EMAIL1Name!=""): $s=" <B>$EMAIL1Name</B>"; endif;
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL1Addr</B> прошла успешно.");
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
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
          if ($EMAIL2Name!=""): $Headers.="\"$EMAIL2Name\" "; endif;
          $Headers.="<$EMAIL2Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL2Addr",$Subject,$message,$Headers)):
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL2Addr</B> прошла успешно.");
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
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
          if ($EMAIL3Name!=""): $Headers.="\"$EMAIL3Name\" "; endif;
          $Headers.="<$EMAIL3Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL3Addr",$Subject,$message,$Headers)):
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL3Addr</B> прошла успешно.");
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
      mysql_close($MySQLConnection);
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Выполнено отключение от MySQL-сервера <B>$HostName</B>."); endif;
?>
  </BODY>
</HTML>
