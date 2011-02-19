<?
// ДОКУМЕНТ был проверен на соответствие html-валидатором 14.04.2005
$DEBUG="off";
$day = date("d");
$month = date("m");
$year = date("Y");
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=WINDOWS-1251">
    <TITLE>База данных &laquo;ОТДЫХ И РАЗВЛЕЧЕНИЯ&raquo; (АРМ телефониста)</TITLE>
    <LINK REL="author" HREF="http://vladracoola.by.ru/index.html">
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
  <BODY BGCOLOR="gainsboro" onload="javascript:document.all.QUERY.focus();">
    <FORM METHOD="GET" ACTION="search.php" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640px" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <TBODY ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD BGCOLOR="#339999" WIDTH="11px" ROWSPAN="22"></TD>
            <TD BGCOLOR="#339999" WIDTH="20px" HEIGHT="10px"></TD>
            <TD BGCOLOR="#339999" WIDTH="473px"></TD>
            <TD BGCOLOR="#339999" WIDTH="100px"></TD>
            <TD BGCOLOR="#339999" WIDTH="11px" ROWSPAN="22"></TD>
          </TR>
          <TR><TD COLSPAN="3" BGCOLOR="#339999" VALIGN="MIDDLE" ALIGN="CENTER" STYLE="font-size: 10pt; font-weight: bold;">Введите параметры отбора при поиске в базе данных &laquo;Отдых и развлечения&raquo;:</TD></TR>
          <TR>
            <TD BGCOLOR="#339999" HEIGHT="10px" COLSPAN="3"></TD>
          </TR>
          <TR VALIGN="MIDDLE">
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 3px 5px;" COLSPAN="2"><INPUT STYLE="border: black solid 1px; vertical-align: middle;" TYPE="TEXT" NAME="QUERY" SIZE="81"></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT"><INPUT TYPE="SUBMIT" VALUE="Найти!.." STYLE="border: black solid 1px; width: 98px; vertical-align: middle; height: 20px;"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">тип организации</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">наименование организации</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">прочая информация об организации</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">тип мероприятия</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">наименование мероприятия</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">автор мероприятия</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px;" COLSPAN="2">исполнитель мероприятия</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px 3px;" COLSPAN="2">прочая информация о мероприятии</TD>
          </TR>
          <TR VALIGN="MIDDLE">
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 3px 5px;" COLSPAN="3"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="ADDRESS" SIZE="98"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" ALIGN="CENTER">-</TD>
            <TD BGCOLOR="#339999" ALIGN="LEFT" STYLE="font-size: 7pt; padding: 0px 5px 3px;" COLSPAN="2">адрес</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="STARTDATE"></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 3px 5px 3px;" COLSPAN="2">дата&nbsp;начала&nbsp;мероприятия: 
              <INPUT STYLE="border: black solid 1px; text-align: center; vertical-align: middle; height: 15px;" TYPE="TEXT" NAME="DAY" SIZE="2" MAXLENGTH="2">&nbsp;(день)&nbsp;
              <INPUT STYLE="border: black solid 1px; text-align: center; vertical-align: middle; height: 15px;" TYPE="TEXT" NAME="MONTH" SIZE="2" MAXLENGTH="2" VALUE="<? print $month;?>">&nbsp;(месяц)&nbsp;
              <INPUT STYLE="border: black solid 1px; text-align: center; vertical-align: middle; height: 15px;" TYPE="TEXT" NAME="YEAR" SIZE="4" MAXLENGTH="4" VALUE="<? print $year;?>">&nbsp;(год)
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="SORTBYDATE"></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 0px 5px 3px;" COLSPAN="2">сортировка по дате</TD>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="PREMIER"></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 0px 5px 3px;" COLSPAN="2">премьера мероприятия</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="TEENAGERS"></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 0px 5px 3px;" COLSPAN="2">подростковое мероприятие</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="CHILDREN"></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 0px 5px 3px;" COLSPAN="2">детское мероприятие</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="LIMITATION" CHECKED></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 0px 5px 3px;" COLSPAN="2">отображать только первые 50 найденых записей</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" ALIGN="CENTER"><INPUT TYPE="CHECKBOX" NAME="OLD" CHECKED></TD>
            <TD BGCOLOR="#EEEEEE" ALIGN="LEFT" STYLE="padding: 0px 5px 3px;" COLSPAN="2">не&nbsp;отображать&nbsp;устаревшие&nbsp;данные (за прошедшие даты)</TD>
          </TR>
          <TR>
            <TD BGCOLOR="#339999" HEIGHT="10px" COLSPAN="3"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
  </BODY>
</HTML>
