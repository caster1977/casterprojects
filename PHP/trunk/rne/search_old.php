<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=WINDOWS-1251">
    <STYLE TYPE="text/css">@import url(ie5.css);</STYLE>
    <LINK REL="STYLESHEET" HREF="ie5.css" TYPE="TEXT/CSS">
    <TITLE>База данных &laquo;ОТДЫХ И РАЗВЛЕЧЕНИЯ&raquo; (АРМ телефониста)</TITLE>
  </HEAD>
  <BODY onload="javascript:document.all.back.focus();">
    <FORM ACTION="index.php" METHOD="GET"><CENTER><INPUT TYPE="SUBMIT" NAME="back" VALUE="Перейти к странице поиска"></CENTER>
<?
function getmicrotime() 
{ 
   list($usec, $sec) = explode(" ", microtime()); 
   return ((float)$usec + (float)$sec); 
} 
$time_start = getmicrotime();

$hostname="10.1.1.250";
$username="sel";
$password="";
$dbName="rne";
$mysqlcon = mysql_connect($hostname,$username,$password) or die("Can't create connection");
mysql_select_db("$dbName") or die("Can't select DataBase");

$QueryStr="";

if ($ORGANIZATIONTYPENAME!=""):
  if ($QueryStr!="") $QueryStr .=" AND ";
  $tok = strtok($ORGANIZATIONTYPENAME, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
  while ($tok):
    if ($SubQueryStr!="") $SubQueryStr .=" AND ";
    $SubQueryStr .="((organizationtypes.organizationtype LIKE '% $tok%') OR (organizationnames.organizationname LIKE '% $tok%'))";
    $tok = strtok(" \n\t");
  endwhile;
  $QueryStr .= "($SubQueryStr)";
endif;

if ($ORGANIZATIONADDRESS!=""):
  if ($QueryStr!="") $QueryStr .=" AND ";
  $tok = strtok($ORGANIZATIONADDRESS, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
  while ($tok):
    if ($SubQueryStr!="") $SubQueryStr .=" AND ";
    $SubQueryStr .="(organizationnames.organizationaddress LIKE '% $tok%')";
    $tok = strtok(" \n\t");
  endwhile;
  $QueryStr .= "($SubQueryStr)";
endif;

if ($MEASURETYPENAME!=""):
  if ($QueryStr!="") $QueryStr .=" AND ";
  $tok = strtok($MEASURETYPENAME, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
  while ($tok):
    if ($SubQueryStr!="") $SubQueryStr .=" AND ";
    $SubQueryStr .="((measuretypes.measuretype LIKE '% $tok%') or (measurenames.measurename LIKE '% $tok%'))";
    $tok = strtok(" \n\t");
  endwhile;
  $QueryStr .= "($SubQueryStr)";
endif;

if ($OTHERINFO!=""):
  if ($QueryStr!="") $QueryStr .=" AND ";
  $tok = strtok($OTHERINFO, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
  while ($tok):
    if ($SubQueryStr!="") $SubQueryStr .=" AND ";
    $SubQueryStr .="((organizationnames.organizationinfo LIKE '% $tok%') OR (measures.measureinfo LIKE '% $tok%') OR (measures.measureperformer LIKE '% $tok%') OR (measureauthors.measureauthor LIKE '% $tok%') OR (measureproducers.measureproducer LIKE '% $tok%'))";
    $tok = strtok(" \n\t");
  endwhile;
  $QueryStr .= "($SubQueryStr)";
endif;

if ($MEASURESTARTDATE=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  // запрос был модифицирован по просьбе телефонисток 29.10.2004 - они не хотели, чтобы при выборе даты отображались все мероприятия где нет даты начала и даты конца мероприятия
  //$QueryStr .="((measures.measurestartdatetime IS NULL) OR (LEFT(measures.measurestartdatetime,10) <= '$MEASURESTARTDATE_YEAR-$MEASURESTARTDATE_MONTH-$MEASURESTARTDATE_DAY'))";
  $QueryStr .="(LEFT(measures.measurestartdatetime,10) <= '$MEASURESTARTDATE_YEAR-$MEASURESTARTDATE_MONTH-$MEASURESTARTDATE_DAY')";
}
/* отбор по дню недели был убран 29.10.2004 по просьбе телефонисток
if ($MEASUREWEEKDAY=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="((measures.measurestartdatetime IS NULL) OR (DAYOFWEEK(LEFT(measures.measurestartdatetime,10)) LIKE '$MEASUREWEEKDAYLIST'))";
}
*/
if ($MEASUREPREMIER=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="measures.measurepremier=1";
}
if ($TEENAGERSMEASURE=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="measures.teenagersmeasure=1";
}
if ($CHILDRENMEASURE=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="measures.childrenmeasure=1";
}

if ($OLDMEASURES=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  if ($MEASURESTARTDATE=="on")
    $QueryStr .="((measures.measurestopdatetime IS NULL) OR (LEFT(measures.measurestopdatetime,10)>='$MEASURESTARTDATE_YEAR-$MEASURESTARTDATE_MONTH-$MEASURESTARTDATE_DAY'))";
  else $QueryStr .="((measures.measurestopdatetime IS NULL) OR (LEFT(measures.measurestopdatetime,10)>=CURRENT_DATE))";
}

$QStr="";
if ($QueryStr!=""):
  $QStr .="WHERE $QueryStr";
endif;

$q="SELECT measures.id as f1, organizationtypes.organizationtype as f2, organizationnames.organizationname as f3, measuretypes.measuretype as f4, measurenames.measurename as f5, measureauthors.measureauthor as f6, measureproducers.measureproducer as f7, DATE_FORMAT(measures.measurestartdatetime, \"%d-%m-%Y %T\") as f8, DATE_FORMAT(measures.measurestopdatetime, \"%d-%m-%Y %T\") as f9, measures.measureticketprice as f10, measures.measureduration as f11, measures.measureperformer as f12, measures.measureorganizer as f13, measures.measureinfo as f14, measures.measurepremier as f15, measures.teenagersmeasure as f16, measures.childrenmeasure as f17, users.realname as f18, organizationnames.organizationaddress as f19, organizationnames.organizationhowtoreach as f20, organizationnames.organizationphones as f21, organizationnames.organizationinfo as f22, LENGTH(CONCAT(IFNULL(organizationnames.organizationinfo,''),IFNULL(measures.measureinfo,''))) as f23 FROM measures LEFT JOIN organizationtypes ON (organizationtypes.id=measures.organizationtypeid) LEFT JOIN organizationnames ON (organizationnames.id=measures.organizationnameid) LEFT JOIN measuretypes ON (measuretypes.id=measures.measuretypeid) LEFT JOIN measurenames ON (measurenames.id=measures.measurenameid) LEFT JOIN measureauthors ON (measureauthors.id=measures.measureauthorid) LEFT JOIN measureproducers ON (measureproducers.id=measures.measureproducerid) LEFT JOIN users ON (users.id=measures.ridcreatorid) $QStr ORDER by f23, organizationnames.organizationname, measures.measurestartdatetime;";

if ($DEBUGMODE=="on"):
  print "QUERY = $q";
endif;

$tm = mysql_query($q);
$num_rows=mysql_num_rows($tm);
if ($num_rows>0):?>
    <TABLE CLASS="border" WIDTH="100%" BORDER="1" ALIGN="CENTER">
      <CAPTION>Всего записей найдено: <?print $num_rows;?>. Результаты отбора:</CAPTION>
<?for ($i=0;$i<$num_rows;$i++):
    $id=mysql_result($tm, $i, "f1");
    $OrganizationType=mysql_result($tm, $i, "f2");
    $OrganizationName=mysql_result($tm, $i, "f3");
    $MeasureType=mysql_result($tm, $i, "f4");
    $MeasureName=mysql_result($tm, $i, "f5");
    $MeasureAuthor=mysql_result($tm, $i, "f6");
    $MeasureProducer=mysql_result($tm, $i, "f7");
    $MeasureStartDateTime=mysql_result($tm, $i, "f8");
    $MeasureStopDateTime=mysql_result($tm, $i, "f9");
    $MeasureTicketPrice=mysql_result($tm, $i, "f10");
    $MeasureDuration=mysql_result($tm, $i, "f11");
    $MeasurePerformer=mysql_result($tm, $i, "f12");
    $MeasureOrganizer=mysql_result($tm, $i, "f13");
    $MeasureInfo=mysql_result($tm, $i, "f14");
    $MeasurePremier=mysql_result($tm, $i, "f15");
    $TeenagersMeasure=mysql_result($tm, $i, "f16");
    $ChildrenMeasure=mysql_result($tm, $i, "f17");
    $RIDCreator=mysql_result($tm, $i, "f18");
    $OrganizationAddress=mysql_result($tm, $i, "f19");
    $OrganizationHowToReach=mysql_result($tm, $i, "f20");
    $OrganizationPhones=mysql_result($tm, $i, "f21");
    $OrganizationInfo=mysql_result($tm, $i, "f22");
    $i1=$i+1;
?>
      <TBODY>
        <TR BGCOLOR="339999">
          <TH CLASS="la" WIDTH="1%">
            <FONT SIZE="3" COLOR="#FFFFFF">
              <B>Запись № <?print $i1;?></B>
            </FONT>
          </TH>
          <TH CLASS="la">
<?  if (($MeasurePremier=="1")||($TeenagersMeasure=="1")||($ChildrenMeasure=="1")||($DEBUGMODE=="on")):?>
            <TABLE BORDER="1" STYLE="border-color: black;">
              <TBODY>
                <TR>
<?    if ($DEBUGMODE=="on"):?>
                  <TD BGCOLOR="#CCCCCC"><FONT SIZE="-2">ID записи БД:<BR><B><?print $id;?></B><BR><BR>Автор<BR>записи&nbsp;БД:<BR><B><?print $RIDCreator;?></B></FONT></TD>
<?    endif;?>

<?    if ($MeasurePremier=="1"):?>
                  <TD BGCOLOR="red"><FONT COLOR="#FFFFFF"><B>ПРЕМЬЕРА</B></FONT></TD>
<?    endif;?>
<?    if ($TeenagersMeasure=="1"):?>
                  <TD BGCOLOR="#00CC00"><FONT COLOR="#FFFFFF"><B>ДЛЯ ПОДРОСТКОВ</B></FONT></TD>
<?    endif;?>
<?    if ($ChildrenMeasure=="1"):?>
                  <TD BGCOLOR="#0000FF"><FONT COLOR="#FFFFFF"><B>ДЛЯ ДЕТЕЙ</B></FONT></TD>
<?    endif;?>
                </TR>
              </TBODY>
            </TABLE>
<?  endif;?>
          </TH>
        </TR>
        <TR VALIGN="MIDDLE" BGCOLOR="#33CCCC">
          <TH WIDTH="1%">Наименование параметра</TH>
          <TH>Значение параметра</TH>
        </TR>
<?  if (($OrganizationType!=nil)&&($OrganizationType!="")):
    $tok = strtok($ORGANIZATIONTYPENAME, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationType = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationType);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationType = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationType);
      $tok=strtoupper($a);
      $OrganizationType = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationType);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Тип&nbsp;организации</TD>
          <TD CLASS="la"><?print $OrganizationType;?></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationName!=nil)&&($OrganizationName!="")):
    $tok = strtok($ORGANIZATIONTYPENAME, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationName = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationName);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationName = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationName);
      $tok=strtoupper($a);
      $OrganizationName = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationName);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Наименование&nbsp;организации</TD>
          <TD CLASS="la"><B><?print $OrganizationName;?></B></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationAddress!=nil)&&($OrganizationAddress!="")):
    $tok = strtok($ORGANIZATIONADDRESS, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationAddress = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationAddress);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationAddress = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationAddress);
      $tok=strtoupper($a);
      $OrganizationAddress = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationAddress);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Адрес&nbsp;организации</TD>
          <TD CLASS="la"><?print $OrganizationAddress;?></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationPhones!=nil)&&($OrganizationPhones!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Контактные&nbsp;телефоны</TD>
          <TD CLASS="la"><?print $OrganizationPhones;?></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationHowToReach!=nil)&&($OrganizationHowToReach!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Проезд&nbsp;(как&nbsp;добраться)</TD>
          <TD CLASS="la"><?print $OrganizationHowToReach;?></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationInfo!=nil)&&($OrganizationInfo!="")):
    $tok = strtok($OTHERINFO, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationInfo = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationInfo);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationInfo = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationInfo);
      $tok=strtoupper($a);
      $OrganizationInfo = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$OrganizationInfo);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Прочая&nbsp;информация</TD>
          <TD CLASS="la"><?print $OrganizationInfo;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureType!=nil)&&($MeasureType!="")):
    $tok = strtok($MEASURETYPENAME, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureType = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureType);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureType = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureType);
      $tok=strtoupper($a);
      $MeasureType = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureType);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Тип&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureType;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureName!=nil)&&($MeasureName!="")):
    $tok = strtok($MEASURETYPENAME, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureName = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureName);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureName = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureName);
      $tok=strtoupper($a);
      $MeasureName = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureName);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Наименование&nbsp;мероприятия</TD>
          <TD CLASS="la"><B><?print $MeasureName;?></B></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureAuthor!=nil)&&($MeasureAuthor!="")):
    $tok = strtok($OTHERINFO, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureAuthor = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureAuthor);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureAuthor = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureAuthor);
      $tok=strtoupper($a);
      $MeasureAuthor = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureAuthor);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Автор&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureAuthor;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureProducer!=nil)&&($MeasureProducer!="")):
    $tok = strtok($OTHERINFO, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureProducer = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureProducer);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureProducer = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureProducer);
      $tok=strtoupper($a);
      $MeasureProducer = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureProducer);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Режиссёр&nbsp;мероприятия</TD>    
          <TD CLASS="la"><?print $MeasureProducer;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureStartDateTime!=nil)&&($MeasureStartDateTime!="")&&($MeasureStartDateTime!="00-00-0000 00:00:00")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Дата&nbsp;и&nbsp;время&nbsp;начала&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureStartDateTime;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureStopDateTime!=nil)&&($MeasureStopDateTime!="")&&($MeasureStopDateTime!="00-00-0000 00:00:00")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Дата&nbsp;и&nbsp;время&nbsp;окончания&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureStopDateTime;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureDuration!=nil)&&($MeasureDuration!="")&&($MeasureDuration!="00:00:00")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Продолжительность&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureDuration;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureTicketPrice!=nil)&&($MeasureTicketPrice!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Стоимость&nbsp;билетов</TD>
          <TD CLASS="la"><?print $MeasureTicketPrice;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasurePerformer!=nil)&&($MeasurePerformer!="")):
    $tok = strtok($OTHERINFO, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasurePerformer = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasurePerformer);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasurePerformer = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasurePerformer);
      $tok=strtoupper($a);
      $MeasurePerformer = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasurePerformer);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Исполнитель&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasurePerformer;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureOrganizer!=nil)&&($MeasureOrganizer!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Организатор&nbsp;мероприятия</TD>    
          <TD CLASS="la"><?print $MeasureOrganizer;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureInfo!=nil)&&($MeasureInfo!="")):
    $tok = strtok($OTHERINFO, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureInfo = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureInfo);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureInfo = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureInfo);
      $tok=strtoupper($a);
      $MeasureInfo = eregi_replace("$tok",strtoupper("<FONT COLOR=red><B>$tok</B></FONT>"),$MeasureInfo);
      $tok = strtok(" \n\t");
    endwhile;?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Информация&nbsp;о&nbsp;мероприятии</TD>
          <TD CLASS="la"><?print $MeasureInfo;?></TD>
        </TR>
<?  endif;?>
        <TR>
          <TD COLSPAN="2"></TD>
        </TR>
<?endfor;?>
      </TBODY>
    </TABLE>
<?
else:?>
    <P>По заданному запросу не найдено ни одной записи!</P>
    <HR>
    <P>Нажмите клавишу <A HREF="javascript:history.back()">&laquo;Backspace&raquo;</A> для возврата к процедуре ввода условий запроса.</P>
<?
endif;
$time_end = getmicrotime();
$time = $time_end - $time_start;
?>
    <P>Время выполнения скрипта: <?print $time?> секунд.</P>
    </FORM>
  </BODY>
</HTML>
