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
    <TABLE STYLE="margin: 3px 5px;">
      <TR>
        <TD WIDTH="100" ALIGN="CENTER" STYLE="padding: 3px 5px; border-color: black; border-width: 1px; color: <?echo $cf;?>; background: <?echo $cb;?>; font-weight: bold;"><?echo $as;?></TD>
        <TD STYLE="padding: 3px 5px;"><?echo $bs;?></TD>
      </TR>
    </TABLE>
<?
}

function ShowErrorMessage($as, $rep, $time, $add, $adm, $ady, $ani, $ddi, $rm)
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
              <INPUT TYPE="HIDDEN" NAME="add" VALUE="<?print $add;?>">
              <INPUT TYPE="HIDDEN" NAME="adm" VALUE="<?print $adm;?>">
              <INPUT TYPE="HIDDEN" NAME="ady" VALUE="<?print $ady;?>">
<?
  if ($ani!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="ani" VALUE="<?print $ani;?>">
<?
  endif;
  if ($ddi!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="ddi" VALUE="<?print $ddi;?>">
<?
  endif;
  if ($rm!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="rm" VALUE="<?print $rm;?>">
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


$ird_filename="ird_$startyear"; if ($startmonth<10) $ird_filename.="0"; $ird_filename.="$startmonth"; if ($startday<10) $ird_filename.="0"; $ird_filename.="$startday";

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?echo $reports[11]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="http://10.1.1.250/ns2/">
    <LINK REL="first" HREF="http://10.1.1.250/ns2/">
    <LINK REL="previous" HREF="http://10.1.1.250/ns2/?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;?>&amp;add=<?echo $add;?>&amp;adm=<?echo $adm;?>&amp;ady=<?echo $ady; if ($ani!=""):?>&amp;ani=<?echo $ani; endif; if ($ddi!=""):?>&amp;ddi=<?echo $ddi; endif; if ($rm!=""):?>&amp;rm=<?echo $rm; endif;?>">
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
    if (!session_register("result_array")):
      ShowErrorMessage("Сбой при попытке регистрации переменной в сессии!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
      die("");
    else: 
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "Info", "Переменная успешно зарегистрирована в сессии."); endif;
    endif;
    if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Выбранная Вами дата - <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>."); endif;
    if ($time=="anotherday"):
      $i=mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y);
      if ($i>0): // если "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Выбранная вами дата (<B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;$months2[$m]&nbsp;$y&nbsp;года</B>)!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if (checkdate($startmonth,$startday,$startyear)<>1):
        ShowErrorMessage("Выбрана несуществующая дата (<B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>)!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endif;
    // если условие выполняется, значит указанная дата не входит в текущий месяц и дата текущего месяца больше 2
    $i=mktime(0,0,0,$m,1,$y)-mktime(0,0,0,$startmonth,$startday,$startyear);
    if ($i>0):
      $i=mktime(0,0,0,$m,$d,$y)-mktime(0,0,0,$m,2,$y);
      if ($i>0):
        ShowErrorMessage("Невозможно выполнить снятие оплаты за (<B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>) т.к. данные по выставляемым счетам вероятнее всего уже были переданы на ИРЦ!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endif;
    if ($ani==""): // если не указан номер телефона, вывести сообщение об ошибке и остановить программу
      ShowErrorMessage("Вы должны обязательно указать номер телефона абонента!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    // разбор переданных через строку переменных
    if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Записей было сохранено в предыдущей сессии: <B>".count($result_array)."</B>."); endif;
    $querylist=array();
    $c=array_keys($HTTP_GET_VARS,"on");
    if (count($result_array)>0):
      for ($i=0;$i<=count($result_array);$i++):
        if ($i<100) $s="0";
        if ($i<10) $s="00";
        if (in_array("idx$s$i",$c)):
          if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Ключ <B>idx$s$i</B> присутствует."); endif;
          $querylist[]=".".$ird_filename." SET rm='-".$result_array["idx$s$i"]["f6"]."' WHERE ani='".$result_array["idx$s$i"]["f1"]."' AND ddi='".$result_array["idx$s$i"]["f2"]."' AND datum='".$result_array["idx$s$i"]["f3"]."' AND vrijeme='".$result_array["idx$s$i"]["f4"]."' AND dur='".$result_array["idx$s$i"]["f5"]."' AND rm='".$result_array["idx$s$i"]["f6"]."' AND izg='".$result_array["idx$s$i"]["f7"]."' AND izgnum='".$result_array["idx$s$i"]["f8"]."' AND v_oper='".$result_array["idx$s$i"]["f9"]."' AND v_mreza='".$result_array["idx$s$i"]["f10"]."';";
        endif;
      endfor;
    endif;
    if (count($querylist)>0):
      $s="";
      foreach($querylist as $i):
        if ($s!=""): $s.="<BR><BR>"; endif;
        $s.="$i";
      endforeach;
      if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "$s"); endif;
      // а теперь выполняем запросы по коректировке записей в базах на серверах DBSERVER и MAINSERVER
      // производим подключение к серверу 10.1.1.2
      $HostName="10.1.1.2";
      $UserName="sel";
      $Passwird="";
      $DBName="statistika";
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
      // составление запроса на получение списка звонков на услуги
      foreach($querylist as $i):
        $q="UPDATE $DBName".$i;
        if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
        mysql_query($q);
        // проверка на корректность выполнения операции конвертации
        if (mysql_affected_rows()==1):
          if ($DEBUG=="on"): PrintMessage("SUCCESS", "MySQL", "Запись в таблице <B>$DBName.$ird_filename</B> была успешно обновлена."); endif;
        else:
          ShowErrorMessage("Возникла ошибка при обновлении записи в таблице <B>$DBName.$ird_filename</B>! Обратитесь к системному администратору!", $rep, $time, $add, $adm, $ady, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endforeach;
      mysql_close($MySQLConnection);
      if (!((($startday+0)==$d)&&(($startmonth+0)==$m)&&(($startyear+0)==$y))):
        // производим подключение к серверу 10.1.1.250
        $HostName="10.1.1.250";
        $UserName="sel";
        $Passwird="";
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
        // составление запроса на получение списка звонков на услуги
        foreach($querylist as $i):
          $q="UPDATE $DBName".$i;
          if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
          mysql_query($q);
          // проверка на корректность выполнения операции конвертации
          if (mysql_affected_rows()==1):
            if ($DEBUG=="on"): PrintMessage("SUCCESS", "MySQL", "Запись в таблице <B>$DBName.$ird_filename</B> была успешно обновлена."); endif;
          else:
            echo mysql_error();
            ShowErrorMessage("Возникла ошибка при обновлении записи в таблице <B>$DBName.$ird_filename</B>! Обратитесь к системному администратору!", $rep, $time, $add, $adm, $ady, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endforeach;
        mysql_close($MySQLConnection);
      endif;
    endif;
    // производим подключение к серверу 10.1.1.250 - по умолчанию данные берутся на сервере MAINSERVER, а уже в случае неудачи - с DBSERVER
    $HostName="10.1.1.2";
    $UserName="sel";
    $Passwird="";
    $DBName="statistika";
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
    // поиск файла за выбранный день
    if ($DEBUG=="on"): PrintMessage("INFORMATION", "My-SQL", "Получение количества таблиц <B>arj.ord_$startyear$startmonth%</B>..."); endif;
    $q="SHOW TABLES FROM $DBName LIKE '$ird_filename';";
    if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($num_rows==1):
      $s="Таблица за <B>$startday ".$months2[$startmonth]." $startyear года</B> была успешно найдена в базе данных <B>$DBName</B>.";
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "Info", $s); endif;
    elseif ($num_rows==0):
      ShowErrorMessage("В базе данных <B>$DBName</B> не была найдена таблица за <B>$startday ".$months2[$startmonth]." $startyear года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
      die("");
    else:
      ShowErrorMessage("Сбой при поиске таблицы за <B>$startday ".$months2[$startmonth]." $startyear года</B> в базе данных <B>$DBName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    // составление запроса на получение списка звонков на услуги
    $q="SELECT ani as f1, ddi as f2, datum as f3, vrijeme as f4, dur as f5, rm as f6, izg as f7, izgnum as f8, v_oper as f9, v_mreza as f10 FROM $DBName.$ird_filename WHERE ani LIKE '%$ani' AND rm>0"; if ($ddi!="") $q.=" AND ddi='$ddi'"; if ($rm!="") $q.=" AND rm='$rm' "; $q.=" ORDER BY datum, vrijeme, ani LIMIT 500;";
    if ($DEBUG=="on") PrintMessage("QUERY", "SQL", $q);
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($num_rows>0):
      if ($DEBUG=="on"): 
        if ($num_rows<500):
          PrintMessage("INFORMATION", "My-SQL", "В таблице <B>$DBName.$ird_filename</B> были успешно найдены звонки, попадающие под указанные Вами условия, в количестве: <B>$num_rows</B>.");
        else:
          PrintMessage("INFORMATION", "My-SQL", "По указанным параметрам отбора в таблице <B>$DBName.$ird_filename</B> было успешно найдено более <B>500</B> звонков. Будет выведен список <B>только</B> первых <B>500</B>.");
        endif;
      endif;
    elseif ($num_rows==0):
      ShowErrorMessage("В таблице <B>$DBName.$ird_filename</B> не найдено ни одного звонка, попадающего под указанные Вами условия!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
      die("");
    else:
      ShowErrorMessage("Сбой при попытке получения из таблицы <B>$DBName.$ird_filename</B> количества звонков, попадающих под указанные Вами условия!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $startday, $startmonth, $startyear, $ani, $ddi, $rm);
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13" HEIGHT="15" ROWSPAN="5"></TD>
            <TD WIDTH="13" HEIGHT="15"></TD>
            <TD WIDTH="20" HEIGHT="15"></TD>
            <TD WIDTH="80"></TD>
            <TD WIDTH="60"></TD>
            <TD WIDTH="70"></TD>
            <TD WIDTH="60"></TD>
            <TD WIDTH="30"></TD>
            <TD WIDTH="30"></TD>
            <TD WIDTH="30"></TD>
            <TD WIDTH="50"></TD>
            <TD WIDTH="60"></TD>
            <TD WIDTH="60"></TD>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13" ROWSPAN="5"></TD>
          </TR>
          <TR>
            <TD COLSPAN="13" STYLE="font-family: Times New Roman; font-weight: bold; font-size: 12pt;">Список звонков, поступивших <?echo "$startday ".$months2[$startmonth]." $startyear года";?> <?if ($ddi!=""): echo "на службу &laquo;$ddi&raquo;"; endif;?> от абонентов с номером телефона, оканчивающимся на <?echo "&laquo;$ani&raquo;"; if ($rm!=""): echo " и распределённых на рабочее место номер &laquo;$rm&raquo;"; endif;?></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="13"></TD>
          </TR>
          <TR>
            <TD COLSPAN="13" ALIGN="LEFT">Всего записей найдено: <B><?if ($num_rows==500): echo "более "; endif; echo "$num_rows</B>"; if ($num_rows==500): echo ".<HR><FONT COLOR=\"red\"><B>Внимание!</B></FONT> Во избежание возможных сбоев и чрезмерного использования ресурсов сервера и Вашего ПК, будут показаны <FONT COLOR=\"red\"><B>только первые $num_rows строк</B></FONT>.<BR>Попытайтесь конкретизировать запрос либо обратитесь к системному администратору!<HR>"; endif;?></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="13"></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD HEIGHT="15" COLSPAN="15"></TD>
          </TR>
          <TR>
            <TD COLSPAN="15">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="3">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
              <INPUT TYPE="HIDDEN" NAME="add" VALUE="<?print $add;?>">
              <INPUT TYPE="HIDDEN" NAME="adm" VALUE="<?print $adm;?>">
              <INPUT TYPE="HIDDEN" NAME="ady" VALUE="<?print $ady;?>">
<?
  if ($ani!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="ani" VALUE="<?print $ani;?>">
<?
  endif;
  if ($ddi!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="ddi" VALUE="<?print $ddi;?>">
<?
  endif;
  if ($rm!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="rm" VALUE="<?print $rm;?>">
<?
  endif;
?>
              <INPUT TYPE="BUTTON" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Для возврата к шагу выбора параметров отчёта нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';" ONCLICK="location=('http://10.1.1.250/ns2/?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;?>&amp;add=<?echo $add;?>&amp;adm=<?echo $adm;?>&amp;ady=<?echo $ady; if ($ani!=""):?>&amp;ani=<?echo $ani; endif; if ($ddi!=""):?>&amp;ddi=<?echo $ddi; endif; if ($rm!=""):?>&amp;rm=<?echo $rm; endif;?>');">&nbsp;
              <INPUT TYPE="SUBMIT" VALUE="Снять оплату" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Нажмите кнопку &laquo;Снять оплату&raquo; для снятия оплаты за помеченные звонки';" ONMOUSEOUT="window.status='';">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="15"></TD>
          </TR>
        </TFOOT>
        <TBODY ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD ROWSPAN="<?echo $num_rows+4;?>"></TD>
            <TD WIDTH="13" ROWSPAN="<?echo $num_rows+4;?>" BGCOLOR="#339999"</TD>
            <TD COLSPAN="11" HEIGHT="15" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="<?echo $num_rows+4;?>" BGCOLOR="#339999"</TD>
            <TD ROWSPAN="<?echo $num_rows+4;?>"></TD>
          </TR>
          <TR>
<?
    $color="#FFFFFF";
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Поставьте флажок для снятия оплаты за звонок по нажатию кнопки &laquo;Снять оплату&raquo;';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Поставьте флажок для снятия оплаты за звонок по нажатию кнопки &laquo;Снять оплату&raquo;">I</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Телефон абонента';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Телефон абонента">II</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Телефон услуги';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Телефон услуги">III</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Дата звонка';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Дата звонка">IV</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Время звонка';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Время звонка">V</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Продолжительность разговора';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Продолжительность разговора">VI</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Номер рабочего места телефониста';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Номер рабочего места телефониста">VII</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Был ли выдан номер на речевую карту';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Был ли выдан номер на речевую карту">VIII</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Выданный номер телефона';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Выданный номер телефона">IX</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Время ответа телефониста';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Время ответа телефониста">X</ABBR></B></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD ALIGN="CENTER" BGCOLOR="<?echo $color;?>" ONMOUSEOVER="window.status='Время ответа платформы';" ONMOUSEOUT="window.status='';"><B><ABBR TITLE="Время ответа платформы">XI</ABBR></B></TD>
          </TR>
          <TR>
            <TD COLSPAN="11" HEIGHT="6" BGCOLOR="#339999"></TD>
          </TR>
<?
    $result_array=array();
    $i=0;
    while ($tmp_array=mysql_fetch_assoc($table)):
      if ($i<100) $s="0";
      if ($i<10) $s="00";      
      $result_array["idx$s$i"]=$tmp_array;
?>
          <TR>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>" WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="<?echo "idx$s$i";?>" ONMOUSEOVER="window.status='Поставьте флажок для снятия оплаты за данный звонок по нажатию кнопки &laquo;Снять оплату&raquo;';" ONMOUSEOUT="window.status='';"></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>" ALIGN="RIGHT" STYLE="padding-right: 3px;"><?echo $result_array["idx$s$i"]["f1"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?echo $result_array["idx$s$i"]["f2"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?echo $result_array["idx$s$i"]["f3"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?echo $result_array["idx$s$i"]["f4"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?echo $result_array["idx$s$i"]["f5"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?if ($result_array["idx$s$i"]["f6"]=="0"): echo "&#151;"; else: echo $result_array["idx$s$i"]["f6"]; endif;?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?if ($result_array["idx$s$i"]["f7"]=="1"): echo "да"; elseif ($result_array["idx$s$i"]["f7"]=="0"): echo "нет"; endif;?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>" ALIGN="RIGHT" STYLE="padding-right: 3px;"><?echo $result_array["idx$s$i"]["f8"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?echo $result_array["idx$s$i"]["f9"];?></TD>
<?
    if ($color=="#FFFFFF"): $color="#EEEEEE"; else: $color="#FFFFFF"; endif;
?>
            <TD BGCOLOR="<?echo $color;?>"><?echo $result_array["idx$s$i"]["f10"];?></TD>
          </TR>
<?
      $i++;
    endwhile;
    mysql_close($MySQLConnection);
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="11" BGCOLOR="#339999"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM> 
<?
?>
  </BODY>
</HTML>
