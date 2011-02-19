<!-- Отчёт "Входящие (голосовая справка) по часам за период подробно" -->
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
$title="Входящие (голосовая справка) по часам подробно за ";
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
$vQuerry="";

if ($v009=="true")
{
 $vQuerry .="(ddi='009')";
}
if ($v099=="true")
{
 if ($vQuerry>"")
 {
  $vQuerry .=" or ";
 }
 $vQuerry .="(ddi='1111')";
}
if ($v9909111=="true")
{
 if ($vQuerry>"")
 {
  $vQuerry .=" or ";
 }
 $vQuerry .="(ddi='2222')";
}
if ($vQuerry=="")
{
 $vQuerry .="(ddi='')";
}
// *** формирование SQL-выборки на основе запроса (для строк) ***
$table=MYSQL_QUERY("SELECT date, time, ddi, countT, work, voice, Aon, (countCT-countT) as fail, durat, ceiling(durat/countCT) AS sv, countCT FROM hour WHERE ($vQuerry) and ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) ORDER BY $sort;");
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
            <TH><A HREF="report06.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Дата</A></TH>
            <TH><A HREF="report06.php?sort=time&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Время<BR>(часы)</A></TH>
            <TH><A HREF="report06.php?sort=ddi&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Телефон<BR>услуги</A></TH>
            <TH><A HREF="report06.php?sort=countT&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Отправлено<BR>на теле-<BR>фонистов</A></TH>
            <TH><A HREF="report06.php?sort=work&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Обработано<BR>теле-<BR>фонистами</A></TH>
            <TH><A HREF="report06.php?sort=voice&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Отправлено<BR>на<BR>речевую<BR>карту</A></TH>
            <TH><A HREF="report06.php?sort=Aon&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Определено<BR>номеров</A></TH>
            <TH><A HREF="report06.php?sort=fail&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Отклонено<BR>платформой</A></TH>
            <TH><A HREF="report06.php?sort=durat&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Длитель-<BR>ность<BR>(сек.)</A></TH>
            <TH><A HREF="report06.php?sort=sv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Среднее<BR>время<BR>звонка<BR>(сек.)</A></TH>
            <TH><A HREF="report06.php?sort=countCT&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&v009=<?print $v009;?>&v099=<?print $v099;?>&v9909111=<?print $v9909111;?>">Посту-<BR>пило<BR>всего</A></TH>
          </TR>
<?
    while (($i < $num_rows) & ($j<=32)):
      $field1=mysql_result($table, $i, "date"); // 'Дата'
      $field2=mysql_result($table, $i, "time"); // 'Время (часы)'
      $field3=mysql_result($table, $i, "ddi"); // 'Телефон услуги'
      $field4=mysql_result($table, $i, "countT"); // 'Отправлено на телефонистов'
      $field5=mysql_result($table, $i, "work"); // 'Обработано телефонистами'
      $field6=mysql_result($table, $i, "voice"); // 'Отправлено на речевую карту'
      $field7=mysql_result($table, $i, "Aon"); // 'Определено номеров'
      $field8=mysql_result($table, $i, "fail"); // 'Отклонено платформой'
      $field9=mysql_result($table, $i, "durat"); // 'Длительность'
      $field10=mysql_result($table, $i, "sv"); // 'Среднее время звонка'
      $field11=mysql_result($table, $i, "countCT"); // 'Поступило всего'
      if ($field3=="1111") $field3="099";
      if ($field3=="2222") $field3="9909111";
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
  $table=MYSQL_QUERY("SELECT '' as z, date, time, ddi, sum(countT) as countT, sum(work) as work, sum(voice) as voice, sum(Aon) as Aon, (sum(countCT)-sum(countT)) as fail, sum(durat) as durat, ceiling(sum(durat)/sum(countCT)) as sv, sum(countCT) as countCT FROM hour WHERE ($vQuerry) and ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
  $field1=mysql_result($table, 0, "countT"); // 'Отправлено на телефонистов'
  $field2=mysql_result($table, 0, "work"); // 'Обработано телефонистами'
  $field3=mysql_result($table, 0, "voice"); // 'Отправлено на речевую карту'
  $field4=mysql_result($table, 0, "Aon"); // 'Определено номеров'
  $field5=mysql_result($table, 0, "fail"); // 'Отклонено платформой'
  $field6=mysql_result($table, 0, "durat"); // 'Длительность'
  $field7=mysql_result($table, 0, "sv"); // 'Среднее время звонка'
  $field8=mysql_result($table, 0, "countCT"); // 'Поступило всего'
?>
        <TR>
          <TH>Итого</TH>
          <TH></TH>
          <TH></TH>
          <TH><?print $field1;?></TH>
          <TH><?print $field2;?></TH>
          <TH><?print $field3;?></TH>
          <TH><?print $field4;?></TH>
          <TH><?print $field5;?></TH>
          <TH><?print $field6;?></TH>
          <TH><?print $field7;?></TH>
          <TH><?print $field8;?></TH>
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