<!-- Отчёт "Статистика работы телефонисток по дням (суммарная)" -->
<?
// *** подключение к серверу MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** если режим сортировки не задан - задать по умолчанию ***
if ($sort=="") $sort="date";
// *** формирование титула отчёта ***
$title="Статистика работы телефонисток по дням (суммарная)<BR>за ";
if (($sday==$fday)&&($smonth==$fmonth)&&($syear==$fyear)):
  $title .=$sday;
  $title .=" ";
  switch ($smonth):
    case "01": $title .="января "; break;
    case "02": $title .="февраля "; break;
    case "03": $title .="марта "; break;
    case "04": $title .="апреля "; break;
    case "05": $title .="мая "; break;
    case "06": $title .="июня "; break;
    case "07": $title .="июля "; break;
    case "08": $title .="августа "; break;
    case "09": $title .="сентября "; break;
    case "10": $title .="октября "; break;
    case "11": $title .="ноября "; break;
    case "12": $title .="декабря "; break;
  endswitch;
  $title .="$syear года";
else:
  $title .="период с $sday/$smonth/$syear по $fday/$fmonth/$fyear";
endif;
?>
<!-- Для печати выставьте следующие параметры страницы: слева: 30.00; сверху, справа, снизу: 5.00; ориентация книжная; нижний колонтитул: &b&bСтраница &p из &P -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?print $title;?></TITLE>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
  </HEAD>
  <BODY>
<?
// *** формирование SQL-выборки на основе запроса (для строк) ***
$table=MYSQL_QUERY("SELECT date, SEC_TO_TIME(sum(TIME_TO_SEC(work))) as work, SEC_TO_TIME(sum(TIME_TO_SEC(paused))) as paused, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY date ORDER BY $sort;");
$num_rows = MYSQL_NUM_ROWS($table); // получение количества строк выборки
$i=0; // переменная для значения текущей позиции строки в выборке
if ($num_rows==0):
?>
    <H1>За заданный период времени записей не найдено!<H1>
<?
else:
  while ($i < $num_rows):
    $j=0; // количество строк на текущей странице
?>
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report04.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Дата</A></TH>
          <TH><A HREF="report04.php?sort=work&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Время<BR>работы</A></TH>
          <TH><A HREF="report04.php?sort=paused&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Пере-<BR>рывы</A></TH>
          <TH><A HREF="report04.php?sort=svob&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Среднее<BR>время<BR>обслу-<BR>живания</A></TH>
          <TH><A HREF="report04.php?sort=svozh&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Среднее<BR>время<BR>ожи-<BR>дания</A></TH>
          <TH><A HREF="report04.php?sort=input&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Посту-<BR>пило<BR>всего</A></TH>
          <TH><A HREF="report04.php?sort=no_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Не<BR>обслу-<BR>жено</A></TH>
          <TH><A HREF="report04.php?sort=in_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Обслу-<BR>жено</A></TH>
        </TR>
<?
    while (($i < $num_rows) & ($j<=49)):
      $field1=mysql_result($table, $i, "date"); // 'Дата'
      $field2=mysql_result($table, $i, "work"); // 'Время работы'
      $field3=mysql_result($table, $i, "paused"); // 'Перерывы'
      $field4=mysql_result($table, $i, "svob"); // 'Среднее время обслуживания'
      $field5=mysql_result($table, $i, "svozh"); // 'Среднее время ожидания'
      $field6=mysql_result($table, $i, "input"); // 'Поступило всего'
      $field7=mysql_result($table, $i, "no_serv"); // 'Не обслужено'
      $field8=mysql_result($table, $i, "in_serv"); // 'Обслужено'
      $i++;
      $j++;
?>
        <TR>
          <TD><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD><?print $field3;?></TD>
          <TD><?print $field4;?></TD>
          <TD><?print $field5;?></TD>
          <TD><?print $field6;?></TD>
          <TD><?print $field7;?></TD>
          <TD><?print $field8;?></TD>
        </TR>
<?
    endwhile;
    if ($i < $num_rows):
?>
      </TBODY>
    </TABLE>
    <BR>
    <BR>
<?
    endif;
  endwhile;
  // *** формирование SQL-выборки на основе запроса (итог) ***
  $table=MYSQL_QUERY("SELECT '' as z, date, SEC_TO_TIME(sum(TIME_TO_SEC(work))) as work, SEC_TO_TIME(sum(TIME_TO_SEC(paused))) as paused, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
  $field1=mysql_result($table, 0, "work"); // 'Время работы'
  $field2=mysql_result($table, 0, "paused"); // 'Перерывы'
  $field3=mysql_result($table, 0, "svob"); // 'Среднее время обслуживания'
  $field4=mysql_result($table, 0, "svozh"); // 'Среднее время ожидания'
  $field5=mysql_result($table, 0, "input"); // 'Поступило всего'
  $field6=mysql_result($table, 0, "no_serv"); // 'Не обслужено'
  $field7=mysql_result($table, 0, "in_serv"); // 'Обслужено'
?>
        <TR>
          <TH>Итого</TH>
          <TH><?print $field1;?></TH>
          <TH><?print $field2;?></TH>
          <TH><?print $field3;?></TH>
          <TH><?print $field4;?></TH>
          <TH><?print $field5;?></TH>
          <TH><?print $field6;?></TH>
          <TH><?print $field7;?></TH>
        </TR>
      </TBODY>
    </TABLE>
    <BR>
    <BR>
<?
endif;
?>
  </BODY>
</HTML>