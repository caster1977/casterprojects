<!-- Отчёт "Статистика работы телефонисток (ночная смена)" -->
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
$title="Статистика работы телефонисток (ночная смена) за ";
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
<!-- Для печати выставьте следующие параметры страницы: слева, сверху, справа, снизу: 5.00; ориентация альбомная; нижний колонтитул: &b&bСтраница &p из &P -->
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
$table=MYSQL_QUERY("SELECT name, sifra, rm, date, vripoc, vrizav, work, paused, ceiling(du_call) AS svob, ceiling(du_wa) AS svozh, input, no_serv, in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) and (sifra LIKE '$vSifra') and (((vripoc>='21:45:00') and (vrizav<='23:59:59')) or ((vripoc>='00:00:00') and (vrizav<='07:15:00')) or (vripoc>vrizav)) ORDER BY $sort;");
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
          <TH><A HREF="report02.php?sort=name&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>"><NOBR>Ф.И.О.</NOBR></A></TH>
          <TH><A HREF="report02.php?sort=sifra&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Личный<BR>номер</A></TH>
          <TH><A HREF="report02.php?sort=rm&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Рабочее<BR>место</A></TH>
          <TH><A HREF="report02.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Дата</A></TH>
          <TH><A HREF="report02.php?sort=vripoc&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Время<BR>начала</A></TH>
          <TH><A HREF="report02.php?sort=vrizav&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Время<BR>окон-<BR>чания</A></TH>
          <TH><A HREF="report02.php?sort=work&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Время<BR>работы</A></TH>
          <TH><A HREF="report02.php?sort=paused&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Пере-<BR>рывы</A></TH>
          <TH><A HREF="report02.php?sort=svob&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Среднее<BR>время<BR>обслу-<BR>живания</A></TH>
          <TH><A HREF="report02.php?sort=svozh&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Среднее<BR>время<BR>ожи-<BR>дания</A></TH>
          <TH><A HREF="report02.php?sort=input&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Посту-<BR>пило<BR>всего</A></TH>
          <TH><A HREF="report02.php?sort=no_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Не<BR>обслу-<BR>жено</A></TH>
          <TH><A HREF="report02.php?sort=in_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">Обслу-<BR>жено</A></TH>
        </TR>
<?
    while (($i < $num_rows) & ($j<=32)):
      $field1=mysql_result($table, $i, "name"); // 'ФИО'
      $field2=mysql_result($table, $i, "sifra"); // 'Личный номер'
      $field3=mysql_result($table, $i, "rm"); // 'Рабочее место'
      $field4=mysql_result($table, $i, "date"); // 'Дата'
      $field5=mysql_result($table, $i, "vripoc"); // 'Время начала'
      $field6=mysql_result($table, $i, "vrizav"); // 'Время окончания'
      $field7=mysql_result($table, $i, "work"); // 'Время работы'
      $field8=mysql_result($table, $i, "paused"); // 'Перерывы'
      $field9=mysql_result($table, $i, "svob"); // 'Среднее время обслуживания'
      $field10=mysql_result($table, $i, "svozh"); // 'Среднее время ожидания'
      $field11=mysql_result($table, $i, "input"); // 'Поступило всего'
      $field12=mysql_result($table, $i, "no_serv"); // 'Не обслужено'
      $field13=mysql_result($table, $i, "in_serv"); // 'Обслужено'
      $i++;
      $j++;
?>
        <TR>
          <TD CLASS="la"><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD><?print $field3;?></TD>
          <TD><NOBR><?print $field4;?></NOBR></TD>
          <TD><?print $field5;?></TD>
          <TD><?print $field6;?></TD>
          <TD><?print $field7;?></TD>
          <TD><?print $field8;?></TD>
          <TD><?print $field9;?></TD>
          <TD><?print $field10;?></TD>
          <TD><?print $field11;?></TD>
          <TD><?print $field12;?></TD>
          <TD><?print $field13;?></TD>
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
  $table=MYSQL_QUERY("SELECT '' as z, name, sifra, rm, date, vripoc, vrizav, SEC_TO_TIME(sum(TIME_TO_SEC(work))) as work, SEC_TO_TIME(sum(TIME_TO_SEC(paused))) as paused, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) and (sifra LIKE '$vSifra') and (((vripoc>='21:45:00') and (vrizav<='23:59:59')) or ((vripoc>='00:00:00') and (vrizav<='07:15:00')) or (vripoc>vrizav)) GROUP BY z;");
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
          <TH></TH>
          <TH></TH>
          <TH></TH>
          <TH></TH>
          <TH></TH>
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