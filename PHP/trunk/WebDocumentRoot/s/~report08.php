<!-- Отчёт "Статистика Content Provider за дату (Гидромет и Агенство Гревцова)" -->
<?
// *** подключение к серверу MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** если режим сортировки не задан - задать по умолчанию ***
if ($sort=="") $sort="ani";
// *** формирование титула отчёта ***
$title="Статистика Content Provider за ";
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
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report08.php?&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Номер<BR>телефона</A></TH>
          <TH>Код<BR>службы</TH>
          <TH>Дата<BR>звонка</TH>
          <TH>Время<BR>звонка</TH>
          <TH><A HREF="report08.php?sort=dur&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">Длительность<BR>звонка</A></TH>
        </TR>
<?
$iyear=$syear; // временная переменная для перебора дат
$iday=$sday; $iday++; $iday--; // временная переменная для перебора дат
$imonth=$smonth; $imonth++; $imonth--; // временная переменная для перебора дат
$i2day=$fday; $i2day++; $i2day--;
$i2month=$fmonth; $i2month++; $i2month--;
do {
  $ird="ird_$iyear";
  if ($imonth<10) $ird .="0";
  $ird .="$imonth";
  if ($iday<10) $ird .="0";
  $ird .="$iday";
  //  $table=MYSQL_QUERY("SELECT ani, datum, vrijeme, SEC_TO_TIME(dur) as dur FROM statistika.$ird WHERE (dur>1) AND ((ddi='098') OR (ddi='001798')) ORDER BY $sort;");
  $table=MYSQL_QUERY("SELECT s.ani, c.ddi,s.datum, s.vrijeme, SEC_TO_TIME(s.dur) as dur FROM statistika.$ird s ,test.contentp c WHERE (s.dur>1) AND ((s.ddi='098') OR (s.ddi='001798')) AND c.abroj=s.ani ORDER BY $sort;"); //Edit by Skavin
  $num_rows = MYSQL_NUM_ROWS($table); // получение количества строк выборки
  $i=0; // переменная для значения текущей позиции строки в выборке
  if ($num_rows>0):
    while ($i < $num_rows):
      $field1=mysql_result($table, $i, "s.ani"); // 'Номер телефона'
      $field2=mysql_result($table, $i, "s.datum"); // 'Дата звонка'
      $field3=mysql_result($table, $i, "s.vrijeme"); // 'Время звонка'
      $field4=mysql_result($table, $i, "dur"); // 'Длительность звонка'
      $field5=mysql_result($table, $i, "c.ddi"); // 'Номер услуги' //Add by Skavin
      // print "<TR><TD><NOBR>$field1</NOBR></TD><TD>098</TD><TD><NOBR>$field2</NOBR></TD><TD><NOBR>$field3</NOBR></TD><TD>$field4</TD></TR>\n";
      print "        <TR>
          <TD><NOBR>$field1</NOBR></TD>
          <TD>$field5</TD>
          <TD><NOBR>$field2</NOBR></TD>
          <TD><NOBR>$field3</NOBR></TD>
          <TD>$field4</TD>
        </TR>\n"; // Edit by Skavin
      $i++;
    endwhile;
  endif;
  do {
    $iday++;
    if ($iday==32):
      $iday=1;
      $imonth++;
    endif;
    if ($imonth==13):
      $imonth=1; 
      $iyear++;
    endif;
  } while (checkdate($imonth,$iday,$iyear)<>1);
  if (($iday<=$i2day)||(($imonth!=$i2month)||($iyear!=$fyear))) print "<TR><TD COLSPAN=5></TD></TR>";
  if (mktime($imonth,$iday,$iyear)>mktime($i2month,$i2day,$fyear)) break;
} while (($iday<=$i2day)||(($imonth!=$i2month)||($iyear!=$fyear)));
?>
        <TR>
          <TH COLSPAN=5 CLASS="la">Исполнитель:</TH>
        </TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>