<!-- Отчёт "Входящие за период" -->
<?
// *** подключение к серверу MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** если режим сортировки не задан - задать по умолчанию ***
IF ($sort=="") $sort="date";
// *** формирование титула отчёта ***
$title="Входящие (все услуги) за ";
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
$table=MYSQL_QUERY("SELECT date, ddi, countT, durat, (durat/countT) as mt, (countCT-countT) as failed, countCT FROM day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) ORDER BY $sort;");
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
          <TH><A HREF="report10.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Дата</A></TH>
          <TH><A HREF="report10.php?sort=ddi&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Телефон<BR>услуги</A></TH>
          <TH><A HREF="report10.php?sort=countT&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Принято<BR>звонков</A></TH>
          <TH><A HREF="report10.php?sort=durat&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Длительность<BR>звонков</A></TH>
          <TH><A HREF="report10.php?sort=mt&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Среднее<BR>время<BR>звонка</A></TH>
          <TH><A HREF="report10.php?sort=failed&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Отклонено<BR>звонков</A></TH>
          <TH><A HREF="report10.php?sort=countCT&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Всего<BR>звонков</A></TH>
        </TR>
<?  
    while (($i < $num_rows) & ($j<=32)):
      $field1=mysql_result($table, $i, "date"); // 'Дата'
      $field2=mysql_result($table, $i, "ddi"); // 'Телефон услуги'
      $field3=mysql_result($table, $i, "countT"); // 'Принято звонков'
      $field4=mysql_result($table, $i, "durat"); // 'Длительность звонков'
      $field5=mysql_result($table, $i, "mt"); // 'Среднее время'
      $field6=mysql_result($table, $i, "failed"); // 'Отклонено звонков'
      $field7=mysql_result($table, $i, "countCT"); // 'Поступило звонков всего'
      if ($field2=="1111") $field2="099";
      if ($field2=="2222") $field2="9909111";
      $i++;
      $j++;
?>
        <TR>
          <TD><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD class="ra"><?print $field3;?></TD>
          <TD class="ra"><?print $field4;?></TD>
          <TD class="ra"><?print $field5;?></TD>
<?
      if ($field6>200):
?>
          <TD class="ra" BGCOLOR="orange"><?print $field6;?></TD>
<?
      else:
?>
          <TD class="ra"><?print $field6;?></TD>
<?
      endif;
?>
          <TD class="ra"><?print $field7;?></TD>
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
  $table=MYSQL_QUERY("SELECT '' as z, date, ddi, sum(countT) as countT, sum(durat) as durat, (sum(durat)/sum(countT)) as mt, (sum(countCT)-sum(countT)) as failed, sum(countCT) as countCT FROM day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
  $field1=mysql_result($table, 0, "countT"); // 'Принято звонков'
  $field2=mysql_result($table, 0, "durat"); // 'Длительность звонков'
  $field3=mysql_result($table, 0, "mt"); // 'Среднее время'
  $field4=mysql_result($table, 0, "failed"); // 'Отклонено звонков'
  $field5=mysql_result($table, 0, "countCT"); // 'Поступило звонков всего'
?>
        <TR>
          <TH>Всего</TH>
          <TH></TH>
          <TH CLASS="ra"><?print $field1;?></TH>
          <TH CLASS="ra"><?print $field2;?></TH>
          <TH CLASS="ra"><?print $field3;?></TH>
          <TH CLASS="ra"><?print $field4;?></TH>
          <TH CLASS="ra"><?print $field5;?></TH>
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