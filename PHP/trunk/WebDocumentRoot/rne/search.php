<?
// ДОКУМЕНТ был проверен на соответствие html-валидатором 14.04.2005
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

function ShowErrorMessage($as)
{
?>
    <FORM METHOD="GET" ACTION="index.php" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
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
              <INPUT TYPE="SUBMIT" NAME="backto" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Для возврата к окну поиска нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
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
            <TD STYLE="padding: 3px 5px;"><?echo $as;?><BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к окну поиска.</TD>
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
$DEBUGMODE="off";
$HostName="10.1.1.250";
$UserName="sel";
$Password="";
$DBName="rne";
$QUERY=trim($QUERY);
$QUERY=preg_replace('/\./', '!', $QUERY); // добавлено 05.10.2005 - данная строка заменяет символ . символом ! конца слова
$QUERY=preg_replace('/\s+/', ' ', $QUERY);
$QUERY=preg_replace('/\*/', '%', $QUERY); // добавлено 30.09.2005 - данная строка заменяет символ * символом % конца слова
if ($DEBUGMODE=="on") echo $QUERY;
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=WINDOWS-1251">
    <TITLE>База данных &laquo;ОТДЫХ И РАЗВЛЕЧЕНИЯ&raquo; (АРМ телефониста)</TITLE>
    <LINK REL="author" HREF="http://vladracoola.by.ru/index.html">
    <LINK REL="prev" HREF="http:\\10.1.1.250\rne\index.php">
    <LINK REL="first" HREF="http:\\10.1.1.250\rne\index.php">
    <LINK REL="search" HREF="http:\\10.1.1.250\rne\index.php">
    <LINK REL="home" HREF="http:\\10.1.1.250\rne\index.php">
    <META NAME="copyright" CONTENT="&copy; 2005 by Vlad Ivanov">
    <META NAME="date" CONTENT="2005-04-13T10:27:43+02:00">
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
      SELECT {
        border: black solid 1px;
        }
    </STYLE>
  </HEAD>
  <BODY BGCOLOR="gainsboro" onload="javascript:document.all.backto.focus();">
<?
$MySQLConnection=@mysql_connect($HostName,$UserName,$Password);
if ($MySQLConnection==FALSE):
  ShowErrorMessage("Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!<BR><BR>Обратитесь к системному администратору!");
?>
  </BODY>
</HTML>
<?
  die("");
endif;
if (@mysql_select_db("$DBName")==FALSE):
  ShowErrorMessage("Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!<BR><BR>Обратитесь к системному администратору!");
?>
  </BODY>
</HTML>
<?
  die("");
endif;

$QueryStr="";

if ($QUERY!=""):
  if ($QueryStr!="") $QueryStr .=" AND ";
  $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
  while ($tok):
    if ($SubQueryStr!="") $SubQueryStr .=" AND ";
    $SubQueryStr .="((organizationtypes.organizationtype LIKE '% $tok%') OR (organizationnames.organizationname LIKE '% $tok%') OR (organizationnames.organizationinfo LIKE '% $tok%') OR (measuretypes.measuretype LIKE '% $tok%') OR (measurenames.measurename LIKE '% $tok%') OR (measures.measureinfo LIKE '% $tok%') OR (measures.measureperformer LIKE '% $tok%') OR (measureauthors.measureauthor LIKE '% $tok%') OR (measureproducers.measureproducer LIKE '% $tok%'))";
    $tok = strtok(" \n\t");
  endwhile;
  $QueryStr .= "($SubQueryStr)";
endif;

if ($ADDRESS!=""):
  if ($QueryStr!="") $QueryStr .=" AND ";
  $tok = strtok($ADDRESS, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
  while ($tok):
    if ($SubQueryStr!="") $SubQueryStr .=" AND ";
    $SubQueryStr .="(organizationnames.organizationaddress LIKE '% $tok%')";
    $tok = strtok(" \n\t");
  endwhile;
  $QueryStr .= "($SubQueryStr)";
endif;

if ($STARTDATE=="on"):
  $ad=$DAY+0;
  if (($ad=="")||(($ad<1)||($ad>31))):
    $ad="__";
  else:
    if ($ad<10):
      $ad="0$ad";
    endif;
  endif;
  $am=$MONTH+0;
  if (($am=="")||(($am<1)||($am>12))):
    $am="__";
  else:
    if ($am<10):
      $am="0$am";
    endif;
  endif;
  $ay=$YEAR+0;
  if ($ay==""):
    $ay="____";
  endif;
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="(LEFT(measures.measurestartdatetime,10) <= '$ay-$am-$ad')";
endif;
if ($PREMIER=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="measures.measurepremier=1";
}
if ($TEENAGERS=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="measures.teenagersmeasure=1";
}
if ($CHILDREN=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  $QueryStr .="measures.childrenmeasure=1";
}

if ($OLD=="on")
{
  if ($QueryStr!="") $QueryStr .=" AND ";
  if ($STARTDATE=="on")
    $QueryStr .="((measures.measurestopdatetime IS NULL) OR (LEFT(measures.measurestopdatetime,10)>='$YEAR-$MONTH-$DAY'))";
  else $QueryStr .="((measures.measurestopdatetime IS NULL) OR (LEFT(measures.measurestopdatetime,10)>=CURRENT_DATE))";
}

$QStr="";
if ($QueryStr!=""):
  $QStr .="WHERE $QueryStr";
endif;

if ($SORTBYDATE=="on"):
  $q="SELECT measures.id as f1, organizationtypes.organizationtype as f2, organizationnames.organizationname as f3, measuretypes.measuretype as f4, measurenames.measurename as f5, measureauthors.measureauthor as f6, measureproducers.measureproducer as f7, DATE_FORMAT(measures.measurestartdatetime, \"%d-%m-%Y %T\") as f8, DATE_FORMAT(measures.measurestopdatetime, \"%d-%m-%Y %T\") as f9, measures.measureticketprice as f10, measures.measureduration as f11, measures.measureperformer as f12, measures.measureorganizer as f13, measures.measureinfo as f14, measures.measurepremier as f15, measures.teenagersmeasure as f16, measures.childrenmeasure as f17, users.realname as f18, organizationnames.organizationaddress as f19, organizationnames.organizationhowtoreach as f20, organizationnames.organizationphones as f21, organizationnames.organizationinfo as f22, LENGTH(CONCAT(IFNULL(organizationnames.organizationinfo,''), IFNULL(measures.measureinfo,''))) as f23 FROM measures LEFT JOIN organizationtypes ON (organizationtypes.id=measures.organizationtypeid) LEFT JOIN organizationnames ON (organizationnames.id=measures.organizationnameid) LEFT JOIN measuretypes ON (measuretypes.id=measures.measuretypeid) LEFT JOIN measurenames ON (measurenames.id=measures.measurenameid) LEFT JOIN measureauthors ON (measureauthors.id=measures.measureauthorid) LEFT JOIN measureproducers ON (measureproducers.id=measures.measureproducerid) LEFT JOIN users ON (users.id=measures.ridcreatorid) $QStr ORDER by measures.measurestartdatetime, organizationnames.organizationname, f23";
else:
  $q="SELECT measures.id as f1, organizationtypes.organizationtype as f2, organizationnames.organizationname as f3, measuretypes.measuretype as f4, measurenames.measurename as f5, measureauthors.measureauthor as f6, measureproducers.measureproducer as f7, DATE_FORMAT(measures.measurestartdatetime, \"%d-%m-%Y %T\") as f8, DATE_FORMAT(measures.measurestopdatetime, \"%d-%m-%Y %T\") as f9, measures.measureticketprice as f10, measures.measureduration as f11, measures.measureperformer as f12, measures.measureorganizer as f13, measures.measureinfo as f14, measures.measurepremier as f15, measures.teenagersmeasure as f16, measures.childrenmeasure as f17, users.realname as f18, organizationnames.organizationaddress as f19, organizationnames.organizationhowtoreach as f20, organizationnames.organizationphones as f21, organizationnames.organizationinfo as f22, LENGTH(CONCAT(IFNULL(organizationnames.organizationinfo,''), IFNULL(measures.measureinfo,''))) as f23 FROM measures LEFT JOIN organizationtypes ON (organizationtypes.id=measures.organizationtypeid) LEFT JOIN organizationnames ON (organizationnames.id=measures.organizationnameid) LEFT JOIN measuretypes ON (measuretypes.id=measures.measuretypeid) LEFT JOIN measurenames ON (measurenames.id=measures.measurenameid) LEFT JOIN measureauthors ON (measureauthors.id=measures.measureauthorid) LEFT JOIN measureproducers ON (measureproducers.id=measures.measureproducerid) LEFT JOIN users ON (users.id=measures.ridcreatorid) $QStr ORDER by f23, organizationnames.organizationname, measures.measurestartdatetime";
endif;
if ($LIMITATION=="on") $q.=" LIMIT 50";
$q.=";";
$q=preg_replace('/!%/', '', $q); // добавлено 30.09.2005 - данная строка делает знак ! символом конца слова

if ($DEBUGMODE=="on") PrintMessage("QUERY","SQL",$q);

$table=mysql_query($q);
$num_rows=mysql_num_rows($table);
if ($num_rows==0):
  ShowErrorMessage("Не найдено ни одного мероприятия, попадающего под указанные Вами условия!");
?>
  </BODY>
</HTML>
<?
  die("");
elseif (!($num_rows>=0)):
  ShowErrorMessage("Сбой при попытке получения данных, попадающих под указанные Вами условия!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
  die("");
endif;
// загрузка данных в массив
$result_array=array();
while ($tmp_array=mysql_fetch_assoc($table)) $result_array[]=$tmp_array;
// завершение соединения с MySQL-сервером
mysql_close($MySQLConnection);

?>
    <FORM METHOD="GET" ACTION="index.php" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="780px" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD>
          <TR>
            <TD WIDTH="11px"></TD>
            <TD WIDTH="240" HEIGHT="12"></TD>
            <TD WIDTH="518"></TD>
            <TD WIDTH="11px"></TD>
          </TR>
          <TR>
            <TD></TD>
            <TD ALIGN="CENTER" COLSPAN="2"><INPUT TYPE="SUBMIT" NAME="backto" VALUE="Перейти к странице поиска" STYLE="border: black solid 1px;"></TD>
            <TD></TD>
          </TR>
          <TR>
            <TD HEIGHT="12" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD></TD>
            <TD COLSPAN="2" ALIGN="CENTER"><?if (($num_rows>=50)&&($LIMITATION=="on")):?><FONT COLOR="red"><B>Внимание!</B></FONT> По указанным Вами условиям было найдено более <?echo $num_rows;?> мероприятий.<BR>Будут показаны только первые <?echo $num_rows;?>.<?else:?>Всего записей найдено: <B><?echo $num_rows;?></B>.<?endif;?></TD>
            <TD></TD>
          </TR>
          <TR>
            <TD HEIGHT="12" COLSPAN="4"></TD>
          </TR>
        </THEAD>
        <TFOOT>
          <TR>
            <TD HEIGHT="0" COLSPAN="4"></TD>
          </TR>
        </TFOOT>
        <TBODY>
<?
// вывод данных на экран
$i1=0;
foreach ($result_array as $i):
  $i1++;
  $id=$i["f1"];
  $OrganizationType=$i["f2"];
  $OrganizationName=$i["f3"];
  $MeasureType=$i["f4"];
  $MeasureName=$i["f5"];
  $MeasureAuthor=$i["f6"];
  $MeasureProducer=$i["f7"];
  $MeasureStartDateTime=$i["f8"];
  $MeasureStopDateTime=$i["f9"];
  $MeasureTicketPrice=$i["f10"];
  $MeasureDuration=$i["f11"];
  $MeasurePerformer=$i["f12"];
  $MeasureOrganizer=$i["f13"];
  $MeasureInfo=$i["f14"];
  $MeasurePremier=$i["f15"];
  $TeenagersMeasure=$i["f16"];
  $ChildrenMeasure=$i["f17"];
  $RIDCreator=$i["f18"];
  $OrganizationAddress=$i["f19"];
  $OrganizationHowToReach=$i["f20"];
  $OrganizationPhones=$i["f21"];
  $OrganizationInfo=$i["f22"];
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; border-width: 2px; background-color: #339999; color: white; padding: 3px 5px;"><B>Запись #<?echo $i1;?></B>&nbsp;&nbsp;&nbsp;<FONT COLOR="black">ID: #<?echo $id;?></FONT></TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; border-width: 2px 2px 2px 0px; font-weight: bold; background-color: #339999; padding: 1px 5px;"><?if ($TeenagersMeasure=="1"):?><FONT COLOR="yellow">Для подростков</FONT>&nbsp;<?endif;?><?if ($ChildrenMeasure=="1"):?><FONT COLOR="#00FF00">Для детей</FONT>&nbsp;<?endif;?><?if ($MeasurePremier=="1"):?><FONT COLOR="red">Премьера</FONT><?endif;?></TD>
            <TD></TD>
          </TR>
          <TR>
            <TD></TD>
            <TD ALIGN="CENTER" STYLE="border-color: black; font-weight: bold; border-width: 0px 2px 2px 2px; background-color: #33CCCC; padding: 3px 5px;">Наименование параметра</TD>
            <TD ALIGN="CENTER" STYLE="border-color: black; font-weight: bold; border-width: 0px 2px 2px 0px; background-color: #33CCCC; padding: 3px 5px;">Значение параметра</TD>
            <TD></TD>
          </TR>
<?
  if (($OrganizationType!=nil)&&($OrganizationType!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationType=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationType);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationType=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationType);
      $tok=strtoupper($a);
      $OrganizationType=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationType);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Тип&nbsp;организации</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $OrganizationType;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($OrganizationName!=nil)&&($OrganizationName!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationName);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationName);
      $tok=strtoupper($a);
      $OrganizationName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationName);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Наименование&nbsp;организации</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px; font-weight: bold;"><?echo $OrganizationName;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($OrganizationAddress!=nil)&&($OrganizationAddress!="")):
    $tok = strtok($ADDRESS, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationAddress=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationAddress);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationAddress=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationAddress);
      $tok=strtoupper($a);
      $OrganizationAddress=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationAddress);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Адрес&nbsp;организации</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $OrganizationAddress;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($OrganizationPhones!=nil)&&($OrganizationPhones!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationPhones);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationPhones=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationPhones);
      $tok=strtoupper($a);
      $OrganizationPhones=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationPhones);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Контактные&nbsp;телефоны</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $OrganizationPhones;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($OrganizationHowToReach!=nil)&&($OrganizationHowToReach!="")):
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Проезд&nbsp;(как&nbsp;добраться)</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $OrganizationHowToReach;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($OrganizationInfo!=nil)&&($OrganizationInfo!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $OrganizationInfo=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationInfo);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $OrganizationInfo=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationInfo);
      $tok=strtoupper($a);
      $OrganizationInfo=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$OrganizationInfo);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Прочая&nbsp;информация</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $OrganizationInfo;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureType!=nil)&&($MeasureType!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureType=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureType);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureType=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureType);
      $tok=strtoupper($a);
      $MeasureType=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureType);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Тип&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureType;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureName!=nil)&&($MeasureName!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureName);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureName);
      $tok=strtoupper($a);
      $MeasureName=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureName);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Наименование&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureName;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureAuthor!=nil)&&($MeasureAuthor!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureAuthor=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureAuthor);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureAuthor=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureAuthor);
      $tok=strtoupper($a);
      $MeasureAuthor=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureAuthor);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Автор&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureAuthor;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureProducer!=nil)&&($MeasureProducer!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureProducer=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureProducer);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureProducer=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureProducer);
      $tok=strtoupper($a);
      $MeasureProducer=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureProducer);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Режиссёр&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureProducer;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureStartDateTime!=nil)&&($MeasureStartDateTime!="")):
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Дата&nbsp;и&nbsp;время&nbsp;начала&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureStartDateTime;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureStopDateTime!=nil)&&($MeasureStopDateTime!="")):
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Дата&nbsp;и&nbsp;время&nbsp;окончания&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureStopDateTime;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureDuration!=nil)&&($MeasureDuration!="")):
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Продолжительность&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureDuration;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureTicketPrice!=nil)&&($MeasureTicketPrice!="")):
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Стоимость&nbsp;билетов</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureTicketPrice;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasurePerformer!=nil)&&($MeasurePerformer!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasurePerformer=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasurePerformer);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasurePerformer=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasurePerformer);
      $tok=strtoupper($a);
      $MeasurePerformer=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasurePerformer);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Исполнитель&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasurePerformer;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureOrganizer!=nil)&&($MeasureOrganizer!="")):
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Организатор&nbsp;мероприятия</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureOrganizer;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
  if (($MeasureInfo!=nil)&&($MeasureInfo!="")):
    $tok = strtok($QUERY, " \n\t"); // в качестве разделителей используем пробел, табуляцию и перевод строки
    while ($tok):
      $MeasureInfo=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureInfo);
      // коррекция ошибки конвертации кириллических символов
      $a="$tok";
      $tok=strtoupper($a[0]);
      $tok.=substr($a, 1);
      $MeasureInfo=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureInfo);
      $tok=strtoupper($a);
      $MeasureInfo=eregi_replace("$tok",strtoupper("<FONT COLOR=\"red\" STYLE=\"font-weight: bold;\">$tok</FONT>"),$MeasureInfo);
      $tok = strtok(" \n\t");
    endwhile;
?>
          <TR>
            <TD></TD>
            <TD ALIGN="LEFT" VALIGN="TOP" BGCOLOR="#33CCCC" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 2px;">Информация&nbsp;о&nbsp;мероприятии</TD>
            <TD ALIGN="LEFT" STYLE="border-color: black; padding: 1px 5px; border-width: 0px 2px 1px 0px;"><?echo $MeasureInfo;?></TD>
            <TD></TD>
          </TR>
<?
  endif;
?>
          <TR>
            <TD></TD>
            <TD HEIGHT="12" COLSPAN="2" STYLE="border-color: black; border-width: 2px 0px 0px 0px;"></TD>
            <TD></TD>
          </TR>
<?
endforeach;
?>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
  </BODY>
</HTML>
