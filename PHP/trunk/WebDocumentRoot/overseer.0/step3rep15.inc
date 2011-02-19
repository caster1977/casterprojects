<?
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

function ShowErrorMessage($as, $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name)
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
      if ($EMAIL3Name!=""): echo "&amp;EMAIL3Name=$EMAIL3Name"; endif;?>">
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
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
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
          ShowErrorMessage("Задана несуществующая начальная дата: <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($stopmonth,$stopday,$stopyear)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата: <B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$startmonth,$startday,$startyear))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат: начальная дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) является более поздней, чем конечная дата (<B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>)!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))>0): // если начальная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$m,$d,$y))>0): // если конечная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // если начальная или конечная дата равна текущей - выдать ошибку и
      if (((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))==0)||((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$m,$d,$y))==0)):
        ShowErrorMessage("Невозможно создать отчёт за указанный период (c <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B> по <B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>), т.к. отсутствуют данные за текущий день (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // подсчитываем количество дней, входящий в период и помещаем его в переменную $daycount
      $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth+0,$startday+0,$startyear+0);
      $daycount=0;
      while ($i>=-3600):
        $daycount++;
        $i=$i-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
      endwhile;
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Количество дней входящих в расчётный период: <B>$daycount</B>."); endif;
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
        ShowErrorMessage("Выбрано некорректое действие!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
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
          ShowErrorMessage("Не задано ни одного адресата! Вы должны указать адрес(а) электронной почты (e-mail) в поле(ях) &laquo;<B>Кому</B>&raquo;.<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // составление списка необходимых дат периода
      $period_strings=array();
      $currentday=$startday+0;
      $currentmonth=$startmonth+0;
      $currentyear=$startyear+0;
      for ($i=1;$i<=$daycount;$i++):
        $nextday=date("d",mktime(1,0,0,$currentmonth,$currentday,$currentyear)+((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0;
        $nextmonth=date("m",mktime(1,0,0,$currentmonth,$currentday,$currentyear)+((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0;
        $nextyear=date("Y",mktime(1,0,0,$currentmonth,$currentday,$currentyear)+((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0;
        $s="".$currentyear;
        if ($currentmonth<10): $s.="0"; endif;
        $s.=$currentmonth;
        if ($currentday<10): $s.="0"; endif;
        $s.=$currentday;
        $period_strings[]=$s;
        $currentday=$nextday;
        $currentmonth=$nextmonth;
        $currentyear=$nextyear;
      endfor;
      // вывод списка необходимых таблиц prijave_ггггммдд в случае отладки
      $s="Список подневных таблиц данных, необходимых для формирования отчёта:";
      foreach ($period_strings as $i):
        $s.="<BR><B>&nbsp;&nbsp;prijave_q_".$i."<B>";
      endforeach;
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", $s); endif;
      // устанавливаем настройки для подключения к серверу
      $HostName="10.1.1.240";
      $DBName="prijaves";
      // попытка подключения к указанному серверу
      $UserName="overseer";
      $Password="";
      $MySQLConnection=@mysql_connect($HostName,$UserName,$Password);
      // если не удалось подключиться к серверу - выдать сообщение и выйти по ошибке
      if ($MySQLConnection==FALSE):
        ShowErrorMessage("Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // если не удалось выбрать базу данных на сервере - выйти по ошибке
      if (@mysql_select_db("$DBName")==FALSE):
        ShowErrorMessage("Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // если удалось подключиться и к серверу и к базе - выдать сообщение в режиме отладки
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>."); endif;
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Проверка наличия всех необходимых таблиц данных (<B>prijave_q_<I>ггггммдд</I></B>)..."); endif;
      foreach ($period_strings as $i):
        $q="SHOW TABLES FROM prijaves LIKE 'prijave_q_$i';";
      	if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      	$table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==0):
          ShowErrorMessage("Отчёт не может быть сформирован по причине отсутствия таблицы данных <B>prijave_q_".$i."</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        elseif ($num_rows==1):
          if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>prijave_q_".$i."</B> найдена успешно."); endif;
        else:
          ShowErrorMessage("Сбой при попытке поиска таблицы данных за <B>".$months[$quart*3-(2-$i)]." $year года</B> (<B>".$irda_names[$i]."</B>) в базе данных <B>$DBName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endforeach;
      // удаляем временную таблицу, использующуюся при формировании отчёта
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Удаление временной таблицы данных (<B>prijaves.prijave_q_temp_grouping</B>)..."); endif;
      $q="DROP TABLE IF EXISTS prijaves.prijave_q_temp_grouping;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      mysql_query($q);
      // проверяем, удалена ли таблица
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>prijaves.prijave_q_temp_grouping</B>)..."); endif;
      $q="SHOW TABLES FROM prijaves LIKE 'prijave_q_temp_grouping';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>prijaves.prijave_q_temp_grouping</B>) удалена успешно."); endif;
      else:
        ShowErrorMessage("Сбой при попытке удаления временной таблицы данных, используемой при расчётах (<B>prijaves.prijave_q_temp_grouping</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // создаём временную таблицу
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Создание временной таблицы данных (<B>prijaves.prijave_q_temp_grouping</B>)..."); endif;
      $q="CREATE TABLE prijaves.prijave_q_temp_grouping (sifra char(20) NOT NULL default '', rm char(6) default NULL, datpoc date NOT NULL default '0000-00-00', vripoc char(8) default NULL, datzav date default NULL, vrizav char(8) default NULL, stiglo decimal(4,0) default NULL, obradio decimal(4,0) default NULL, tsred decimal(4,0) default NULL, kratki decimal(4,0) default NULL, wait decimal(4,0) default NULL, odbio decimal(4,0) default NULL, trans decimal(4,0) default NULL, qid decimal(4,0) default NULL, ccid decimal(3,0) NOT NULL default '0', priority decimal(3,0) NOT NULL default '0', rbr int(11) NOT NULL auto_increment, PRIMARY KEY  (rbr), KEY sifra (sifra), KEY datpoc (datpoc), KEY rm (rm), KEY vripoc (vripoc), KEY datzav (datzav), KEY vrizav (vrizav)) TYPE=MyISAM PACK_KEYS=1;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      mysql_query($q);
      // проверяем, создана ли таблица
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>prijaves.prijave_q_temp_grouping</B>)..."); endif;
      $q="SHOW TABLES FROM prijaves LIKE 'prijave_q_temp_grouping';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>prijaves.prijave_q_temp_grouping</B>) создана успешно."); endif;
      else:
        ShowErrorMessage("Сбой при попытке создания временной таблицы данных, используемой при расчётах (<B>prijaves.prijave_q_temp_grouping</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // добавление данных за выбранные дни во временную таблицу
      foreach ($period_strings as $i):
        $q="INSERT INTO prijaves.prijave_q_temp_grouping SELECT * FROM prijaves.prijave_q_$i p WHERE ((p.qid=90) OR (p.qid=93)) AND p.datpoc=p.datzav AND p.vripoc>'06:30:00' AND p.vrizav<'22:30:00';";
      	if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      	mysql_query($q);
      endforeach;
      // выборка данных
      if (count($period_strings)==1):
        $q="SELECT CONCAT(UCASE(LEFT(u.ime,1)),LCASE(RIGHT(u.ime,(LENGTH(u.ime)-1))), ' ', u.prezime) AS f1, p.sifra AS f2, p.datpoc AS f3, p.vripoc AS f4, p.vrizav AS f5, SUM(p.tsred)/COUNT(*) AS f6, TIME_FORMAT(SEC_TO_TIME(r.paused),'%H:%i:%S') AS f7, SUM(p.stiglo) AS f8, SUM(p.obradio) AS f9, SUM(p.odbio) AS f10 FROM prijaves.prijave_q_temp_grouping p LEFT JOIN ARJ.users u ON u.sifra=p.sifra LEFT JOIN prijaves.prijave_".$period_strings[0]." r ON (r.rm=p.rm) AND (r.sifra=p.sifra) AND r.datpoc=p.datpoc AND ((LEFT(r.vripoc,5)=LEFT(p.vripoc,5)) OR (LEFT(r.vrizav,5)=LEFT(p.vrizav,5))) WHERE ((p.qid=90) OR (p.qid=93)) AND p.datpoc=p.datzav AND p.vripoc>'06:30:00' AND p.vrizav<'22:30:00' AND p.stiglo>0 GROUP BY f1, f2, f3, f4, f5 ORDER BY f1, f2, f3, f4, f5;";
        if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows>=1):
          if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Данные за указанный период были успешно найдены."); endif;
        else:
          ShowErrorMessage("Сбой при попытке получения данных из временной таблицы <B>prijaves.prijave_q_temp_grouping</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $result_array=array();
        for ($i=0;$i<($num_rows);$i++):
          $tmp_array=mysql_fetch_assoc($table);
          $result_array[]=$tmp_array;
        endfor;
        $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"116px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"55px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"80px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"60px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"60px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"60px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"60px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"55px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"55px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"55px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"10\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"10\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;\">Статистика работы телефонистов<BR>сервисно-информационных услуг &laquo;090&raquo; и &laquo;093&raquo;<BR>за $startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года<BR>(дневная смена - с 7:00 до 22:00)</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Ф.И.О.</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Личный<BR>номер</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Дата</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Время<BR>начала<BR>работы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Время<BR>оконча-<BR>ния<BR>работы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Пере-<BR>рывы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Среднее<BR>время обслу-<BR>живания,<BR>сек.</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Посту-<BR>пило<BR>звонков<BR>(всего)</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Обслу-<BR>жено<BR>звонков</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Не обслу-<BR>жено<BR>звонков</TD>
        </TR>";
        for ($i=0;$i<(count($result_array));$i++):
        $bodymessage.="
        <TR>
          <TD STYLE=\"text-align:   left; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 2px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f1"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f2"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f4"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f5"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f7"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f6"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f8"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f9"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f10"]."</TD>
        </TR>";
      endfor;
      $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"10\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"10\" HEIGHT=\"".(702-(count($result_array)*13))."\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"10\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      elseif (count($period_strings)>1):
//        $q="SELECT p.sifra AS f1 FROM prijaves.prijave_q_temp_grouping p WHERE ((p.qid=90) OR (p.qid=93)) AND p.datpoc=p.datzav AND p.vripoc>'06:30:00' AND p.vrizav<'22:30:00' AND p.stiglo>0 GROUP BY f1 ORDER BY f1;";
        $q="SELECT CONCAT(UCASE(LEFT(u.ime,1)),LCASE(RIGHT(u.ime,(LENGTH(u.ime)-1))), ' ', u.prezime) AS f1, p.sifra AS f2 FROM prijaves.prijave_q_temp_grouping p LEFT JOIN ARJ.users u ON u.sifra=p.sifra WHERE ((p.qid=90) OR (p.qid=93)) AND p.datpoc=p.datzav AND p.vripoc>'06:30:00' AND p.vrizav<'22:30:00' AND p.stiglo>0 GROUP BY f1, f2 ORDER BY f1, f2;";
        if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows>=1):
          if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Данные за указанный период были успешно найдены."); endif;
        else:
          ShowErrorMessage("Сбой при попытке получения данных из временной таблицы <B>prijaves.prijave_q_temp_grouping</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $user_array=array();
        for ($i=0;$i<($num_rows);$i++):
          $tmp_array=mysql_fetch_assoc($table);
          $user_array[]=$tmp_array;
        endfor;
        $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"116px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"70px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"110px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"90px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"90px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"90px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"90px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"7\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"7\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;\">Статистика работы телефонистов<BR>сервисно-информационных услуг &laquo;090&raquo; и &laquo;093&raquo;<BR>за период c $startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года по $stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года<BR>(дневная смена - с 7:00 до 22:00)</TD>
        </TR>
        <TR>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Ф.И.О.</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Личный<BR>номер</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Дата</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Среднее<BR>время обслуживания,<BR>сек.</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Поступило<BR>звонков<BR>(всего)</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Обслужено<BR>звонков</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Не обслужено<BR>звонков</TD>
        </TR>";
        foreach ($user_array as $k):
          $q="SELECT CONCAT(UCASE(LEFT(u.ime,1)),LCASE(RIGHT(u.ime,(LENGTH(u.ime)-1))), ' ', u.prezime) AS f1, p.sifra AS f2, p.datpoc AS f3, SUM(p.tsred)/COUNT(*) AS f6, SUM(p.stiglo) AS f8, SUM(p.obradio) AS f9, SUM(p.odbio) AS f10 FROM prijaves.prijave_q_temp_grouping p LEFT JOIN ARJ.users u ON u.sifra=p.sifra WHERE p.sifra='".$k["f2"]."' AND ((p.qid=90) OR (p.qid=93)) AND p.datpoc=p.datzav AND p.vripoc>'06:30:00' AND p.vrizav<'22:30:00' AND p.stiglo>0 GROUP BY f1, f2, f3 ORDER BY f1, f2, f3;";
          if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>=1):
            if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Данные за указанный период были успешно найдены."); endif;
          else:
            ShowErrorMessage("Сбой при попытке получения данных из временной таблицы <B>prijaves.prijave_q_temp_grouping</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $result_array=array();
          for ($i=0;$i<($num_rows);$i++):
            $tmp_array=mysql_fetch_assoc($table);
            $result_array[]=$tmp_array;
          endfor;
          for ($i=0;$i<(count($result_array));$i++):
            $bodymessage.="
        <TR>
          <TD STYLE=\"text-align:   left; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 2px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f1"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f2"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f6"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f8"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f9"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($i==(count($result_array)-1)))."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f10"]."</TD>
        </TR>";
          endfor;
          $q="SELECT CONCAT(UCASE(LEFT(u.ime,1)),LCASE(RIGHT(u.ime,(LENGTH(u.ime)-1))), ' ', u.prezime) AS f1, p.sifra AS f2, SUM(p.tsred)/COUNT(*) AS f6, SUM(p.stiglo) AS f8, SUM(p.obradio) AS f9, SUM(p.odbio) AS f10 FROM prijaves.prijave_q_temp_grouping p LEFT JOIN ARJ.users u ON u.sifra=p.sifra WHERE p.sifra='".$k["f2"]."' AND ((p.qid=90) OR (p.qid=93)) AND p.datpoc=p.datzav AND p.vripoc>'06:30:00' AND p.vrizav<'22:30:00' AND p.stiglo>0 GROUP BY f1, f2 ORDER BY f1, f2;";
          if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>=1):
            if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Данные за указанный период были успешно найдены."); endif;
          else:
            ShowErrorMessage("Сбой при попытке получения данных из временной таблицы <B>prijaves.prijave_q_temp_grouping</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $result_array=array();
          for ($i=0;$i<($num_rows);$i++):
            $tmp_array=mysql_fetch_assoc($table);
            $result_array[]=$tmp_array;
          endfor;
          $bodymessage.="
        <TR>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align:   left; border-width: 0px 2px 2px 2px; border-color: black; padding: 1px 2px;\">".$result_array[0]["f1"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 1px 2px;\">".$result_array[0]["f2"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 1px 2px;\">Итого за период:</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 1px 2px;\">".$result_array[0]["f6"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 1px 2px;\">".$result_array[0]["f8"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 1px 2px;\">".$result_array[0]["f9"]."</TD>
          <TD BGCOLOR=\"#EEEEEE\" STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; padding: 1px 2px;\">".$result_array[0]["f10"]."</TD>
        </TR>";
        endforeach;
        $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"7\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"7\" HEIGHT=\"20\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"7\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      endif;
      // удаляем временную таблицу, использующуюся при формировании отчёта
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Удаление временной таблицы данных (<B>prijaves.prijave_q_temp_grouping</B>)..."); endif;
      $q="DROP TABLE IF EXISTS prijaves.prijave_q_temp_grouping;";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      mysql_query($q);
      // проверяем, удалена ли таблица
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Проверка наличия временной таблицы данных (<B>prijaves.prijave_q_temp_grouping</B>)..."); endif;
      $q="SHOW TABLES FROM prijaves LIKE 'prijave_q_temp_grouping';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==0):
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Временная таблица данных (<B>prijaves.prijave_q_temp_grouping</B>) удалена успешно."); endif;
      else:
        ShowErrorMessage("Сбой при попытке удаления временной таблицы данных, используемой при расчётах (<B>prijaves.prijave_q_temp_grouping</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
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
