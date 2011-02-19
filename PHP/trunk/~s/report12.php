<!-- Отчёт "Статистика выработки телефонисток (все смены)"-->
<?
// *** подключение к серверу MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase");
// *** если режим сортировки не задан - задать по умолчанию ***
if ($sort=="") $sort="sifra";
// *** формирование титула отчёта ***
$title="Статистика выработки телефонисток за ";
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
<!-- Для печати выставьте следующие параметры страницы: слева, сверху, справа, снизу 5.00; ориентация альбомная; нижний колонтитул: &b&bСтраница &p из &P-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?print $title;?></TITLE>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
    <SCRIPT LANGUAGE="JavaScript">
      function calculate(comp1,comp2,comp3)
      {
        comp1.value = Math.round(((comp3.value/comp2.value)/82)*100);
      }
    </SCRIPT>
  </HEAD>
  <BODY>
<?
// *** формирование SQL-выборки на основе запроса (для строк) ***
$table=MYSQL_QUERY("SELECT name,sifra,sum(in_serv) as in_serv FROM t_day WHERE (((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday'))) GROUP BY sifra ORDER BY $sort;");
$num_rows = MYSQL_NUM_ROWS($table); // получение количества строк выборки
$i=0; // переменная для значения текущей позиции строки в выборке
if ($num_rows==0):
?>
    <H1>За заданный период времени записей не найдено!<H1>
<?
else:
  while ($i < $num_rows):
?>
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report03.php?sort=name&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>"><NOBR>Ф.И.О.</NOBR></A></TH>
          <TH><A HREF="report03.php?sort=sifra&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Личный номер</A></TH>
          <TH>Время работы</TH>
          <TH><A HREF="report03.php?sort=in_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Обслужено</A></TH>
          <TH>% выработки</TH>
        </TR>
<?
    while ($i < $num_rows):
      $field1=mysql_result($table, $i, "name"); // 'ФИО'
      $field2=mysql_result($table, $i, "sifra"); // 'Личный номер'
      $field3=mysql_result($table, $i, "in_serv"); // 'Обслужено'
      $i++;
?>
        <TR VALIGN="MIDDLE">
          <TD CLASS="la"><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD><INPUT TYPE="text" NAME="wt<?print $i;?>" onchange="calculate(wp<?print $i;?>,wt<?print $i;?>,ob<?print $i;?>);"></TD>
          <TD><?print $field3;?><INPUT TYPE="hidden" NAME="ob<?print $i;?>" VALUE="<?print $field3;?>"></TD>
          <TD><INPUT TYPE="text" NAME="wp<?print $i;?>" READONLY></TD>
        </TR>
<?
    endwhile;
  endwhile;
  // *** формирование SQL-выборки на основе запроса (итог) ***
  $table=MYSQL_QUERY("SELECT '' as z,name,sifra,sum(in_serv) as in_serv FROM t_day WHERE (((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday'))) GROUP BY z;");
  $field1=mysql_result($table, 0, "in_serv"); // 'Обслужено'
?>
        <TR>
          <TH>Итого</TH>
          <TH></TH>
          <TH></TH>
          <TH><?print $field1;?></TH>
          <TH></TH>
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