<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=WINDOWS-1251">
    <STYLE TYPE="text/css">@import url(ie5.css);</STYLE>
    <LINK REL="STYLESHEET" HREF="ie5.css" TYPE="TEXT/CSS">
    <TITLE>База данных &laquo;ОТДЫХ И РАЗВЛЕЧЕНИЯ&raquo; (АРМ телефониста)</TITLE>
  </HEAD>
  <BODY>
<?
$DEBUGMODE="off";
$hostname="10.1.1.250";
$username="sel";
$password="";
$dbName="rne";
$mysqlcon = mysql_connect($hostname,$username,$password) or die("Can't create connection");
mysql_select_db("$dbName") or die("Can't select DataBase");
if ($MEASURE_ID!=""):
$q="SELECT measures.id as f1, organizationtypes.organizationtype as f2, organizationnames.organizationname as f3, measuretypes.measuretype as f4, measurenames.measurename as f5, measureauthors.measureauthor as f6, measureproducers.measureproducer as f7, DATE_FORMAT(measures.measurestartdatetime, \"%d-%m-%Y %T\") as f8, DATE_FORMAT(measures.measurestopdatetime, \"%d-%m-%Y %T\") as f9, measures.measureticketprice as f10, measures.measureduration as f11, measures.measureperformer as f12, measures.measureorganizer as f13, measures.measureinfo as f14, measures.measurepremier as f15, measures.teenagersmeasure as f16, measures.childrenmeasure as f17, users.realname as f18, organizationnames.organizationaddress as f19, organizationnames.organizationhowtoreach as f20, organizationnames.organizationphones as f21, organizationnames.organizationinfo as f22 FROM measures LEFT JOIN organizationtypes ON (organizationtypes.id=measures.organizationtypeid) LEFT JOIN organizationnames ON (organizationnames.id=measures.organizationnameid) LEFT JOIN measuretypes ON (measuretypes.id=measures.measuretypeid) LEFT JOIN measurenames ON (measurenames.id=measures.measurenameid) LEFT JOIN measureauthors ON (measureauthors.id=measures.measureauthorid) LEFT JOIN measureproducers ON (measureproducers.id=measures.measureproducerid) LEFT JOIN users ON (users.id=measures.ridcreatorid) WHERE measures.id=$MEASURE_ID";
$tm = mysql_query($q);
$num_rows=mysql_num_rows($tm);
if ($num_rows>0):?>
    <TABLE CLASS="border" WIDTH="100%" BORDER="1" ALIGN="CENTER">
      <TBODY>
<?  $id=mysql_result($tm, 0, "f1");
    $OrganizationType=mysql_result($tm, 0, "f2");
    $OrganizationName=mysql_result($tm, 0, "f3");
    $MeasureType=mysql_result($tm, 0, "f4");
    $MeasureName=mysql_result($tm, 0, "f5");
    $MeasureAuthor=mysql_result($tm, 0, "f6");
    $MeasureProducer=mysql_result($tm, 0, "f7");
    $MeasureStartDateTime=mysql_result($tm, 0, "f8");
    $MeasureStopDateTime=mysql_result($tm, 0, "f9");
    $MeasureTicketPrice=mysql_result($tm, 0, "f10");
    $MeasureDuration=mysql_result($tm, 0, "f11");
    $MeasurePerformer=mysql_result($tm, 0, "f12");
    $MeasureOrganizer=mysql_result($tm, 0, "f13");
    $MeasureInfo=mysql_result($tm, 0, "f14");
    $MeasurePremier=mysql_result($tm, 0, "f15");
    $TeenagersMeasure=mysql_result($tm, 0, "f16");
    $ChildrenMeasure=mysql_result($tm, 0, "f17");
    $RIDCreator=mysql_result($tm, 0, "f18");
    $OrganizationAddress=mysql_result($tm, 0, "f19");
    $OrganizationHowToReach=mysql_result($tm, 0, "f20");
    $OrganizationPhones=mysql_result($tm, 0, "f21");
    $OrganizationInfo=mysql_result($tm, 0, "f22");
?>
        <TR BGCOLOR="339999">
          <TH CLASS="ca" WIDTH="1%">
            <FONT SIZE="3" COLOR="#FFFFFF">
              <B>Запись&nbsp;№&nbsp;<?print $id;?></B>
            </FONT>
          </TH>
          <TH CLASS="la" >
<?  if (($MeasurePremier=="1")||($TeenagersMeasure=="1")||($ChildrenMeasure=="1")||($DEBUGMODE=="on")):?>
            <TABLE BORDER="1" STYLE="bordercolor: black;">
              <TBODY>
                <TR>
<?    if ($DEBUGMODE=="on"):?>
                  <TD BGCOLOR="#CCCCCC"><FONT SIZE="-2">ID записи БД:<BR><B><?print $id;?></B><BR><BR>Автор<BR>записи&nbsp;БД:<BR><B><?print $RIDCreator;?></B></FONT></TD>
<?    endif;?>

<?    if ($MeasurePremier=="1"):?>
                  <TD BGCOLOR="#FF0000"><FONT COLOR="#FFFFFF"><B>ПРЕМЬЕРА</B></FONT></TD>
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
          <TH WIDTH="1%">Наименование&nbsp;параметра</TH>
          <TH>Значение&nbsp;параметра</TH>
        </TR>
<?  if (($OrganizationType!=nil)&&($OrganizationType!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Тип&nbsp;организации</TD>
          <TD CLASS="la"><?print $OrganizationType;?></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationName!=nil)&&($OrganizationName!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Наименование&nbsp;организации</TD>
          <TD CLASS="la"><B><?print $OrganizationName;?></B></TD>
        </TR>
<?  endif;?>
<?  if (($OrganizationAddress!=nil)&&($OrganizationAddress!="")):?>
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
<?  if (($OrganizationInfo!=nil)&&($OrganizationInfo!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Прочая&nbsp;информация</TD>
          <TD CLASS="la"><?print $OrganizationInfo;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureType!=nil)&&($MeasureType!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Тип&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureType;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureName!=nil)&&($MeasureName!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Наименование&nbsp;мероприятия</TD>
          <TD CLASS="la"><B><?print $MeasureName;?></B></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureAuthor!=nil)&&($MeasureAuthor!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Автор&nbsp;мероприятия</TD>
          <TD CLASS="la"><?print $MeasureAuthor;?></TD>
        </TR>
<?  endif;?>
<?  if (($MeasureProducer!=nil)&&($MeasureProducer!="")):?>
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
<?  if (($MeasurePerformer!=nil)&&($MeasurePerformer!="")):?>
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
<?  if (($MeasureInfo!=nil)&&($MeasureInfo!="")):?>
        <TR>
          <TD CLASS="la" BGCOLOR="#33CCCC">Информация&nbsp;о&nbsp;мероприятии</TD>
          <TD CLASS="la"><?print $MeasureInfo;?></TD>
        </TR>
<?  endif;?>
      </TBODY>
    </TABLE>
<?endif;
endif;?>
  </BODY>
</HTML>