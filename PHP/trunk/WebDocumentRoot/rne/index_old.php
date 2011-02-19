<?
// ДОКУМЕНТ был проверен на соответствие html-валидатором 14.01.2005
$day = date("d");
$month = date("m");
$year = date("Y");
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=WINDOWS-1251">
    <STYLE TYPE="text/css">@import url(ie5.css);</STYLE>
    <LINK REL="STYLESHEET" HREF="ie5.css" TYPE="TEXT/CSS">
    <TITLE>База данных &laquo;ОТДЫХ И РАЗВЛЕЧЕНИЯ&raquo; (АРМ телефониста)</TITLE>
  </HEAD>
  <BODY onload="javascript:document.all.ORGANIZATIONTYPENAME.focus();">
<?
$hostname="10.1.1.250";
$username="sel";
$password="";
$dbName="rne";
$mysqlcon=mysql_connect($hostname,$username,$password) or die("Can't create connection");
mysql_select_db("$dbName") or die("Can't select DataBase");
?>
    <FORM ACTION="search.php" METHOD="GET">
      <TABLE BORDER="0" ALIGN="CENTER">
        <TBODY>
          <TR>
            <TD COLSPAN="3" BGCOLOR="#339999" VALIGN="MIDDLE" ALIGN="CENTER">
              <TABLE BORDER="0" ALIGN="CENTER">
                <TBODY>
                  <TR VALIGN="MIDDLE" BGCOLOR="#339999"><TD HEIGHT="10" COLSPAN="3"></TD></TR>
                  <TR><TD COLSPAN="3" BGCOLOR="#339999" VALIGN="MIDDLE" ALIGN="CENTER"><B>Введите параметры для осуществления поиска в базе данных &laquo;Отдых и развлечения&raquo;:</B></TD></TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#339999"><TD HEIGHT="10" COLSPAN="3"></TD></TR>
                  <!-- заголовок полей таблицы  - убран по просьбе телефонисток
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TH COLSPAN="2">Наименование поля<BR>и флаг использования поля</TH>
                    <TH>Значение поля</TH>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#339999"><TD HEIGHT="5" COLSPAN="3"></TD></TR>
                  -->
                  <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD HEIGHT="2" COLSPAN="3"></TD></TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
                    <TD ALIGN="LEFT" COLSPAN="2">Тип и наименование организации</TD>
                    <TD><INPUT TYPE="TEXT" NAME="ORGANIZATIONTYPENAME" SIZE="67"></TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TD ALIGN="LEFT" COLSPAN="2">Адрес организации</TD>
                    <TD><INPUT TYPE="TEXT" NAME="ORGANIZATIONADDRESS" SIZE="67"></TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
                    <TD ALIGN="LEFT" COLSPAN="2">Тип и наименование мероприятия</TD>
                    <TD><INPUT TYPE="TEXT" NAME="MEASURETYPENAME" SIZE="67"></TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TD ALIGN="LEFT" COLSPAN="2">Прочая информация (в т.ч. автор,<BR>режиссёр мероприятия, исполнитель,<BR>информация об организации,<BR>информация о мероприятии)</TD>
                  <TD><INPUT TYPE="TEXT" NAME="OTHERINFO" SIZE="67"></TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="MEASURESTARTDATE"></TD>
                    <TD ALIGN="LEFT">Дата&nbsp;начала&nbsp;мероприятия</TD>
                    <TD>
                      <INPUT TYPE="TEXT" NAME="MEASURESTARTDATE_DAY" SIZE="2" MAXLENGTH="2">&nbsp;/&nbsp;
                      <INPUT TYPE="TEXT" NAME="MEASURESTARTDATE_MONTH" SIZE="2" MAXLENGTH="2" VALUE="<? print $month;?>">&nbsp;/&nbsp;
                      <INPUT TYPE="TEXT" NAME="MEASURESTARTDATE_YEAR" SIZE="4" MAXLENGTH="4" VALUE="<? print $year;?>">&nbsp;(ДД/ММ/ГГГГ)
                    </TD>
                  </TR>
                  <!-- отбор по дню недели начала мероприятия был убран 29.10.2004 по просьбе телефонисток
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="MEASUREWEEKDAY"></TD>
                    <TD ALIGN="LEFT">День&nbsp;недели&nbsp;начала&nbsp;мероприятия</TD>
                    <TD>
                      <SELECT NAME="MEASUREWEEKDAYLIST">
                        <OPTION VALUE="8" SELECTED></OPTION>
                        <OPTION VALUE="2">понедельник</OPTION>
                        <OPTION VALUE="3">вторник</OPTION>
                        <OPTION VALUE="4">среда</OPTION>
                        <OPTION VALUE="5">четверг</OPTION>
                        <OPTION VALUE="6">пятница</OPTION>
                        <OPTION VALUE="7">суббота</OPTION>
                        <OPTION VALUE="1">воскресенье</OPTION>
                      </SELECT>
                    </TD>
                  </TR>
                  -->
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="MEASUREPREMIER"></TD>
                    <TD ALIGN="LEFT" COLSPAN="2">Премьера мероприятия</TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="TEENAGERSMEASURE"></TD>
                    <TD ALIGN="LEFT" COLSPAN="2">Подростковое мероприятие</TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="CHILDRENMEASURE"></TD>
                    <TD ALIGN="LEFT" COLSPAN="2">Детское мероприятие</TD>
                  </TR>
                  <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="OLDMEASURES" CHECKED></TD>
                    <TD ALIGN="LEFT" COLSPAN="2">Не&nbsp;отображать&nbsp;устаревшие&nbsp;данные (за прошедшие даты)</TD>
                  </TR>
                  <!-- используется автором во время отладки внесённых изменений
                  <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
                    <TD ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="DEBUGMODE" CHECKED></TD>
                    <TD ALIGN="LEFT" COLSPAN="2">Режим отладки</TD>
                  </TR>
                  -->
                  <TR VALIGN="MIDDLE" BGCOLOR="#339999"><TD HEIGHT="5" COLSPAN="3"></TD></TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR VALIGN="MIDDLE" BGCOLOR="#339999">
            <TD COLSPAN="3" ALIGN="CENTER"><INPUT TYPE="SUBMIT" VALUE="Найти информацию"></TD>
          </TR>
          <TR VALIGN="MIDDLE" BGCOLOR="#339999"><TD HEIGHT="5"></TD></TR>
        </TBODY>
      </TABLE>
    </FORM>
  </BODY>
</HTML>

