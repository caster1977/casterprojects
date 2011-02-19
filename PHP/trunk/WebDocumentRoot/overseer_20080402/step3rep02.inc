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

function ShowErrorMessage($as)
{
  global $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $OPENCICLE;
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
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?echo $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?echo $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?echo $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?echo $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?echo $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?echo $aey;?>">
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
  if ($RECALC=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
  endif;
  if ($OPENCICLE=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="OPENCICLE" VALUE="<?print $OPENCICLE;?>">
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
    <TITLE><?echo $reports[$rep]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <LINK REL="previous" HREF="<?echo $base_url;?>?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;
      if ($amm!=""): echo "&amp;amm=$amm"; endif;
      if ($amy!=""): echo "&amp;amy=$amy"; endif;
      if ($abd!=""): echo "&amp;abd=$abd"; endif;
      if ($abm!=""): echo "&amp;abm=$abm"; endif;
      if ($aby!=""): echo "&amp;aby=$aby"; endif;
      if ($aed!=""): echo "&amp;aed=$aed"; endif;
      if ($aem!=""): echo "&amp;aem=$aem"; endif;
      if ($aey!=""): echo "&amp;aey=$aey"; endif;
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
      if ($OPENCICLE!=""): echo "&amp;OPENCICLE=$OPENCICLE"; endif;?>">
    <LINK REL="author" HREF="http://vladracoola.by.ru/index1.html">
    <STYLE MEDIA="screen, print" TYPE="text/css">
      * {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt;
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
  <BODY <?if (($DEBUG=="on")||($action=="email")):?> BGCOLOR="gainsboro"<?endif;?>>
<?
      // валидация временного промежутка
      if (($time!="yesterday")&&($time!="lastweek")&&($time!="lastmonth")&&($time!="anothermonth")&&($time!="another")): // если временной промежуток не попадает ни под один из дозволенных - вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // вывод отладочной информации в случае необходимости
      if ($DEBUG=="on"):
        if (($time=="yesterday")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear))):
          PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>.");
        elseif (($time=="lastweek")||($time=="lastmonth")||($time=="anothermonth")||($time=="another")):
          PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - с <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B> по <B>$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;года</B>.");
        endif;
      endif;
      // если был выбран произвольный промежуток дат, проводим валидацию дат
      if ($time=="another"):
        if (checkdate($startmonth,$startday,$startyear)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата: <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($stopmonth,$stopday,$stopyear)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата: <B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$startmonth,$startday,$startyear))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат: начальная дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) является более поздней, чем конечная дата (<B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))>0): // если начальная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$m,$d,$y))>0): // если конечная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // если начальная или конечная дата равна текущей - выдать ошибку и
      if (((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))==0)||((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$m,$d,$y))==0)):
        ShowErrorMessage("Невозможно создать отчёт за указанный период (c <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B> по <B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>), т.к. отсутствуют данные за текущий день (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // валидация выбранного действия
      switch ($action):
        case "print": $s="визуальный просмотр, подготовка к сохранению на диск либо к печати"; break;
        case "email": $s="отправка по электронной почте"; break;
        default: $s=""; break;
      endswitch;
      if ($s!=""):
        PrintMessage("INFORMATION", "Info", "Выбранное Вами действие - <B>$s</B>.");
      else:
        ShowErrorMessage("Выбрано некорректое действие!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
          ShowErrorMessage("Не задано ни одного адресата! Вы должны указать адрес(а) электронной почты (e-mail) в поле(ях) &laquo;<B>Кому</B>&raquo;.<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // подсчитываем количество дней, входящий в период и помещаем его в переменную $daycount
      $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth+0,$startday+0,$startyear+0);
      //var_dump($i);
      $daycount=0;
      while ($i>=-3600):
        $daycount++;
        //var_dump($daycount);
        $i=$i-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
        //var_dump($i);
      endwhile;
      PrintMessage("INFORMATION", "Info", "Количество дней входящих в расчётный период: <B>$daycount</B>.");
      // составление списка дат, входящих в выбранный период
      $k=mktime(6,0,0,$startmonth+0,$startday+0,$startyear+0);
      $dates=array();
      for ($j=0; $j<$daycount; $j++):
        $cd=date("d",$k)+0;
        if ($cd<10): $cd="0".$cd; endif;
        $cm=date("m",$k)+0;
        if ($cm<10): $cm="0".$cm; endif;
        $cy=date("Y",$k)+0;
        $dates[]="".$cy.$cm.$cd;
        $k=$k+(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
      endfor;
      //var_dump($dates);

      // вывод списка необходимых таблиц prijave_ггггммдд в случае отладки
      $s="Список подневных таблиц данных <B>prijaves.prijave_ггггммдд</B>, необходимых для формирования отчёта:";
      foreach ($dates as $i):
        $s.="<BR><B>&nbsp;&nbsp;prijave_".$i."<B>";
      endforeach;
      PrintMessage("INFORMATION", "Info", $s);
      // вывод списка необходимых таблиц ird_ггггммдд в случае отладки
      $s="Список подневных таблиц данных <B>ird.ird_ггггммдд</B>, необходимых для формирования отчёта:";
      foreach ($dates as $i):
        $s.="<BR><B>&nbsp;&nbsp;ird_".$i."<B>";
      endforeach;
      PrintMessage("INFORMATION", "Info", $s);
      // устанавливаем настройки для подключения к серверу
      $HostName="10.1.1.240";
      $DBName="overseer";
      // попытка подключения к указанному серверу
      $UserName="overseer";
      $Password="";
      $MySQLConnection=@mysql_connect($HostName,$UserName,$Password);
      // если не удалось подключиться к серверу - выдать сообщение и выйти по ошибке
      if ($MySQLConnection==FALSE):
        ShowErrorMessage("Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // если не удалось выбрать базу данных на сервере - выйти по ошибке
      if (@mysql_select_db("$DBName")==FALSE):
        ShowErrorMessage("Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // если удалось подключиться и к серверу и к базе - выдать сообщение в режиме отладки
      PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>.");
      PrintMessage("INFORMATION", "Info", "Проверка наличия всех необходимых таблиц данных (<B>prijaves.prijave_<I>ггггммдд</I></B>)...");
      foreach ($dates as $i):
        $q="SHOW TABLES FROM prijaves LIKE 'prijave_$i';";
      	PrintMessage("QUERY", "SQL", $q);
      	$table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==0):
          ShowErrorMessage("Отчёт не может быть сформирован по причине отсутствия таблицы данных <B>prijaves.prijave_q_".$i."</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        elseif ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>prijaves.prijave_".$i."</B> найдена успешно.");
        else:
          ShowErrorMessage("Сбой при попытке поиска таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>prijave_".$i."</B>) в базе данных <B>prijaves</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endforeach;
      PrintMessage("INFORMATION", "Info", "Проверка наличия всех необходимых таблиц данных (<B>ird.ird_<I>ггггммдд</I></B>)...");
      foreach ($dates as $i):
        $q="SHOW TABLES FROM ird LIKE 'ird_$i';";
      	PrintMessage("QUERY", "SQL", $q);
      	$table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==0):
          ShowErrorMessage("Отчёт не может быть сформирован по причине отсутствия таблицы данных <B>ird.ird_".$i."</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        elseif ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>ird.ird_".$i."</B> найдена успешно.");
        else:
          ShowErrorMessage("Сбой при попытке поиска таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>ird_".$i."</B>) в базе данных <B>ird</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endforeach;
      // удаляем временные таблицы, использующиеся при формировании отчёта
      PrintMessage("INFORMATION", "Info", "Удаление временных таблиц данных (<B>overseer.rep2_arrived</B>, <B>overseer.rep2_served</B>)...");
      $q="DROP TABLE IF EXISTS overseer.rep2_arrived, overseer.rep2_served;";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      // проверяем, удаленв ли таблица overseer.rep2_arrived
      PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>overseer.rep2_arrived</B>)...");
      $q="SHOW TABLES FROM overseer LIKE 'rep2_arrived';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>overseer.rep2_arrived</B>) удалена успешно.");
      else:
        ShowErrorMessage("Сбой при попытке удаления временной таблицы данных, используемой при расчётах (<B>overseer.rep2_arrived</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // проверяем, удаленв ли таблица overseer.rep2_served
      PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>overseer.rep2_served</B>)...");
      $q="SHOW TABLES FROM overseer LIKE 'rep2_served';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>overseer.rep2_served</B>) удалена успешно.");
      else:
        ShowErrorMessage("Сбой при попытке удаления временной таблицы данных, используемой при расчётах (<B>overseer.rep2_served</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // проверка наличия таблицы overseer2.rep2 и её создание в случае отсутствия
      PrintMessage("INFORMATION", "Info", "Проверка наличия таблицы данных <B>overseer.rep2</B>...");
      $q="SHOW TABLES FROM overseer LIKE 'rep2';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>overseer.rep2</B> найдена успешно.");
      elseif ($num_rows==0):
        PrintMessage("ERROR", "My-SQL", "Таблица данных <B>overseer.rep2</B> не найдена! Будет произведена попытка создания данной таблицы.");
        $q="CREATE TABLE overseer.rep2 (session_date date NOT NULL default '0000-00-00', user_name varchar(100) default NULL, user_private_number varchar(20) default NULL, rm int(11) default NULL, session_start_date date default NULL, session_start_time time default NULL, session_stop_date date default NULL, session_stop_time time default NULL, session_pause_in_seconds int(10) unsigned default NULL, served_calls_average_duration_in_seconds decimal(10,2) default NULL, arrived_calls int(10) unsigned default NULL, served_calls int(10) unsigned default NULL, nonserved_calls int(10) unsigned default NULL, KEY session_date (session_date), KEY rm (rm), KEY session_start_date (session_start_date), KEY session_start_time (session_start_time), KEY user_name (user_name), KEY session_stop_date (session_stop_date), KEY session_stop_time (session_stop_time), KEY user_private_number (user_private_number)) TYPE=MyISAM;";
        PrintMessage("QUERY", "SQL", $q);
        mysql_query($q);
        PrintMessage("INFORMATION", "My-SQL", "Попытка создания таблицы данных <B>overseer.rep2</B> выполнена. Будет произведена проверка создания данной таблицы.");
        $q="SHOW TABLES FROM overseer LIKE 'rep2';";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>overseer.rep2</B> создана успешно.");
        else:
          ShowErrorMessage("Сбой при попытке создания таблицы данных <B>overseer.rep2</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      else:
        ShowErrorMessage("Сбой при попытке доступа к таблице данных (<B>overseer.rep2</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // создание временной таблицы данных overseer.rep2_arrived
      PrintMessage("INFORMATION", "My-SQL", "Будет произведена попытка создания временной таблицы данных <B>overseer.rep2_arrived</B>.");
      $q="CREATE TABLE overseer.rep2_arrived (session_date date NOT NULL default '0000-00-00', user_name varchar(100) default NULL, user_private_number varchar(20) default NULL, rm int(11) default NULL, session_start_date date default NULL, session_start_time time default NULL, session_stop_date date default NULL, session_stop_time time default NULL, session_pause_in_seconds int(10) unsigned default NULL, served_calls_average_duration_in_seconds decimal(10,2) default NULL, arrived_calls int(10) unsigned default NULL, served_calls int(10) unsigned default NULL, nonserved_calls int(10) unsigned default NULL, KEY session_date (session_date), KEY rm (rm), KEY session_start_date (session_start_date), KEY session_start_time (session_start_time), KEY user_name (user_name), KEY session_stop_date (session_stop_date), KEY session_stop_time (session_stop_time), KEY user_private_number (user_private_number)) TYPE=MyISAM;";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      PrintMessage("INFORMATION", "My-SQL", "Попытка создания временной таблицы данных <B>overseer.rep2_arrived</B> выполнена. Будет произведена проверка создания данной таблицы.");
      $q="SHOW TABLES FROM overseer LIKE 'rep2_arrived';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных <B>overseer.rep2_arrived</B> создана успешно.");
      else:
        ShowErrorMessage("Сбой при попытке создания временной таблицы данных <B>overseer.rep2_arrived</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // создание временной таблицы данных overseer.rep2_served
      PrintMessage("INFORMATION", "My-SQL", "Будет произведена попытка создания временной таблицы данных <B>overseer.rep2_served</B>.");
      $q="CREATE TABLE overseer.rep2_served (session_date date NOT NULL default '0000-00-00', user_name varchar(100) default NULL, user_private_number varchar(20) default NULL, rm int(11) default NULL, session_start_date date default NULL, session_start_time time default NULL, session_stop_date date default NULL, session_stop_time time default NULL, session_pause_in_seconds int(10) unsigned default NULL, served_calls_average_duration_in_seconds decimal(10,2) default NULL, arrived_calls int(10) unsigned default NULL, served_calls int(10) unsigned default NULL, nonserved_calls int(10) unsigned default NULL, KEY session_date (session_date), KEY rm (rm), KEY session_start_date (session_start_date), KEY session_start_time (session_start_time), KEY user_name (user_name), KEY session_stop_date (session_stop_date), KEY session_stop_time (session_stop_time), KEY user_private_number (user_private_number)) TYPE=MyISAM;";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      PrintMessage("INFORMATION", "My-SQL", "Попытка создания временной таблицы данных <B>overseer.rep2_served</B> выполнена. Будет произведена проверка создания данной таблицы.");
      $q="SHOW TABLES FROM overseer LIKE 'rep2_served';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных <B>overseer.rep2_served</B> создана успешно.");
      else:
        ShowErrorMessage("Сбой при попытке создания временной таблицы данных <B>overseer.rep2_served</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      foreach ($dates as $i):
        // удаление данных за очередной день в случае установленного флажка RECALC
        if ($RECALC=="on"):
          PrintMessage("INFORMATION", "My-SQL", "Будет произведена попытка удаления данных за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) из таблицы <B>overseer.rep2</B>.");
          // попытка удаления данных за день
          $q="DELETE FROM overseer.rep2 WHERE session_date='".$i."';";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          // проверка удаления данных
          $q="SELECT * FROM overseer.rep2 WHERE session_date='".$i."';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows==0):
            PrintMessage("SUCCESS", "My-SQL", "Данные за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) удалены успешно.");
          else:
            ShowErrorMessage("Сбой при удалении данных за <B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
        // предварительная очистка временных таблиц
        PrintMessage("INFORMATION", "My-SQL", "Будет произведена предварительная очистка временной таблицы <B>overseer.rep2_arrived</B>.");
        $q="DELETE FROM overseer.rep2_arrived;";
        PrintMessage("QUERY", "SQL", $q);
        mysql_query($q);
        // проверка удаления данных
        $q="SELECT * FROM overseer.rep2_arrived;";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==0):
          PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных <B>overseer.rep2_arrived</B> очищена успешно.");
        else:
          ShowErrorMessage("Сбой при очистке данных временной таблицы данных <B>overseer.rep2_arrived</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        PrintMessage("INFORMATION", "My-SQL", "Будет произведена предварительная очистка временной таблицы <B>overseer.rep2_served</B>.");
        $q="DELETE FROM overseer.rep2_served;";
        PrintMessage("QUERY", "SQL", $q);
        mysql_query($q);
        // проверка удаления данных
        $q="SELECT * FROM overseer.rep2_served;";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==0):
          PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных <B>overseer.rep2_served</B> очищена успешно.");
        else:
          ShowErrorMessage("Сбой при очистке данных временной таблицы данных <B>overseer.rep2_served</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        // проверка на наличие данных за очередной день
        $q="SELECT * FROM overseer.rep2 WHERE session_date='".$i."';";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows>0):
          PrintMessage("SUCCESS", "My-SQL", "Данные за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) уже присутствуют в таблице данных <B>overseer.rep2</B>.");
        elseif ($num_rows==0):
          PrintMessage("SUCCESS", "My-SQL", "Данные за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) в таблице данных <B>overseer.rep2</B> не найдены! Будет произведена выборка данных и добавление их в таблицу <B>overseer.rep2</B>.");
          // добавление данных за очередной день во временные таблицы
          PrintMessage("INFORMATION", "My-SQL", "Добавление данных по поступившим абонентам за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) во временную таблицу <B>overseer.rep2_arrived</B>.");
          $q="INSERT INTO overseer.rep2_arrived SELECT a.datum, CONCAT(UCASE(LEFT(c.ime,1)),LCASE(RIGHT(c.ime,(LENGTH(c.ime)-1))), ' ', c.prezime) AS name, b.sifra, b.rm, b.datpoc, b.vripoc, b.datzav, b.vrizav, b.paused, NULL, COUNT(*), NULL, NULL FROM ird.ird_".$i." a LEFT JOIN prijaves.prijave_".$i." b ON a.rm=b.rm LEFT JOIN ARJ.users c ON c.sifra=b.sifra WHERE a.ddi in('190','193') AND a.vrijeme BETWEEN '07:00:00' AND '21:59:59' AND UNIX_TIMESTAMP(CONCAT(a.datum,' ',a.vrijeme)) BETWEEN UNIX_TIMESTAMP(CONCAT(b.datpoc,' ',b.vripoc)) AND UNIX_TIMESTAMP(CONCAT(b.datzav,' ',b.vrizav)) GROUP BY a.datum, name, b.sifra, b.rm, b.datpoc, b.vripoc, b.datzav, b.vrizav, b.paused ORDER BY a.datum, name, b.sifra, b.datpoc, b.vripoc, b.datzav, b.vrizav;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          PrintMessage("INFORMATION", "My-SQL", "Добавление данных по обслуженным абонентам за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) во временную таблицу <B>overseer.rep2_served</B>.");
          $q="INSERT INTO overseer.rep2_served SELECT a.datum, CONCAT(UCASE(LEFT(c.ime,1)),LCASE(RIGHT(c.ime,(LENGTH(c.ime)-1))), ' ', c.prezime) AS name, b.sifra, b.rm, b.datpoc, b.vripoc, b.datzav, b.vrizav, b.paused, SUM(dur)/COUNT(*), NULL, COUNT(*), NULL FROM ird.ird_".$i." a LEFT JOIN prijaves.prijave_".$i." b ON a.rm=b.rm LEFT JOIN ARJ.users c ON c.sifra=b.sifra WHERE a.ddi in('190','193') AND a.v_oper>'' AND a.vrijeme BETWEEN '07:00:00' AND '21:59:59' AND UNIX_TIMESTAMP(CONCAT(a.datum,' ',a.vrijeme)) BETWEEN UNIX_TIMESTAMP(CONCAT(b.datpoc,' ',b.vripoc)) AND UNIX_TIMESTAMP(CONCAT(b.datzav,' ',b.vrizav)) GROUP BY a.datum, name, b.sifra, b.rm, b.datpoc, b.vripoc, b.datzav, b.vrizav, b.paused ORDER BY a.datum, name, b.sifra, b.datpoc, b.vripoc, b.datzav, b.vrizav;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
          // формирование сводных данных за день и добавление их в таблицу overseer.rep2
          PrintMessage("INFORMATION", "My-SQL", "Формирование сводных данных за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) и добавление их в таблицу <B>overseer.rep2</B>.");
          $q="INSERT INTO overseer.rep2 SELECT a.session_date, a.user_name, a.user_private_number, a.rm, a.session_start_date, a.session_start_time, a.session_stop_date, a.session_stop_time, a.session_pause_in_seconds, b.served_calls_average_duration_in_seconds, a.arrived_calls, b.served_calls, (a.arrived_calls-b.served_calls) AS nonserved_calls FROM overseer.rep2_arrived a LEFT JOIN overseer.rep2_served b ON a.session_date=b.session_date AND a.user_name=b.user_name AND a.user_private_number=b.user_private_number AND a.rm=b.rm AND a.session_start_date=b.session_start_date AND a.session_start_time=b.session_start_time AND a.session_stop_date=b.session_stop_date AND a.session_stop_time=b.session_stop_time ORDER BY a.session_date, a.user_name, a.user_private_number, a.session_start_date, a.session_start_time, a.session_stop_date, a.session_stop_time;";
          PrintMessage("QUERY", "SQL", $q);
          mysql_query($q);
        else:
          ShowErrorMessage("Сбой при удалении данных за <B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endforeach;
      // удаляем временные таблицы, использующиеся при формировании отчёта
      PrintMessage("INFORMATION", "Info", "Удаление временных таблиц данных (<B>overseer.rep2_arrived</B>, <B>overseer.rep2_served</B>)...");
      $q="DROP TABLE IF EXISTS overseer.rep2_arrived, overseer.rep2_served;";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      // проверяем, удаленв ли таблица overseer.rep2_arrived
      PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>overseer.rep2_arrived</B>)...");
      $q="SHOW TABLES FROM overseer LIKE 'rep2_arrived';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>overseer.rep2_arrived</B>) удалена успешно.");
      else:
        ShowErrorMessage("Сбой при попытке удаления временной таблицы данных, используемой при расчётах (<B>overseer.rep2_arrived</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // проверяем, удаленв ли таблица overseer.rep2_served
      PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>overseer.rep2_served</B>)...");
      $q="SHOW TABLES FROM overseer LIKE 'rep2_served';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>overseer.rep2_served</B>) удалена успешно.");
      else:
        ShowErrorMessage("Сбой при попытке удаления временной таблицы данных, используемой при расчётах (<B>overseer.rep2_served</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // к этому моменту все данные за все дни помещены в таблицу overseer.rep2
      // необходимо выполнить проверку на наличие хоть каких-либо данных за указанный период
      $j=0;
      foreach ($dates as $i):
        $q="SELECT * FROM overseer.rep2 WHERE session_date='".$i."';";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows>=0):
          $j=$j+$num_rows;
        else:
          ShowErrorMessage("Сбой при попытке получения результатов выборки данных за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) из таблицы (<B>overseer.rep2_served</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endforeach;
      // в случае, если данных за указанный период нет, выводим соответствующее сообщение и завершаем работу программы
      if ($j==0):
        $s="";
        if (($time=="yesterday")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear))):
          $s="(<B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>) ";
        elseif (($time=="lastweek")||($time=="lastmonth")||($time=="anothermonth")||($time=="another")):
          $s="(с <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B> по <B>$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;года</B>) ";
        endif;
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
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?echo $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?echo $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?echo $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?echo $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?echo $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?echo $aey;?>">
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
  if ($RECALC=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
  endif;
  if ($OPENCICLE=="on"):
?>
              <INPUT TYPE="HIDDEN" NAME="OPENCICLE" VALUE="<?print $OPENCICLE;?>">
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
            <TD ALIGN="CENTER" BGCOLOR="#339999" STYLE="color: white;"><B>Операция выполнена успешно!</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">За выбранный Вами период времени <?echo $s;?>не было найдено ни одного звонка по услугам <B>&laquo;190&raquo;</B> и <B>&laquo;193&raquo;</B>.<BR><BR>Если Вы <I>уверены</I>, что этого не может быть, попробуйте сформировать отчёт повторно, установив на предыдущем шаге флажок <B>&laquo;Провести полный пересчёт данных таблицы за указанный период&raquo;</B>. Если это не исправит ситуацию, обратитесь к системному администратору или инженеру-программисту.<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
<?
        die("");
      endif;
      // составляем вспомогательную строку для шапки отчёта
      $s="";
      if (($time=="yesterday")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear))):
        $s="за ".$startday."&nbsp;".$months2[$startmonth]."&nbsp;".$startyear."&nbsp;года<BR>";
      elseif (($time=="lastweek")||($time=="lastmonth")||($time=="anothermonth")||($time=="another")):
        $s="за период с ".$startday."&nbsp;".$months2[$startmonth]."&nbsp;".$startyear."&nbsp;года по ".$stopday."&nbsp;".$months2[$stopmonth]."&nbsp;".$stopyear."&nbsp;года<BR>";
      endif;
      // теперь необходимо определить, в каком виде необходимо вывести данные на экран - подробном, или свёрнутои
      if ($OPENCICLE=="on"):
        $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"86px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"60px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"60px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"50px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"12\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"12\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;\">Статистика работы телефонистов<BR>сервисно-информационных услуг &laquo;190&raquo; и &laquo;193&raquo;<BR>".$s."(дневная смена - с 7:00 до 22:00)</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Ф.И.О.</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Личный<BR>номер</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Номер<BR>рабочего<BR>места</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Дата<BR>начала<BR>работы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Время<BR>начала<BR>работы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Дата<BR>оконча-<BR>ния<BR>работы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Время<BR>оконча-<BR>ния<BR>работы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Пере-<BR>рывы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Среднее<BR>время обслу-<BR>живания,<BR>сек.</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Посту-<BR>пило<BR>звонков<BR>(всего)</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Обслу-<BR>жено<BR>звонков</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 6pt; padding: 2px;\">Не обслу-<BR>жено<BR>звонков</TD>
        </TR>";
        foreach ($dates as $i):
          $q="SELECT user_name as f1, user_private_number as f2, rm as f3, session_start_date as f4, session_start_time as f5, session_stop_date as f6, session_stop_time as f7, SEC_TO_TIME(session_pause_in_seconds) as f8, served_calls_average_duration_in_seconds as f9, arrived_calls as f10, served_calls as f11, nonserved_calls as f12 FROM overseer.rep2 WHERE session_date='".$i."' ORDER BY session_date, user_name, user_private_number, session_start_date, session_start_time, session_stop_date, session_stop_time;";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>0):
            PrintMessage("SUCCESS", "My-SQL", "Данные за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) присутствуют в таблице данных <B>overseer.rep2</B>. Будет произведен вывод данных в форму отчёта.");
            $result_array=array();
            for ($j=0;$j<($num_rows);$j++):
              $tmp_array=mysql_fetch_assoc($table);
              $result_array[]=$tmp_array;
            endfor;
            for ($j=0;$j<(count($result_array));$j++):
              $bodymessage.="
        <TR>
          <TD STYLE=\"text-align:   left; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 2px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f1"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f2"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f4"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f5"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f6"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f7"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f8"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f9"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f10"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f11"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; font-size: 6pt; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f12"]."</TD>
        </TR>";
            endfor;
          elseif ($num_rows==0):
            PrintMessage("INFORMATION", "My-SQL", "Данные за очередной день (<B>".substr($i,6,2)." ".$months2[((substr($i,4,2))+0)]." ".substr($i,0,4)." года</B>) в таблице данных <B>overseer.rep2</B> не найдены! Данный день не будет включён в отчёт.");
          endif;
        endforeach;
        $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"12\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"12\" HEIGHT=\"20\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"12\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      else:
        // составляем список фамилий и личных номеров телефонистов
        $q="SELECT user_name as f1, user_private_number as f2 FROM overseer.rep2 WHERE session_date BETWEEN '".$dates[0]."' AND '".$dates[count($dates)-1]."' GROUP BY f1, f2 ORDER BY f1, f2;";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows>=1):
          PrintMessage("SUCCESS", "My-SQL", "Данные для составления списка телефонистов, работавших в указанный период времени были успешно найдены.");
        else:
          ShowErrorMessage("Сбой при попытке получения данных из таблицы <B>overseer.rep2</B>, необходимых для составления списка телефонистов, работавших в указанный период времени!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $user_array=array();
        for ($j=0;$j<($num_rows);$j++):
          $tmp_array=mysql_fetch_assoc($table);
          $user_array[]=$tmp_array;
        endfor;
        //var_dump($user_array);      
        $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"131px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"85px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"125px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"105px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"105px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"105px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"6\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"6\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;\">Статистика работы телефонистов<BR>сервисно-информационных услуг &laquo;190&raquo; и &laquo;193&raquo;<BR>".$s."(дневная смена - с 7:00 до 22:00)</TD>
        </TR>
        <TR>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Ф.И.О.</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Личный<BR>номер</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Дата</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Поступило<BR>звонков<BR>(всего)</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Обслужено<BR>звонков</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Не обслужено<BR>звонков</TD>
        </TR>";
        foreach ($user_array as $k):
          $q="SELECT user_name AS f1, user_private_number AS f2, session_date as f3, SUM(arrived_calls) AS f4, SUM(served_calls) AS f5, SUM(nonserved_calls) AS f6 FROM overseer.rep2 WHERE user_name='".$k["f1"]."' AND user_private_number='".$k["f2"]."' AND session_date BETWEEN '".$dates[0]."' AND '".$dates[count($dates)-1]."' GROUP BY f1, f2, f3 ORDER BY f1, f2, f3;";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>=1):
            PrintMessage("SUCCESS", "My-SQL", "Данные по телефонисту за указанный период были успешно найдены.");
          else:
            ShowErrorMessage("Сбой при попытке получения данных по телефонисту <B>".$k["f1"]."</B> (личный номер - <B>".$k["f2"]."</B>) за указанный период (<B>c&nbsp;".$startday."&nbsp;".$months2[$startmonth]."&nbsp;".$startyear."&nbsp;года по ".$stopday."&nbsp;".$months2[$stopmonth]."&nbsp;".$stopyear."&nbsp;года</B>) из таблицы <B>overseer.rep2</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $result_array=array();
          for ($j=0;$j<($num_rows);$j++):
            $tmp_array=mysql_fetch_assoc($table);
            $result_array[]=$tmp_array;
          endfor;
          for ($j=0;$j<(count($result_array));$j++):
            $bodymessage.="
        <TR>
          <TD STYLE=\"text-align:   left; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 2px; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f1"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f2"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f4"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f5"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$j]["f6"]."</TD>
        </TR>";
          endfor;
          $q="SELECT user_name AS f1, user_private_number AS f2, SUM(arrived_calls) AS f3, SUM(served_calls) AS f4, SUM(nonserved_calls) AS f5 FROM overseer.rep2 WHERE user_name='".$k["f1"]."' AND user_private_number='".$k["f2"]."' AND session_date BETWEEN '".$dates[0]."' AND '".$dates[count($dates)-1]."' GROUP BY f1, f2 ORDER BY f1, f2;";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>=1):
            PrintMessage("SUCCESS", "My-SQL", "Итоговые данные по телефонисту получены успешно.");
          else:
            ShowErrorMessage("Сбой при попытке получения итоговых данных по телефонисту из таблицы <B>overseer.rep2</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $result_array=array();
          for ($j=0;$j<($num_rows);$j++):
            $tmp_array=mysql_fetch_assoc($table);
            $result_array[]=$tmp_array;
          endfor;
          $bodymessage.="
        <TR>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align:   left; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; padding: 1px 2px;\">".$result_array[0]["f1"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;\">".$result_array[0]["f2"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;\">Итого за период:</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;\">".$result_array[0]["f3"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;\">".$result_array[0]["f4"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 1px 2px;\">".$result_array[0]["f5"]."</TD>
        </TR>";
        endforeach;
        $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"6\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"6\" HEIGHT=\"20\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"6\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      endif;
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
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
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
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL1Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL2Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL2Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL3Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL3Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
      endif;
      mysql_close($MySQLConnection);
      PrintMessage("SUCCESS", "My-SQL", "Выполнено отключение от MySQL-сервера <B>$HostName</B>.");
?>
  </BODY>
</HTML>
