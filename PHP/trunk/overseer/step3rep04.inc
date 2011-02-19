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
  global $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC;
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
  if ($RECALC!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?echo $RECALC;?>">
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
    <TITLE><?echo $reports[4]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <LINK REL="previous" HREF="<?echo $base_url;?>?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;
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
      if ($RECALC!=""): echo "&amp;RECALC=$RECALC"; endif;?>">
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
      if (($time!="yesterday")&&($time!="today")&&($time!="lastweek")&&($time!="another")): // если временной промежуток не попадает ни под один из дозволенных - вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // вывод отладочной информации в случае необходимости
      if (($time=="yesterday")||($time=="today")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear))):
        PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>.");
      elseif (($time=="lastweek")||($time=="another")):
        PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - с <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B> по <B>$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;года</B>.");
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
          ShowErrorMessage("Выбранная вами конечная дата (<B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // если начальная дата или конечная дата равны текущей, и начальная и текущая даты не совпадают, выдать сообщение об ошибке и завершить работу
      if (($time=="today")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear)&&($startday==$d)&&($startmonth==$m)&&($startyear==$y))):
        $thisdayrep=1; // устанавливаем флаг, означающий, что отчёт нужен за текущий день
        PrintMessage("INFORMATION", "Info", "Вы выбрали для формирования отчёта текущую дату - <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>.");
      elseif ((($startday==$d)&&($startmonth==$m)&&($startyear==$y))||(($stopday==$d)&&($stopmonth==$m)&&($stopyear==$y))):
        $s="";
        if (($startday!=$ldd)||($startmonth!=$ldm)||($startyear!=$ldy)):
          $s="&nbsp;-&nbsp;$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года";
        endif;
        ShowErrorMessage("Извините, но формирование отчёта за указанный промежуток времени невозможно: сформировать отчёт за все указанные предыдущие даты (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года$s</B>) можно только отдельно от текущей даты (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
        die("");
      else:
        $thisdayrep=0; // устанавливаем флаг, означающий, что отчёт нужен за прошедшие дни
        $s="";
        if (($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear)):
          PrintMessage("INFORMATION", "Info", "Вы выбрали для формирования отчёта прошедшую дату - <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>.");
        else:
          PrintMessage("INFORMATION", "Info", "Вы выбрали для формирования отчёта прошедшие даты - <B>с $startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года по $stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>.");
        endif;
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
      $daycount=0;
      while ($i>=-3600):
        $daycount++;
        $i=$i-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
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
      // вывод списка необходимых таблиц ird_ггггммдд в случае отладки
      $s="Список подневных таблиц данных, необходимых для формирования отчёта:";
      foreach ($dates as $i):
        $s.="<BR><B>&nbsp;&nbsp;ird_".$i."<B>";
      endforeach;
      PrintMessage("INFORMATION", "Info", $s);
      // устанавливаем настройки для подключения к серверу
      if ($thisdayrep==1): // если отчёт нужно сформировать за текущий день
        $HostName="10.1.1.2";
        $DBName="statistika";
        $UserName="sel";
        $Password="";
      elseif ($thisdayrep==0): // если отчёт нужно сформировать за прошедшие дни
        $HostName="10.1.1.240";
        $DBName="ird";
        $UserName="overseer";
        $Password="";
      endif;
      // попытка подключения к указанному серверу
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
      if ($thisdayrep==1): // если отчёт нужно сформировать за текущий день
        // проверяем на 10.1.1.2 наличие в БД statistika таблицы "ird\_".$dates[0]  
        $q="SHOW TABLES FROM statistika LIKE 'ird\_".$dates[0]."';";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Таблица данных <B>ird_".$dates[0]."</B> за текущий день (<B>".substr($dates[0],6,2)." ".$months2[(substr($dates[0],4,2))+0]." ".substr($dates[0],0,4)." года</B>) в БД <B>statistika</B> на MySQL-сервере <B>$HostName</B> успешно найдена.");
          // т.к. таблица была успешно найдена - выполняем операции по выбору необходимых данных
          $q="SELECT ani AS f1, datum AS f2, vrijeme AS f3, SEC_TO_TIME(dur) AS f4 FROM statistika.ird_".$dates[0]." WHERE datum=".$dates[0]." AND (dur>1) AND ((ddi LIKE '%2339535') OR (ddi='198') OR (ddi='001798')) AND (ani LIKE '%2370654') ORDER BY f2, f3;";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>0):
            PrintMessage("SUCCESS", "My-SQL", "Данные за&nbsp;<B>".substr($dates[0],6,2)."&nbsp;".$months2[(substr($dates[0],4,2))+0]."&nbsp;".substr($dates[0],0,4)."&nbsp;года</B> в таблице <B>ird_".$dates[0]."</B> БД <B>statistika</B> на MySQL-сервере <B>$HostName</B> успешно найдены.");
          elseif ($num_rows==0):
            PrintMessage("WARNING", "My-SQL", "Данные за&nbsp;<B>".substr($dates[0],6,2)."&nbsp;".$months2[(substr($dates[0],4,2))+0]."&nbsp;".substr($dates[0],0,4)."&nbsp;года</B> в таблице <B>ird_".$dates[0]."</B> БД <B>statistika</B> на MySQL-сервере <B>$HostName</B> отсутствуют.");
          else:
            ShowErrorMessage("Возникла ошибка получении данных за&nbsp;<B>".substr($dates[0],6,2)."&nbsp;".$months2[(substr($dates[0],4,2))+0]."&nbsp;".substr($dates[0],0,4)."&nbsp;года</B> из таблицы <B>ird_".$dates[0]."</B> БД <B>statistika</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
          endif;
          // выбираем данные за текущий день и помещаем их в массив
          $result_array=array();
          for ($j=0;$j<($num_rows);$j++):
            $tmp_array=mysql_fetch_assoc($table);
            $result_array[]=$tmp_array;
          endfor;
        else:
          // если таблица не найдена - выходим по ошибке
          ShowErrorMessage("В БД на MySQL-сервере <B>$HostName</B> не найдена таблица данных <B>ird_".$dates[0]."</B> за текущий день (<B>".substr($dates[0],6,2)." ".$months2[(substr($dates[0],4,2))+0]." ".substr($dates[0],0,4)." года</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
        endif;
      elseif ($thisdayrep==0): // если отчёт нужно сформировать за прошедшие дни
     
        PrintMessage("INFORMATION", "Info", "Проверка наличия всех необходимых таблиц данных (<B>ird.ird_<I>ггггммдд</I></B>)...");
        foreach ($dates as $i):
          $q="SHOW TABLES FROM ird LIKE 'ird\_$i';";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows==0):
            ShowErrorMessage("Отчёт не может быть сформирован по причине отсутствия таблицы данных <B>ird.ird_".$i."</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
        // к этому моменту найдены все таблицы данных ird
        // в цикле начинаем перебирать таблицы ird, получать из них данные и заносить в массив
        $result_array=array();
        foreach ($dates as $i):
          $q="SELECT ani AS f1, datum AS f2, vrijeme AS f3, SEC_TO_TIME(dur) AS f4 FROM ird.ird_".$i." WHERE datum=".$i." AND (dur>1) AND ((ddi LIKE '%2339535') OR (ddi='198') OR (ddi='001798')) AND (ani LIKE '%2370654') ORDER BY f2, f3;";
          PrintMessage("QUERY", "SQL", $q);
          $table=mysql_query($q);
          $num_rows=mysql_num_rows($table);
          if ($num_rows>0):
            PrintMessage("SUCCESS", "My-SQL", "Данные за&nbsp;<B>".substr($i,6,2)."&nbsp;".$months2[(substr($i,4,2))+0]."&nbsp;".substr($i,0,4)."&nbsp;года</B> в таблице <B>ird_".$i."</B> БД <B>ird</B> на MySQL-сервере <B>$HostName</B> успешно найдены.");
          elseif ($num_rows==0):
            PrintMessage("WARNING", "My-SQL", "Данные за&nbsp;<B>".substr($i,6,2)."&nbsp;".$months2[(substr($i,4,2))+0]."&nbsp;".substr($i,0,4)."&nbsp;года</B> в таблице <B>ird_".$i."</B> БД <B>ird</B> на MySQL-сервере <B>$HostName</B> отсутствуют.");
          else:
            ShowErrorMessage("Возникла ошибка получении данных за&nbsp;<B>".substr($i,6,2)."&nbsp;".$months2[(substr($i,4,2))+0]."&nbsp;".substr($i,0,4)."&nbsp;года</B> из таблицы <B>ird_".$i."</B> БД <B>statistika</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
          endif;
          // выбираем данные за текущий день и помещаем их в массив
          for ($j=0;$j<($num_rows);$j++):
            $tmp_array=mysql_fetch_assoc($table);
            $result_array[]=$tmp_array;
          endfor;
        endforeach;
      endif;
      if ($DEBUG=="on"):
        //var_dump($result_array);
      endif;
      // к этому моменту в массиве $result_array находятся все необходимые данные
      // данные выводятся на форму
      // в случае, если данных за указанный период нет, выводим соответствующее сообщение и завершаем работу программы
      $j=count($result_array);
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
  if ($RECALC!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?echo $RECALC;?>">
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
            <TD STYLE="padding: 3px 5px;">За выбранный Вами период времени <?echo $s;?>не было найдено ни одного звонка.<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
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
      $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"164px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"164px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"164px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"164px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"4\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"4\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;\">Статистика звонков Гидрометцентра<BR>на услугу &laquo;Content Provider&raquo;<BR>".$s."</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Номер телефона</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Дата звонка</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Время звонка</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Длительность звонка</TD>
        </TR>
";
        for ($i=0;$i<count($result_array);$i++):
          if ($i==(count($result_array)-1)):
            $j=1;
          elseif ($result_array[$i+1]["f2"]!=$result_array[$i]["f2"]):
            $j=1;
          else:
            $j=0;
          endif;
          $bodymessage.="
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+$j)."px 2px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f1"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+$j)."px 0px; border-color: black; padding: 1px 2px;\">".substr($result_array[$i]["f2"],8,2)."&nbsp;".$months2[substr($result_array[$i]["f2"],5,2)+0]."&nbsp;".substr($result_array[$i]["f2"],0,4)."&nbsp;года</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+$j)."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+$j)."px 0px; border-color: black; padding: 1px 2px;\">".$result_array[$i]["f4"]."</TD>
        </TR>";
        endfor;
        $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"4\" STYLE=\"text-align: left; media: print, screen; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
        if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
        if ($makerstate!="") $bodymessage.="<BR>$makerstate";
        if ($maker!="") $bodymessage.="<BR>$maker";
        if ($makerphone!="") $bodymessage.="<BR>$makerphone";
        $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"4\" HEIGHT=\"20\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"4\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
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
