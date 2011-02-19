<?
$DEBUG="on";

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
    <TABLE STYLE="margin: 3px 5px; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">
      <TR>
        <TD WIDTH="100" ALIGN="CENTER" STYLE="padding: 3px 5px; border-color: black; border-width: 1px; color: <?echo $cf;?>; background: <?echo $cb;?>; font-weight: bold;"><?echo $as;?></TD>
        <TD STYLE="padding: 3px 5px;"><?echo $bs;?></TD>
      </TR>
    </TABLE>
<?
}

function ShowErrorMessage($as, $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR)
{
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
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
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="2">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?echo $time;?>">
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?echo $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?echo $amy;?>">
<?
  if ($maker!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?echo $maker;?>">
<?
  endif;
  if ($makerstate!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?echo $makerstate;?>">
<?
  endif;
  if ($makerphone!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?echo $makerphone;?>">
<?
  endif;
  if ($action!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="action" VALUE="<?echo $action;?>">
<?
  endif;
  if ($EMAIL1Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL1Addr" VALUE="<?echo $EMAIL1Addr;?>">
<?
  endif;
  if ($EMAIL1Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL1Name" VALUE="<?echo $EMAIL1Name;?>">
<?
  endif;
  if ($EMAIL2Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL2Addr" VALUE="<?echo $EMAIL2Addr;?>">
<?
  endif;
  if ($EMAIL2Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL2Name" VALUE="<?echo $EMAIL2Name;?>">
<?
  endif;
  if ($EMAIL3Addr!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL3Addr" VALUE="<?echo $EMAIL3Addr;?>">
<?
  endif;
  if ($EMAIL3Name!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="EMAIL3Name" VALUE="<?echo $EMAIL3Name;?>">
<?
  endif;
  if ($RECALC!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?echo $RECALC;?>">
<?
  endif;
  if ($FROMSTARTOFYEAR!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="FROMSTARTOFYEAR" VALUE="<?echo $FROMSTARTOFYEAR;?>">
<?
  endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Для возврата к шагу выбора параметров отчёта нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
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
            <TD STYLE="padding: 3px 5px;"><?echo $as;?><BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
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

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?echo $reports[12]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="http://10.1.1.250/ns2/">
    <LINK REL="first" HREF="http://10.1.1.250/ns2/">
    <LINK REL="previous" HREF="http://10.1.1.250/ns2/?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;
      if ($amm!=""): echo "&amp;amm=$amm"; endif;
      if ($amy!=""): echo "&amp;amy=$amy"; endif;
      if ($maker!=""): echo "&amp;maker=$maker"; endif;
      if ($makerstate!=""): echo "&amp;makerstate=$makerstate"; endif;
      if ($makerphone!=""): echo "&amp;makerphone=$makerphone"; endif;
      if ($action!=""): echo "&amp;action=$action"; endif;
      if ($EMAIL1Addr!=""): echo "&amp;EMAIL1Addr=$EMAIL1Addr"; endif;
      if ($EMAIL1Name!=""): echo "&amp;EMAIL1Name=$EMAIL1Name"; endif;
      if ($EMAIL2Addr!=""): echo "&amp;EMAIL2Addr=$EMAIL2Addr"; endif;
      if ($EMAIL2Name!=""): echo "&amp;EMAIL2Name=$EMAIL2Name"; endif;
      if ($EMAIL3Addr!=""): echo "&amp;EMAIL3Addr=$EMAIL3Addr"; endif;
      if ($EMAIL3Name!=""): echo "&amp;EMAIL3Name=$EMAIL3Name"; endif;
      if ($RECALC!=""): echo "&amp;RECALC=$RECALC"; endif;
      if ($FROMSTARTOFYEAR!=""): echo "&amp;FROMSTARTOFYEAR=$FROMSTARTOFYEAR"; endif;?>">
    <LINK REL="author" HREF="http://vladracoola.by.ru/index1.html">
    <STYLE MEDIA="screen, print" TYPE="text/css">
      * {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 8pt;
        padding: 0;
        margin: 0;
        border-color: transparent;
        border-width: 0;
        }
      TABLE, TD {
        border-style: solid;
      }
    </STYLE>
  </HEAD>
  <BODY<?if (($DEBUG=="on")||($action=="email")):?> BGCOLOR="gainsboro"<?endif;?>>
<?
      // валидация временного промежутка
      if (($time!="lastmonth")&&($time!="anothermonth")): // если временной промежуток не попадает ни под один из дозволенных - вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $amm, $amy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $FROMSTARTOFYEAR);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
?>



  </BODY>
</HTML>
