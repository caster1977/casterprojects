<?
$DEBUG="off";

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

function ShowErrorMessage($as, $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY)
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
              <INPUT TYPE="HIDDEN" NAME="add" VALUE="<?echo $add;?>">
              <INPUT TYPE="HIDDEN" NAME="adm" VALUE="<?echo $adm;?>">
              <INPUT TYPE="HIDDEN" NAME="ady" VALUE="<?echo $ady;?>">
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
  if ($UA1!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA1" VALUE="<?echo $UA1;?>">
<?
  endif;
  if ($AN1!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN1" VALUE="<?echo $AN1;?>">
<?
  endif;
  if ($A1BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A1BD" VALUE="<?echo $A1BD;?>">
<?
  endif;
  if ($A1BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A1BM" VALUE="<?echo $A1BM;?>">
<?
  endif;
  if ($A1BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A1BY" VALUE="<?echo $A1BY;?>">
<?
  endif;
  if ($A1ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A1ED" VALUE="<?echo $A1ED;?>">
<?
  endif;
  if ($A1EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A1EM" VALUE="<?echo $A1EM;?>">
<?
  endif;
  if ($A1EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A1EY" VALUE="<?echo $A1EY;?>">
<?
  endif;
  if ($UA2!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA2" VALUE="<?echo $UA2;?>">
<?
  endif;
  if ($AN2!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN2" VALUE="<?echo $AN2;?>">
<?
  endif;
  if ($A2BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A2BD" VALUE="<?echo $A2BD;?>">
<?
  endif;
  if ($A2BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A2BM" VALUE="<?echo $A2BM;?>">
<?
  endif;
  if ($A2BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A2BY" VALUE="<?echo $A2BY;?>">
<?
  endif;
  if ($A2ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A2ED" VALUE="<?echo $A2ED;?>">
<?
  endif;
  if ($A2EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A2EM" VALUE="<?echo $A2EM;?>">
<?
  endif;
  if ($A2EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A2EY" VALUE="<?echo $A2EY;?>">
<?
  endif;
  if ($UA3!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA3" VALUE="<?echo $UA3;?>">
<?
  endif;
  if ($AN3!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN3" VALUE="<?echo $AN3;?>">
<?
  endif;
  if ($A3BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A3BD" VALUE="<?echo $A3BD;?>">
<?
  endif;
  if ($A3BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A3BM" VALUE="<?echo $A3BM;?>">
<?
  endif;
  if ($A3BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A3BY" VALUE="<?echo $A3BY;?>">
<?
  endif;
  if ($A3ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A3ED" VALUE="<?echo $A3ED;?>">
<?
  endif;
  if ($A3EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A3EM" VALUE="<?echo $A3EM;?>">
<?
  endif;
  if ($A3EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A3EY" VALUE="<?echo $A3EY;?>">
<?
  endif;

  if ($UA4!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA4" VALUE="<?echo $UA4;?>">
<?
  endif;
  if ($AN4!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN4" VALUE="<?echo $AN4;?>">
<?
  endif;
  if ($A4BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A4BD" VALUE="<?echo $A4BD;?>">
<?
  endif;
  if ($A4BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A4BM" VALUE="<?echo $A4BM;?>">
<?
  endif;
  if ($A4BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A4BY" VALUE="<?echo $A4BY;?>">
<?
  endif;
  if ($A4ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A4ED" VALUE="<?echo $A4ED;?>">
<?
  endif;
  if ($A4EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A4EM" VALUE="<?echo $A4EM;?>">
<?
  endif;
  if ($A4EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A4EY" VALUE="<?echo $A4EY;?>">
<?
  endif;
  if ($UA5!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA5" VALUE="<?echo $UA5;?>">
<?
  endif;
  if ($AN5!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN5" VALUE="<?echo $AN5;?>">
<?
  endif;
  if ($A5BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A5BD" VALUE="<?echo $A5BD;?>">
<?
  endif;
  if ($A5BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A5BM" VALUE="<?echo $A5BM;?>">
<?
  endif;
  if ($A5BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A5BY" VALUE="<?echo $A5BY;?>">
<?
  endif;
  if ($A5ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A5ED" VALUE="<?echo $A5ED;?>">
<?
  endif;
  if ($A5EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A5EM" VALUE="<?echo $A5EM;?>">
<?
  endif;
  if ($A5EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A5EY" VALUE="<?echo $A5EY;?>">
<?
  endif;
  if ($UA6!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA6" VALUE="<?echo $UA6;?>">
<?
  endif;
  if ($AN6!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN6" VALUE="<?echo $AN6;?>">
<?
  endif;
  if ($A6BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A6BD" VALUE="<?echo $A6BD;?>">
<?
  endif;
  if ($A6BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A6BM" VALUE="<?echo $A6BM;?>">
<?
  endif;
  if ($A6BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A6BY" VALUE="<?echo $A6BY;?>">
<?
  endif;
  if ($A6ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A6ED" VALUE="<?echo $A6ED;?>">
<?
  endif;
  if ($A6EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A6EM" VALUE="<?echo $A6EM;?>">
<?
  endif;
  if ($A6EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A6EY" VALUE="<?echo $A6EY;?>">
<?
  endif;
  if ($UA7!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA7" VALUE="<?echo $UA7;?>">
<?
  endif;
  if ($AN7!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN7" VALUE="<?echo $AN7;?>">
<?
  endif;
  if ($A7BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A7BD" VALUE="<?echo $A7BD;?>">
<?
  endif;
  if ($A7BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A7BM" VALUE="<?echo $A7BM;?>">
<?
  endif;
  if ($A7BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A7BY" VALUE="<?echo $A7BY;?>">
<?
  endif;
  if ($A7ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A7ED" VALUE="<?echo $A7ED;?>">
<?
  endif;
  if ($A7EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A7EM" VALUE="<?echo $A7EM;?>">
<?
  endif;
  if ($A7EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A7EY" VALUE="<?echo $A7EY;?>">
<?
  endif;
  if ($UA8!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA8" VALUE="<?echo $UA8;?>">
<?
  endif;
  if ($AN8!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN8" VALUE="<?echo $AN8;?>">
<?
  endif;
  if ($A8BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A8BD" VALUE="<?echo $A8BD;?>">
<?
  endif;
  if ($A8BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A8BM" VALUE="<?echo $A8BM;?>">
<?
  endif;
  if ($A8BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A8BY" VALUE="<?echo $A8BY;?>">
<?
  endif;
  if ($A8ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A8ED" VALUE="<?echo $A8ED;?>">
<?
  endif;
  if ($A8EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A8EM" VALUE="<?echo $A8EM;?>">
<?
  endif;
  if ($A8EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A8EY" VALUE="<?echo $A8EY;?>">
<?
  endif;
  if ($UA9!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA9" VALUE="<?echo $UA9;?>">
<?
  endif;
  if ($AN9!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN9" VALUE="<?echo $AN9;?>">
<?
  endif;
  if ($A9BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A9BD" VALUE="<?echo $A9BD;?>">
<?
  endif;
  if ($A9BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A9BM" VALUE="<?echo $A9BM;?>">
<?
  endif;
  if ($A9BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A9BY" VALUE="<?echo $A9BY;?>">
<?
  endif;
  if ($A9ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A9ED" VALUE="<?echo $A9ED;?>">
<?
  endif;
  if ($A9EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A9EM" VALUE="<?echo $A9EM;?>">
<?
  endif;
  if ($A9EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A9EY" VALUE="<?echo $A9EY;?>">
<?
  endif;
  if ($UA10!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="UA10" VALUE="<?echo $UA10;?>">
<?
  endif;
  if ($AN10!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="AN10" VALUE="<?echo $AN10;?>">
<?
  endif;
  if ($A10BD!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A10BD" VALUE="<?echo $A10BD;?>">
<?
  endif;
  if ($A10BM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A10BM" VALUE="<?echo $A10BM;?>">
<?
  endif;
  if ($A10BY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A10BY" VALUE="<?echo $A10BY;?>">
<?
  endif;
  if ($A10ED!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A10ED" VALUE="<?echo $A10ED;?>">
<?
  endif;
  if ($A10EM!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A10EM" VALUE="<?echo $A10EM;?>">
<?
  endif;
  if ($A10EY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="A10EY" VALUE="<?echo $A10EY;?>">
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
    <TITLE><?echo $reports[$rep]["Наименование"];?></TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <LINK REL="previous" HREF="<?echo $base_url;?>?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;
      if ($add!=""): echo "&amp;add=$add"; endif;
      if ($adm!=""): echo "&amp;adm=$adm"; endif;
      if ($ady!=""): echo "&amp;ady=$ady"; endif;
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
      if ($UA1=="on"): echo "&amp;UA1=$UA1"; endif;
      if ($AN1!=""): echo "&amp;AN1=$AN1"; endif;
      if ($A1BD!=""): echo "&amp;A1BD=$A1BD"; endif;
      if ($A1BM!=""): echo "&amp;A1BM=$A1BM"; endif;
      if ($A1BY!=""): echo "&amp;A1BY=$A1BY"; endif;
      if ($A1ED!=""): echo "&amp;A1ED=$A1ED"; endif;
      if ($A1EM!=""): echo "&amp;A1EM=$A1EM"; endif;
      if ($A1EY!=""): echo "&amp;A1EY=$A1EY"; endif;
      if ($UA2=="on"): echo "&amp;UA2=$UA2"; endif;
      if ($AN2!=""): echo "&amp;AN2=$AN2"; endif;
      if ($A2BD!=""): echo "&amp;A2BD=$A2BD"; endif;
      if ($A2BM!=""): echo "&amp;A2BM=$A2BM"; endif;
      if ($A2BY!=""): echo "&amp;A2BY=$A2BY"; endif;
      if ($A2ED!=""): echo "&amp;A2ED=$A2ED"; endif;
      if ($A2EM!=""): echo "&amp;A2EM=$A2EM"; endif;
      if ($A2EY!=""): echo "&amp;A2EY=$A2EY"; endif;
      if ($UA3=="on"): echo "&amp;UA3=$UA3"; endif;
      if ($AN3!=""): echo "&amp;AN3=$AN3"; endif;
      if ($A3BD!=""): echo "&amp;A3BD=$A3BD"; endif;
      if ($A3BM!=""): echo "&amp;A3BM=$A3BM"; endif;
      if ($A3BY!=""): echo "&amp;A3BY=$A3BY"; endif;
      if ($A3ED!=""): echo "&amp;A3ED=$A3ED"; endif;
      if ($A3EM!=""): echo "&amp;A3EM=$A3EM"; endif;
      if ($A3EY!=""): echo "&amp;A3EY=$A3EY"; endif;
      if ($UA4=="on"): echo "&amp;UA4=$UA4"; endif;
      if ($AN4!=""): echo "&amp;AN4=$AN4"; endif;
      if ($A4BD!=""): echo "&amp;A4BD=$A4BD"; endif;
      if ($A4BM!=""): echo "&amp;A4BM=$A4BM"; endif;
      if ($A4BY!=""): echo "&amp;A4BY=$A4BY"; endif;
      if ($A4ED!=""): echo "&amp;A4ED=$A4ED"; endif;
      if ($A4EM!=""): echo "&amp;A4EM=$A4EM"; endif;
      if ($A4EY!=""): echo "&amp;A4EY=$A4EY"; endif;
      if ($UA5=="on"): echo "&amp;UA5=$UA5"; endif;
      if ($AN5!=""): echo "&amp;AN5=$AN5"; endif;
      if ($A5BD!=""): echo "&amp;A5BD=$A5BD"; endif;
      if ($A5BM!=""): echo "&amp;A5BM=$A5BM"; endif;
      if ($A5BY!=""): echo "&amp;A5BY=$A5BY"; endif;
      if ($A5ED!=""): echo "&amp;A5ED=$A5ED"; endif;
      if ($A5EM!=""): echo "&amp;A5EM=$A5EM"; endif;
      if ($A5EY!=""): echo "&amp;A5EY=$A5EY"; endif;
      if ($UA6=="on"): echo "&amp;UA6=$UA6"; endif;
      if ($AN6!=""): echo "&amp;AN6=$AN6"; endif;
      if ($A6BD!=""): echo "&amp;A6BD=$A6BD"; endif;
      if ($A6BM!=""): echo "&amp;A6BM=$A6BM"; endif;
      if ($A6BY!=""): echo "&amp;A6BY=$A6BY"; endif;
      if ($A6ED!=""): echo "&amp;A6ED=$A6ED"; endif;
      if ($A6EM!=""): echo "&amp;A6EM=$A6EM"; endif;
      if ($A6EY!=""): echo "&amp;A6EY=$A6EY"; endif;
      if ($UA7=="on"): echo "&amp;UA7=$UA7"; endif;
      if ($AN7!=""): echo "&amp;AN7=$AN7"; endif;
      if ($A7BD!=""): echo "&amp;A7BD=$A7BD"; endif;
      if ($A7BM!=""): echo "&amp;A7BM=$A7BM"; endif;
      if ($A7BY!=""): echo "&amp;A7BY=$A7BY"; endif;
      if ($A7ED!=""): echo "&amp;A7ED=$A7ED"; endif;
      if ($A7EM!=""): echo "&amp;A7EM=$A7EM"; endif;
      if ($A7EY!=""): echo "&amp;A7EY=$A7EY"; endif;
      if ($UA8=="on"): echo "&amp;UA8=$UA8"; endif;
      if ($AN8!=""): echo "&amp;AN8=$AN8"; endif;
      if ($A8BD!=""): echo "&amp;A8BD=$A8BD"; endif;
      if ($A8BM!=""): echo "&amp;A8BM=$A8BM"; endif;
      if ($A8BY!=""): echo "&amp;A8BY=$A8BY"; endif;
      if ($A8ED!=""): echo "&amp;A8ED=$A8ED"; endif;
      if ($A8EM!=""): echo "&amp;A8EM=$A8EM"; endif;
      if ($A8EY!=""): echo "&amp;A8EY=$A8EY"; endif;
      if ($UA9=="on"): echo "&amp;UA9=$UA9"; endif;
      if ($AN9!=""): echo "&amp;AN9=$AN9"; endif;
      if ($A9BD!=""): echo "&amp;A9BD=$A9BD"; endif;
      if ($A9BM!=""): echo "&amp;A9BM=$A9BM"; endif;
      if ($A9BY!=""): echo "&amp;A9BY=$A9BY"; endif;
      if ($A9ED!=""): echo "&amp;A9ED=$A9ED"; endif;
      if ($A9EM!=""): echo "&amp;A9EM=$A9EM"; endif;
      if ($A9EY!=""): echo "&amp;A9EY=$A9EY"; endif;
      if ($UA10=="on"): echo "&amp;UA10=$UA10"; endif;
      if ($AN10!=""): echo "&amp;AN10=$AN10"; endif;
      if ($A10BD!=""): echo "&amp;A10BD=$A10BD"; endif;
      if ($A10BM!=""): echo "&amp;A10BM=$A10BM"; endif;
      if ($A10BY!=""): echo "&amp;A10BY=$A10BY"; endif;
      if ($A10ED!=""): echo "&amp;A10ED=$A10ED"; endif;
      if ($A10EM!=""): echo "&amp;A10EM=$A10EM"; endif;
      if ($A10EY!=""): echo "&amp;A10EY=$A10EY"; endif;?>">
    <LINK REL="author" HREF="http://vladracoola.by.ru/index1.html">
    <STYLE MEDIA="screen, print" TYPE="text/css">
      * {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt;
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
  <BODY <?if (($DEBUG=="on")||($action=="email")):?> BGCOLOR="gainsboro"<?endif;?>>
<?
      // валидация временного промежутка
      if (($time!="yesterday")&&($time!="today")&&($time!="anotherday")): // если временной промежуток не попадает ни под один из дозволенных - вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // вывод отладочной информации в случае необходимости
      if ($DEBUG=="on"):
        PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>.");
      endif;
      // если была выбрана произвольная дата, проводим валидацию даты
      if ($time=="anotherday"):
        if (checkdate($startmonth,$startday,$startyear)<>1): // если была выбрана несуществующая дата
          ShowErrorMessage("Задана несуществующая дата: <B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))>0): // если начальная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами дата (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // валидация выбранного действия
      switch ($action):
        case "print": $s="визуальный просмотр, подготовка к сохранению на диск либо к печати"; break;
        case "email": $s="отправка по электронной почте"; break;
        default: $s=""; break;
      endswitch;
      if ($s!=""):
        if ($DEBUG=="on"):
          PrintMessage("INFORMATION", "Info", "Выбранное Вами действие - <B>$s</B>.");
        endif;
      else:
        ShowErrorMessage("Выбрано некорректое действие!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // валидация адресов электронной почты, если выбранное действие - отправка на E-Mail
      if ($action=="email"):
        if ((($EMAIL1Addr!="")||($EMAIL1Name!=""))&&($DEBUG=="on")):
          PrintMessage("INFORMATION", "Info", "Выбранные Вами параметры адресата #1 - <I>Куда:</I> <B>$EMAIL1Addr</B>, <I>Кому:</I> <B>$EMAIL1Name</B>.");
        endif;
        if ((($EMAIL2Addr!="")||($EMAIL2Name!=""))&&($DEBUG=="on")):
          PrintMessage("INFORMATION", "Info", "Выбранные Вами параметры адресата #2 - <I>Куда:</I> <B>$EMAIL2Addr</B>, <I>Кому:</I> <B>$EMAIL2Name</B>.");
        endif;
        if ((($EMAIL3Addr!="")||($EMAIL3Name!=""))&&($DEBUG=="on")):
          PrintMessage("INFORMATION", "Info", "Выбранные Вами параметры адресата #3 - <I>Куда:</I> <B>$EMAIL3Addr</B>, <I>Кому:</I> <B>$EMAIL3Name</B>.");
        endif;
        if (($EMAIL1Addr=="")&&($EMAIL2Addr=="")&&($EMAIL3Addr=="")):
          ShowErrorMessage("Не задано ни одного адресата! Вы должны указать адрес(а) электронной почты (e-mail) в поле(ях) &laquo;<B>Кому</B>&raquo;.<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // проверка наличия хотя-бы одного номера телефона, по которому необходимо формировать выгрузку
      if ((!(($UA1=="on")&&($AN1!="")))&&(!(($UA2=="on")&&($AN2!="")))&&(!(($UA3=="on")&&($AN3!="")))&&(!(($UA4=="on")&&($AN4!="")))&&(!(($UA5=="on")&&($AN5!="")))&&(!(($UA6=="on")&&($AN6!="")))&&(!(($UA7=="on")&&($AN7!="")))&&(!(($UA8=="on")&&($AN8!="")))&&(!(($UA9=="on")&&($AN9!="")))&&(!(($UA10=="on")&&($AN10!="")))):
        ShowErrorMessage("Не задано ни одного номера телефона для формирования запроса!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // формирование и вывод списка телефонов, включённых в запрос
      $phones_array=array();
      if (($UA1=="on")&&($AN1!="")):
        // валидация временного периода
        if (checkdate($A1BM,$A1BD,$A1BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №1: <B>$A1BD&nbsp;".$months2[$A1BM]."&nbsp;$A1BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A1EM,$A1ED,$A1EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №1: <B>$A1ED&nbsp;".$months2[$A1EM]."&nbsp;$A1EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A1EM,$A1ED,$A1EY)-mktime(0,0,0,$A1BM,$A1BD,$A1BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №1: начальная дата (<B>$A1BD&nbsp;".$months2[$A1BM]."&nbsp;$A1BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A1ED&nbsp;".$months2[$A1EM]."&nbsp;$A1EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A1BM,$A1BD,$A1BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A1BD&nbsp;".$months2[$A1BM]."&nbsp;$A1BY&nbsp;года</B>) в расчётном периоде для абонента №1 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A1EM,$A1ED,$A1EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A1ED&nbsp;".$months2[$A1EM]."&nbsp;$A1EY&nbsp;года</B>) в расчётном периоде для абонента №1 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN1,"День начала"=>$A1BD,"Месяц начала"=>$A1BM,"Год начала"=>$A1BY,"День окончания"=>$A1ED,"Месяц окончания"=>$A1EM,"Год окончания"=>$A1EY);
      endif;
      if (($UA2=="on")&&($AN2!="")):
        // валидация временного периода
        if (checkdate($A2BM,$A2BD,$A2BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №2: <B>$A2BD&nbsp;".$months2[$A2BM]."&nbsp;$A2BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A2EM,$A2ED,$A2EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №2: <B>$A2ED&nbsp;".$months2[$A2EM]."&nbsp;$A2EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A2EM,$A2ED,$A2EY)-mktime(0,0,0,$A2BM,$A2BD,$A2BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №2: начальная дата (<B>$A2BD&nbsp;".$months2[$A2BM]."&nbsp;$A2BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A2ED&nbsp;".$months2[$A2EM]."&nbsp;$A2EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A2BM,$A2BD,$A2BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A2BD&nbsp;".$months2[$A2BM]."&nbsp;$A2BY&nbsp;года</B>) в расчётном периоде для абонента №2 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A2EM,$A2ED,$A2EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A2ED&nbsp;".$months2[$A2EM]."&nbsp;$A2EY&nbsp;года</B>) в расчётном периоде для абонента №2 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN2,"День начала"=>$A2BD,"Месяц начала"=>$A2BM,"Год начала"=>$A2BY,"День окончания"=>$A2ED,"Месяц окончания"=>$A2EM,"Год окончания"=>$A2EY);
      endif;
      if (($UA3=="on")&&($AN3!="")):
        // валидация временного периода
        if (checkdate($A3BM,$A3BD,$A3BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №3: <B>$A3BD&nbsp;".$months2[$A3BM]."&nbsp;$A3BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A3EM,$A3ED,$A3EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №3: <B>$A3ED&nbsp;".$months2[$A3EM]."&nbsp;$A3EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A3EM,$A3ED,$A3EY)-mktime(0,0,0,$A3BM,$A3BD,$A3BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №3: начальная дата (<B>$A3BD&nbsp;".$months2[$A3BM]."&nbsp;$A3BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A3ED&nbsp;".$months2[$A3EM]."&nbsp;$A3EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A3BM,$A3BD,$A3BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A3BD&nbsp;".$months2[$A3BM]."&nbsp;$A3BY&nbsp;года</B>) в расчётном периоде для абонента №3 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A3EM,$A3ED,$A3EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A3ED&nbsp;".$months2[$A3EM]."&nbsp;$A3EY&nbsp;года</B>) в расчётном периоде для абонента №3 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN3,"День начала"=>$A3BD,"Месяц начала"=>$A3BM,"Год начала"=>$A3BY,"День окончания"=>$A3ED,"Месяц окончания"=>$A3EM,"Год окончания"=>$A3EY);
      endif;
      if (($UA4=="on")&&($AN4!="")):
        // валидация временного периода
        if (checkdate($A4BM,$A4BD,$A4BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №4: <B>$A4BD&nbsp;".$months2[$A4BM]."&nbsp;$A4BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A4EM,$A4ED,$A4EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №4: <B>$A4ED&nbsp;".$months2[$A4EM]."&nbsp;$A4EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A4EM,$A4ED,$A4EY)-mktime(0,0,0,$A4BM,$A4BD,$A4BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №4: начальная дата (<B>$A4BD&nbsp;".$months2[$A4BM]."&nbsp;$A4BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A4ED&nbsp;".$months2[$A4EM]."&nbsp;$A4EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A4BM,$A4BD,$A4BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A4BD&nbsp;".$months2[$A4BM]."&nbsp;$A4BY&nbsp;года</B>) в расчётном периоде для абонента №4 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A4EM,$A4ED,$A4EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A4ED&nbsp;".$months2[$A4EM]."&nbsp;$A4EY&nbsp;года</B>) в расчётном периоде для абонента №4 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN4,"День начала"=>$A4BD,"Месяц начала"=>$A4BM,"Год начала"=>$A4BY,"День окончания"=>$A4ED,"Месяц окончания"=>$A4EM,"Год окончания"=>$A4EY);
      endif;
      if (($UA5=="on")&&($AN5!="")):
        // валидация временного периода
        if (checkdate($A5BM,$A5BD,$A5BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №5: <B>$A5BD&nbsp;".$months2[$A5BM]."&nbsp;$A5BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A5EM,$A5ED,$A5EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №5: <B>$A5ED&nbsp;".$months2[$A5EM]."&nbsp;$A5EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A5EM,$A5ED,$A5EY)-mktime(0,0,0,$A5BM,$A5BD,$A5BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №5: начальная дата (<B>$A5BD&nbsp;".$months2[$A5BM]."&nbsp;$A5BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A5ED&nbsp;".$months2[$A5EM]."&nbsp;$A5EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A5BM,$A5BD,$A5BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A5BD&nbsp;".$months2[$A5BM]."&nbsp;$A5BY&nbsp;года</B>) в расчётном периоде для абонента №5 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A5EM,$A5ED,$A5EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A5ED&nbsp;".$months2[$A5EM]."&nbsp;$A5EY&nbsp;года</B>) в расчётном периоде для абонента №5 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN5,"День начала"=>$A5BD,"Месяц начала"=>$A5BM,"Год начала"=>$A5BY,"День окончания"=>$A5ED,"Месяц окончания"=>$A5EM,"Год окончания"=>$A5EY);
      endif;
      if (($UA6=="on")&&($AN6!="")):
        // валидация временного периода
        if (checkdate($A6BM,$A6BD,$A6BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №6: <B>$A6BD&nbsp;".$months2[$A6BM]."&nbsp;$A6BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A6EM,$A6ED,$A6EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №6: <B>$A6ED&nbsp;".$months2[$A6EM]."&nbsp;$A6EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A6EM,$A6ED,$A6EY)-mktime(0,0,0,$A6BM,$A6BD,$A6BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №6: начальная дата (<B>$A6BD&nbsp;".$months2[$A6BM]."&nbsp;$A6BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A6ED&nbsp;".$months2[$A6EM]."&nbsp;$A6EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A6BM,$A6BD,$A6BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A6BD&nbsp;".$months2[$A6BM]."&nbsp;$A6BY&nbsp;года</B>) в расчётном периоде для абонента №6 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A6EM,$A6ED,$A6EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A6ED&nbsp;".$months2[$A6EM]."&nbsp;$A6EY&nbsp;года</B>) в расчётном периоде для абонента №6 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN6,"День начала"=>$A6BD,"Месяц начала"=>$A6BM,"Год начала"=>$A6BY,"День окончания"=>$A6ED,"Месяц окончания"=>$A6EM,"Год окончания"=>$A6EY);
      endif;
      if (($UA7=="on")&&($AN7!="")):
        // валидация временного периода
        if (checkdate($A7BM,$A7BD,$A7BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №7: <B>$A7BD&nbsp;".$months2[$A7BM]."&nbsp;$A7BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A7EM,$A7ED,$A7EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №7: <B>$A7ED&nbsp;".$months2[$A7EM]."&nbsp;$A7EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A7EM,$A7ED,$A7EY)-mktime(0,0,0,$A7BM,$A7BD,$A7BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №7: начальная дата (<B>$A7BD&nbsp;".$months2[$A7BM]."&nbsp;$A7BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A7ED&nbsp;".$months2[$A7EM]."&nbsp;$A7EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A7BM,$A7BD,$A7BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A7BD&nbsp;".$months2[$A7BM]."&nbsp;$A7BY&nbsp;года</B>) в расчётном периоде для абонента №7 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A7EM,$A7ED,$A7EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A7ED&nbsp;".$months2[$A7EM]."&nbsp;$A7EY&nbsp;года</B>) в расчётном периоде для абонента №7 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN7,"День начала"=>$A7BD,"Месяц начала"=>$A7BM,"Год начала"=>$A7BY,"День окончания"=>$A7ED,"Месяц окончания"=>$A7EM,"Год окончания"=>$A7EY);
      endif;
      if (($UA8=="on")&&($AN8!="")):
        // валидация временного периода
        if (checkdate($A8BM,$A8BD,$A8BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №8: <B>$A8BD&nbsp;".$months2[$A8BM]."&nbsp;$A8BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A8EM,$A8ED,$A8EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №8: <B>$A8ED&nbsp;".$months2[$A8EM]."&nbsp;$A8EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A8EM,$A8ED,$A8EY)-mktime(0,0,0,$A8BM,$A8BD,$A8BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №8: начальная дата (<B>$A8BD&nbsp;".$months2[$A8BM]."&nbsp;$A8BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A8ED&nbsp;".$months2[$A8EM]."&nbsp;$A8EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A8BM,$A8BD,$A8BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A8BD&nbsp;".$months2[$A8BM]."&nbsp;$A8BY&nbsp;года</B>) в расчётном периоде для абонента №8 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A8EM,$A8ED,$A8EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A8ED&nbsp;".$months2[$A8EM]."&nbsp;$A8EY&nbsp;года</B>) в расчётном периоде для абонента №8 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN8,"День начала"=>$A8BD,"Месяц начала"=>$A8BM,"Год начала"=>$A8BY,"День окончания"=>$A8ED,"Месяц окончания"=>$A8EM,"Год окончания"=>$A8EY);
      endif;
      if (($UA9=="on")&&($AN9!="")):
        // валидация временного периода
        if (checkdate($A9BM,$A9BD,$A9BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №9: <B>$A9BD&nbsp;".$months2[$A9BM]."&nbsp;$A9BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A9EM,$A9ED,$A9EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №9: <B>$A9ED&nbsp;".$months2[$A9EM]."&nbsp;$A9EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A9EM,$A9ED,$A9EY)-mktime(0,0,0,$A9BM,$A9BD,$A9BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №9: начальная дата (<B>$A9BD&nbsp;".$months2[$A9BM]."&nbsp;$A9BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A9ED&nbsp;".$months2[$A9EM]."&nbsp;$A9EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A9BM,$A9BD,$A9BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A9BD&nbsp;".$months2[$A9BM]."&nbsp;$A9BY&nbsp;года</B>) в расчётном периоде для абонента №9 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A9EM,$A9ED,$A9EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A9ED&nbsp;".$months2[$A9EM]."&nbsp;$A9EY&nbsp;года</B>) в расчётном периоде для абонента №9 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN9,"День начала"=>$A9BD,"Месяц начала"=>$A9BM,"Год начала"=>$A9BY,"День окончания"=>$A9ED,"Месяц окончания"=>$A9EM,"Год окончания"=>$A9EY);
      endif;
      if (($UA10=="on")&&($AN10!="")):
        // валидация временного периода
        if (checkdate($A10BM,$A10BD,$A10BY)<>1): // если была выбрана несуществующая начальная дата
          ShowErrorMessage("Задана несуществующая начальная дата в расчётном периоде для абонента №10: <B>$A10BD&nbsp;".$months2[$A10BM]."&nbsp;$A10BY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (checkdate($A10EM,$A10ED,$A10EY)<>1): // если была выбрана несуществующая конечная дата
          ShowErrorMessage("Задана несуществующая конечная дата в расчётном периоде для абонента №10: <B>$A10ED&nbsp;".$months2[$A10EM]."&nbsp;$A10EY&nbsp;года</B>!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A10EM,$A10ED,$A10EY)-mktime(0,0,0,$A10BM,$A10BD,$A10BY))<0): // если начальная дата позднее, чем конечная
          ShowErrorMessage("Задан некорректный диапазон дат в расчётном периоде для абонента №10: начальная дата (<B>$A10BD&nbsp;".$months2[$A10BM]."&nbsp;$A10BY&nbsp;года</B>) является более поздней, чем конечная дата (<B>$A10ED&nbsp;".$months2[$A10EM]."&nbsp;$A10EY&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A10BM,$A10BD,$A10BY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если начальная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами начальная дата (<B>$A10BD&nbsp;".$months2[$A10BM]."&nbsp;$A10BY&nbsp;года</B>) в расчётном периоде для абонента №10 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$A10EM,$A10ED,$A10EY)-mktime(0,0,0,$ldm,$ldd,$ldy))>0): // если конечная "указанная" дата больше, чем вчерашняя, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Выбранная вами конечная дата (<B>$A10ED&nbsp;".$months2[$A10EM]."&nbsp;$A10EY&nbsp;года</B>) в расчётном периоде для абонента №10 больше вчерашней (<B>$ldd&nbsp;".$months2[$ldm]."&nbsp;$ldy&nbsp;года</B>)!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $phones_array[]=array("Телефон"=>$AN10,"День начала"=>$A10BD,"Месяц начала"=>$A10BM,"Год начала"=>$A10BY,"День окончания"=>$A10ED,"Месяц окончания"=>$A10EM,"Год окончания"=>$A10EY);
      endif;
      $s="";
      foreach ($phones_array as $i):
        $s.="<BR>&nbsp;&nbsp;телефон ".$i["Телефон"].", период с ".$i["День начала"]." ".$months2[$i["Месяц начала"]]." ".$i["Год начала"]." по ".$i["День окончания"]." ".$months2[$i["Месяц окончания"]]." ".$i["Год окончания"];
      endforeach;
      if ($DEBUG=="on"):
        PrintMessage("INFORMATION", "Info", "Список номеров телефонов и периодов, включённых в обсчёт:<B>$s</B>.");
      endif;
      // подключение к MySQL-серверу
      $HostName="10.1.1.240";
      $UserName="overseer";
      $Password="";
      $DBName="ird";
      $MySQLConnection=@mysql_connect($HostName,$UserName,$Password);
      if ($MySQLConnection==FALSE):
        ShowErrorMessage("Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if (@mysql_select_db("$DBName")==FALSE):
        ShowErrorMessage("Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>."); endif;
      // проверка наличия таблиц БД
      $q="SHOW TABLES FROM ird LIKE 'ird\_%';";
      if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows<1):
        ShowErrorMessage("Не найдено ни одной таблицы данных в БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // первоначальная инициализация переменной
      $b=TRUE;
      $ird_founded=array();
      $ird_failed=array();
      // помещаем в нумерованный массив $result_array список всех найденых таблиц ird_ггггммдд
      for ($i=0;$i<($num_rows);$i++):
        $tmp_array=mysql_fetch_array($table, MYSQL_NUM);
        $ird_founded[]=$tmp_array[0];
      endfor;
      for ($l=0;$l<count($phones_array);$l++):
        $i=$phones_array[$l];
        // подсчитываем количество дней, входящий в период и помещаем его в переменную $daycount
        $j=mktime(0,0,0,$i["Месяц окончания"]+0,$i["День окончания"]+0,$i["Год окончания"]+0)-mktime(0,0,0,$i["Месяц начала"]+0,$i["День начала"]+0,$i["Год начала"]+0);
        $daycount=0;
        while ($j>=-3600):
          $daycount++;
          $j=$j-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
        endwhile;
        if ($DEBUG=="on"): PrintMessage("SUCCESS", "Инфо", "Количество дней входящих в расчётный период для телефона № <B>".$i['Телефон']."</B>: <B>".$daycount."</B>."); endif;
        // формирование списка файлов, необходимых для запроса по очередному номеру телефона
        $ird_must=array();
        // заполнение массива НЕОБХОДИМЫХ файлов
        $k=mktime(6,0,0,$i["Месяц начала"]+0,$i["День начала"]+0,$i["Год начала"]+0);
        for ($j=0; $j<$daycount; $j++):
          $cd=date("d",$k)+0;
          if ($cd<10): $cd="0".$cd; endif;
          $cm=date("m",$k)+0;
          if ($cm<10): $cm="0".$cm; endif;
          $cy=date("Y",$k)+0;
          $ird_must[]="ird_".$cy.$cm.$cd;
          $k=$k+(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
        endfor;
        // формирование массива недостающих таблиц
        foreach ($ird_must as $j):
          if (!(in_array($j, $ird_founded))):
            if (!(in_array($j, $ird_failed))):
              $ird_failed[]=$j;
            endif;
            $b=FALSE;
          endif;
        endforeach;
      endfor;
      if ($b==FALSE):
        // вывод ошибки при отсутствии некоторых таблиц БД
        $s="Не удалось найти следующие таблицы базы данных <B>$DBName</B> на MySQL-сервере <B>$HostName</B>:";
        sort($ird_failed);
        foreach ($ird_failed as $i):
          $s.="<BR>".$i;
        endforeach;
        ShowErrorMessage("$s<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $add, $adm, $ady, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $UA1, $AN1, $A1BD, $A1BM, $A1BY, $A1ED, $A1EM, $A1EY, $UA2, $AN2, $A2BD, $A2BM, $A2BY, $A2ED, $A2EM, $A2EY, $UA3, $AN3, $A3BD, $A3BM, $A3BY, $A3ED, $A3EM, $A3EY, $UA4, $AN4, $A4BD, $A4BM, $A4BY, $A4ED, $A4EM, $A4EY, $UA5, $AN5, $A5BD, $A5BM, $A5BY, $A5ED, $A5EM, $A5EY, $UA6, $AN6, $A6BD, $A6BM, $A6BY, $A6ED, $A6EM, $A6EY, $UA7, $AN7, $A7BD, $A7BM, $A7BY, $A7ED, $A7EM, $A7EY, $UA8, $AN8, $A8BD, $A8BM, $A8BY, $A8ED, $A8EM, $A8EY, $UA9, $AN9, $A9BD, $A9BM, $A9BY, $A9ED, $A9EM, $A9EY, $UA10, $AN10, $A10BD, $A10BM, $A10BY, $A10ED, $A10EM, $A10EY);
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // к этому моменту все проверки выполнены, все необходимые файлы найдены
      // можно заняться получением результатов запросов и формированием тела отчёта
      $bodymessage2="";
      $bodymessage1="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"100px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"100px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"100px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"100px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"256px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"3\" STYLE=\"border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 0px 0px; font-size: 8pt; text-align: left;\">Министерство связи и информатизации РБ<BR>РУП &laquo;Белтелеком&raquo;<BR>Информационно-расчётный центр<BR>220030, г. Минск, ул. К. Маркса, 24<BR><U>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear</U>&nbsp;№&nbsp;<U>26-03-117/01-11</U></TD>
          <TD COLSPAN=\"2\" STYLE=\"border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 0px 1px; font-size: 8pt; text-align: right;\">Начальнику справочно-информационного цеха<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;<BR>Степановой М.Н.<BR>&nbsp;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"5\" STYLE=\"border-color: white; border-width: 0; text-align: justify; font-size: 8pt; padding: 50px 0px 10px 0px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Прошу предоставить информацию о наличии соединений по услуге &laquo;СИС МГТС&raquo; по следующим номерам телефонов:</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"4\" STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Запрос</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Ответ</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 1px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">№ п/п</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 1px 2px 1px; border-color: black; font-weight: bold; padding: 2px;\">№ телефона</TD>
          <TD COLSPAN=\"2\" STYLE=\"text-align: center; border-width: 0px 2px 2px 1px; border-color: black; font-weight: bold; padding: 2px;\">Период</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Наличие соединений</TD>
        </TR>
";
      for ($l=0;$l<count($phones_array);$l++):
        $i=$phones_array[$l];
        // подсчитываем количество дней, входящий в период и помещаем его в переменную $daycount
        $j=mktime(0,0,0,$i["Месяц окончания"]+0,$i["День окончания"]+0,$i["Год окончания"]+0)-mktime(0,0,0,$i["Месяц начала"]+0,$i["День начала"]+0,$i["Год начала"]+0);
        $daycount=0;
        while ($j>=-3600):
          $daycount++;
          $j=$j-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
        endwhile;
        // формирование списка файлов, необходимых для запроса по очередному номеру телефона
        $ird_must=array();
        // заполнение массива НЕОБХОДИМЫХ файлов
        $k=mktime(6,0,0,$i["Месяц начала"]+0,$i["День начала"]+0,$i["Год начала"]+0);
        for ($j=0; $j<$daycount; $j++):
          $cd=date("d",$k)+0;
          if ($cd<10): $cd="0".$cd; endif;
          $cm=date("m",$k)+0;
          if ($cm<10): $cm="0".$cm; endif;
          $cy=date("Y",$k)+0;
          $ird_must[]="ird_".$cy.$cm.$cd;
          $k=$k+(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
        endfor;
        // составляем текст запроса
        $q="";
        for ($j=0;$j<count($ird_must);$j++):
          $q.="SELECT ani, ddi, datum, vrijeme, v_mreza, dur FROM ird.".$ird_must[$j]." WHERE ani LIKE '%".$i['Телефон']."' AND v_mreza>'' ";
          if ($j<(count($ird_must)-1)): $q.=" UNION "; else: $q.=";"; endif;
        endfor;
        if ($DEBUG=="on"): PrintMessage("QUERY", "SQL", $q); endif;
        // выполняем запрос
        $table=mysql_query($q);
        // получаем количество элементов результата запроса
        $num_rows=mysql_num_rows($table);
        if ($DEBUG=="on"): PrintMessage("INFORMATION", "SQL", 'Количество строк результата: '.$num_rows.'.'); endif;
        // добавляем ведущие нули к дням и месяцам при необходимости
        if (($i["День начала"]+0)<10): $i["День начала"]="0".($i["День начала"]+0); endif;
        if (($i["Месяц начала"]+0)<10): $i["Месяц начала"]="0".($i["Месяц начала"]+0); endif;
        if (($i["День окончания"]+0)<10): $i["День окончания"]="0".($i["День окончания"]+0); endif;
        if (($i["Месяц окончания"]+0)<10): $i["Месяц окончания"]="0".($i["Месяц окончания"]+0); endif;
        $bodymessage1.="        <TR>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 0px 1px ".(1+($l==count($phones_array)-1))."px 2px; border-color: black; padding: 2px;\">".($l+1)."</TD>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 0px 1px ".(1+($l==count($phones_array)-1))."px 1px; border-color: black; padding: 2px;\">".$i['Телефон']."</TD>
          <TD STYLE=\"text-align: left; border-width: 0px 1px 1px 1px; border-color: black; padding: 2px 2px 2px 5px;\">Начало</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 1px 1px; border-color: black; padding: 2px;\">".$i["День начала"].".".$i["Месяц начала"].".".$i["Год начала"]."</TD>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 0px 2px ".(1+($l==count($phones_array)-1))."px 0px; border-color: black; padding: 2px;\">";
        if ($num_rows>=1):
          $bodymessage1.="Соединения присутствуют, см. приложение";
          // формирование списка звонков для очередного телефона
          $bodymessage2.="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"100px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"80px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"156px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"80px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"80px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"80px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"80px\"></TD>
        </TR>
        <TR>
          <TD COLSPAN=\"7\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 8pt; font-weight: bold; padding: 10px 0px 5px 0px;\">Статистика звонков с номера телефона ".$phones_array[$l]["Телефон"].", период с ".$phones_array[$l]["День начала"]." ".$months2[$phones_array[$l]["Месяц начала"]]." ".$phones_array[$l]["Год начала"]." по ".$phones_array[$l]["День окончания"]." ".$months2[$phones_array[$l]["Месяц окончания"]]." ".$phones_array[$l]["Год окончания"]."</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; padding: 2px;\">Номер телефона абонента</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Номер услуги</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Наименование услуги</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Дата звонка</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Время звонка</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Время ответа платформы</TD>
          <TD STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; padding: 2px;\">Длительность соединения</TD>
        </TR>
";
          for ($k=0;$k<$num_rows;$k++):
            $tmp_array=mysql_fetch_array($table, MYSQL_NUM);
            if ($tmp_array[1]=='1111'):
              $tmp_array[1]='099';
            endif;
            $bodymessage2.="        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 2px; border-color: black; padding: 2px;\">".$tmp_array[0]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 0px; border-color: black; padding: 2px;\">".$tmp_array[1]."</TD>
          <TD STYLE=\"text-align: left; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 0px; border-color: black; padding: 2px 2px 2px 5px;\">".$services[$tmp_array[1]]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 0px; border-color: black; padding: 2px;\">".$tmp_array[2]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 0px; border-color: black; padding: 2px;\">".$tmp_array[3]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 0px; border-color: black; padding: 2px;\">".$tmp_array[4]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($k==$num_rows-1))."px 0px; border-color: black; padding: 2px;\">".$tmp_array[5]."</TD>
        </TR>
";
          endfor;
          $bodymessage2.="      </TBODY>
    </TABLE>
    </CENTER>
";
        else:
          $bodymessage1.="Соединения отсутствуют";
        endif;
        $bodymessage1.="</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: left; border-width: 0px 1px ".(1+($l==count($phones_array)-1))."px 1px; border-color: black; padding: 2px 2px 2px 5px;\">Окончание</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($l==count($phones_array)-1))."px 1px; border-color: black; padding: 2px;\">".$i["День окончания"].".".$i["Месяц окончания"].".".$i["Год окончания"]."</TD>
        </TR>
";        
      endfor;
      $bodymessage1.="        <TR>
          <TD COLSPAN=\"4\" STYLE=\"border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 0px 0px; font-size: 7pt; text-align: left; padding: 30px 0px 50px 0px;\">Начальник цеха расчётов<BR>Борбат Н.Н.</TD>
          <TD STYLE=\"border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 0px 1px; font-size: 7pt; text-align: right; padding: 30px 0px 50px 0px;\">Начальник СИЦ филиала &laquo;МГТС&raquo;<BR>Степанова М.Н.</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      if ($bodymessage2!=""):
        $bodymessage2.="        <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD COLSPAN=\"7\" STYLE=\"border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 0px 0px; font-size: 7pt; text-align: left; padding: 30px 0px 0px 0px;\">";
          if (($maker!="")||($makerstate!="")||($makerphone!="")):
            $bodymessage2.="Исполнитель:";
          endif;
          if ($makerstate!=""):
            $bodymessage2.="<BR>$makerstate";
          endif;
          if ($maker!="") $bodymessage2.="<BR>$maker";
          if ($makerphone!="") $bodymessage2.="<BR>$makerphone";
          $bodymessage2.="</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
        $bodymessage1.="    <!--P STYLE=\"page-break-after: always;\"></P-->
".$bodymessage2;
      endif;
      if ($action=="print"):
        if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Выполняется вывод отчёта на экран для просмотра/печати. Рабочая область отчёта закрашена белым цветом."); endif;
        echo $bodymessage1;
      elseif ($action=="email"):
        if ($DEBUG=="on"): PrintMessage("INFORMATION", "Info", "Выполняется отправка отчёта указанным адресатам (см. выше)."); endif;
        $message="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<HTML>
  <HEAD>
    <TITLE>".$reports[$rep]["Наименование"]."</TITLE>
    <META CONTENT=\"no-cache\" HTTP-EQUIV=\"pragma\">
    <META CONTENT=\"no-cache\" HTTP-EQUIV=\"cache-control\">
    <META CONTENT=\"Dynamic\" NAME=\"Document-state\">
    <META CONTENT=\"text/html; charset=Windows-1251\" HTTP-EQUIV=\"Content-Type\">
    <LINK REL=\"author\" HREF=\"http://vladracoola.by.ru/index1.html\">
    <STYLE MEDIA=\"screen, print\" TYPE=\"text/css\">
      * {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 8pt;
        padding: 0;
        margin: 0;
        border-color: transparent;
        border-width: 0;
        border-style: solid;
        }
      TABLE, TD {
        border-style: solid;
      }
    </STYLE>
  </HEAD>
  <BODY>
".$bodymessage1."
  </BODY>
</HTML>";
        $s="";
        // отправка писем адресатам в случае если был выбран соответствующий пункт и заполнены поля адресатов
        if (($EMAIL1Addr!="")&&($action=="email")&&($message!="")):
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
          if ($EMAIL1Name!=""): $Headers.="\"$EMAIL1Name\" "; endif;
          $Headers.="<$EMAIL1Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL1Addr",$Subject,$message,$Headers)):
            if ($EMAIL1Name!=""): $s=" <B>$EMAIL1Name</B>"; endif;
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL1Addr</B> прошла успешно.");
          else:
            if ($EMAIL1Name!=""): $s=" <B>$EMAIL1Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL1Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
        if (($EMAIL2Addr!="")&&($action=="email")&&($message!="")):
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
          if ($EMAIL2Name!=""): $Headers.="\"$EMAIL2Name\" "; endif;
          $Headers.="<$EMAIL2Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL2Addr",$Subject,$message,$Headers)):
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL2Addr</B> прошла успешно.");
          else:
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL2Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
        if (($EMAIL3Addr!="")&&($action=="email")&&($message!="")):
          $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: ";
          if ($EMAIL3Name!=""): $Headers.="\"$EMAIL3Name\" "; endif;
          $Headers.="<$EMAIL3Addr>\nContent-Type: text/html; charset=Windows-1251";
          if (mail("$EMAIL3Addr",$Subject,$message,$Headers)):
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL3Addr</B> прошла успешно.");
          else:
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL3Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!", $rep, $time, $aqq, $aqy, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC);
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
      endif;
      mysql_close($MySQLConnection);
      if ($DEBUG=="on"): PrintMessage("SUCCESS", "My-SQL", "Выполнено отключение от MySQL-сервера <B>$HostName</B>."); endif;
?>
  </BODY>
</HTML>
