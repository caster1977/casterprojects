/*
  case 4: // страница выбора пользователем действия, производимого над отчётом: печать, просмотр, отправка по мылу, факсу и т.п.
    if (($rep==1)||($rep==2)||($rep==4)||($rep==5)||($rep==8)) $rowcount=6; elseif (($rep==3)||($rep==6)||($rep==7)||($rep==9)||($rep==10)) $rowcount=5; else $rowcount=2;
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR><TD BGCOLOR="WHITE" COLSPAN="4"><H1><?echo $title?></H1></TD></TR>
          <TR VALIGN="MIDDLE" HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" WIDTH="50%" BGCOLOR="#FFFFFF">Отчёт:</TH><TD WIDTH="50%" BGCOLOR="#EEEEEE"><?print $reports[$rep]["Наименование"]; ?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" BGCOLOR="#EEEEEE">Комментарии:</TH><TD BGCOLOR="#FFFFFF"><?if (!($reports[$rep]["Комментарии"]=="")) echo $reports[$rep]["Комментарии"]; else echo "&#151;";?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#FFFFFF">Промежуток времени:</TH>
            <TD BGCOLOR="#EEEEEE">
<?
    switch ($time):
      case "yesterday":
        if ($ldd<10) print "0"; print "$ldd $months2[$ldm] $ldy года";
      break;
      case "lastweek":
        if ($lwbd<10) print "0";
        print "$lwbd $months2[$lwbm] $lwby года - ";
        if ($lwed<10) print "0";
        print "$lwed $months2[$lwem] $lwey года";
      break;
      case "lastmonth":
        print "$months[$lmm] $lmy года";
      break;
      case "lastquart":
        print "$quartals[$lqq] квартал $lqy года";
      break;
      case "anothermonth":
        print "$months[$amm] $amy года";
      break;
      case "anotherquart":
        print "$quartals[$aqq] квартал $aqy года";
      break;
      case "another":
        if (($abd==$aed)&&($abm==$aem)&&($aby==$aey)):
          print "$abd $months2[$abm] $aby года";
        else:
          print "$abd $months2[$abm] $aby года - $aed $months2[$aem] $aey года";
        endif;
      break;
    endswitch;
?>
            </TD>
          </TR>
<?
    if (($rep==1)||($rep==2)):
      $s="";
      if ($C009=="on") $s .= "009 &#151; $services[009]<BR>";
      if ($C075=="on"): $s .= "075 &#151; $services[075]<BR>"; endif;
      if ($C088=="on"): $s .= "088 &#151; $services[088]<BR>"; endif;
      if ($C090=="on"): $s .= "090 &#151; $services[090]<BR>"; endif;
      if ($C091=="on"): $s .= "091 &#151; $services[091]<BR>"; endif;
      if ($C092=="on"): $s .= "092 &#151; $services[092]<BR>"; endif;
      if ($C093=="on"): $s .= "093 &#151; $services[093]<BR>"; endif;
      if ($C094=="on"): $s .= "094 &#151; $services[094]<BR>"; endif;
      if ($C095=="on"): $s .= "095 &#151; $services[095]<BR>"; endif;
      if ($C096=="on"): $s .= "096 &#151; $services[096]<BR>"; endif;
      if ($C097=="on"): $s .= "097 &#151; $services[097]<BR>"; endif;
      if ($C098=="on"): $s .= "098 &#151; $services[098]<BR>"; endif;
      if ($C099=="on"): $s .= "099 &#151; $services[099]<BR>"; endif;
      if ($C9900911=="on"): $s .= "9900911 &#151; $services[9900911]<BR>"; endif;
      if ($C9909111=="on"): $s .= "9909111 &#151; $services[9909111]<BR>"; endif;
      if ($C9909911=="on"): $s .= "9909911 &#151; $services[9909911]<BR>"; endif;
      if ($C99075=="on"): $s .= "99075 &#151; $services[99075]<BR>"; endif;
      if ($C99088=="on"): $s .= "99088 &#151; $services[99088]<BR>"; endif;
      if ($C99091=="on"): $s .= "99091 &#151; $services[99091]<BR>"; endif;
      if ($C99092=="on"): $s .= "99092 &#151; $services[99092]<BR>"; endif;
      if ($C99094=="on"): $s .= "99094 &#151; $services[99094]<BR>"; endif;
      if ($C99095=="on"): $s .= "99095 &#151; $services[99095]<BR>"; endif;
      if ($C99096=="on"): $s .= "99096 &#151; $services[99096]<BR>"; endif;
      if ($C99097=="on"): $s .= "99097 &#151; $services[99097]<BR>"; endif;
?>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#EEEEEE">Услуги:
              <INPUT TYPE="HIDDEN" NAME="C009" VALUE="<?print $C009;?>">
              <INPUT TYPE="HIDDEN" NAME="C075" VALUE="<?print $C075;?>">
              <INPUT TYPE="HIDDEN" NAME="C088" VALUE="<?print $C088;?>">
              <INPUT TYPE="HIDDEN" NAME="C090" VALUE="<?print $C090;?>">
              <INPUT TYPE="HIDDEN" NAME="C091" VALUE="<?print $C091;?>">
              <INPUT TYPE="HIDDEN" NAME="C092" VALUE="<?print $C092;?>">
              <INPUT TYPE="HIDDEN" NAME="C093" VALUE="<?print $C093;?>">
              <INPUT TYPE="HIDDEN" NAME="C094" VALUE="<?print $C094;?>">
              <INPUT TYPE="HIDDEN" NAME="C095" VALUE="<?print $C095;?>">
              <INPUT TYPE="HIDDEN" NAME="C096" VALUE="<?print $C096;?>">
              <INPUT TYPE="HIDDEN" NAME="C097" VALUE="<?print $C097;?>">
              <INPUT TYPE="HIDDEN" NAME="C098" VALUE="<?print $C098;?>">
              <INPUT TYPE="HIDDEN" NAME="C099" VALUE="<?print $C099;?>">
              <INPUT TYPE="HIDDEN" NAME="C9900911" VALUE="<?print $C9900911;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909111" VALUE="<?print $C9909111;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909911" VALUE="<?print $C9909911;?>">
              <INPUT TYPE="HIDDEN" NAME="C99075" VALUE="<?print $C99075;?>">
              <INPUT TYPE="HIDDEN" NAME="C99088" VALUE="<?print $C99088;?>">
              <INPUT TYPE="HIDDEN" NAME="C99091" VALUE="<?print $C99091;?>">
              <INPUT TYPE="HIDDEN" NAME="C99092" VALUE="<?print $C99092;?>">
              <INPUT TYPE="HIDDEN" NAME="C99094" VALUE="<?print $C99094;?>">
              <INPUT TYPE="HIDDEN" NAME="C99095" VALUE="<?print $C99095;?>">
              <INPUT TYPE="HIDDEN" NAME="C99096" VALUE="<?print $C99096;?>">
              <INPUT TYPE="HIDDEN" NAME="C99097" VALUE="<?print $C99097;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_VOICE" VALUE="<?print $CHECK_ALL_VOICE;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_AUTO" VALUE="<?print $CHECK_ALL_AUTO;?>">
            </TH>
            <TD BGCOLOR="#FFFFFF"><?print $s;?></TD>
          </TR>
<?
    elseif (($rep==4)||($rep==5)||($rep==8)):
      $s="";
      if ($makerstate!="")
        $s.="$makerstate";
      if ($maker!=""):
        if ($s!="") $s.=" ";
        $s.="$maker";
      endif;
      if ($makerphone!=""):
        if ($s!="") $s .=", ";
        $s.="телефон: $makerphone";
      endif;
?>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#EEEEEE">Исполнитель:</TH>
            <TD BGCOLOR="#FFFFFF"><?print $s;?></TD>
          </TR>
<?
    endif;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="3">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==6)||($rep==7)||($rep==9)||($rep==10)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?print $maker;?>">
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?print $makerstate;?>">
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?print $makerphone;?>">
<?
    endif;
    if ($rep==5):
?>
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
    if ((($rep==1)||($rep==2)||($rep==5)||($rep==6)||($rep==7))&&($RECALC!="")):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)):
?>
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?print $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?print $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?print $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?print $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?print $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?print $aey;?>">
<?
    endif;
    if ($rep==3):
?>
              <INPUT TYPE="HIDDEN" NAME="F_DDBD" VALUE="<?print $F_DDBD;?>">
              <INPUT TYPE="HIDDEN" NAME="F_DDBPN" VALUE="<?print $F_DDBPN;?>">
              <INPUT TYPE="HIDDEN" NAME="F_SONT" VALUE="<?print $F_SONT;?>">
              <INPUT TYPE="HIDDEN" NAME="F_DATE" VALUE="<?print $F_DATE;?>">
              <INPUT TYPE="HIDDEN" NAME="F_FIO" VALUE="<?print $F_FIO;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PRIVATENUMBER" VALUE="<?print $F_PRIVATENUMBER;?>">
              <INPUT TYPE="HIDDEN" NAME="F_RM" VALUE="<?print $F_RM;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WORKBEGINTIME" VALUE="<?print $F_WORKBEGINTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WORKENDTIME" VALUE="<?print $F_WORKENDTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WAITTIME" VALUE="<?print $F_WAITTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WORKTIME" VALUE="<?print $F_WORKTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PROCESSMIDDLETIME" VALUE="<?print $F_PROCESSMIDDLETIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WAITMIDDLETIME" VALUE="<?print $F_WAITMIDDLETIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PROCESSEDALL" VALUE="<?print $F_PROCESSEDALL;?>">
              <INPUT TYPE="HIDDEN" NAME="F_NOTPROCESSED" VALUE="<?print $F_NOTPROCESSED;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PROCESSED" VALUE="<?print $F_PROCESSED;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
    if (($rep==1) && ($C009!="on") && ($C075!="on") && ($C088!="on") && ($C090!="on") && ($C091!="on") && ($C092!="on") && ($C093!="on") && ($C094!="on") && ($C095!="on") && ($C096!="on") && ($C097!="on") && ($C098!="on") && ($C099!="on") && ($C9900911!="on") && ($C9909111!="on") && ($C9909911!="on") && ($C99075!="on") && ($C99088!="on") && ($C99091!="on") && ($C99092!="on") && ($C99094!="on") && ($C99095!="on") && ($C99096!="on") && ($C99097!="on")):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Вы должны выбрать хотя бы одну из услуг СИЦ для формирования данного отчёта!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к шагу выбора услуг СИЦ.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <!--TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR-->
        <!--TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR-->
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
      die("");
    endif;
    if ((($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==8))&&(($maker=="")||($makerstate=="")||($makerphone==""))):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Вы должны заполнить поле &laquo;<?if ($maker==""): echo "Фамилия, инициалы"; elseif ($makerstate==""): echo "Должность"; elseif ($makerphone==""): echo "Контактный телефон"; endif;?> исполнителя&raquo; для формирования данного отчёта!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к шагу выбора услуг СИЦ.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <!--TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR-->
        <!--TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR-->
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
      die("");
    endif;
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)): $rowcount=21-4;
    elseif (($rep==9)||($rep==10)): $rowcount=3;
    else: $rowcount=3;
    endif;
?>
          <TR VALIGN="MIDDLE" HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD></TR>
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)):
?>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"><B>Выберите действие, которое необходимо выполнить:</B></TD></TR>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
<?
      // if ($rep==1) $action="email";
      if ($action==""): if ($rep==1) $action="print"; elseif (($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)) $action="print"; endif;
      if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)) $orientation="книжная";
      elseif (($rep==6)||($rep==7)||($rep==8)) $orientation="альбомная"; // указание ориентации страницы для отчётов
?>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="action" VALUE="print" STYLE='height:13px;'<?if ($action=="print") print " CHECKED";?>><B>визуальный просмотр, подготовка к печати</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT"" COLSPAN="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B><FONT COLOR="#FF0000">Внимание!</FONT></B> Для печати необходимо выставить в меню <B>|Файл|Параметры страницы&#133;|</B> следующие параметры страницы:</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ слева:</TD><TD><B><?if ($orientation=="книжная") print "20.00"; elseif ($orientation=="альбомная") print "5.00";?></B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ справа:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ сверху:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ снизу:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ориентация страницы:</TD><TD><B><?print $orientation;?></B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Нижний колонтитул:</TD><TD><B>&b&bСтраница &p из &P</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="action" VALUE="email" STYLE='height:13px;'<?if ($action=="email") print " CHECKED";?>><B>отправка по электронной почте</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT" WIDTH="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите первого получателя:</TD><TD>Куда: <INPUT TYPE="TEXT" NAME="EMAIL1Addr" SIZE="30" VALUE="<?if ($rep==1) print "irai@mgts.by"?>"><BR>Кому: <INPUT TYPE="TEXT" NAME="EMAIL1Name" SIZE="30" VALUE="<?if ($rep==1) print "Илюк Ирине Михайловне";?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите второго получателя:</TD><TD>Куда: <INPUT TYPE="TEXT" NAME="EMAIL2Addr" SIZE="30" VALUE=""><BR>Кому: <INPUT TYPE="TEXT" NAME="EMAIL2Name" SIZE="30" VALUE=""></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите третьего получателя:</TD><TD>Куда: <INPUT TYPE="TEXT" NAME="EMAIL3Addr" SIZE="30" VALUE=""><BR>Кому: <INPUT TYPE="TEXT" NAME="EMAIL3Name" SIZE="30" VALUE=""></TD></TR>
<!--
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="action" VALUE="save" STYLE='height:13px;'<?if ($action=="save") print " CHECKED";?>><B>сохранение в файл на диске</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT" WIDTH="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите путь для сохранения файла:</TD><TD><INPUT TYPE="TEXT" NAME="SAVEPATH" SIZE="30" VALUE="C:\"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Выберите формат файла:</TD><TD><SELECT NAME="savefiletype"><OPTION VALUE="htm" CHECKED>htm</OPTION><OPTION VALUE="txt">txt</OPTION><OPTION VALUE="csv">csv</OPTION></SELECT></TD></TR>
-->
<?
    elseif (($rep==9)||($rep==10)):
?>
          <TR><TD VALIGN="MIDDLE" ALIGN="CENTER" COLSPAN="2"><B>Отсутствет выбор действий для формирования выбранного отчёта</B></TD></TR>
<?
    endif;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="5">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==6)||($rep==7)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if ($rep==5):
?>
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?print $maker;?>">
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?print $makerstate;?>">
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?print $makerphone;?>">
<?
    endif;
    if ((($rep==1)||($rep==2)||($rep==5)||($rep==6)||($rep==7))&&($RECALC!="")):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)):
?>
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?print $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?print $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?print $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?print $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?print $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?print $aey;?>">
<?
    endif;
    if (($rep==1)||($rep==2)):
?>
              <INPUT TYPE="HIDDEN" NAME="C009" VALUE="<?print $C009;?>">
              <INPUT TYPE="HIDDEN" NAME="C075" VALUE="<?print $C075;?>">
              <INPUT TYPE="HIDDEN" NAME="C088" VALUE="<?print $C088;?>">
              <INPUT TYPE="HIDDEN" NAME="C090" VALUE="<?print $C090;?>">
              <INPUT TYPE="HIDDEN" NAME="C091" VALUE="<?print $C091;?>">
              <INPUT TYPE="HIDDEN" NAME="C092" VALUE="<?print $C092;?>">
              <INPUT TYPE="HIDDEN" NAME="C093" VALUE="<?print $C093;?>">
              <INPUT TYPE="HIDDEN" NAME="C094" VALUE="<?print $C094;?>">
              <INPUT TYPE="HIDDEN" NAME="C095" VALUE="<?print $C095;?>">
              <INPUT TYPE="HIDDEN" NAME="C096" VALUE="<?print $C096;?>">
              <INPUT TYPE="HIDDEN" NAME="C097" VALUE="<?print $C097;?>">
              <INPUT TYPE="HIDDEN" NAME="C098" VALUE="<?print $C098;?>">
              <INPUT TYPE="HIDDEN" NAME="C099" VALUE="<?print $C099;?>">
              <INPUT TYPE="HIDDEN" NAME="C9900911" VALUE="<?print $C9900911;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909111" VALUE="<?print $C9909111;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909911" VALUE="<?print $C9909911;?>">
              <INPUT TYPE="HIDDEN" NAME="C99075" VALUE="<?print $C99075;?>">
              <INPUT TYPE="HIDDEN" NAME="C99088" VALUE="<?print $C99088;?>">
              <INPUT TYPE="HIDDEN" NAME="C99091" VALUE="<?print $C99091;?>">
              <INPUT TYPE="HIDDEN" NAME="C99092" VALUE="<?print $C99092;?>">
              <INPUT TYPE="HIDDEN" NAME="C99094" VALUE="<?print $C99094;?>">
              <INPUT TYPE="HIDDEN" NAME="C99095" VALUE="<?print $C99095;?>">
              <INPUT TYPE="HIDDEN" NAME="C99096" VALUE="<?print $C99096;?>">
              <INPUT TYPE="HIDDEN" NAME="C99097" VALUE="<?print $C99097;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_VOICE" VALUE="<?print $CHECK_ALL_VOICE;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_AUTO" VALUE="<?print $CHECK_ALL_AUTO;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="Далее >>>">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;





  case 5: // шаг - вывод отчёта на экран и прочие действия (отправка по эл. почте, на факс, сохранение в файл на диске)
    $DEBUG="off";

    // копирование необходимых файлов по FTP
    if (($rep==9)||($rep==10)):
      $ftp_server="10.1.1.2";
      $conn_id=ftp_connect($ftp_server);
      if ($conn_id<1) die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD ALIGN=\"CENTER\" WIDTH=\"62px\" STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">FTP</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">Не удалось установить соединение с FTP-сервером <B>$ftp_server</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
      $login_result=ftp_login($conn_id, "root", "kron");
      if ((!$conn_id)||(!$login_result)) die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD ALIGN=\"CENTER\" WIDTH=\"62px\" STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">FTP</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">Не удалось подключиться к FTP-серверу <B>$ftp_server</B> под указанным логином и паролем! Обратитесь к администратору сети.</TD></TR></TABLE>\n  </BODY>\n</HTML>");
      else
        if ($DEBUG=="on"):
?>
    <TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">FTP</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Соединение с FTP-сервером <B><?echo $ftp_server;?></B> разорвано.</TD></TR></TBODY></TABLE>
<?
        endif;
      ftp_quit($conn_id);
      if ($DEBUG=="on"):
?>
    <TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">FTP</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Успешно установлено соединение с FTP-сервером <B><?echo $ftp_server;?></B>.</TD></TR></TBODY></TABLE>
<?
      endif;
    endif;

    // производим подключение к серверу 10.1.1.250 - по умолчанию данные берутся на сервере MAINSERVER, а уже в случае неудачи - с DBSERVER

    $HostName="10.1.1.250";
    $UserName="sel";
    $Password="";
    $DBName="newstat";
    $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
    MYSQL_SELECT_DB("$DBName") OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
    if ($DEBUG=="on"):
?>
    <TABLE BORDER="1" ALIGN="CENTER" STYLE="margin-bottom: 1px; border-color: black; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">My-SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Удалось установить подключение к БД <B><?echo $DBName;?></B> на MySQL-сервере <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE>
<?
    endif;









































    // формирование отчёта #1

    if ($rep==1):
      if ($time=="lastweek"):
        $startday=$lwbd;
        $stopday=$lwed;
        $startmonth=$lwbm;
        $stopmonth=$lwem;
        $startyear=$lwby;
        $stopyear=$lwey;
      elseif ($time=="yesterday"):
        $startday=$ldd;
        $stopday=$ldd;
        $startmonth=$ldm;
        $stopmonth=$ldm;
        $startyear=$ldy;
        $stopyear=$ldy;
      elseif ($time=="lastmonth"):
        $startday=$lmbd;
        $stopday=$lmed;
        $startmonth=$lmm;
        $stopmonth=$lmm;
        $startyear=$lmy;
        $stopyear=$lmy;
      elseif ($time=="anothermonth"):
        $startday=$amd;
        $stopday=$amd;
        $startmonth=$amm;
        $stopmonth=$amm;
        $startyear=$amy;
        $stopyear=$amy;
      elseif ($time=="another"):
        $startday=$abd;
        $stopday=$aed;
        $startmonth=$abm;
        $stopmonth=$aem;
        $startyear=$aby;
        $stopyear=$aey;
      endif;

      // заполнение вспомогательного массива, в котором содержатся данные о том, нужно ли выводить на печать определённую услугу или нет
      $a[0]=$C009; $a[1]=$C075; $a[2]=$C088; $a[3]=$C090; $a[4]=$C091; $a[5]=$C092; $a[6]=$C093; $a[7]=$C094; $a[8]=$C095; $a[9]=$C096; $a[10]=$C097; $a[11]=$C098; $a[12]=$C099; $a[13]=$C9900911; $a[14]=$C9909111; $a[15]=$C9909911; $a[16]=$C99075; $a[17]=$C99088; $a[18]=$C99091; $a[19]=$C99092; $a[20]=$C99094; $a[21]=$C99095; $a[22]=$C99095; $a[23]=$C99096; $a[24]=$C99097;

      $currentd=$startday+0;
      $currentm=$startmonth+0;
      $currenty=$startyear+0;
      $daycount=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth,$startday,$startyear);

      if ($daycount>=0): // количество дней участвующих в отчёте больше, чем 0 - начинаем выводить отчёт
        // формирование заголовка отчёта для дальнейшего его вывода
        $title="Статистика&nbsp;по&nbsp;услугам&nbsp;СИЦ "; if (($time=="lastmonth")||($time=="anothermonth")||(($time=="another")&&(($startday==$lmbd)&&($startmonth==$lmm)&&($startyear==$lmy)&&($stopday==$lmed)&&($stopmonth==$lmm)&&($stopyear==$lmy)))): $title.="за&nbsp;$months[$startmonth]&nbsp;$startyear&nbsp;года"; elseif ((($time=="another")&&(($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear)))||($time=="yesterday")): $title.="за&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года"; else: $title.="за&nbsp;период с&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года по&nbsp;$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;года"; endif;
?>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border-width: 0; border-style: solid; border-color: black; font-size: 8pt">
      <TBODY>
        <TR STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><H1><?echo $title;?></H1></TD></TR>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid black;"><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px;">Телефон<BR>службы</TH><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 2px 0;">Наименование<BR>службы</TH><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 2px 0;">Обслужено<BR>звонков</TH><TH COLSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 1px 0;">Длительность<BR>звонков</TH><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 2px 0;">Среднее&nbsp;время<BR>звонка&nbsp;(в&nbsp;сек.)</TH><TH ROWSPAN="2" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Звонков<BR>к&nbsp;оплате***</TH></TR>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid black;"><TH STYLE="border-color: black; border-style: solid; border-width: 0 1px 2px 0;">в&nbsp;сек.*</TH><TH STYLE="border-color: black; border-style: solid; border-width: 0 2px 2px 0;">в&nbsp;мин.**</TH></TR>
        <TR ALIGN="CENTER" STYLE="font-size: 6pt;"><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 2px;"><B>I</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>II</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>III</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 1px 2px 0;"><B>IV</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>V</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>VI</B><BR><FONT STYLE="font-size: 6pt;">(ст. IV / ст. III)</FONT></TD><TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>VII</B><BR><FONT STYLE="font-size: 6pt;"></FONT></TD></TR>
<?
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Проверка наличия таблицы <B>newstat.rep1</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
        // проверка на наличие таблицы newstat.rep1
        $q="SHOW TABLES FROM newstat LIKE 'rep1';";
        if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
        endif;
        $table=MYSQL_QUERY($q);
        $num_rows=MYSQL_NUM_ROWS($table);
        if ($num_rows!=0):
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>newstat.rep1</B> успешно найдена.</TD></TR></TABLE></TD></TR>
<?
          endif;
        else:
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>newstat.rep1</B> не найдена!</TD></TR></TABLE></TD></TR>
<?
          endif;
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Создание таблицы <B>newstat.rep1</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
          $len=0;
          for ($j=0;$j<count($servicelist);$j++)
            if ($len<strlen($servicelist[$j]))
              $len=strlen($servicelist[$j]);
          $q="CREATE TABLE newstat.rep1 (service char($len) NOT NULL default '', year_month_day char(8) NOT NULL default '', served_calls int(10) unsigned default NULL, duration_in_sec int(10) unsigned default NULL, duration_in_min int(10) unsigned default NULL, average_duration_in_sec decimal(10,2) default NULL, calls_to_pay int(10) unsigned default NULL) TYPE=MyISAM;";
          MYSQL_QUERY($q);
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
          $q="SHOW TABLES FROM newstat LIKE 'rep1';";
          $table=MYSQL_QUERY($q);
          $num_rows=MYSQL_NUM_ROWS($table);
          if ($num_rows!=0):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>newstat.rep1</B> успешно найдена.</TD></TR></TABLE></TD></TR>
<?
            endif;
          else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Не удаётся создать таблицу <B>newstat.rep1</B>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;

// НАЧАЛО ЦИКЛА

        while ($i>=0):
          if ($currentd<10) $cd="0$currentd"; else $cd="$currentd";
          if ($currentm<10) $cm="0$currentm"; else $cm="$currentm";
          $flag1=0; // устанавливаем флаг нахождения в ноль ("не найдено")
// ПОДКЛЮЧЕНИЕ К MySQL-СЕРВЕРУ MAINSERVER В СЛУЧАЕ, ЕСЛИ ДАННОГО ПОДКЛЮЧЕНИЯ УЖЕ НЕТ
          if ($HostName!="10.1.1.250"):
            MYSQL_CLOSE($MYSQLCON);
            $HostName="10.1.1.250";
            $UserName="sel";
            $Password="";
            $DBName="newstat";
            $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            MYSQL_SELECT_DB("$DBName") OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD WIDTH="62px" ALIGN="CENTER" STYLE="border-color: white; border-style: solid; border-width: 0;">Удалось установить подключение к БД <B><?echo $DBName;?></B> на MySQL-сервере <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
          endif;
// УДАЛЕНИЕ СТАРЫХ ДАННЫХ ЗА ДЕНЬ ПО ВСЕМ УСЛУГАМ ЗА "ТЕКУЩИЙ" РАСЧЁТНЫЙ ДЕНЬ
          if ($RECALC=="on"):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Удаление ранее расчитанных данных из таблицы <B>newstat.rep1</B> за <?echo "$currentd $months2[$currentm] $currenty года";?>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            for ($serv=0;$serv<count($servicelist);$serv++):
              if ($a[$serv]=="on"):
                $q="DELETE FROM newstat.rep1 WHERE year_month_day='$currenty$cm$cd' AND service='$servicelist[$serv]';";
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                MYSQL_QUERY($q);
              endif;
            endfor;
          endif;
// ПОИСК РАСЧИТАННЫХ ДАННЫХ ПО "ТЕКУЩЕЙ" УСЛУГЕ ЗА "ТЕКУЩУЮ" РАСЧЁТНУЮ ДАТУ В ТАБЛИЦЕ newstat.rep1
            for ($serv=0;$serv<count($servicelist);$serv++):
              if ($a[$serv]=="on"):
                $flag2=0; // устанавливаем флаг уже расчитанного результата в 0 ("не найден")
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Поиск ранее расчитанных данных по услуге <B><?echo "$servicelist[$serv]";?></B> в таблице <B>newstat.rep1</B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                $q="SELECT COUNT(*) AS f1 FROM newstat.rep1 WHERE year_month_day='$currenty$cm$cd' AND service='$servicelist[$serv]';";
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                $table=MYSQL_QUERY($q);
                $num_rows=MYSQL_NUM_ROWS($table);
                if ($num_rows==1):
                  $f1=MYSQL_RESULT($table, 0, "f1");
                  if ($f1==1):
                    if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Ранее расчитанный результат по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B> успешно найден.</TD></TR></TABLE></TD></TR>
<?
                    endif;
                    $flag2=1; // устанавливаем флаг нахождения уже расчитанного результата в 1 ("найден")
                  else:
                    if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Данные по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B> в таблице <B>newstat.rep1</B> не найдены!</TD></TR></TABLE></TD></TR>
<?
                    endif;
                  endif;
                else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Сбой при получении данных по услуге <?echo "$servicelist[$serv]";?> за <?echo "$currentd $months2[$currentm] $currenty года";?> из таблицы newstat.rep1! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                  die("");
                endif;
// В ЗАВИСИМОСТИ ОТ ТОГО НАЙДЕНЫ ЛИ ДАННЫЕ ЗА "ТЕКУЩИЙ" РАСЧЁТНЫЙ ДЕНЬ ПО "ТЕКУЩЕЙ" УСЛУГЕ В ТАБЛИЦЕ newstat.rep1
                if ($flag2!=1):
// ЕСЛИ ДАННЫЕ НЕ БЫЛИ НАЙДЕНЫ - ДЕЛАЕМ РАСЧЁТ ДАННЫХ И ЗАНЕСЕНИЕ ИХ В ТАБЛИЦУ newstat.rep1
  // ПООЧЕРЁДНОЕ ПРОВЕДЕНИЕ ПОИСКА ТАБЛИЦ И ИНФОРМАЦИИ В ТАБЛИЦАХ mainserver@arj.ird_ггггммдд, mainserver@arj.irda_ггггмм, dbserver@statistika.ird_ггггммдд
                  $current_table="arj.ird_$currenty$cm$cd";
    // ЕСЛИ ДАННЫЕ БЫЛИ НАЙДЕНЫЙ В ПЕРВОЙ ТАБЛИЦЕ - УСТАНАВЛИВАЕМ ФЛАГ НАХОЖДЕНИЯ
    // ЕСЛИ ФЛАГ НАХОЖДЕНИЯ НЕ УСТАНОВЛЕН, ПРОВОДИМ ПОИСК ВО ВТОРОЙ ТАБЛИЦЕ
    // ЕСЛИ ДАННЫЕ БЫЛИ НАЙДЕНЫЙ ВО ВТОРОЙ ТАБЛИЦЕ - УСТАНАВЛИВАЕМ ФЛАГ НАХОЖДЕНИЯ
    // ЕСЛИ ФЛАГ НАХОЖДЕНИЯ НЕ УСТАНОВЛЕН, ПРОИЗВОДИМ ПЕРЕКЛЮЧЕНИЕ НА dbserver И ПРОВОДИМ ПОИСК ВО ТРЕТЕЙ ТАБЛИЦЕ
    // ЕСЛИ ДАННЫЕ БЫЛИ НАЙДЕНЫЙ ВО ТРЕТЕЙ ТАБЛИЦЕ - УСТАНАВЛИВАЕМ ФЛАГ НАХОЖДЕНИЯ
    // ЕСЛИ ФЛАГ НАХОЖДЕНИЯ НЕ УСТАНОВЛЕН - ВЫХОДИМ ПО ОШИБКЕ "Данные не найдены!"
  // ЕСЛИ ФЛАГ НАХОДЕНИЯ УСТАНОВЛЕН - ВЫПОЛНЯЕМ ЗАПРОСЫ
    // ВЫПОЛНЯЕМ ЗАПРОС НА РАСЧЁТ ДАННЫХ ПО ОБСЛУЖЕННЫМ АБОНЕНТАМ, ДЛИТЕЛЬНОСТЯМ И СРЕДНЕМУ ВРЕМЕНИ ЗВОНКА
                  $row1="$servicelist[$serv]";
                  $row2="$currenty$cm$cd";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Расчёт количества обслуженных звонков, длительности звонков и среднего времени звонка по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $q="SELECT COUNT(*) AS row3, SUM(dur) AS row4, SUM(SEC_TO_TIME(CEILING(dur/60))) AS row5, SUM(dur)/COUNT(*) AS row6 FROM $current_table WHERE $service_servedcondition[$row1] AND datum='$currenty-$cm-$cd';";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows==1):
                    $row3=MYSQL_RESULT($table, 0, "row3");
                    $row4=MYSQL_RESULT($table, 0, "row4");
                    $row5=MYSQL_RESULT($table, 0, "row5");
                    $row6=MYSQL_RESULT($table, 0, "row6");
                    if ($row3=="") $row3=0;
                    if ($row4=="") $row4=0;
                    if ($row5=="") $row5=0;
                    if ($row6=="") $row6=0;
                    if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество обслуженных звонков, длительности звонков и среднее время звонка по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B> успешно расчитаны.</TD></TR></TABLE></TD></TR>
<?
                    endif;
                  else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Сбой при расчёте количества обслуженных звонков, длительности звонков и среднего времени звонка по услуге <?echo "$servicelist[$serv]";?> за <?echo "$currentd $months2[$currentm] $currenty года";?>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                    die("");
                  endif;
    // ВЫПОЛНЯЕМ ЗАПРОС НА РАСЧЁТ ДАННЫХ ПО ОПЛАЧИВАЕМЫМ ЗВОНКАМ
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Расчёт количества звонков к оплате по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $q="SELECT COUNT(*) AS row7 FROM $current_table WHERE $service_billingcondition[$row1] AND datum='$currenty-$cm-$cd';";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows==1):
                    $row7=MYSQL_RESULT($table, 0, "row7");
                    if ($row7!=""):
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество подлежащих оплате звонков по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B> успешно расчитано.</TD></TR></TABLE></TD></TR>
<?
                      endif;
    // ДОБАВЛЯЕМ В БАЗУ РАСЧИТАННЫЕ ДАННЫЕ
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Добавление расчитанных данных по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B> в таблицу <B>newstat.rep1</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                      endif;
                      $q="INSERT INTO newstat.rep1(service, year_month_day, served_calls, duration_in_sec, duration_in_min, average_duration_in_sec, calls_to_pay) VALUES ('$row1', '$row2', $row3, $row4, $row5, $row6, $row7);";
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                      endif;
                      MYSQL_QUERY($q);
                    else:
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Не удалось расчитать количество подлежащих оплате звонков по услуге <B><?echo "$servicelist[$serv]";?></B> за <B><?echo "$currentd $months2[$currentm] $currenty года";?></B>!</TD></TR></TABLE></TD></TR>
<?
                      endif;
                    endif;
                  else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Сбой при расчёте количества подлежащих оплате звонков по услуге <?echo "$servicelist[$serv]";?> за <?echo "$currentd $months2[$currentm] $currenty года";?>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                    die("");
                  endif;
                endif;
              endif;
            endfor;
          // инкрементация даты
          $ncurrentd=date("d",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrentm=date("m",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrenty=date("Y",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $currentd=$ncurrentd;
          $currentm=$ncurrentm;
          $currenty=$ncurrenty;
          $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$currentm+0,$currentd+0,$currenty+0);
        endwhile;


        for ($serv=0;$serv<count($servicelist);$serv++):
          if ($a[$serv]=="on"):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Получение итоговых данных по услуге <B><?echo $servicelist[$serv];?></B> за период с <B><?echo "$startday $months2[$startmonth] $startyear";?> года</B> по <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> года</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $q="SELECT service AS f1, SUM(served_calls) AS f2, SUM(duration_in_sec) AS f3, SUM(duration_in_min) AS f4, SUM(duration_in_sec)/sum(served_calls) AS f5, SUM(calls_to_pay) AS f6 FROM newstat.rep1 WHERE (service='$servicelist[$serv]') AND (year_month_day BETWEEN '$startyear";
            if ($startmonth<10) $q.="0";
            $q.="$startmonth";
            if ($startday<10) $q.="0";
            $q.="$startday' AND '$stopyear";
            if ($stopmonth<10) $q.="0";
            $q.="$stopmonth";
            if ($stopday<10) $q.="0";
            $q.="$stopday') GROUP BY service;";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows==1):
              $f1=MYSQL_RESULT($table, 0, "f1");
              $f2=MYSQL_RESULT($table, 0, "f2");
              $f3=MYSQL_RESULT($table, 0, "f3");
              $f4=MYSQL_RESULT($table, 0, "f4");
              $f5=MYSQL_RESULT($table, 0, "f5");
              $f6=MYSQL_RESULT($table, 0, "f6");
              if (($f1!=0)||($f2!="")||($f3!="")||($f4!="")||($f5!="")||($f6!="")):
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Данные по услуге <B><?echo $servicelist[$serv];?></B> за период с <B><?echo "$startday $months2[$startmonth] $startyear";?> года</B> по <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> года</B> успешно получены.</TD></TR></TABLE></TD></TR>
<?
                endif;
              else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Не удалось получить результаты выборки из таблицы <B>newstat.rep1</B>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                die("");
              endif;
            else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Сбой при получении результататов выборки из таблицы <B>newstat.rep1</B>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
              die("");
            endif;
            if (($f2!=0)||($f3!=0)||($f4!=0)||($f5!=0)||($f6!=0)): // если данные по "текущей" услуге есть - вывести их в отчёт

?>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid #000000;">
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;" ALIGN="CENTER"><?echo $f1;?></TD>
          <TD ALIGN="LEFT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $services[$f1];?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f2;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?echo $f3;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f4;?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f5;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f6;?></TD>
        </TR>
<?
            endif;
          endif;
        endfor;

        // формирование строки итогового запроса
        $q1="";
        for ($serv=0;$serv<count($servicelist);$serv++):
          if ($a[$serv]=="on"):
            if ($q1!="") $q1.=" OR ";
            $q1.="(service='$servicelist[$serv]')";
          endif;
        endfor;
        if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Получение итоговых данных по всем выбранным услугам за период с <B><?echo "$startday $months2[$startmonth] $startyear";?> года</B> по <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> года</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
        endif;
        $q="SELECT SUM(served_calls) AS f1, SUM(duration_in_sec) AS f2, SUM(duration_in_min) AS f3, SUM(duration_in_sec)/sum(served_calls) AS f4, SUM(calls_to_pay) AS f5 FROM newstat.rep1 WHERE ($q1) AND (year_month_day BETWEEN '$startyear";
        if ($startmonth<10) $q.="0";
        $q.="$startmonth";
        if ($startday<10) $q.="0";
        $q.="$startday' AND '$stopyear";
        if ($stopmonth<10) $q.="0";
        $q.="$stopmonth";
        if ($stopday<10) $q.="0";
        $q.="$stopday') GROUP BY '';";
        if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
        endif;
        $table=MYSQL_QUERY($q);
        $num_rows=MYSQL_NUM_ROWS($table);
        if ($num_rows==1):
          $f1=MYSQL_RESULT($table, 0, "f1");
          $f2=MYSQL_RESULT($table, 0, "f2");
          $f3=MYSQL_RESULT($table, 0, "f3");
          $f4=MYSQL_RESULT($table, 0, "f4");
          $f5=MYSQL_RESULT($table, 0, "f5");
          if (($f1!=0)||($f2!="")||($f3!="")||($f4!="")||($f5!="")):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Итоговые данные по всем выбранным услугам за период с <B><?echo "$startday $months2[$startmonth] $startyear";?> года</B> по <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> года</B> успешно получены.</TD></TR></TABLE></TD></TR>
<?
            endif;
          else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Не удалось получить результаты выборки из таблицы <B>newstat.rep1</B>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
            die("");
          endif;
        else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Сбой при получении результататов выборки из таблицы <B>newstat.rep1</B>! Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
          die("");
        endif;
?>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid #000000;">
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;;">Итого:</TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">&#151;</TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f1;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 1px 2px 0;"><?echo $f2;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f3;?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f4;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f5;?></TD>
        </TR>
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0; padding-top: 10px;">* - сумма длительностей в секундах каждого из звонков</TD></TR>
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;">** - сумма длительностей в минутах каждого из звонков</TD></TR>
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="7" STYLE="border-color: <?if ($maker!=""):?>gray<?else:?>white<?endif;?>; border-style: solid; border-width: 0 0 1px 0; padding-bottom: 5px;">*** - количество звонков, которое будет включено в список счетов на оплату для АСКР</TD></TR>
<?
        if (($maker!="")||($makerstate!="")||($makerphone!="")): // если указан исполнитель отчёта - вывести его на печать
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 10px; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;">Исполнитель:<?if ($makerstate!="") echo "<BR>$makerstate"; if ($maker!="") echo "<BR>$maker"; if ($makerphone!="") echo "<BR>$makerphone";?></TD></TR>
<?
        endif;
?>
      </TBODY>
    </TABLE>
<?
      else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Расчётный период отчёта менее одного дня!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      endif;




















































    elseif ($rep==4):
      if ($time=="lastweek"):
        $startday=$lwbd;
        $stopday=$lwed;
        $startmonth=$lwbm;
        $stopmonth=$lwem;
        $startyear=$lwby;
        $stopyear=$lwey;
      elseif ($time=="yesterday"):
        $startday=$ldd;
        $stopday=$ldd;
        $startmonth=$ldm;
        $stopmonth=$ldm;
        $startyear=$ldy;
        $stopyear=$ldy;
      elseif ($time=="another"):
        $startday=$abd;
        $stopday=$aed;
        $startmonth=$abm;
        $stopmonth=$aem;
        $startyear=$aby;
        $stopyear=$aey;
      endif;
      $currentd=$startday+0;
      $currentm=$startmonth+0;
      $currenty=$startyear+0;
      $title="Статистика&nbsp;звонков&nbsp;Гидрометцентра на&nbsp;номер&nbsp;&laquo;098&raquo;";
      if ((($time=="another")&&(($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear)))||($time=="yesterday")) $title.=" за&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года"; else $title.="за&nbsp;период с&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;года по&nbsp;$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;года";
      $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth,$startday,$startyear);
      if ($i>=0): // количество дней участвующих в отчёте больше, чем 0 нужно нарисовать шапку для отчёта
?>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border: 0 solid #FFFFFF; font-size: 6pt">
      <TBODY>
        <TR STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><TD COLSPAN="4" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><H1><?print $title;?></H1></TD></TR>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid #000000;">
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px;">Номер телефона</TH>
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Дата звонка</TH>
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Время звонка</TH>
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Длительность звонка</TH>
        </TR>
<?
        while ($i>=0):
          if ($currentd<10) $cd="0$currentd"; else $cd="$currentd";
          if ($currentm<10) $cm="0$currentm"; else $cm="$currentm";
          $flag=0; // устанавливаем флаг нахождения в ноль (не найдено)
          if ($HostName!="10.1.1.250"):
            MYSQL_CLOSE($MYSQLCON);
            $HostName="10.1.1.250";
            $UserName="sel";
            $Password="";
            $DBName="newstat";
            $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            MYSQL_SELECT_DB("$DBName") OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Удалось установить подключение к БД <B><?echo $DBName;?></B> на MySQL-сервере <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
          endif;
          // ищем во всех местах по порядку
          // попытка №1: на 10.1.1.250 в каталоге "arj" в файле "irda_ггггмм"
          $q="SHOW TABLES FROM arj LIKE 'irda_$currenty$cm';";
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN=4 STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
          $table=MYSQL_QUERY($q);
          $num_rows=MYSQL_NUM_ROWS($table);
          if ($num_rows!=0): // если искомый файл найден, делаем проверку на наличие в нём записей
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>arj.irda_<?echo "$currenty$cm";?></B> успешно найдена.</TD></TR></TABLE></TD></TR>
<?
            endif;
            $q="SELECT COUNT(*) AS row1 FROM arj.irda_$currenty$cm;";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows>0): // если запрос удалось выполнить
              $row1=MYSQL_RESULT($table, 0, "row1"); // пробуем получить количество записей в таблице
              if ($row1>0): // если количество записей больше нуля
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество строк в таблице <B><?echo "arj.irda_$currenty$cm";?></B> больше чем ноль.</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                // пробуем найти данные за искомый день в таблице за месяц
                $q="SELECT ani AS f1, vrijeme AS f2, SEC_TO_TIME(dur) AS f3 FROM arj.irda_$currenty$cm WHERE datum='$currenty-$cm-$cd' AND (dur>1) AND ((ddi='098') OR (ddi='001798')) AND (ani LIKE '%2370654');";
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                $table=MYSQL_QUERY($q);
                $num_rows=MYSQL_NUM_ROWS($table);
                if ($num_rows>0): // если запрос удалось выполнить
                  $flag=1;
                endif;
              else:
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество записей в таблице <B><?echo "arj.irda_$currenty$cm";?></B> равно нулю - таблица не заполнена!</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
              endif;
            else:
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Произошла ошибка при попытке получения количества записей в таблице <B><?echo "arj.irda_$currenty$cm";?></B>!</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
          else:
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B><?echo "arj.irda_$currenty$cm";?></B> не найдена!</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
          endif;
          if ($flag!=1): // если данные ещё не были найдены, продолжить поиск
            // попытка №2: на 10.1.1.250 в каталоге "arj" в файле "ird_ггггммдд"
            $q="SHOW TABLES FROM arj LIKE 'ird_$currenty$cm$cd';";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows!=0): // если искомый файл найден, делаем проверку на наличие в нём записей
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>arj.irda_<?echo "$currenty$cm$cd";?></B> успешно найдена.</TD></TR></TABLE></TD></TR>
<?
              endif;
              $q="SELECT COUNT(*) AS row1 FROM arj.ird_$currenty$cm$cd;";
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
              $table=MYSQL_QUERY($q);
              $num_rows=MYSQL_NUM_ROWS($table);
              if ($num_rows>0): // если запрос удалось выполнить
                $row1=MYSQL_RESULT($table, 0, "row1"); // пробуем получить количество записей в таблице
                if ($row1>0): // если количество записей больше нуля
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество строк в таблице <B><?echo "arj.ird_$currenty$cm$cd";?></B> больше чем ноль.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  // пробуем найти данные за искомый день в таблице за день
                  $q="SELECT ani AS f1, vrijeme AS f2, SEC_TO_TIME(dur) AS f3 FROM arj.ird_$currenty$cm$cd WHERE datum='$currenty-$cm-$cd' AND (dur>1) AND ((ddi='098') OR (ddi='001798')) AND (ani LIKE '%2370654');";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows>0): // если запрос удалось выполнить
                    $flag=1;
                  endif;
                else:
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество записей в таблице <B><?echo "arj.irda_$currenty$cm$cd";?></B> равно нулю - таблица не заполнена!</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                endif;
              else:
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Произошла ошибка при попытке получения количества записей в таблице <B><?echo "arj.irda_$currenty$cm$cd";?></B>!</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
              endif;
            else:
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B><?echo "arj.irda_$currenty$cm$cd";?></B> не найдена!</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
          endif;
          if ($flag!=1): // если данные ещё не были найдены, продолжить поиск
            // попытка №2: на 10.1.1.2 в каталоге "statistika" в файле "ird_ггггммдд"
            if ($HostName!="10.1.1.2"):
              MYSQL_CLOSE($MYSQLCON);
              $HostName="10.1.1.2";
              $UserName="sel";
              $Password="";
              $DBName="statistika";
              $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">Не удалось установить подключение к MySQL-серверу <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
              MYSQL_SELECT_DB("$DBName") OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">Не удалось установить подключение к БД <B>$DBName</B> на MySQL-сервере <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">My-SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Удалось установить подключение к БД <B><?echo $DBName;?></B> на MySQL-сервере <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
            $q="SHOW TABLES FROM statistika LIKE 'ird_$currenty$cm$cd';";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows!=0): // если искомый файл найден, делаем проверку на наличие в нём записей
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> успешно найдена.</TD></TR></TABLE></TD></TR>
<?
              endif;
              $q="SELECT COUNT(*) AS row1 FROM statistika.ird_$currenty$cm$cd;";
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
              $table=MYSQL_QUERY($q);
              $num_rows=MYSQL_NUM_ROWS($table);
              if ($num_rows>0): // если запрос удалось выполнить
                $row1=MYSQL_RESULT($table, 0, "row1"); // пробуем получить количество записей в таблице
                if ($row1>0): // если количество записей больше нуля
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество строк в таблице <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> больше чем ноль.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  // пробуем найти данные за искомый день в таблице за день
                  $q="SELECT ani AS f1, vrijeme AS f2, SEC_TO_TIME(dur) AS f3 FROM statistika.ird_$currenty$cm$cd WHERE datum='$currenty-$cm-$cd' AND (dur>1) AND ((ddi='098') OR (ddi='001798')) AND (ani LIKE '%2370654');";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows>0): // если запрос удалось выполнить
                    $flag=1;
                  endif;
                else:
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Количество записей в таблице <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> равно нулю - таблица не заполнена!</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                endif;
              else:
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Произошла ошибка при попытке получения количества записей в таблице <B>statistika.ird_<?echo "$currenty$cm$cd";?></B>!</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
              endif;
            else:
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">Таблица <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> не найдена!</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
          endif;
          if ($flag!=1):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER">Данные за указанный Вами промежуток времени (<B><?print "$cd $months2[$cm] $currenty года";?></B>) в таблицах базы данных найдены не были!<BR><BR>Внимательно проверьте условия формирования отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $j=0; // переменная для значения текущей позиции строки в выборке
          if ($num_rows>0):
            while ($j<$num_rows):
              $f1=mysql_result($table, $j, "f1");
              $f2=mysql_result($table, $j, "f2");
              $f3=mysql_result($table, $j, "f3");
?>
        <TR VALIGN="MIDDLE" STYLE="border: 2px solid #000000;">
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 2px;"><?print "$f1";?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 0;"><?print "$currentd $months2[$currentm] $currenty года";?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 0;"><?print "$f2";?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 0;"><?print "$f3";?></TD>
        </TR>
<?
              $j++;
            endwhile;
          endif;
          $ncurrentd=date("d",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrentm=date("m",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrenty=date("Y",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $currentd=$ncurrentd;
          $currentm=$ncurrentm;
          $currenty=$ncurrenty;
          $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$currentm+0,$currentd+0,$currenty+0);
        endwhile;
        $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth,$startday,$startyear);
?>
        <TR>
<?
        if ($maker!=""):
?>
          <TD COLSPAN="2" STYLE="padding-top: 10px; border-color: white; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;">Исполнитель:<BR>
<?
        if ($makerstate!=""): print "$makerstate<BR>"; endif;
        print "$maker";
        if ($makerphone!=""): print "<BR>$makerphone"; endif;
      else:
        // можно вставить обработчик некорректного указания дат (конечная дата является более поздней, нежели начальная)
?>
          <TD COLSPAN="6" STYLE="border-color: white; border-style: solid; border-width: 0;">
<?
      endif;
?>
          </TD>
        </TR>
      </TBODY>
    </TABLE>
<?
      endif;
    elseif ($rep==5): // шаг №5 для отчёта №5
      if ($time=="lastquart"):
        $quart=$lqq;
        $year=$lqy;
      elseif ($time=="anotherquart"):
        $quart=$aqq;
        $year=$aqy;
      endif;
      $m=($quart*3)-2; if ($m<10) $m1="0$m"; else $m1="$m";
      $m=($quart*3)-1; if ($m<10) $m2="0$m"; else $m2="$m";
      $m=($quart*3); if ($m<10) $m3="0$m"; else $m3="$m";
      for ($i=1;$i<4;$i++):
        $m=(($quart-1)*3)+$i;
        if ($m<10) $m="0$m"; else $m="$m";
        $table=MYSQL_QUERY("SHOW TABLES FROM arj LIKE 'irda_$year$m';");
        $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
        if ($num_rows==0):
          $m=$m+0;
?>
    <P>Отчёт не может быть создан по причине отсутствия таблицы данных за <?print "$months[$m] $year года";?>!</P>
<?
          die("");
        else:
          $table=MYSQL_QUERY("SELECT COUNT(*) AS f1 FROM arj.irda_$year$m;");
          $rows=mysql_result($table, 0, "f1");
          if ($rows==0):
            $m=$m+0;
?>
    <P>Отчёт не может быть создан по причине отсутствия данных в таблице БД за <?print "$months[$m] $year года";?>!</P>
<?
            die("");
          endif;
        endif;
      endfor;

      $table=MYSQL_QUERY("SHOW TABLES FROM newstat LIKE 'rep5';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // если результирующая таблица не найдена - создаём её
      if ($num_rows==0)
        MYSQL_QUERY("CREATE TABLE newstat.rep5 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, call_middletime decimal(13,2) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL, allowed_call_middletime decimal(13,2) default NULL, nonallowed_call_percent decimal(5,2) default NULL) TYPE=MyISAM;");

      if ($time=="lastquart"):
        $title="Статистика по услуге &laquo;009&raquo;<BR>за период с $lqbd $months2[$lqbm] $lqy года по $lqed $months2[$lqem] $lqy года";
        $Subject="Статистика по услуге \"009\" за период с $lqbd $months2[$lqbm] $lqy года по $lqed $months2[$lqem] $lqy года";
      elseif ($time=="anotherquart"):
        $title="Статистика по услуге &laquo;009&raquo;<BR>за период с $aqbd $months2[$aqbm] $aqy года по $aqed $months2[$aqem] $aqy года";
        $Subject="Статистика по услуге \"009\" за период с $aqbd $months2[$aqbm] $aqy года по $aqed $months2[$aqem] $aqy года";
      endif;
      // если необходимо полностью пересчитать данные за расчётный период - удаляем из результирующей таблицы все данные за расчётный период
      if ($RECALC=="on")
        MYSQL_QUERY("DELETE FROM newstat.rep5 WHERE yearmonth='$year$m1' OR yearmonth='$year$m2' OR yearmonth='$year$m3';");
      // удаляем все временные таблицы, использующиеся при формировании отчётов
      MYSQL_QUERY("DROP TABLE IF EXISTS newstat.rep5_1, newstat.rep5_2, newstat.rep5_3;");
      // и создаём их заново
      MYSQL_QUERY("CREATE TABLE newstat.rep5_1 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL) TYPE=MyISAM COMMENT='выборка по поступившим абонентам';");
      MYSQL_QUERY("CREATE TABLE newstat.rep5_2 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL) TYPE=MyISAM COMMENT='выборка по обслуженным абонентам';");
      MYSQL_QUERY("CREATE TABLE newstat.rep5_3 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, call_middletime decimal(13,2) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL, allowed_call_middletime decimal(13,2) default NULL, nonallowed_call_percent decimal(5,2) default NULL) TYPE=MyISAM COMMENT='суммарная выборка';");
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m1';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows==0): // если выборка пуста - значит записей за данный месяц в результирующей таблице нет и требуется пересчёт данных
        // выборка и полный пересчёт данных из основного источника
        MYSQL_QUERY("INSERT INTO newstat.rep5_1 SELECT ddi AS 'Номер услуги', '$year$m1', COUNT(*) AS 'Количество поступивших звонков', SUM(dur) AS 'Общая продолжительность звонков', '' AS 'Количество обслуженных звонков', '' AS 'Общая продолжительность обслуженных звонков' FROM arj.irda_$year$m1 WHERE ddi='009' GROUP BY ddi;");
        MYSQL_QUERY("INSERT INTO newstat.rep5_2 SELECT ddi AS 'Номер услуги', '$year$m1', '' AS 'Количество поступивших звонков', '' AS 'Общая продолжительность звонков', COUNT(*) AS 'Количество обслуженных звонков', SUM(dur) AS 'Общая продолжительность обслуженных звонков' FROM arj.irda_$year$m1 WHERE ddi='009' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;");
        // формирование предварительного результата
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT a.ddi AS 'Номер услуги', '$year$m1', a.call_quantity AS 'Количество поступивших звонков', a.call_sumtime AS 'Общая продолжительность поступивших звонков', a.call_sumtime/a.call_quantity AS 'Среднее время поступившего звонка', b.allowed_call_quantity AS 'Количество обслуженных звонков', b.allowed_call_sumtime AS 'Общая продолжительность обслуженных звонков', b.allowed_call_sumtime/b.allowed_call_quantity AS 'Среднее время обслуженного звонка', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS 'Процент отказов' FROM newstat.rep5_1 AS a, newstat.rep5_2 AS b WHERE a.ddi=b.ddi;");
        // удаление всех промежуточных данных за первый из месяцев
        MYSQL_QUERY("DELETE FROM newstat.rep5_1;");
        MYSQL_QUERY("DELETE FROM newstat.rep5_2;");
        // помещение предварительного результата в результируюую таблицу
        MYSQL_QUERY("INSERT INTO newstat.rep5 SELECT * FROM newstat.rep5_3 WHERE yearmonth='$year$m1'");
      else: // иначе - просто выгребаем записи из результирующей таблицы во временную
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m1'");
      endif;

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m2';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows==0): // если выборка пуста - значит записей за данный месяц в результирующей таблице нет и требуется пересчёт данных
        // выборка и полный пересчёт данных из основного источника
        MYSQL_QUERY("INSERT INTO newstat.rep5_1 SELECT ddi AS 'Номер услуги', '$year$m2', COUNT(*) AS 'Количество поступивших звонков', SUM(dur) AS 'Общая продолжительность звонков', '' AS 'Количество обслуженных звонков', '' AS 'Общая продолжительность обслуженных звонков' FROM arj.irda_$year$m2 WHERE ddi='009' GROUP BY ddi;");
        MYSQL_QUERY("INSERT INTO newstat.rep5_2 SELECT ddi AS 'Номер услуги', '$year$m2', '' AS 'Количество поступивших звонков', '' AS 'Общая продолжительность звонков', COUNT(*) AS 'Количество обслуженных звонков', SUM(dur) AS 'Общая продолжительность обслуженных звонков' FROM arj.irda_$year$m2 WHERE ddi='009' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;");
        // формирование предварительного результата
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT a.ddi AS 'Номер услуги', '$year$m2', a.call_quantity AS 'Количество поступивших звонков', a.call_sumtime AS 'Общая продолжительность поступивших звонков', a.call_sumtime/a.call_quantity AS 'Среднее время поступившего звонка', b.allowed_call_quantity AS 'Количество обслуженных звонков', b.allowed_call_sumtime AS 'Общая продолжительность обслуженных звонков', b.allowed_call_sumtime/b.allowed_call_quantity AS 'Среднее время обслуженного звонка', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS 'Процент отказов' FROM newstat.rep5_1 AS a, newstat.rep5_2 AS b WHERE a.ddi=b.ddi;");
        // удаление всех промежуточных данных за второй месяц
        MYSQL_QUERY("DELETE FROM newstat.rep5_1;");
        MYSQL_QUERY("DELETE FROM newstat.rep5_2;");
        // помещение предварительного результата в результируюую таблицу
        MYSQL_QUERY("INSERT INTO newstat.rep5 SELECT * FROM newstat.rep5_3 WHERE yearmonth='$year$m2'");
      else: // иначе - просто выгребаем записи из результирующей таблицы во временную
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m2'");
      endif;

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m3';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows==0): // если выборка пуста - значит записей за данный месяц в результирующей таблице нет и требуется пересчёт данных
        // выборка и полный пересчёт данных из основного источника
        MYSQL_QUERY("INSERT INTO newstat.rep5_1 SELECT ddi AS 'Номер услуги', '$year$m3', COUNT(*) AS 'Количество поступивших звонков', SUM(dur) AS 'Общая продолжительность звонков', '' AS 'Количество обслуженных звонков', '' AS 'Общая продолжительность обслуженных звонков' FROM arj.irda_$year$m3 WHERE ddi='009' GROUP BY ddi;");
        MYSQL_QUERY("INSERT INTO newstat.rep5_2 SELECT ddi AS 'Номер услуги', '$year$m3', '' AS 'Количество поступивших звонков', '' AS 'Общая продолжительность звонков', COUNT(*) AS 'Количество обслуженных звонков', SUM(dur) AS 'Общая продолжительность обслуженных звонков' FROM arj.irda_$year$m3 WHERE ddi='009' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;");
        // формирование предварительного результата
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT a.ddi AS 'Номер услуги', '$year$m3', a.call_quantity AS 'Количество поступивших звонков', a.call_sumtime AS 'Общая продолжительность поступивших звонков', a.call_sumtime/a.call_quantity AS 'Среднее время поступившего звонка', b.allowed_call_quantity AS 'Количество обслуженных звонков', b.allowed_call_sumtime AS 'Общая продолжительность обслуженных звонков', b.allowed_call_sumtime/b.allowed_call_quantity AS 'Среднее время обслуженного звонка', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS 'Процент отказов' FROM newstat.rep5_1 AS a, newstat.rep5_2 AS b WHERE a.ddi=b.ddi;");
        // помещение предварительного результата в результируюую таблицу
        MYSQL_QUERY("INSERT INTO newstat.rep5 SELECT * FROM newstat.rep5_3 WHERE yearmonth='$year$m3'");
      else: // иначе - просто выгребаем записи из результирующей таблицы во временную
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m3'");
      endif;

      // вывод данных на экран
?>
    <H1><BR><?print $title;?></H1>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border: 2px solid #000000;">
      <TBODY>
        <TR VALIGN="MIDDLE" STYLE="border: 2px solid #000000;">
          <TH STYLE="border: 2px solid #000000;">Период (месяц, год)</TH>
          <TH STYLE="border: 2px solid #000000;">Количество поступивших звонков</TH>
          <TH STYLE="border: 2px solid #000000;">Общая продолжительность поступивших звонков, сек.</TH>
          <TH STYLE="border: 2px solid #000000;">Количество обслуженных звонков</TH>
          <TH STYLE="border: 2px solid #000000;">Общая продолжительность обслуженных звонков, сек.</TH>
          <TH STYLE="border: 2px solid #000000;">Отказы по услуге, %</TH>
        </TR>
<?
      // подготовка данных для отправки на мыло
      $message="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">
<HTML>
  <BODY STYLE=\"font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; background-color: white; margin: 10px; color: #000000;\">
    <H1 STYLE=\"font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;\">$title</H1>
    <TABLE BORDER=\"1\" ALIGN=\"CENTER\" STYLE=\"caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent; border: 1px solid #000000;\">
      <TBODY STYLE=\"vertical-align: top;\">
        <TR VALIGN=\"MIDDLE\" STYLE=\"font-weight: bold; padding: 10px 5px; border: 1px solid #000000;\">
          <TH STYLE=\"\">Период (месяц, год)</TH>
          <TH STYLE=\"\">Количество поступивших звонков</TH>
          <TH STYLE=\"\">Общая продолжительность поступивших звонков, сек.</TH>
          <TH STYLE=\"\">Количество обслуженных звонков</TH>
          <TH STYLE=\"\">Общая продолжительность обслуженных звонков, сек.</TH>
          <TH STYLE=\"\">Отказы по услуге, %</TH>
        </TR>
";
      $table=MYSQL_QUERY("SELECT CONCAT(RIGHT(yearmonth,2),'.',LEFT(yearmonth,4)) AS f1, call_quantity AS f2, call_sumtime AS f3, allowed_call_quantity AS f4, allowed_call_sumtime AS f5, (100-((allowed_call_quantity/call_quantity)*100)) AS f6 FROM newstat.rep5_3 GROUP BY yearmonth, ddi ORDER BY yearmonth, ddi;");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        for ($i=0;$i<$num_rows;$i++):
          $f1=mysql_result($table, $i, "f1");
          $f2=mysql_result($table, $i, "f2");
          $f3=mysql_result($table, $i, "f3");
          $f4=mysql_result($table, $i, "f4");
          $f5=mysql_result($table, $i, "f5");
          $f6=mysql_result($table, $i, "f6");
          if ($i==0) $a="1px"; else $a="0px";
?>
        <TR>
          <TD ALIGN="CENTER" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f1;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f2;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f3;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f4;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f5;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f6;?></TD>
        </TR>
<?
          // подготовка данных для отправки на мыло
          $message.="        <TR VALIGN=\"MIDDLE\">
          <TD ALIGN=\"CENTER\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f1</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f2</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f3</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f4</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f5</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f6</TD>
        </TR>
";
        endfor;
      else: // таблица не заполнена!
      endif;
      // итоговая запись
      $table=MYSQL_QUERY("SELECT 'Итого' AS f1, SUM(call_quantity) AS f2, SUM(call_sumtime) AS f3, SUM(allowed_call_quantity) AS f4, SUM(allowed_call_sumtime) AS f5, (100-((SUM(allowed_call_quantity)/SUM(call_quantity))*100)) AS f6 FROM newstat.rep5_3 GROUP BY ddi;");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f1=mysql_result($table, 0, "f1");
        $f2=mysql_result($table, 0, "f2");
        $f3=mysql_result($table, 0, "f3");
        $f4=mysql_result($table, 0, "f4");
        $f5=mysql_result($table, 0, "f5");
        $f6=mysql_result($table, 0, "f6");
?>
        <TR STYLE="border: 2px solid #000000;">
          <TH ALIGN="CENTER" STYLE="border: 2px solid #000000;"><?print $f1;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f2;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f3;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f4;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f5;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f6;?></TH>
        </TR>
<?
        $message.="        <TR VALIGN=\"MIDDLE\">
          <TH ALIGN=\"CENTER\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f1</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f2</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f3</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f4</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f5</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f6</TH>
        </TR>
";
      endif;
      $message.="      </TBODY>
    </TABLE>
  </BODY>
</HTML>";
?>
      </TBODY>
    </TABLE>
<?
        if ($maker!=""):
?>
          <P STYLE="padding-top: 50px; padding-left: 5px; border-color: white; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;">Исполнитель:<BR>
<?
        if ($makerstate!=""): print "$makerstate<BR>"; endif;
        print "$maker";
        if ($makerphone!=""): print "<BR>$makerphone"; endif;
      endif;
?>
<?
      MYSQL_QUERY("DROP TABLE IF EXISTS newstat.rep5_1, newstat.rep5_2, newstat.rep5_3;");

    elseif (($rep==6)||($rep==7)):
      if ($time=="lastmonth"):
        $startdate=$lmbd;
        $stopdate=$lmed;
        $month=$lmm;
        $year=$lmy;
      elseif ($time=="anothermonth"):
        $startdate=$ambd;
        $stopdate=$amed;
        $month=$amm;
        $year=$amy;
      endif;
      // добавление ведущего нуля впереди цир дат
      if ($startdate<10) $startdate="0$startdate";
      if ($stopdate<10) $stopdate="0$stopdate";
      if ($month<10) $month="0$month";

      $table=MYSQL_QUERY("SHOW TABLES FROM arj LIKE 'irda_$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows==0):
        print "SHOW TABLES FROM arj LIKE 'irda_$year$month';";
        $month=$month+0;
?>
    <P>Отчёт не может быть создан по причине отсутствия таблицы данных за <?print "$months[$month] $year года";?>!</P>
<?
        die("");
      else:
        $table=MYSQL_QUERY("SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;");
        $rows=mysql_result($table, 0, "f1");
        if ($rows==0):
          print "SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;";
          $month=$month+0;
?>
    <P>Отчёт не может быть создан по причине отсутствия данных в таблице БД за <?print "$months[$month] $year года";?>!</P>
<?
          die("");
        endif;
      endif;
      $i=$month+0;
      $Subject="Сведения о входящем трафике в сеть РУП \"Белтелеком\" на платные справочные службы от сети ";
      if ($rep==6)
        $Subject.="СП \"МЦС\"";
      elseif ($rep==7)
        $Subject.=$Subject.="СООО \"МТС\"";
      $Subject.=" за период с $startdate по $stopdate $months2[$i] $year года";
?>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border-width: 0; border-style: solid; border-color: #FFFFFF; font-size: 8pt;">
      <TBODY STYLE="vertical-align: top;">
        <TR font-size: 6pt;"><TD COLSPAN="5" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;">&nbsp;</TD><TD COLSPAN="4" STYLE="border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: right;">Справочно-информационный цех филиала &laquo;МГТС&raquo; РУП &laquo;Белтелеком&raquo;</TD></TR>
        <TR><TD COLSPAN="8" STYLE="font-weight: bold; padding-top: 0.5cm; padding-bottom: 0.3cm; border-color: #FFFFFF; border-style: solid; border-width: 0; font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent;">Сведения&nbsp;о&nbsp;входящем&nbsp;трафике в&nbsp;сеть&nbsp;РУП&nbsp;&laquo;Белтелеком&raquo; на&nbsp;платные&nbsp;справочные&nbsp;службы от&nbsp;сети&nbsp;<?if ($rep==6):?>СП&nbsp;&laquo;МЦС&raquo;<?elseif ($rep==7):?>СООО&nbsp;&laquo;МТС&raquo;<?endif;?></TD></TR>
        <TR><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 10pt;">Период:</TD><TD STYLE="border-color: #000000; border-style: solid; border-width: 1px; text-align: center; font-size: 10pt; font-weight: bold;"><?print "$startdate-$stopdate.$month.$year";?></TD></TR>
        <TR><TD COLSPAN="8" STYLE="font-weight: bold; padding-bottom: 0.5cm; padding-left: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 10pt;">5. Входящий трафик на платные справочные службы РУП &laquo;Белтелеком&raquo;</TD></TR>
        <TR><TD COLSPAN="8" STYLE="padding-bottom: 0.5cm; padding-left: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">5.1. Услуги со способом взаиморасчётов за факт пользования</TD></TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;" ROWSPAN="2">Служба</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">Количество соединений</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">Тариф, долларов США</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="3">Сумма, долларов США</TH>
        </TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Дневное время*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">Ночное время**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Дневное время*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">Ночное время**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Дневное время*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Ночное время**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">Всего</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;"><B>I</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>II</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>III</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>IV</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>V</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>VI</B><BR><FONT STYLE="font-size: 6pt;">(ст. II * ст. IV)</FONT></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>VII</B><BR><FONT STYLE="font-size: 6pt;">(ст. III * ст. V)</FONT></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>VIII</B><BR><FONT STYLE="font-size: 6pt;">(ст. V + ст. VI)</FONT></TD>
        </TR>
<?
      switch ($rep):
        case 6: $mask1="0296______";
           $mask2="0293______";
        break;
        case 7: $mask1="0297______";
           $mask2="0295______";
        break;
      endswitch;
      // проверка на наличие ранее созданной таблицы
      $table=MYSQL_QUERY("SHOW TABLES FROM newstat LIKE 'rep$rep';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // создание таблицы в случае её отсутствия
      if ($num_rows==0)
        MYSQL_QUERY("CREATE TABLE newstat.rep$rep (service char(4) NOT NULL DEFAULT '', yearmonth char(6) NOT NULL DEFAULT '', calls_quantity int(12) unsigned, duration decimal(12,0) NOT NULL DEFAULT '0');");

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='009d' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='009d' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) AND ((vrijeme>='06:00:00') AND (vrijeme<'22:00:00')) GROUP BY ddi;"); // получение количества звонков на услугу в дневное время
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('009d', '$year$month', $row1, 0);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='009n' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='009n' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) AND ((vrijeme<'06:00:00') OR (vrijeme>='22:00:00')) GROUP BY ddi;"); // получение количества звонков на услугу в ночное время
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('009n', '$year$month', $row1, 0);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='075' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='075' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='075') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('075', '$year$month', $row1, $row2);");
      endif;
      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='088' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='088' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE (ddi='088') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('088', '$year$month', $row1, 0);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='090' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='090' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE ddi='090' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('090', '$year$month', $row1, $row2);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='091' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='091' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='091') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('091', '$year$month', $row1, $row2);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='092') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('092', '$year$month', $row1, $row2);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='093' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='093' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE ddi='093' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('093', '$year$month', $row1, $row2);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='094' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='094' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='094') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('094', '$year$month', $row1, $row2);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='095' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='095' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE (ddi='095') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('095', '$year$month', $row1, 0);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='096' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='096' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='096') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('096', '$year$month', $row1, $row2);");
      endif;

      // удаление записи за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='097' AND yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='097' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='097') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('097', '$year$month', $row1, $row2);");
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f1 FROM newstat.rep$rep WHERE service='009d' AND yearmonth='$year$month';"); // получение количества звонков на услугу в дневное время
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0) $f1=mysql_result($table, 0, "f1"); else $f1="Ошибка!"; // если запрос был выполнен, в форму будет передано полученное значение
      $tax1=0.066;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f2 FROM newstat.rep$rep WHERE service='009n' AND yearmonth='$year$month';"); // получение количества звонков на услугу в ночное время
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0) $f2=mysql_result($table, 0, "f2"); else $f2="Ошибка!"; // если запрос был выполнен, в форму будет передано полученное значение
      $tax2=$tax1*2;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f3, duration AS f3_1 FROM newstat.rep$rep WHERE service='075' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f3=mysql_result($table, 0, "f3"); // если запрос был выполнен, в форму будет передано полученное значение
        $f3_1=mysql_result($table, 0, "f3_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f3="Ошибка!";
        $f3_1="Ошибка!";
      endif;
      $tax3=0.0121;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f4 FROM newstat.rep$rep WHERE service='088' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0) $f4=mysql_result($table, 0, "f4"); else $f4="Ошибка!"; // если запрос был выполнен, в форму будет передано полученное значение
      $tax4=0.0028;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f5, duration AS f5_1 FROM newstat.rep$rep WHERE service='090' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f5=mysql_result($table, 0, "f5"); // если запрос был выполнен, в форму будет передано полученное значение
        $f5_1=mysql_result($table, 0, "f5_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f5="Ошибка!";
        $f5_1="Ошибка!";
      endif;
      $tax5=0.101;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f6, duration AS f6_1 FROM newstat.rep$rep WHERE service='091' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f6=mysql_result($table, 0, "f6"); // если запрос был выполнен, в форму будет передано полученное значение
        $f6_1=mysql_result($table, 0, "f6_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f6="Ошибка!";
        $f6_1="Ошибка!";
      endif;
      $tax6=0.0121;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f7, duration AS f7_1 FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f7=mysql_result($table, 0, "f7"); // если запрос был выполнен, в форму будет передано полученное значение
        $f7_1=mysql_result($table, 0, "f7_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f7="Ошибка!";
        $f7_1="Ошибка!";
      endif;
      $tax7=0.0121;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f8, duration AS f8_1  FROM newstat.rep$rep WHERE service='093' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f8=mysql_result($table, 0, "f8"); // если запрос был выполнен, в форму будет передано полученное значение
        $f8_1=mysql_result($table, 0, "f8_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f8="Ошибка!";
        $f8_1="Ошибка!";
      endif;
      $tax8=0.101;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f9, duration AS f9_1 FROM newstat.rep$rep WHERE service='094' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f9=mysql_result($table, 0, "f9"); // если запрос был выполнен, в форму будет передано полученное значение
        $f9_1=mysql_result($table, 0, "f9_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f9="Ошибка!";
        $f9_1="Ошибка!";
      endif;
      $tax9=0.0121;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f10 FROM newstat.rep$rep WHERE service='095' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0) $f10=mysql_result($table, 0, "f10"); else $f10="Ошибка!"; // если запрос был выполнен, в форму будет передано полученное значение
      $tax10=0.0186;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f11, duration AS f11_1 FROM newstat.rep$rep WHERE service='096' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f11=mysql_result($table, 0, "f11"); // если запрос был выполнен, в форму будет передано полученное значение
        $f11_1=mysql_result($table, 0, "f11_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f11="Ошибка!";
        $f11_1="Ошибка!";
      endif;
      $tax11=0.0121;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f12, duration AS f12_1 FROM newstat.rep$rep WHERE service='097' AND yearmonth='$year$month';"); // получение количества звонков на услугу
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f12=mysql_result($table, 0, "f12"); // если запрос был выполнен, в форму будет передано полученное значение
        $f12_1=mysql_result($table, 0, "f12_1"); // если запрос был выполнен, в форму будет передано полученное значение
      else:
        $f12="Ошибка!";
        $f12_1="Ошибка!";
      endif;
      $tax12=0.0121;
      if (($f1=="Ошибка!")||($f2=="Ошибка!")||($f3=="Ошибка!")||($f3_1=="Ошибка!")||($f4=="Ошибка!")||($f5=="Ошибка!")||($f5_1=="Ошибка!")||($f6=="Ошибка!")||($f6_1=="Ошибка!")||($f7=="Ошибка!")||($f7_1=="Ошибка!")||($f8=="Ошибка!")||($f8_1=="Ошибка!")||($f9=="Ошибка!")||($f9_1=="Ошибка!")||($f10=="Ошибка!")||($f11=="Ошибка!")||($f11_1=="Ошибка!")||($f12=="Ошибка!")||($f12_1=="Ошибка!"))
        ($sum=="Ошибка!");
      else $sum=($f1*$tax1)+($f2*$tax2)+($f3_1*$tax3)+($f4*$tax4)+($f5_1*$tax5)+($f6_1*$tax6)+($f7_1*$tax7)+($f8_1*$tax8)+($f9_1*$tax9)+($f10*$tax10)+($f11_1*$tax11)+($f12_1*$tax12);
?>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">009</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?print $f1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f2;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?print $tax1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax2;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?if ($f1=="Ошибка!") print "Ошибка!"; else print $tax1*$f1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?if ($f2=="Ошибка!") print "Ошибка!"; else print $tax2*$f2;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if (($f1=="Ошибка!")||($f2=="Ошибка!")) print "Ошибка!"; else print (($tax1*$f1)+($tax2*$f2));?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">088</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;" COLSPAN="2"><?print $f4;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;" COLSPAN="2"><?print $tax4;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;" COLSPAN="2"><?if ($f4=="Ошибка!") print "Ошибка!"; else print $tax4*$f4;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f4=="Ошибка!") print "Ошибка!"; else print $tax4*$f4;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;">095</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;" COLSPAN="2"><?print $f10;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;" COLSPAN="2"><?print $tax10;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;" COLSPAN="2"><?if ($f10=="Ошибка!") print "Ошибка!"; else print $tax10*$f10;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?if ($f10=="Ошибка!") print "Ошибка!"; else print $tax10*$f10;?></TD>
        </TR>
      </TBODY>
    </TABLE>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border: 0 solid #FFFFFF; font-size: 8pt;">
      <TBODY STYLE="vertical-align: top;">
        <TR><TD COLSPAN="8" STYLE="padding: 0.5cm 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">5.2. Услуги со способом взаиморасчётов за трафик</TD></TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;">Служба</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Количество соединений</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Продолжительность соединений, минут</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Тариф, долларов США</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">Сумма, долларов США</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;"><B>I</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>II</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>III</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>IV</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>V</B><BR><FONT STYLE="font-size: 6pt;">(ст. III * ст. IV)</FONT></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">075</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f3;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f3_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax3;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f3_1=="Ошибка!") print "Ошибка!"; else print $tax3*$f3_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">090</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f5;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f5_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax5;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f5_1=="Ошибка!") print "Ошибка!"; else print $tax5*$f5_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">091</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f6;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f6_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax6;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f6_1=="Ошибка!") print "Ошибка!"; else print $tax6*$f6_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">092</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f7;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f7_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax7;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f7_1=="Ошибка!") print "Ошибка!"; else print $tax7*$f7_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">093</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f8;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f8_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax8;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f8_1=="Ошибка!") print "Ошибка!"; else print $tax8*$f8_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">094</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f9;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f9_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax9;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f9_1=="Ошибка!") print "Ошибка!"; else print $tax9*$f9_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">096</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f11;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f11_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax11;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f11_1=="Ошибка!") print "Ошибка!"; else print $tax11*$f11_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;">097</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f12;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f12_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $tax12;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?if ($f12_1=="Ошибка!") print "Ошибка!"; else print $tax12*$f12_1;?></TD>
        </TR>
        <TR><TD COLSPAN="4" STYLE="padding: 0.5cm 0 0 0; font-weight: bold; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">Итого в пользу РУП &laquo;Белтелеком&raquo;:</TD><TD STYLE="padding: 0.5cm 0 0 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 9pt; font-weight: bold;"><?print "$sum долл. США";?></TD></TR>
        <TR><TD COLSPAN="4" STYLE="padding: 0; font-style: italic; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">Курс доллара США на <?print "$stopdate $months2[$i] $year года";?>:</TD><TD STYLE="padding: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 9pt; font-style: italic;"><?print "бел. руб.";?></TD></TR>
        <TR><TD COLSPAN="4" STYLE="padding: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">Эквивалент в белорусских рублях:</TD><TD STYLE="padding: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 9pt;"><?print "бел. руб.";?></TD></TR>
        <TR VALIGN="BOTTOM" STYLE="height: 1.4cm;"><TD COLSPAN="4" STYLE="padding: 0; text-align: left; font-size: 6pt; border-color: #FFFFFF; border-style: solid; border-width: 0;"><I>Примечания:</I><BR>*: ежедневное оказание услуг с 06<SUP>00</SUP> до 21<SUP>59</SUP> (для справочной службы &laquo;009&raquo;, 8-ABC-9900911)<BR>**: ежедневное оказание услуг с 21<SUP>00</SUP> до 05<SUP>59</SUP> (для справочной службы &laquo;009&raquo;, 8-ABC-9900911)</TD><TD COLSPAN="3" STYLE="text-align: right; padding-top: 0; border-color: gray; border-style: solid; border-width: 0; font-size: 6pt;">Факс для отправки отчёта:<BR>(8017)2261288, (8017)2222901</TD></TR>
      </TBODY>
    </TABLE>
<?
    elseif ($rep==8):
      if ($time=="lastmonth"):
        $startdate=$lmbd;
        $stopdate=$lmed;
        $month=$lmm;
        $year=$lmy;
      elseif ($time=="anothermonth"):
        $startdate=$ambd;
        $stopdate=$amed;
        $month=$amm;
        $year=$amy;
      endif;
      // добавление ведущего нуля впереди цир дат
      if ($startdate<10) $startdate="0$startdate";
      if ($stopdate<10) $stopdate="0$stopdate";
      if ($month<10) $month="0$month";

      $table=MYSQL_QUERY("SHOW TABLES FROM arj LIKE 'irda_$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows==0):
        print "SHOW TABLES FROM arj LIKE 'irda_$year$month';";
        $month=$month+0;
?>
    <P>Отчёт не может быть создан по причине отсутствия таблицы данных за <?print "$months[$month] $year года";?>!</P>
<?
        die("");
      else:
        $table=MYSQL_QUERY("SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;");
        $rows=mysql_result($table, 0, "f1");
        if ($rows==0):
          print "SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;";
          $month=$month+0;
?>
    <P>Отчёт не может быть создан по причине отсутствия данных в таблице БД за <?print "$months[$month] $year года";?>!</P>
<?
          die("");
        endif;
      endif;
      $i=$month+0;
      // !!! изменение тарифов !!!
      if ($year<2004):
        $tax1=84;
      elseif ($year>2004):
        $tax1=90;
      elseif ($year==2004):
        if ($i<=2): $tax1=84; endif;
        if (($i>=3)&&($i<=5)): $tax1=87; endif;
        if ($i>5): $tax1=90; endif;
      endif;
      $tax2=$tax1*2;
      $Subject="Сведения о входящем трафике в сеть РУП \"Белтелеком\" на платные справочные службы от сети СООО \"МТС\" за период с $startdate по $stopdate $months2[$i] $year года";
      // проверка на наличие ранее созданной таблицы
      $table=MYSQL_QUERY("SHOW TABLES FROM newstat LIKE 'rep8';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // создание таблицы в случае её отсутствия
      if ($num_rows==0)
        MYSQL_QUERY("CREATE TABLE newstat.rep8 (service char(4) NOT NULL default '', yearmonth char(6) NOT NULL default '', calls_quantity int(11) unsigned default NULL) TYPE=MyISAM;");
      // удаление всех записей за данный период в случае необходимости пересчёта уже существующих данных
      if ($RECALC=="on")
        MYSQL_QUERY("DELETE FROM newstat.rep8 WHERE yearmonth='$year$month';");
      // проверка на наличие данных за период в таблице

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep8 WHERE service='009d' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '0297______') OR (ani LIKE '0295______')) AND ((vrijeme>='06:00:00') AND (vrijeme<'22:00:00')) GROUP BY ddi;"); // получение количества звонков на услугу в дневное время
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep8 VALUES('009d', '$year$month', $row1);");
      endif;

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep8 WHERE service='009n' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      // расчёт данных за период в случае их отсутствия в таблице
      if ($num_rows==0):
        // проверка на наличие данных за месяц
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '0297______') OR (ani LIKE '0295______')) AND ((vrijeme<'06:00:00') OR (vrijeme>='22:00:00')) GROUP BY ddi;"); // получение количества звонков на услугу в ночное время
        $num_rows1=MYSQL_NUM_ROWS($table1); // получение количества строк выборки
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep8 VALUES('009n', '$year$month', $row1);");
      endif;

      $f1="Ошибка!"; // поле для количества звонков за день
      $f2="Ошибка!"; // поле для суммы за день
      $f3="Ошибка!"; // поле для количества звонков за ночь
      $f4="Ошибка!"; // поле для суммы за ночь
      $f5="Ошибка!"; // поле для итоговой суммы
      $table=MYSQL_QUERY("SELECT calls_quantity AS f1 FROM newstat.rep8 WHERE service='009d' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f1=mysql_result($table, 0, "f1");
        $f2=$tax1*$f1;
      endif;
      $table=MYSQL_QUERY("SELECT calls_quantity AS f3 FROM newstat.rep8 WHERE service='009n' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // получение количества строк выборки
      if ($num_rows>0):
        $f3=mysql_result($table, 0, "f3");
        $f4=$tax2*$f3;
      endif;
      // если суммы за день и за ночь являются числами, а не строками "Ошибка!" - расчитать итоговую сумму
      if (($f2!="Ошибка!")&&($f4!="Ошибка!")) $f5=$f2+$f4;
      // вывод данных на экран
?>
    <TABLE BORDER="1" ALIGN="CENTER" STYLE="border: 0 solid #FFFFFF; font-size: 8pt;">
      <TBODY STYLE="vertical-align: top;">
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="5" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;">&nbsp;</TD><TD COLSPAN="4" STYLE="border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: right;">Справочно-информационный цех филиала &laquo;МГТС&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD></TR>
        <TR><TD COLSPAN="9" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0; font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 2cm; padding-bottom: 0.5cm;">Сведения&nbsp;о&nbsp;входящем&nbsp;трафике в&nbsp;сеть&nbsp;РУП&nbsp;&laquo;Белтелеком&raquo; на&nbsp;платные&nbsp;справочные&nbsp;службы от&nbsp;сети&nbsp;СООО&nbsp;&laquo;МТС&raquo;</TD></TR>
        <TR><TD COLSPAN="9" STYLE="padding: 1cm 0cm 0.5cm 0cm; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 10pt;">Период: <B><?print "$startdate-$stopdate $months2[$i] $year года";?></B></TD></TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;" ROWSPAN="2">Служба</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;" ROWSPAN="2">Период</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">Количество соединений</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">Тариф (бел. руб.)</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="3">Сумма (бел. руб.)</TH>
        </TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Дневное время*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">Ночное время**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Дневное время*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">Ночное время**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Дневное время*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">Ночное время**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">Всего</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;">009</TD>
          <TD WIDTH="150px" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print "$startdate-$stopdate.$month.$year";?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $f1;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f3;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $tax1;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $tax2;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $f2;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $f4;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f5;?></TD>
        </TR>
        <TR><TD COLSPAN="9" STYLE="padding: 10px 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 10pt;\">Итого в пользу РУП &laquo;Белтелеком&raquo;:&nbsp;&nbsp;&nbsp;<B><?print "$f5&nbsp;бел.&nbsp;руб.";?></B></TD></TR>
        <TR VALIGN="BOTTOM" STYLE="height: 7.7cm;"><TD COLSPAN="9" STYLE="padding-bottom: 1cm; text-align: left; font-size: 7pt; border-color: #FFFFFF; border-style: solid; border-width: 0;"><I>Примечания:</I><BR>*: ежедневное оказание услуг с 06<SUP>00</SUP> до 21<SUP>59</SUP> (для справочной службы &laquo;009&raquo;)<BR>**: ежедневное оказание услуг с 21<SUP>00</SUP> до 05<SUP>59</SUP> (для справочной службы &laquo;009&raquo;)</TD></TR>
        <TR>
<?
      if ($maker!=""):
?>
          <TD COLSPAN="6" STYLE="padding-top: 10px; border-color: gray; border-style: solid; border-width: 1px 0 0 0; text-align: left; font-size: 6pt;">Исполнитель:<BR>
<?
        if ($makerstate!=""): print "$makerstate<BR>"; endif;
        print "$maker";
        if ($makerphone!=""): print "<BR>$makerphone"; endif;
      else:
?>
          <TD COLSPAN="6" STYLE="border-color: white; border-style: solid; border-width: 0;">
<?
      endif;
?>
          </TD>
          <TD COLSPAN="3" STYLE="text-align: right; padding-top: 10px; border-color: gray; border-style: solid; border-width: 1px 0 0 0; font-size: 6pt;">Факс для отправки отчёта:<BR>(8017)2261288, (8017)2222901</TD>
        </TR>
      </TBODY>
    </TABLE>
<?
      $i=$month+0;
      // формирование текста письма
      $message="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">
<HTML>
  <BODY STYLE=\"font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; background-color: white; margin: 10px; color: #000000;\">
    <TABLE BORDER=\"1\" ALIGN=\"CENTER\" STYLE=\"caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent; border: 0 solid #FFFFFF;\">
      <TBODY STYLE=\"vertical-align: top;\">
        <TR><TD COLSPAN=\"5\" STYLE=\"border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 6pt;\">&nbsp;</TD><TD COLSPAN=\"4\" STYLE=\"border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: right; font-size: 6pt;\">Справочно-информационный цех филиала &laquo;МГТС&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD></TR>
        <TR><TD COLSPAN=\"9\" STYLE=\"border-color: #FFFFFF; border-style: solid; border-width: 0; font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 2cm; padding-bottom: 0.5cm;\">Сведения&nbsp;о&nbsp;входящем&nbsp;трафике в&nbsp;сеть&nbsp;РУП&nbsp;&laquo;Белтелеком&raquo; на&nbsp;платные&nbsp;справочные&nbsp;службы от&nbsp;сети&nbsp;СООО&nbsp;&laquo;МТС&raquo;</TD></TR>
        <TR><TD COLSPAN=\"9\" STYLE=\"padding: 1cm 0cm 0.5cm 0cm; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 10pt;\">Период: <B>$startdate-$stopdate $months2[$i] $year года</B></TD></TR>
        <TR VALIGN=\"MIDDLE\" STYLE=\"font-weight: bold;\">
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px 2px;\" ROWSPAN=\"2\">Служба</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px  1px;\" ROWSPAN=\"2\">Период</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px  1px;\" COLSPAN=\"2\">Количество соединений</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px  1px;\" COLSPAN=\"2\">Тариф (бел. руб.)</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px  1px;\" COLSPAN=\"3\">Сумма (бел. руб.)</TH>
        </TR>
        <TR VALIGN=\"MIDDLE\" STYLE=\"font-weight: bold;\">
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 1px;\">Дневное время*</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;\">Ночное время**</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 1px;\">Дневное время*</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;\">Ночное время**</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 1px;\">Дневное время*</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;\">Ночное время**</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;\">Всего</TH>
        </TR>
        <TR VALIGN=\"MIDDLE\">
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 2px;\">009</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$startdate-$stopdate.$month.$year</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$f1</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 0;\">$f3</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$tax1</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 0;\">$tax2</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$f2</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 0;\">$f4</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 2px 2px 0;\">$f5</TD>
        </TR>
        <TR><TD COLSPAN=\"9\" STYLE=\"padding: 10px; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 10pt;\">Итого в пользу РУП &laquo;Белтелеком&raquo;:&nbsp;&nbsp;&nbsp;<B>$f5&nbsp;бел.&nbsp;руб.</B></TD></TR>
        <TR><TD COLSPAN=\"5\" STYLE=\"padding-top: 14.5cm; padding-bottom: 1cm; border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: left; font-size: 7pt;\"><I>Примечания:</I><BR>*: ежедневное оказание услуг с 06:00 до 21:59 (для справочной службы &laquo;009&raquo;)<BR>**: ежедневное оказание услуг с 21:00 до 05:59 (для справочной службы &laquo;009&raquo;)</TD COLSPAN=\"4\"><TD></TD></TR>
";
      if ($maker!=""):
        $message.="        <TR>
          <TD COLSPAN=\"9\" STYLE=\"padding-top: 10px; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;\">Исполнитель:<BR>
";
        if ($makerstate!="") $message.="$makerstate<BR>";
        $message.="$maker";
        if ($makerphone!="") $message.="<BR>$makerphone";
        $message.="
          </TD>
        </TR>
      </TBODY>
    </TABLE>
";
      endif;
      $message.="  </BODY>\n</HTML>";
    endif; // ($rep=="номер отчёта")
    // отправка писем адресатам в случае если был выбран соответствующий пункт и заполнены поля адресатов
    if (($EMAIL1Addr!="")&&($action=="email")&&($message!="")): $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: "; if ($EMAIL1Name!="") $Headers.="\"$EMAIL1Name\" "; $Headers.="<$EMAIL1Addr>\nContent-Type: text/html; charset=Windows-1251"; if (mail("$EMAIL1Addr",$Subject,$message,$Headers)): print "<BR><HR><P>Отправка отчёта "; if ($EMAIL1Name!=""): print "<B>$EMAIL1Name</B> "; endif; print "по адресу <B>$EMAIL1Addr</B> прошла успешно.</P>"; else: print "<BR><HR><P>Не удалось отправить отчёт "; if ($EMAIL1Name!=""): print "<B>$EMAIL1Name</B> "; endif; print "по адресу <B>$EMAIL1Addr</B>!</P>"; endif; endif;
    if (($EMAIL2Addr!="")&&($action=="email")&&($message!="")): $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: "; if ($EMAIL2Name!="") $Headers.="\"$EMAIL2Name\" "; $Headers.="<$EMAIL2Addr>\nContent-Type: text/html; charset=Windows-1251"; if (mail("$EMAIL2Addr",$Subject,$message,$Headers)): print "<P>Отправка отчёта "; if ($EMAIL2Name!=""): print "<B>$EMAIL2Name</B> "; endif; print "по адресу <B>$EMAIL2Addr</B> прошла успешно.</P>"; else: print "<P>Не удалось отправить отчёт "; if ($EMAIL2Name!=""): print "<B>$EMAIL2Name</B> "; endif; print "по адресу <B>$EMAIL2Addr</B>!</P>"; endif; endif;
    if (($EMAIL3Addr!="")&&($action=="email")&&($message!="")): $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"Справочно-информационный цех филиала МГТС РУП Белтелеком\" <sic009@tut.by>\nTo: "; if ($EMAIL3Name!="") $Headers.="\"$EMAIL3Name\" "; $Headers.="<$EMAIL3Addr>\nContent-Type: text/html; charset=Windows-1251"; if (mail("$EMAIL3Addr",$Subject,$message,$Headers)): print "<P>Отправка отчёта "; if ($EMAIL3Name!=""): print "<B>$EMAIL3Name</B> "; endif; print "по адресу <B>$EMAIL3Addr</B> прошла успешно.</P>"; else: print "<P>Не удалось отправить отчёт "; if ($EMAIL3Name!=""): print "<B>$EMAIL3Name</B> "; endif; print "по адресу <B>$EMAIL3Addr</B>!</P>"; endif; endif;
  break;
*/

if (($step==5)): // ¤«п ўбҐе ®взсв®ў: Ґб«Ё ®в®Ўа ¦ Ґвбп и Ј 5 Ё ўлЎа ­  а бЇҐз вЄ  ­  ЇаЁ­вҐаҐ, ®в®Ўа §Ёвм Є­®ЇЄЁ "<< Ќ § ¤" Ё "ЏҐз вм"
?>
    <BR><CENTER><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Ќ § ¤" NAME="back"><?if ($action=="print"):?>&nbsp;<INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="document.all.print.style.visibility='hidden'; document.all.back.style.visibility='hidden'; if (typeof(window.print) != 'undefined') {window.print();}; document.all.back.style.visibility = '';document.all.print.style.visibility = '';" VALUE="ЏҐз вм" NAME="print"><?endif;?></CENTER>
<?
endif;


var_dump($result_array);