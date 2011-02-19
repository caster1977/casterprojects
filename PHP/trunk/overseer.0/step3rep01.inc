<?
$DEBUG="off";
function PrintMessage($at, $as, $bs)
{
  global $DEBUG;
  if ($DEBUG=="on"):
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
  endif;
}

function ShowErrorMessage($as)
{
  global $rep, $time, $amm, $amy, $abd, $abm, $aby, $aed, $aem, $aey, $C009, $C075, $C088, $C090, $C091, $C092, $C093, $C094, $C095, $C096, $C097, $C098, $C099, $C9900911, $C9909111, $C9909911, $C99075, $C99088, $C99090, $C99091, $C99092, $C99093, $C99094, $C99095, $C99096, $C99097, $CHECK_ALL_VOICE, $CHECK_ALL_AUTO, $maker, $makerstate, $makerphone, $action, $EMAIL1Addr, $EMAIL1Name, $EMAIL2Addr, $EMAIL2Name, $EMAIL3Addr, $EMAIL3Name, $RECALC, $HIDECALLSTOPAY;
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
  if ($abd!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?echo $abd;?>">
<?
  endif;
  if ($abm!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?echo $abm;?>">
<?
  endif;
  if ($aby!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?echo $aby;?>">
<?
  endif;
  if ($aed!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?echo $aed;?>">
<?
  endif;
  if ($aem!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?echo $aem;?>">
<?
  endif;
  if ($aey!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?echo $aey;?>">
<?
  endif;
  if ($C009!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C009" VALUE="<?echo $C009;?>">
<?
  endif;
  if ($C075!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C075" VALUE="<?echo $C075;?>">
<?
  endif;
  if ($C088!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C088" VALUE="<?echo $C088;?>">
<?
  endif;
  if ($C090!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C090" VALUE="<?echo $C090;?>">
<?
  endif;
  if ($C091!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C091" VALUE="<?echo $C091;?>">
<?
  endif;
  if ($C092!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C092" VALUE="<?echo $C092;?>">
<?
  endif;
  if ($C093!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C093" VALUE="<?echo $C093;?>">
<?
  endif;
  if ($C094!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C094" VALUE="<?echo $C094;?>">
<?
  endif;
  if ($C095!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C095" VALUE="<?echo $C095;?>">
<?
  endif;
  if ($C096!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C096" VALUE="<?echo $C096;?>">
<?
  endif;

  if ($C097!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C097" VALUE="<?echo $C097;?>">
<?
  endif;
  if ($C098!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C098" VALUE="<?echo $C098;?>">
<?
  endif;
  if ($C099!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C099" VALUE="<?echo $C099;?>">
<?
  endif;
  if ($C9900911!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C9900911" VALUE="<?echo $C9900911;?>">
<?
  endif;
  if ($C9909111!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C9909111" VALUE="<?echo $C9909111;?>">
<?
  endif;
  if ($C9909911!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C9909911" VALUE="<?echo $C9909911;?>">
<?
  endif;
  if ($C99075!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99075" VALUE="<?echo $C99075;?>">
<?
  endif;
  if ($C99088!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99088" VALUE="<?echo $C99088;?>">
<?
  endif;
  if ($C99090!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99090" VALUE="<?echo $C99090;?>">
<?
  endif;
  if ($C99091!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99091" VALUE="<?echo $C99091;?>">
<?
  endif;
  if ($C99092!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99092" VALUE="<?echo $C99092;?>">
<?
  endif;
  if ($C99093!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99093" VALUE="<?echo $C99093;?>">
<?
  endif;
  if ($C99094!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99094" VALUE="<?echo $C99094;?>">
<?
  endif;
  if ($C99095!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99095" VALUE="<?echo $C99095;?>">
<?
  endif;
  if ($C99096!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99096" VALUE="<?echo $C99096;?>">
<?
  endif;
  if ($C99097!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="C99097" VALUE="<?echo $C99097;?>">
<?
  endif;
  if ($CHECK_ALL_VOICE!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_VOICE" VALUE="<?echo $CHECK_ALL_VOICE;?>">
<?
  endif;
  if ($CHECK_ALL_AUTO!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_AUTO" VALUE="<?echo $CHECK_ALL_AUTO;?>">
<?
  endif;
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
  if ($HIDECALLSTOPAY!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="HIDECALLSTOPAY" VALUE="<?echo $HIDECALLSTOPAY;?>">
<?
  endif;
  if ($net_type!=""):
?>
              <INPUT TYPE="HIDDEN" NAME="net_type" VALUE="<?echo $net_type;?>">
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

function PrepareData($YYYYMMDD, $abonent_type, $service, $timetype)
// функция заносит в таблицу данных overseer.rep1 данные за указанный день по указанному типу абонентов и указанной услуге
// $timetype - время суток ("d","n","") - день, ночь, сутки целиком
{
  global $RECALC, $DEBUG, $rep, $service_types, $abonent_types, $months2, $DBName, $HostName;
  $dataexist=2;
  if ($RECALC!="on"):
    $q="SELECT COUNT(*) FROM overseer.rep".$rep." WHERE DATE_FORMAT(date_of_calls,'%Y%m%d')='".$YYYYMMDD."' AND service='".$service."' AND abonent_type='".$abonent_type."' AND timetype='".$timetype."';";
    PrintMessage("QUERY", "SQL", $q);
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($timetype=="d"):
      $s="за дневную смену ";
    elseif ($timetype=="n"):
      $s="за ночную смену ";
    else:
      $s="";
    endif;       
    if ($num_rows==1):
      PrintMessage("SUCCESS", "My-SQL", "Данные по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> успешно найдены в таблице <B>overseer.rep".$rep."</B>.");
    else:
      // произошёл сбой при попытке удаления некорректных данных из таблицы данных overseer.rep1
      ShowErrorMessage("Произошёл сбой при попытке получения данных из таблицы <B>overseer.rep".$rep."</B> по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    $row = mysql_fetch_row($table);
    if ($row[0]=="0"):
      // данные за указанный день по указанной услуге не найдены
      $dataexist=0;
    elseif ($row[0]==1):
      // данные за указанный день по указанной услуге в таблице данных overseer.rep1 найдены успешно
      $dataexist=1;
    elseif ($row[0]>1):
      // произошла ошибка при поиске данных по указанной услуге - найдено несколько строк данных вместо одной
      PrintMessage("ERROR", "My-SQL", "Вместо ожидаемой одной строки, в таблице данных <B>overseer.rep1</B> было найдено <B>".$row[0]."</B> строк данных. Будет произведено удаление всех этих данных во избежание дальнейших ошибок.");
      // необходимо удалить все строки из таблицы данных overseer.rep1 и проверить их удаление
      $q="DELETE FROM overseer.rep".$rep." WHERE DATE_FORMAT(date_of_calls,'%Y%m%d')='".$YYYYMMDD."' AND service='".$service."' AND abonent_type='".$abonent_type."' AND timetype='".$timetype."';";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      if (mysql_affected_rows==$row[0]):
        PrintMessage("SUCCESS", "My-SQL", "Все некорректные данные были успешно удалены.");
        $dataexist=0;        
      else:
        // произошёл сбой при попытке удаления некорректных данных из таблицы данных overseer.rep1
        ShowErrorMessage("Произошёл сбой при попытке удаления некорректных (дублированных) данных по абоненту <B>".$abonent_type."</B> за <B>".substr($YYYYMMDD,6,2)." ".$months2[((substr($YYYYMMDD,4,2))+0)]." ".substr($YYYYMMDD,0,4)." года</B> из таблицы данных <B>overseer.rep1</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    else:
      // произошёл сбой при попытке получения данных из таблицы данных overseer.rep1
      ShowErrorMessage("Произошёл сбой при попытке получения данных по абоненту <B>".$abonent_type."</B> за <B>".substr($YYYYMMDD,6,2)." ".$months2[((substr($YYYYMMDD,4,2))+0)]." ".substr($YYYYMMDD,0,4)." года</B> из таблицы данных <B>overseer.rep1</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
  endif;
  // если данные не найдены или нужно проводить перерасчёт данных - выясняем, все ли исходные таблицы имеются в базе данных
  if (($dataexist==0)||($RECALC=="on")):
    // проверяем наличия требующейся таблицы ird.ird_ггггммдд
    $q="SHOW TABLES FROM ird LIKE 'ird\_".$YYYYMMDD."';";
    PrintMessage("QUERY", "SQL", $q);
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($num_rows==1):
      $ird_type="d"; // флаг, означающий, что найдена подневная таблица
    else:
      // если таблица не найдена
      PrintMessage("ERROR", "My-SQL", "Подневная таблица данных <B>ird_".$YYYYMMDD."</B> в БД <B>ird</B> на MySQL-сервере <B>$HostName</B> не найдена!<BR>Будет произведена попытка найти помесячную таблицу <B>irda.irda_".substr($YYYYMMDD,0,6)."<B>.</B>");
      // проверяем наличие требующейся таблицы irda.irda_ггггмм
      $q="SHOW TABLES FROM irda LIKE 'irda\_".substr($YYYYMMDD,0,6)."';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Помесячная таблица данных <B>irda_".substr($YYYYMMDD,0,6)."</B> в БД <B>irda</B> на MySQL-сервере <B>$HostName</B> успешно найдена.");
        $ird_type="m"; // флаг, означающий, что найдена помесячная таблица
      else:
        // если таблица не найдена
        ShowErrorMessage("В БД на MySQL-сервере <B>$HostName</B> не найдены таблицы данных в которых находятся запрашиваемые Вами данные за <B>".substr($YYYYMMDD,6,2)." ".$months2[(substr($YYYYMMDD,4,2))+0]." ".substr($YYYYMMDD,0,4)." года</B> (<B>ird.ird_".$YYYYMMDD."</B>, <B>irda.irda_".substr($YYYYMMDD,0,6)."</B>)!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;          
    endif;
    if ($RECALC=="on"):
      // удаляем данные из таблицы overseer.rep1
      PrintMessage("INFORMATION", "Info", "Т.к. был выбран режим перерасчёта данных, из таблицы <B>overseer.rep1</B> будет произведено удаление всех соответствующих старых данных.");
      $q="SELECT COUNT(*) FROM overseer.rep".$rep." WHERE DATE_FORMAT(date_of_calls,'%Y%m%d')='".$YYYYMMDD."' AND service='".$service."' AND abonent_type='".$abonent_type."' AND timetype='".$timetype."';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Количество строк результирующей выборки: <B>".$num_rows."</B>.");
      else:
        // произошёл сбой при попытке удаления некорректных данных из таблицы данных overseer.rep1
        ShowErrorMessage("Произошёл сбой при попытке получения данных по абоненту <B>".$abonent_type."</B> за <B>".substr($YYYYMMDD,6,2)." ".$months2[((substr($YYYYMMDD,4,2))+0)]." ".substr($YYYYMMDD,0,4)." года</B> из таблицы данных <B>overseer.rep1</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      $row = mysql_fetch_row($table);
      if ($row[0]==0):
        // данных подлежащих удалению в таблице данных нет
        PrintMessage("INFORMATION", "My-SQL", "Данные, подлежащие перерасчёту в таблице данных <B>overseer.rep1</B> отсутствуют.");
      else:        
        // необходимо удалить все строки из таблицы данных overseer.rep1 и проверить их удаление
        $q="DELETE FROM overseer.rep".$rep." WHERE DATE_FORMAT(date_of_calls,'%Y%m%d')='".$YYYYMMDD."' AND service='".$service."' AND abonent_type='".$abonent_type."' AND timetype='".$timetype."';";
        PrintMessage("QUERY", "SQL", $q);
        mysql_query($q);
        if (mysql_affected_rows()==$row[0]):
          PrintMessage("SUCCESS", "My-SQL", "Все старые данные были успешно удалены.");
        else:
          // произошёл сбой при попытке удаления старых данных из таблицы данных overseer.rep1
          ShowErrorMessage("Произошёл сбой при попытке удаления старых данных по абоненту <B>".$abonent_type."</B> за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[((substr($YYYYMMDD,4,2))+0)]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> из таблицы данных <B>overseer.rep1</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
    endif;
    // производим расчёт данных и вносим их в таблицу overseer.rep1
    // получаем количество поступивших абонентов
    $q="SELECT '".substr($YYYYMMDD,0,4)."-".substr($YYYYMMDD,4,2)."-".substr($YYYYMMDD,6,2)."' AS f1, '".$abonent_type."' AS f2, '".$service."' AS f3, '".$timetype."' AS f4, COUNT(*) AS f5 FROM ";
    if ($ird_type=="d"):
      $q.="ird.ird_".$YYYYMMDD;
    elseif ($ird_type=="m"):
      $q.="irda.irda_".substr($YYYYMMDD,0,6);
    endif;
    $q.=" WHERE datum='".substr($YYYYMMDD,0,4)."-".substr($YYYYMMDD,4,2)."-".substr($YYYYMMDD,6,2)."'";
    if ($service=="099"):
      $q.=" AND ((ddi='099') OR (ddi='1111')) ";
    elseif ($service=="9909111"):
      $q.=" AND ((ddi='9909111') OR (ddi='2222')) ";
    else:
      $q.=" AND ddi='".$service."' ";
    endif;
    if ($timetype=="d"):
      $q.="AND (vrijeme>='06:00:00' AND vrijeme<'22:00:00') ";
    elseif ($timetype=="n"):
      $q.="AND (vrijeme<'06:00:00' OR vrijeme>='22:00:00') ";
    else:
      $q.="";
    endif;
    $q.="AND ".$abonent_types[$abonent_type]." ";
    if ($service_types[$service]=="voice"):
      $q.="AND v_mreza>'' AND rm>0 ";
    elseif ($service_types[$service]=="auto"):
      $q.="AND v_mreza>'' ";
    else:
      ShowErrorMessage("Возникла ошибка при постоении запроса к БД - не указан тип для услуги <B>".$service."</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    $q.="GROUP BY ddi;";
    PrintMessage("QUERY", "SQL", $q);
    $table=mysql_query($q);
    $num_rows=mysql_num_rows($table);
    if ($num_rows==1):
      PrintMessage("SUCCESS", "My-SQL", "Данные по услуге успешно найдены.");
      $result1=mysql_fetch_assoc($table);
      //var_dump($result1);
    elseif ($num_rows==0):
      PrintMessage("SUCCESS", "My-SQL", "Данные по услуге отсутствуют.");
    else:
      if ($timetype=="d"):
        $s="за дневную смену ";
      elseif ($timetype=="n"):
        $s="за ночную смену ";
      else:
        $s="";
      endif;       
      ShowErrorMessage("Возникла ошибка получении данных по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> из таблицы <B>rep".$rep."</B> БД <B>".$DBName."</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
      die("");
    endif;
    // если данные по услуге были найдены, значит продолжаем получать оставшиеся данные
    if ($num_rows==1):
      // получаем количество поступивших абонентов и длительности в минутах и секундах
      $q="SELECT COUNT(*) AS f6, SUM(dur) AS f7, CEILING(SUM(dur)/60) AS f8, SUM(CEILING(dur/60)) AS f9, (SUM(dur)/COUNT(*)) AS f10 FROM ";
      if ($ird_type=="d"):
        $q.="ird.ird_".$YYYYMMDD;
      elseif ($ird_type=="m"):
        $q.="irda.irda_".substr($YYYYMMDD,0,6);
      endif;
      $q.=" WHERE datum='".substr($YYYYMMDD,0,4)."-".substr($YYYYMMDD,4,2)."-".substr($YYYYMMDD,6,2)."'";
      if ($service=="099"):
        $q.=" AND ((ddi='099') OR (ddi='1111')) ";
      elseif ($service=="9909111"):
        $q.=" AND ((ddi='9909111') OR (ddi='2222')) ";
      else:
        $q.=" AND ddi='".$service."' ";
      endif;
      if ($timetype=="d"):
        $q.="AND (vrijeme>='06:00:00' AND vrijeme<'22:00:00') ";
      elseif ($timetype=="n"):
        $q.="AND (vrijeme<'06:00:00' OR vrijeme>='22:00:00') ";
      else:
        $q.="";
      endif;
      $q.="AND ".$abonent_types[$abonent_type]." ";
      if ($service_types[$service]=="voice"):
      $q.="AND v_mreza>'' AND rm>0 AND (v_oper>'') AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
      elseif ($service_types[$service]=="auto"):
        $q.="AND v_mreza>'' AND (dur>0)";
      else:
        ShowErrorMessage("Возникла ошибка при постоении запроса к БД - не указан тип для услуги <B>".$service."</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      $q.=" GROUP BY ddi;";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Данные по услуге успешно найдены.");
        $result2=mysql_fetch_assoc($table);
        //var_dump($result2);
      elseif ($num_rows==0):
        PrintMessage("SUCCESS", "My-SQL", "Данные по услуге отсутствуют.");
      else:
        if ($timetype=="d"):
          $s="за дневную смену ";
        elseif ($timetype=="n"):
          $s="за ночную смену ";
        else:
          $s="";
        endif;       
        ShowErrorMessage("Возникла ошибка получении данных по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> из таблицы <B>rep".$rep."</B> БД <B>".$DBName."</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // получаем количество звонков к оплате
      if (($abonent_type=="прочие")||($abonent_type=="МЦС")||($abonent_type=="МТС")||($abonent_type=="БеСТ")||($service=="098")||($service=="099")||($service=="9909911")||($service=="9900911")||($service=="9909111")||($service=="99075")||($service=="99088")||($service=="99090")||($service=="99091")||($service=="99092")||($service=="99093")||($service=="99094")||($service=="99095")||($service=="99096")||($service=="99097")):
        $result=array();
        $result3=array("f11"=>"0");
        //var_dump($result3);
      else:
        $q="SELECT COUNT(*) AS f11 FROM ";
        if ($ird_type=="d"):
          $q.="ird.ird_".$YYYYMMDD;
        elseif ($ird_type=="m"):
          $q.="irda.irda_".substr($YYYYMMDD,0,6);
        endif;
        $q.=" a LEFT JOIN arj.black b ON RIGHT(a.ani,7) LIKE b.phn WHERE  b.phn IS null AND datum='".substr($YYYYMMDD,0,4)."-".substr($YYYYMMDD,4,2)."-".substr($YYYYMMDD,6,2)."' AND druga_info=0";
        if ($service=="099"):
          $q.=" AND ((ddi='099') OR (ddi='1111')) ";
        elseif ($service=="9909111"):
          $q.=" AND ((ddi='9909111') OR (ddi='2222')) ";
        else:
          $q.=" AND ddi='".$service."' ";
        endif;
        if ($timetype=="d"):
          $q.="AND (vrijeme>='06:00:00' AND vrijeme<'22:00:00') ";
        elseif ($timetype=="n"):
          $q.="AND (vrijeme<'06:00:00' OR vrijeme>='22:00:00') ";
        else:
          $q.="";
        endif;
        $q.="AND ".$abonent_types[$abonent_type]." ";
        if ($service_types[$service]=="voice"):
        $q.="AND v_mreza>'' AND rm>0 AND (v_oper>'') AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
        elseif ($service_types[$service]=="auto"):
          $q.="AND v_mreza>'' AND (dur>0)";
        else:
          ShowErrorMessage("Возникла ошибка при постоении запроса к БД - не указан тип для услуги <B>".$service."</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        $q.=" GROUP BY ddi;";
        PrintMessage("QUERY", "SQL", $q);
        $table=mysql_query($q);
        $num_rows=mysql_num_rows($table);
        if ($num_rows==1):
          PrintMessage("SUCCESS", "My-SQL", "Данные по услуге успешно найдены.");
          $result3=mysql_fetch_assoc($table);
          //var_dump($result3);
        elseif ($num_rows==0):
          PrintMessage("SUCCESS", "My-SQL", "Данные по услуге отсутствуют.");
        else:
          if ($timetype=="d"):
            $s="за дневную смену ";
          elseif ($timetype=="n"):
            $s="за ночную смену ";
          else:
            $s="";
          endif;       
          ShowErrorMessage("Возникла ошибка получении данных по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> из таблицы <B>rep".$rep."</B> БД <B>".$DBName."</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      $result=array();
      $result[0]=$result1["f1"];
      $result[1]=$result1["f2"];
      $result[2]=$result1["f3"];
      $result[3]=$result1["f4"];
      $result[4]=$result1["f5"];
      $result[5]=$result2["f6"];
      $result[6]=$result2["f7"];
      $result[7]=$result2["f8"];
      $result[8]=$result2["f9"];
      $result[9]=$result2["f10"];
      $result[10]=$result3["f11"];
      //var_dump($result);
      // вносим полученные данные в таблицу
      $q="INSERT INTO overseer.rep".$rep." VALUES(NULL, '".$result[0]."', '".$result[1]."', '".$result[2]."', '".$result[3]."', '".$result[4]."', '".$result[5]."', '".$result[6]."', '".$result[7]."', '".$result[8]."', '".$result[9]."', '".$result[10]."');";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      // проверка на успешность проведения операции
      if ($timetype=="d"):
        $s="за дневную смену ";
      elseif ($timetype=="n"):
        $s="за ночную смену ";
      else:
        $s="";
      endif;       
      if (mysql_affected_rows()==1):
        PrintMessage("SUCCESS", "My-SQL", "Данные по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> успешно добавлены в таблицу <B>overseer.rep".$rep."</B>.");
      else:
        ShowErrorMessage("Возникла ошибка при вставке данных в таблицу <B>overseer.rep".$rep."</B> по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    elseif ($num_rows==0):
      $q="INSERT INTO overseer.rep".$rep." VALUES(NULL, '".substr($YYYYMMDD,0,4)."-".substr($YYYYMMDD,4,2)."-".substr($YYYYMMDD,6,2)."', '".$abonent_type."', '".$service."', '".$timetype."', '0', '0', '0', '0', '0', '0', '0');";
      PrintMessage("QUERY", "SQL", $q);
      mysql_query($q);
      // проверка на успешность проведения операции
      if ($timetype=="d"):
        $s="за дневную смену ";
      elseif ($timetype=="n"):
        $s="за ночную смену ";
      else:
        $s="";
      endif;       
      if (mysql_affected_rows()==1):
        PrintMessage("SUCCESS", "My-SQL", "Данные по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B> успешно добавлены в таблицу <B>overseer.rep".$rep."</B>.");
      else:
        ShowErrorMessage("Возникла ошибка при вставке данных в таблицу <B>overseer.rep".$rep."</B> по сети &laquo;<B>".$abonent_type."</B>&raquo; по услуге <B>".$service."</B> ".$s."за&nbsp;<B>".substr($YYYYMMDD,6,2)."&nbsp;".$months2[(substr($YYYYMMDD,4,2))+0]."&nbsp;".substr($YYYYMMDD,0,4)."&nbsp;года</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endif;
  endif;
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
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <LINK REL="previous" HREF="<?echo $base_url;?>?step=2&amp;rep=<?echo $rep;?>&amp;time=<?echo $time;
      if ($amm!=""): echo "&amp;amm=$amm"; endif;
      if ($amy!=""): echo "&amp;amy=$amy"; endif;
      if ($abd!=""): echo "&amp;abd=$abd"; endif;
      if ($abm!=""): echo "&amp;abm=$abm"; endif;
      if ($aby!=""): echo "&amp;aby=$aby"; endif;
      if ($aed!=""): echo "&amp;aed=$aed"; endif;
      if ($aem!=""): echo "&amp;aem=$aem"; endif;
      if ($aey!=""): echo "&amp;aey=$aey"; endif;
      if ($C009!=""): echo "&amp;C009=$C009"; endif;
      if ($C075!=""): echo "&amp;C075=$C075"; endif;
      if ($C088!=""): echo "&amp;C088=$C088"; endif;
      if ($C090!=""): echo "&amp;C090=$C090"; endif;
      if ($C091!=""): echo "&amp;C091=$C091"; endif;
      if ($C092!=""): echo "&amp;C092=$C092"; endif;
      if ($C093!=""): echo "&amp;C093=$C093"; endif;
      if ($C094!=""): echo "&amp;C094=$C094"; endif;
      if ($C095!=""): echo "&amp;C095=$C095"; endif;
      if ($C096!=""): echo "&amp;C096=$C096"; endif;
      if ($C097!=""): echo "&amp;C097=$C097"; endif;
      if ($CHECK_ALL_VOICE!=""): echo "&amp;CHECK_ALL_VOICE=$CHECK_ALL_VOICE"; endif;
      if ($CHECK_ALL_AUTO!=""): echo "&amp;CHECK_ALL_AUTO=$CHECK_ALL_AUTO"; endif;
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
      if ($HIDECALLSTOPAY!=""): echo "&amp;HIDECALLSTOPAY=$HIDECALLSTOPAY"; endif;
      if ($RECALC!=""): echo "&amp;RECALC=$RECALC"; endif;?>">
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
      if (($time!="yesterday")&&($time!="lastweek")&&($time!="lastmonth")&&($time!="anothermonth")&&($time!="another")): // если временной промежуток не попадает ни под один из дозволенных - вывести сообщение об ошибке и остановить программу
        ShowErrorMessage("Задан некорректный временной промежуток!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      // вывод отладочной информации в случае необходимости
      if (($time=="yesterday")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear))):
        PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B>.");
      elseif (($time=="lastweek")||($time=="lastmonth")||($time=="anothermonth")||($time=="another")):
        PrintMessage("INFORMATION", "Info", "Выбранный Вами временной период - с <B>$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года</B> по <B>$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;года</B>.");
      endif;
      // если был выбран произвольный месяц, проводим валидацию даты
      if (($time=="another")||($time=="anothermonth")):
        if (checkdate($startmonth,$startday,$startyear)<>1): // если была выбрана несуществующая дата
          ShowErrorMessage("Задан несуществующий месяц! Пожалуйста, вернитесь к предыдущему шагу и повторите ввод.<BR>Если ошибка будет повторяться, обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$startmonth,$startday,$startyear)-mktime(0,0,0,$m,$d,$y))>0): // если начальная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Дата начала выбранного Вами месяца (<B>$startday&nbsp;".$months2[$startmonth]."&nbsp;$startyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if ((mktime(0,0,0,$stopmonth,$stopday,$stopyear)-mktime(0,0,0,$m,$d,$y))>0): // если конечная "указанная" дата больше, чем текущая, вывести сообщение об ошибке и остановить программу
          ShowErrorMessage("Дата окончания выбранного Вами месяца (<B>$stopday&nbsp;".$months2[$stopmonth]."&nbsp;$stopyear&nbsp;года</B>) больше текущей (<B>$d&nbsp;".$months2[$m]."&nbsp;$y&nbsp;года</B>)!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      if (!(($C009=="on")||($C075=="on")||($C088=="on")||($C090=="on")||($C091=="on")||($C092=="on")||($C093=="on")||($C094=="on")||($C095=="on")||($C096=="on")||($C097=="on")||($C098=="on")||($C099=="on")||($C9900911=="on")||($C9909111=="on")||($C9909911=="on")||($C99075=="on")||($C99088=="on")||($C99090=="on")||($C99091=="on")||($C99092=="on")||($C99093=="on")||($C99094=="on")||($C99095=="on")||($C99096=="on")||($C99097=="on"))):
        ShowErrorMessage("Вы должны выбрать хотя бы одну из перечисленных услуг для формирования отчёта!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if ($DEBUG=="on"):
        $s="";
        if ($C009=="on"): $s.="009"; endif;
        if ($C075=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="075";
        endif;
        if ($C088=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="088";
        endif;
        if ($C090=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="090";
        endif;
        if ($C091=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="091";
        endif;
        if ($C092=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="092";
        endif;
        if ($C093=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="093";
        endif;
        if ($C094=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="094";
        endif;
        if ($C095=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="095";
        endif;
        if ($C096=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="096";
        endif;
        if ($C097=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="097";
        endif;
        if ($C098=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="098";
        endif;
        if ($C099=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="099";
        endif;
        if ($C99075=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99075";
        endif;
        if ($C99088=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99088";
        endif;
        if ($C99090=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99090";
        endif;
        if ($C99091=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99091";
        endif;
        if ($C99092=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99092";
        endif;
        if ($C99093=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99093";
        endif;
        if ($C99094=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99094";
        endif;
        if ($C99095=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99095";
        endif;
        if ($C99096=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99096";
        endif;
        if ($C99097=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="99097";
        endif;
        if ($C9900911=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="9900911";
        endif;
        if ($C9909111=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="9909111";
        endif;
        if ($C9909911=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="9909911";
        endif;
        PrintMessage("INFORMATION", "Info", "Список выбранных Вами услуг - <B>$s</B>.");
      endif;
      // валидация выбранного действия
      switch ($action):
        case "print": $s="визуальный просмотр, подготовка к сохранению на диск либо к печати"; break;
        case "email": $s="отправка по электронной почте"; break;
        default: $s=""; break;
      endswitch;
      if ($s!=""):
        PrintMessage("INFORMATION", "Info", "Выбранное Вами действие - <B>$s</B>.");
      else:
        ShowErrorMessage("Выбрано некорректое действие!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
          ShowErrorMessage("Не задано ни одного адресата! Вы должны указать адрес(а) электронной почты (e-mail) в поле(ях) &laquo;<B>Кому</B>&raquo;.<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
          die("");
        endif;
      endif;
      // подсчитываем количество дней, входящий в период и помещаем его в переменную $daycount
      $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth+0,$startday+0,$startyear+0);
      $daycount=0;
      while ($i>=-3600):
        $daycount++;
        $i=$i-(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
      endwhile;
      PrintMessage("INFORMATION", "Info", "Количество дней в выбранном периоде - <B>$daycount</B>.");
      // составление списка дат, входящих в выбранный период
      $k=mktime(6,0,0,$startmonth+0,$startday+0,$startyear+0);
      $dates=array();
      for ($j=0; $j<$daycount; $j++):
        $cd=date("d",$k)+0;
        if ($cd<10): $cd="0".$cd; endif;
        $cm=date("m",$k)+0;
        if ($cm<10): $cm="0".$cm; endif;
        $cy=date("Y",$k)+0;
        $dates[]="".$cy.$cm.$cd;
        $k=$k+(mktime(1,0,0,1,2,2000)-mktime(1,0,0,1,1,2000));
      endfor;
      //var_dump($dates);
      // подключение к MySQL-серверу
      $HostName="10.1.1.240";
      $UserName="overseer";
      $Password="";
      $DBName="overseer";
      $MySQLConnection=@mysql_connect($HostName,$UserName,$Password);
      if ($MySQLConnection==FALSE):
        ShowErrorMessage("Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      if (@mysql_select_db("$DBName")==FALSE):
        ShowErrorMessage("Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      PrintMessage("SUCCESS", "My-SQL", "Удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>.");

      foreach ($dates as $i):
        if ($C009=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "009", "");
            PrepareData($i, "МГТС", "009", "d");
            PrepareData($i, "МГТС", "009", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "009", "");
            PrepareData($i, "МЦС", "009", "d");
            PrepareData($i, "МЦС", "009", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "009", "");
            PrepareData($i, "МТС", "009", "d");
            PrepareData($i, "МТС", "009", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "009", "");
            PrepareData($i, "БеСТ", "009", "d");
            PrepareData($i, "БеСТ", "009", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "009", "");
            PrepareData($i, "БелСел", "009", "d");
            PrepareData($i, "БелСел", "009", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "009", "");
            PrepareData($i, "прочие", "009", "d");
            PrepareData($i, "прочие", "009", "n");
          endif;
        endif;
        if ($C075=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "075", "");
            PrepareData($i, "МГТС", "075", "d");
            PrepareData($i, "МГТС", "075", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "075", "");
            PrepareData($i, "МЦС", "075", "d");
            PrepareData($i, "МЦС", "075", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "075", "");
            PrepareData($i, "МТС", "075", "d");
            PrepareData($i, "МТС", "075", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "075", "");
            PrepareData($i, "БеСТ", "075", "d");
            PrepareData($i, "БеСТ", "075", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "075", "");
            PrepareData($i, "БелСел", "075", "d");
            PrepareData($i, "БелСел", "075", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "075", "");
            PrepareData($i, "прочие", "075", "d");
            PrepareData($i, "прочие", "075", "n");
          endif;
        endif;
        if ($C088=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "088", "");
            PrepareData($i, "МГТС", "088", "d");
            PrepareData($i, "МГТС", "088", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "088", "");
            PrepareData($i, "МЦС", "088", "d");
            PrepareData($i, "МЦС", "088", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "088", "");
            PrepareData($i, "МТС", "088", "d");
            PrepareData($i, "МТС", "088", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "088", "");
            PrepareData($i, "БеСТ", "088", "d");
            PrepareData($i, "БеСТ", "088", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "088", "");
            PrepareData($i, "БелСел", "088", "d");
            PrepareData($i, "БелСел", "088", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "088", "");
            PrepareData($i, "прочие", "088", "d");
            PrepareData($i, "прочие", "088", "n");
          endif;
        endif;
        if ($C090=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "090", "");
            PrepareData($i, "МГТС", "090", "d");
            PrepareData($i, "МГТС", "090", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "090", "");
            PrepareData($i, "МЦС", "090", "d");
            PrepareData($i, "МЦС", "090", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "090", "");
            PrepareData($i, "МТС", "090", "d");
            PrepareData($i, "МТС", "090", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "090", "");
            PrepareData($i, "БеСТ", "090", "d");
            PrepareData($i, "БеСТ", "090", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "090", "");
            PrepareData($i, "БелСел", "090", "d");
            PrepareData($i, "БелСел", "090", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "090", "");
            PrepareData($i, "прочие", "090", "d");
            PrepareData($i, "прочие", "090", "n");
          endif;
        endif;
        if ($C091=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "091", "");
            PrepareData($i, "МГТС", "091", "d");
            PrepareData($i, "МГТС", "091", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "091", "");
            PrepareData($i, "МЦС", "091", "d");
            PrepareData($i, "МЦС", "091", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "091", "");
            PrepareData($i, "МТС", "091", "d");
            PrepareData($i, "МТС", "091", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "091", "");
            PrepareData($i, "БеСТ", "091", "d");
            PrepareData($i, "БеСТ", "091", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "091", "");
            PrepareData($i, "БелСел", "091", "d");
            PrepareData($i, "БелСел", "091", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "091", "");
            PrepareData($i, "прочие", "091", "d");
            PrepareData($i, "прочие", "091", "n");
          endif;
        endif;
        if ($C092=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "092", "");
            PrepareData($i, "МГТС", "092", "d");
            PrepareData($i, "МГТС", "092", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "092", "");
            PrepareData($i, "МЦС", "092", "d");
            PrepareData($i, "МЦС", "092", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "092", "");
            PrepareData($i, "МТС", "092", "d");
            PrepareData($i, "МТС", "092", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "092", "");
            PrepareData($i, "БеСТ", "092", "d");
            PrepareData($i, "БеСТ", "092", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "092", "");
            PrepareData($i, "БелСел", "092", "d");
            PrepareData($i, "БелСел", "092", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "092", "");
            PrepareData($i, "прочие", "092", "d");
            PrepareData($i, "прочие", "092", "n");
          endif;
        endif;
        if ($C093=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "093", "");
            PrepareData($i, "МГТС", "093", "d");
            PrepareData($i, "МГТС", "093", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "093", "");
            PrepareData($i, "МЦС", "093", "d");
            PrepareData($i, "МЦС", "093", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "093", "");
            PrepareData($i, "МТС", "093", "d");
            PrepareData($i, "МТС", "093", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "093", "");
            PrepareData($i, "БеСТ", "093", "d");
            PrepareData($i, "БеСТ", "093", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "093", "");
            PrepareData($i, "БелСел", "093", "d");
            PrepareData($i, "БелСел", "093", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "093", "");
            PrepareData($i, "прочие", "093", "d");
            PrepareData($i, "прочие", "093", "n");
          endif;
        endif;
        if ($C094=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "094", "");
            PrepareData($i, "МГТС", "094", "d");
            PrepareData($i, "МГТС", "094", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "094", "");
            PrepareData($i, "МЦС", "094", "d");
            PrepareData($i, "МЦС", "094", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "094", "");
            PrepareData($i, "МТС", "094", "d");
            PrepareData($i, "МТС", "094", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "094", "");
            PrepareData($i, "БеСТ", "094", "d");
            PrepareData($i, "БеСТ", "094", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "094", "");
            PrepareData($i, "БелСел", "094", "d");
            PrepareData($i, "БелСел", "094", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "094", "");
            PrepareData($i, "прочие", "094", "d");
            PrepareData($i, "прочие", "094", "n");
          endif;
        endif;
        if ($C095=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "095", "");
            PrepareData($i, "МГТС", "095", "d");
            PrepareData($i, "МГТС", "095", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "095", "");
            PrepareData($i, "МЦС", "095", "d");
            PrepareData($i, "МЦС", "095", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "095", "");
            PrepareData($i, "МТС", "095", "d");
            PrepareData($i, "МТС", "095", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "095", "");
            PrepareData($i, "БеСТ", "095", "d");
            PrepareData($i, "БеСТ", "095", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "095", "");
            PrepareData($i, "БелСел", "095", "d");
            PrepareData($i, "БелСел", "095", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "095", "");
            PrepareData($i, "прочие", "095", "d");
            PrepareData($i, "прочие", "095", "n");
          endif;
        endif;
        if ($C096=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "096", "");
            PrepareData($i, "МГТС", "096", "d");
            PrepareData($i, "МГТС", "096", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "096", "");
            PrepareData($i, "МЦС", "096", "d");
            PrepareData($i, "МЦС", "096", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "096", "");
            PrepareData($i, "МТС", "096", "d");
            PrepareData($i, "МТС", "096", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "096", "");
            PrepareData($i, "БеСТ", "096", "d");
            PrepareData($i, "БеСТ", "096", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "096", "");
            PrepareData($i, "БелСел", "096", "d");
            PrepareData($i, "БелСел", "096", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "096", "");
            PrepareData($i, "прочие", "096", "d");
            PrepareData($i, "прочие", "096", "n");
          endif;
        endif;
        if ($C097=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "097", "");
            PrepareData($i, "МГТС", "097", "d");
            PrepareData($i, "МГТС", "097", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "097", "");
            PrepareData($i, "МЦС", "097", "d");
            PrepareData($i, "МЦС", "097", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "097", "");
            PrepareData($i, "МТС", "097", "d");
            PrepareData($i, "МТС", "097", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "097", "");
            PrepareData($i, "БеСТ", "097", "d");
            PrepareData($i, "БеСТ", "097", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "097", "");
            PrepareData($i, "БелСел", "097", "d");
            PrepareData($i, "БелСел", "097", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "097", "");
            PrepareData($i, "прочие", "097", "d");
            PrepareData($i, "прочие", "097", "n");
          endif;
        endif;
        if ($C098=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "098", "");
            PrepareData($i, "МГТС", "098", "d");
            PrepareData($i, "МГТС", "098", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "098", "");
            PrepareData($i, "МЦС", "098", "d");
            PrepareData($i, "МЦС", "098", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "098", "");
            PrepareData($i, "МТС", "098", "d");
            PrepareData($i, "МТС", "098", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "098", "");
            PrepareData($i, "БеСТ", "098", "d");
            PrepareData($i, "БеСТ", "098", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "098", "");
            PrepareData($i, "БелСел", "098", "d");
            PrepareData($i, "БелСел", "098", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "098", "");
            PrepareData($i, "прочие", "098", "d");
            PrepareData($i, "прочие", "098", "n");
          endif;
        endif;
        if ($C099=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "099", "");
            PrepareData($i, "МГТС", "099", "d");
            PrepareData($i, "МГТС", "099", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "099", "");
            PrepareData($i, "МЦС", "099", "d");
            PrepareData($i, "МЦС", "099", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "099", "");
            PrepareData($i, "МТС", "099", "d");
            PrepareData($i, "МТС", "099", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "099", "");
            PrepareData($i, "БеСТ", "099", "d");
            PrepareData($i, "БеСТ", "099", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "099", "");
            PrepareData($i, "БелСел", "099", "d");
            PrepareData($i, "БелСел", "099", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "099", "");
            PrepareData($i, "прочие", "099", "d");
            PrepareData($i, "прочие", "099", "n");
          endif;
        endif;
        if ($C99075=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99075", "");
            PrepareData($i, "МГТС", "99075", "d");
            PrepareData($i, "МГТС", "99075", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99075", "");
            PrepareData($i, "МЦС", "99075", "d");
            PrepareData($i, "МЦС", "99075", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99075", "");
            PrepareData($i, "МТС", "99075", "d");
            PrepareData($i, "МТС", "99075", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99075", "");
            PrepareData($i, "БеСТ", "99075", "d");
            PrepareData($i, "БеСТ", "99075", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99075", "");
            PrepareData($i, "БелСел", "99075", "d");
            PrepareData($i, "БелСел", "99075", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99075", "");
            PrepareData($i, "прочие", "99075", "d");
            PrepareData($i, "прочие", "99075", "n");
          endif;
        endif;
        if ($C99088=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99088", "");
            PrepareData($i, "МГТС", "99088", "d");
            PrepareData($i, "МГТС", "99088", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99088", "");
            PrepareData($i, "МЦС", "99088", "d");
            PrepareData($i, "МЦС", "99088", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99088", "");
            PrepareData($i, "МТС", "99088", "d");
            PrepareData($i, "МТС", "99088", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99088", "");
            PrepareData($i, "БеСТ", "99088", "d");
            PrepareData($i, "БеСТ", "99088", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99088", "");
            PrepareData($i, "БелСел", "99088", "d");
            PrepareData($i, "БелСел", "99088", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99088", "");
            PrepareData($i, "прочие", "99088", "d");
            PrepareData($i, "прочие", "99088", "n");
          endif;
        endif;
        if ($C99090=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99090", "");
            PrepareData($i, "МГТС", "99090", "d");
            PrepareData($i, "МГТС", "99090", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99090", "");
            PrepareData($i, "МЦС", "99090", "d");
            PrepareData($i, "МЦС", "99090", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99090", "");
            PrepareData($i, "МТС", "99090", "d");
            PrepareData($i, "МТС", "99090", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99090", "");
            PrepareData($i, "БеСТ", "99090", "d");
            PrepareData($i, "БеСТ", "99090", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99090", "");
            PrepareData($i, "БелСел", "99090", "d");
            PrepareData($i, "БелСел", "99090", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99090", "");
            PrepareData($i, "прочие", "99090", "d");
            PrepareData($i, "прочие", "99090", "n");
          endif;
        endif;
        if ($C99091=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99091", "");
            PrepareData($i, "МГТС", "99091", "d");
            PrepareData($i, "МГТС", "99091", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99091", "");
            PrepareData($i, "МЦС", "99091", "d");
            PrepareData($i, "МЦС", "99091", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99091", "");
            PrepareData($i, "МТС", "99091", "d");
            PrepareData($i, "МТС", "99091", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99091", "");
            PrepareData($i, "БеСТ", "99091", "d");
            PrepareData($i, "БеСТ", "99091", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99091", "");
            PrepareData($i, "БелСел", "99091", "d");
            PrepareData($i, "БелСел", "99091", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99091", "");
            PrepareData($i, "прочие", "99091", "d");
            PrepareData($i, "прочие", "99091", "n");
          endif;
        endif;
        if ($C99092=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99092", "");
            PrepareData($i, "МГТС", "99092", "d");
            PrepareData($i, "МГТС", "99092", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99092", "");
            PrepareData($i, "МЦС", "99092", "d");
            PrepareData($i, "МЦС", "99092", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99092", "");
            PrepareData($i, "МТС", "99092", "d");
            PrepareData($i, "МТС", "99092", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99092", "");
            PrepareData($i, "БеСТ", "99092", "d");
            PrepareData($i, "БеСТ", "99092", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99092", "");
            PrepareData($i, "БелСел", "99092", "d");
            PrepareData($i, "БелСел", "99092", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99092", "");
            PrepareData($i, "прочие", "99092", "d");
            PrepareData($i, "прочие", "99092", "n");
          endif;
        endif;
        if ($C99093=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99093", "");
            PrepareData($i, "МГТС", "99093", "d");
            PrepareData($i, "МГТС", "99093", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99093", "");
            PrepareData($i, "МЦС", "99093", "d");
            PrepareData($i, "МЦС", "99093", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99093", "");
            PrepareData($i, "МТС", "99093", "d");
            PrepareData($i, "МТС", "99093", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99093", "");
            PrepareData($i, "БеСТ", "99093", "d");
            PrepareData($i, "БеСТ", "99093", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99093", "");
            PrepareData($i, "БелСел", "99093", "d");
            PrepareData($i, "БелСел", "99093", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99093", "");
            PrepareData($i, "прочие", "99093", "d");
            PrepareData($i, "прочие", "99093", "n");
          endif;
        endif;
        if ($C99094=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99094", "");
            PrepareData($i, "МГТС", "99094", "d");
            PrepareData($i, "МГТС", "99094", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99094", "");
            PrepareData($i, "МЦС", "99094", "d");
            PrepareData($i, "МЦС", "99094", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99094", "");
            PrepareData($i, "МТС", "99094", "d");
            PrepareData($i, "МТС", "99094", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99094", "");
            PrepareData($i, "БеСТ", "99094", "d");
            PrepareData($i, "БеСТ", "99094", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99094", "");
            PrepareData($i, "БелСел", "99094", "d");
            PrepareData($i, "БелСел", "99094", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99094", "");
            PrepareData($i, "прочие", "99094", "d");
            PrepareData($i, "прочие", "99094", "n");
          endif;
        endif;
        if ($C99095=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99095", "");
            PrepareData($i, "МГТС", "99095", "d");
            PrepareData($i, "МГТС", "99095", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99095", "");
            PrepareData($i, "МЦС", "99095", "d");
            PrepareData($i, "МЦС", "99095", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99095", "");
            PrepareData($i, "МТС", "99095", "d");
            PrepareData($i, "МТС", "99095", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99095", "");
            PrepareData($i, "БеСТ", "99095", "d");
            PrepareData($i, "БеСТ", "99095", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99095", "");
            PrepareData($i, "БелСел", "99095", "d");
            PrepareData($i, "БелСел", "99095", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99095", "");
            PrepareData($i, "прочие", "99095", "d");
            PrepareData($i, "прочие", "99095", "n");
          endif;
        endif;
        if ($C99096=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99096", "");
            PrepareData($i, "МГТС", "99096", "d");
            PrepareData($i, "МГТС", "99096", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99096", "");
            PrepareData($i, "МЦС", "99096", "d");
            PrepareData($i, "МЦС", "99096", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99096", "");
            PrepareData($i, "МТС", "99096", "d");
            PrepareData($i, "МТС", "99096", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99096", "");
            PrepareData($i, "БеСТ", "99096", "d");
            PrepareData($i, "БеСТ", "99096", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99096", "");
            PrepareData($i, "БелСел", "99096", "d");
            PrepareData($i, "БелСел", "99096", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99096", "");
            PrepareData($i, "прочие", "99096", "d");
            PrepareData($i, "прочие", "99096", "n");
          endif;
        endif;
        if ($C99097=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "99097", "");
            PrepareData($i, "МГТС", "99097", "d");
            PrepareData($i, "МГТС", "99097", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "99097", "");
            PrepareData($i, "МЦС", "99097", "d");
            PrepareData($i, "МЦС", "99097", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "99097", "");
            PrepareData($i, "МТС", "99097", "d");
            PrepareData($i, "МТС", "99097", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "99097", "");
            PrepareData($i, "БеСТ", "99097", "d");
            PrepareData($i, "БеСТ", "99097", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "99097", "");
            PrepareData($i, "БелСел", "99097", "d");
            PrepareData($i, "БелСел", "99097", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "99097", "");
            PrepareData($i, "прочие", "99097", "d");
            PrepareData($i, "прочие", "99097", "n");
          endif;
        endif;
        if ($C9900911=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "9900911", "");
            PrepareData($i, "МГТС", "9900911", "d");
            PrepareData($i, "МГТС", "9900911", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "9900911", "");
            PrepareData($i, "МЦС", "9900911", "d");
            PrepareData($i, "МЦС", "9900911", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "9900911", "");
            PrepareData($i, "МТС", "9900911", "d");
            PrepareData($i, "МТС", "9900911", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "9900911", "");
            PrepareData($i, "БеСТ", "9900911", "d");
            PrepareData($i, "БеСТ", "9900911", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "9900911", "");
            PrepareData($i, "БелСел", "9900911", "d");
            PrepareData($i, "БелСел", "9900911", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "9900911", "");
            PrepareData($i, "прочие", "9900911", "d");
            PrepareData($i, "прочие", "9900911", "n");
          endif;
        endif;
        if ($C9909111=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "9909111", "");
            PrepareData($i, "МГТС", "9909111", "d");
            PrepareData($i, "МГТС", "9909111", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "9909111", "");
            PrepareData($i, "МЦС", "9909111", "d");
            PrepareData($i, "МЦС", "9909111", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "9909111", "");
            PrepareData($i, "МТС", "9909111", "d");
            PrepareData($i, "МТС", "9909111", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "9909111", "");
            PrepareData($i, "БеСТ", "9909111", "d");
            PrepareData($i, "БеСТ", "9909111", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "9909111", "");
            PrepareData($i, "БелСел", "9909111", "d");
            PrepareData($i, "БелСел", "9909111", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "9909111", "");
            PrepareData($i, "прочие", "9909111", "d");
            PrepareData($i, "прочие", "9909111", "n");
          endif;
        endif;
        if ($C9909911=="on"):
          if (($net_type=="common")||($net_type=="MGTS")): // расчёт данных для общей статистики или только МГТС (город и пригород)
            PrepareData($i, "МГТС", "9909911", "");
            PrepareData($i, "МГТС", "9909911", "d");
            PrepareData($i, "МГТС", "9909911", "n");
          endif;
          if (($net_type=="common")||($net_type=="MCS")): // расчёт данных для общей статистики или только МЦС (Velcom)
            PrepareData($i, "МЦС", "9909911", "");
            PrepareData($i, "МЦС", "9909911", "d");
            PrepareData($i, "МЦС", "9909911", "n");
          endif;
          if (($net_type=="common")||($net_type=="MTS")): // расчёт данных для общей статистики или только МТС
            PrepareData($i, "МТС", "9909911", "");
            PrepareData($i, "МТС", "9909911", "d");
            PrepareData($i, "МТС", "9909911", "n");
          endif;
          if (($net_type=="common")||($net_type=="BeST")): // расчёт данных для общей статистики или только БеСТ
            PrepareData($i, "БеСТ", "9909911", "");
            PrepareData($i, "БеСТ", "9909911", "d");
            PrepareData($i, "БеСТ", "9909911", "n");
          endif;
          if (($net_type=="common")||($net_type=="BelSel")): // расчёт данных для общей статистики или только БелСел
            PrepareData($i, "БелСел", "9909911", "");
            PrepareData($i, "БелСел", "9909911", "d");
            PrepareData($i, "БелСел", "9909911", "n");
          endif;
          if (($net_type=="common")||($net_type=="other")): // расчёт данных для общей статистики или только прочие
            PrepareData($i, "прочие", "9909911", "");
            PrepareData($i, "прочие", "9909911", "d");
            PrepareData($i, "прочие", "9909911", "n");
          endif;
        endif;
      endforeach; 
      //   к этому моменту все данные уже находятся в таблице overseer.rep1
      // составляем вспомогательную строку для шапки отчёта
      $s="";
      if (($time=="yesterday")||(($time=="another")&&($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear))):
        $s="<BR>за ".$startday."&nbsp;".$months2[$startmonth]."&nbsp;".$startyear."&nbsp;года<BR>";
      elseif (($time=="lastweek")||($time=="lastmonth")||($time=="anothermonth")||($time=="another")):
        $s="<BR>за период с ".$startday."&nbsp;".$months2[$startmonth]."&nbsp;".$startyear."&nbsp;года по ".$stopday."&nbsp;".$months2[$stopmonth]."&nbsp;".$stopyear."&nbsp;года<BR>";
      endif;
      if ($net_type=="MGTS"):
        $s1="Статистика по звонкам<BR>абонентов &laquo;МГТС&raquo; на услуги СИЦ ".$s;
        $q1="abonent_type='МГТС' AND ";
      elseif ($net_type=="MCS"):
        $s1="Статистика по звонкам<BR>абонентов сети СП &laquo;МЦС&raquo; на услуги СИЦ ".$s;
        $q1="abonent_type='МЦС' AND ";
      elseif ($net_type=="MTS"):
        $s1="Статистика по звонкам<BR>абонентов сети СООО &laquo;МТС&raquo; на услуги СИЦ ".$s;
        $q1="abonent_type='МТС' AND ";
      elseif ($net_type=="BeST"):
        $s1="Статистика по звонкам<BR>абонентов сети ЗАО &laquo;БеСТ&raquo; на услуги СИЦ ".$s;
        $q1="abonent_type='БеСТ' AND ";
      elseif ($net_type=="BelSel"):
        $s1="Статистика по звонкам<BR>абонентов сети СП &laquo;БелСел&raquo; на услуги СИЦ ".$s;
        $q1="abonent_type='БелСел' AND ";
      elseif ($net_type=="other"):
        $s1="Статистика по звонкам прочих абонентов на услуги СИЦ ".$s;
        $q1="abonent_type='прочие' AND ";
      elseif ($net_type=="common"):
        $s1="Статистика по звонкам на услуги СИЦ ".$s;
        $q1='';
      endif;
      if ($HIDECALLSTOPAY=="on"):
        $c1=100;
        $c2=100;
        $c3=100;
      else:
        $c1=80;
        $c2=84;
        $c3=74;
      endif;
      $bodymessage="    <CENTER>
    <TABLE ALIGN=\"CENTER\" BORDER=\"1\" BGCOLOR=\"WHITE\" WIDTH=\"656\" STYLE=\"border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;\">
      <TBODY VALIGN=\"MIDDLE\" STYLE=\"border-color: white; border-width: 0;\">
        <TR>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"".$c1."px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"156px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"".$c2."px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"".$c2."px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"".$c2."px\"></TD>
          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"".$c3."px\"></TD>
";          
      if ($HIDECALLSTOPAY!="on"):
        $bodymessage.="          <TD HEIGHT=\"1px\" STYLE=\"border-color: white; border-width: 0;\" WIDTH=\"84px\"></TD>
";
      endif;
      $bodymessage.="        </TR>
        <TR>
          <TD COLSPAN=\"".(7-($HIDECALLSTOPAY=="on"))."\" STYLE=\"border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;\">Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
        </TR>
        <TR>
          <TD COLSPAN=\"".(7-($HIDECALLSTOPAY=="on"))."\" STYLE=\"border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;\">".$s1."</TD>
        </TR>
        <TR>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">Телефон<BR>службы</TD>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">Наименование<BR>службы</TD>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">Обслужено<BR>звонков</TD>
          <TD COLSPAN=\"2\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">Длительность<BR>звонков</TD>
          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">Среднее<BR>время<BR>звонка<BR>(секунд)</TD>
";          
      if ($HIDECALLSTOPAY!="on"):
        $bodymessage.="          <TD ROWSPAN=\"2\" STYLE=\"text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">Звонков<BR>к<BR>оплате***</TD>
";
      endif;
      $bodymessage.="        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">в&nbsp;секундах*</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">в&nbsp;минутах**</TD>
        </TR>
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">I</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">II</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">III</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">IV</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">V</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">VI</TD>
";          
      if ($HIDECALLSTOPAY!="on"):
        $bodymessage.="          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 7pt; padding: 2px;\">VII</TD>
";
      endif;
      $bodymessage.="        </TR>
";
      $k=mktime(6,0,0,$startmonth+0,$startday+0,$startyear+0);
      $bd=date("d",$k)+0;
      if ($bd<10): $bd="0".$bd; endif;
      $bm=date("m",$k)+0;
      if ($bm<10): $bm="0".$bm; endif;
      $by=date("Y",$k)+0;
      $k=mktime(6,0,0,$stopmonth+0,$stopday+0,$stopyear+0);
      $ed=date("d",$k)+0;
      if ($ed<10): $ed="0".$ed; endif;
      $em=date("m",$k)+0;
      if ($em<10): $em="0".$em; endif;
      $ey=date("Y",$k)+0;
      if (($C009=="on")||($C075=="on")||($C088=="on")||($C090=="on")||($C091=="on")||($C092=="on")||($C093=="on")||($C094=="on")||($C095=="on")||($C096=="on")||($C097=="on")||($C098=="on")||($C099=="on")||($C9900911=="on")||($C9909111=="on")||($C9909911=="on")||($C99075=="on")||($C99088=="on")||($C99090=="on")||($C99091=="on")||($C99092=="on")||($C99093=="on")||($C99094=="on")||($C99095=="on")||($C99096=="on")||($C99097=="on")):
        $s="";
        if ($C009=="on"): $s.="'009'"; endif;
        if ($C075=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'075'";
        endif;
        if ($C088=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'088'";
        endif;
        if ($C090=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'090'";
        endif;
        if ($C091=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'091'";
        endif;
        if ($C092=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'092'";
        endif;
        if ($C093=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'093'";
        endif;
        if ($C094=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'094'";
        endif;
        if ($C095=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'095'";
        endif;
        if ($C096=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'096'";
        endif;
        if ($C097=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'097'";
        endif;
        if ($C098=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'098'";
        endif;
        if ($C099=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'099'";
        endif;
        if ($C99075=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99075'";
        endif;
        if ($C99088=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99088'";
        endif;
        if ($C99090=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99090'";
        endif;
        if ($C99091=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99091'";
        endif;
        if ($C99092=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99092'";
        endif;
        if ($C99093=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99093'";
        endif;
        if ($C99094=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99094'";
        endif;
        if ($C99095=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99095'";
        endif;
        if ($C99096=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99096'";
        endif;
        if ($C99097=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'99097'";
        endif;
        if ($C9900911=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'9900911'";
        endif;
        if ($C9909111=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'9909111'";
        endif;
        if ($C9909911=="on"):
          if ($s!=""):
            $s.=", ";
          endif;
          $s.="'9909911'";
        endif;
        $q2="AND service IN(".$s.") ";
      endif;
      
      $q="SELECT service AS f1, SUM(served_calls) AS f2, SUM(served_calls_duration_in_seconds) AS f3, SUM(served_calls_duration_in_minutes_with_ceiling_per_call) AS f4, (SUM(served_calls_duration_in_seconds)/SUM(served_calls)) AS f5, SUM(calls_to_pay) AS f6 FROM overseer.rep".$rep." WHERE date_of_calls BETWEEN '".$by.$bm.$bd."' AND '".$ey.$em.$ed."' AND ".$q1."timetype='' ".$q2."GROUP BY service ORDER BY service;";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows>0):
        PrintMessage("SUCCESS", "My-SQL", "Данные были успешно найдены в таблице <B>overseer.rep".$rep."</B>.");
      else:
        // произошёл сбой при попытке удаления некорректных данных из таблицы данных overseer.rep1
        ShowErrorMessage("Произошёл сбой при попытке получения данных из таблицы <B>overseer.rep".$rep."</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      $result_array=array();
      for ($j=0;$j<($num_rows);$j++):
        $tmp_array=mysql_fetch_assoc($table);
        $result_array[]=$tmp_array;
      endfor;
      //var_dump($result_array);
      for ($j=0;$j<(count($result_array));$j++):
        if (!($result_array[$j]["f5"]>0)):
          $result_array[$j]["f5"]=0;
        endif;
        //if (!(($result_array[$j]["f3"]==0)&&($result_array[$j]["f4"]==0)&&($result_array[$j]["f5"]==0)&&($result_array[$j]["f7"]==0))):
          $bodymessage.="
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 2px; border-color: black; font-size: 7pt; padding: 2px;\">".$result_array[$j]["f1"]."</TD>
          <TD STYLE=\"text-align: left; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; font-size: 7pt; padding: 2px 2px 2px 5px;\">".$services[$result_array[$j]["f1"]]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; font-size: 7pt; padding: 2px;\">".$result_array[$j]["f2"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; font-size: 7pt; padding: 2px;\">".$result_array[$j]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; font-size: 7pt; padding: 2px;\">".$result_array[$j]["f4"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; font-size: 7pt; padding: 2px;\">".$result_array[$j]["f5"]."</TD>
";
        if ($HIDECALLSTOPAY!="on"):
        $bodymessage.="          <TD STYLE=\"text-align: center; border-width: 0px 2px ".(1+($j==(count($result_array)-1)))."px 0px; border-color: black; font-size: 7pt; padding: 2px;\">".$result_array[$j]["f6"]."</TD>
";
      endif;
      $bodymessage.="        </TR>
";
        //endif;
      endfor;
      $q="SELECT SUM(served_calls) AS f1, SUM(served_calls_duration_in_seconds) AS f2, SUM(served_calls_duration_in_minutes_with_ceiling_per_call) AS f3, (SUM(served_calls_duration_in_seconds)/SUM(served_calls)) AS f4, SUM(calls_to_pay) AS f5 FROM overseer.rep".$rep." WHERE date_of_calls BETWEEN '".$by.$bm.$bd."' AND '".$ey.$em.$ed."' AND ".$q1."timetype='' ".$q2."GROUP BY '';";
      PrintMessage("QUERY", "SQL", $q);
      $table=mysql_query($q);
      $num_rows=mysql_num_rows($table);
      if ($num_rows==1):
        PrintMessage("SUCCESS", "My-SQL", "Данные были успешно найдены в таблице <B>overseer.rep".$rep."</B>.");
      else:
        // произошёл сбой при попытке удаления некорректных данных из таблицы данных overseer.rep1
        ShowErrorMessage("Произошёл сбой при попытке получения данных из таблицы <B>overseer.rep".$rep."</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
        die("");
      endif;
      $result_array=array();
      for ($j=0;$j<($num_rows);$j++):
        $tmp_array=mysql_fetch_assoc($table);
        $result_array[]=$tmp_array;
      endfor;
      $bodymessage.="
        <TR>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">Итого:</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">&#151;</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">".$result_array[0]["f1"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">".$result_array[0]["f2"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">".$result_array[0]["f3"]."</TD>
          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">".$result_array[0]["f4"]."</TD>
";
        if ($HIDECALLSTOPAY!="on"):
        $bodymessage.="          <TD STYLE=\"text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 7pt; font-weight: bold; padding: 2px;\">".$result_array[0]["f5"]."</TD>
";
      endif;
      $bodymessage.="        </TR>
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"".(7-($HIDECALLSTOPAY=="on"))."\" STYLE=\"text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">* - сумма длительностей в секундах каждого из звонков<BR>** - сумма длительностей в минутах каждого из звонков<BR>*** - количество звонков, которое будет включено в список счетов на оплату для АСКР</TD>
        </TR>
";
      $bodymessage.="
        <TR>
          <TD VALIGN=\"TOP\" COLSPAN=\"".(7-($HIDECALLSTOPAY=="on"))."\" STYLE=\"text-align: left; font-size: 7pt; border-color: white; border-width: 0; padding-top: 20px;\">";
      if (($maker!="")||($makerstate!="")||($makerphone!="")) $bodymessage.="Исполнитель:";
      if ($makerstate!="") $bodymessage.="<BR>$makerstate";
      if ($maker!="") $bodymessage.="<BR>$maker";
      if ($makerphone!="") $bodymessage.="<BR>$makerphone";
      $bodymessage.="</TD>
        <TR>
           <TD COLSPAN=\"".(7-($HIDECALLSTOPAY=="on"))."\" HEIGHT=\"20\" STYLE=\"text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\"></TD>
        </TR>
        <TR>
           <TD COLSPAN=\"".(7-($HIDECALLSTOPAY=="on"))."\" STYLE=\"text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;\">Отчёт подготовлен $d ".$months2[$m]." $y года в ".date("H:i:s")." при помощи программного комплекса &laquo;OVERSEER&raquo;, &copy;&nbsp;2006&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>
        </TR>
      </TBODY>
    </TABLE>
    </CENTER>
";
      if ($action=="print"):
        PrintMessage("INFORMATION", "Info", "Выполняется вывод отчёта на экран для просмотра/печати. Рабочая область отчёта закрашена белым цветом.");
        echo $bodymessage;
      elseif ($action=="email"):
        PrintMessage("INFORMATION", "Info", "Выполняется отправка отчёта указанным адресатам (см. выше).");
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
".$bodymessage."
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
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL1Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL1Name!=""): $s=" <B>$EMAIL1Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL1Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL2Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL2Name!=""): $s=" <B>$EMAIL2Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL2Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
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
            $d=$DEBUG;
            $DEBUG="on";
            PrintMessage("SUCCESS", "Инфо", "Отправка отчёта$s по адресу <B>$EMAIL3Addr</B> прошла успешно.");
            $DEBUG=$d;
          else:
            if ($EMAIL3Name!=""): $s=" <B>$EMAIL3Name</B>"; endif;
            ShowErrorMessage("Не удалось отправить отчёт$s по адресу <B>$EMAIL3Addr</B>!<BR>Обратитесь к инженеру-программисту или системному администратору!");
?>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;
      endif;
      mysql_close($MySQLConnection);
      PrintMessage("SUCCESS", "My-SQL", "Выполнено отключение от MySQL-сервера <B>$HostName</B>.");
?>
  </BODY>
</HTML>