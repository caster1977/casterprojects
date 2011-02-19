<?
  // проверка на корректность указанного периода времени
    if ($time=="another"):
      if (checkdate($abm,$abd,$aby)<>1):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR><TD BGCOLOR="WHITE" COLSPAN="3"><H1><?echo $title?></H1></TD></TR>
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Внимание! Указана несуществующая начальная дата:</B> <?print "$abd&nbsp;$months2[$abm]&nbsp;$aby&nbsp;года";?>!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к шагу выбора расчётного периода.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      elseif (checkdate($aem,$aed,$aey)<>1):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR><TD BGCOLOR="WHITE" COLSPAN="3"><H1><?echo $title?></H1></TD></TR>
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Внимание! Указана несуществующая конечная дата:</B> <?print "$aed&nbsp;$months2[$aem]&nbsp;$aey&nbsp;года";?>!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к шагу выбора расчётного периода.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      // проверка на адекватность начальной и конечной дат по отношению друг к другу - конечная дата должна быть позднее начальной
      elseif ((mktime(0,0,0,$aem+0,$aed+0,$aey+0)-mktime(0,0,0,$abm,$abd,$aby))<0):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR><TD BGCOLOR="WHITE" COLSPAN="3"><H1><?echo $title?></H1></TD></TR>
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Внимание! Задан некорректный диапазон дат:</B><BR>начальная дата (<?print "$abd&nbsp;$months2[$abm]&nbsp;$aby&nbsp;года";?>) является более поздней, чем конечная дата (<?print "$aed&nbsp;$months2[$aem]&nbsp;$aey&nbsp;года";?>)!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к шагу выбора расчётного периода.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endif;
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR><TD BGCOLOR="WHITE" COLSPAN="4"><H1><?echo $title?></H1></TD></TR>
          <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="5">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="5">&nbsp;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" WIDTH="50%" BGCOLOR="#FFFFFF">Отчёт:</TH><TD WIDTH="50%" BGCOLOR="#EEEEEE"><?echo $reports[$rep]["Наименование"]; ?></TD></TR>
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
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="2">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==6)||($rep==7)||($rep==8)||($rep==9)||($rep==10)):
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
    if ($rep==5):
?>
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
    <FORM METHOD="GET">
      <INPUT TYPE="HIDDEN" NAME="step" VALUE="4">
      <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
      <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==6)||($rep==7)||($rep==8)||($rep==9)||($rep==10)):
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
    if ($rep==5):
?>
      <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
      <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
?>
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
<?
    if (($rep==1)||($rep==2)) $rowcount=2+24+8;
    elseif ($rep==3) $rowcount=2+25;
    elseif ($rep==5) $rowcount=2+9;
    elseif (($rep==6)||($rep==7)||($rep==9)||($rep==10)) $rowcount=2+1;
    elseif (($rep==4)||($rep==8)) $rowcount=2+5;
    else $rowcount=2;
?>
          <TR VALIGN="MIDDLE" HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD></TR>
<?
    // если у отчёта есть дополнительные параметры, выводим ниже форму для их ввода
    if (($rep==1)||($rep==2)):
?>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Выберите услуги СИЦ, по которым необходимо сформировать отчёт:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH BGCOLOR="#FFFFFF" WIDTH="50%">Голосовые услуги</TH><TH BGCOLOR="#EEEEEE" WIDTH="50%">Автоинформатор</TH></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C009" <?if ($C009=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">009 &#151; <?echo $services["009"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C075" <?if ($C075=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">075 &#151; <?echo $services["075"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C090" <?if ($C090=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">090 &#151; <?echo $services["090"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C088" <?if ($C088=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">088 &#151; <?echo $services["088"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C093" <?if ($C093=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">093 &#151; <?echo $services["093"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C091" <?if ($C091=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">091 &#151; <?echo $services["091"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C098" <?if ($C099=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.checked);">098 &#151; <?echo $services["098"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C092" <?if ($C092=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">092 &#151; <?echo $services["092"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C099" <?if ($C099=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">099 &#151; <?echo $services["099"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C094" <?if ($C094=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">094 &#151; <?echo $services["094"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C9900911" <?if ($C9900911=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">9900911 &#151; <?echo $services["9900911"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C095" <?if ($C095=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">095 &#151; <?echo $services["095"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C9909111" <?if ($C9909111=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">9909111 &#151; <?echo $services["9909111"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C096" <?if ($C096=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">096 &#151; <?echo $services["096"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C9909911" <?if ($C9909911=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">9909911 &#151; <?echo $services["9909911"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C097" <?if ($C097=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">097 &#151; <?echo $services["097"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99075" <?if ($C99075=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99075 &#151; <?echo $services["99075"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99088" <?if ($C99088=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99088 &#151; <?echo $services["99088"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99091" <?if ($C99091=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99091 &#151; <?echo $services["99091"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99092" <?if ($C99092=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99092 &#151; <?echo $services["99092"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99094" <?if ($C99094=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99094 &#151; <?echo $services["99094"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99095" <?if ($C99095=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99095 &#151; <?echo $services["99095"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99096" <?if ($C99096=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99096 &#151; <?echo $services["99096"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99097" <?if ($C99097=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99097 &#151; <?echo $services["99097"]?></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="CHECK_ALL_VOICE" <?if ($CHECK_ALL_VOICE=="on") print "CHECKED ";?>ONCLICK="C009.checked=this.checked; C090.checked=this.checked; C093.checked=this.checked; C099.checked=this.checked; C9900911.checked=this.checked; C9909111.checked=this.checked; C9909911.checked=this.checked; C098.checked=this.checked;">выбрать все голосовые услуги</TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="CHECK_ALL_AUTO" <?if ($CHECK_ALL_AUTO=="on") print "CHECKED ";?>ONCLICK="C075.checked=this.checked; C088.checked=this.checked; C091.checked=this.checked; C092.checked=this.checked; C094.checked=this.checked; C095.checked=this.checked; C096.checked=this.checked; C097.checked=this.checked; C99075.checked=this.checked; C99088.checked=this.checked; C99091.checked=this.checked; C99092.checked=this.checked; C99094.checked=this.checked; C99095.checked=this.checked; C99096.checked=this.checked; C99097.checked=this.checked;">выбрать все услуги на базе автоинформатора</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Введите данные исполнителя (составителя отчёта):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">Фамилия, инициалы</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>Должность</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: print "инженер-системотехник"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>Контактный телефон</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: print "(8017)2367544"; endif;?>"></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Выберите прочие параметры для формирования отчёта:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" BGCOLOR="#FFFFFF"><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="LEFT"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;"  NAME="RECALC" <?if ($RECALC=="on") print "CHECKED";?>>Провести полный пересчёт данных таблицы за указанный период</TD></TR>
<?
    elseif ($rep==3):
?>
          <TR><TD VALIGN="MIDDLE" ALIGN="CENTER" COLSPAN="2"><B>Выберите параметры отчёта по работе телефонистов и отображаемые поля формы:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="DDBD" <?if ($DDBD=="on") print "CHECKED ";?>ONCLICK="F_DATE.checked=!DDBD.checked;">Не разделять по датам</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="DDBPN" <?if ($DDBPN=="on") print "CHECKED ";?>ONCLICK="F_FIO.checked=!DDBPN.checked; F_PRIVATENUMBER.checked=!DDBPN.checked; F_RM.checked=!DDBPN.checked; F_WORKBEGINTIME.checked=!DDBPN.checked; F_WORKENDTIME.checked=!DDBPN.checked;">Не разделять по личным номерам</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="SONT" <?if ($SONT=="on") print "CHECKED ";?>>Отображать только работу ночной смены</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_DATE" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_DATE.checked) DDBD.checked=false;">Поле &laquo;Дата&raquo; (может выводиться только в случае, если не установлен флажок &laquo;Не разделять по датам&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_FIO" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_FIO.checked) DDBPN.checked=false;">Поле &laquo;Ф.И.О.&raquo; (может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PRIVATENUMBER" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_PRIVATENUMBER.checked) DDBPN.checked=false;">Поле &laquo;Личный номер&raquo; (может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_RM" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_RM.checked) DDBPN.checked=false;">Поле &laquo;Номер рабочего места&raquo; (может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WORKBEGINTIME" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_WORKBEGINTIME.checked) DDBPN.checked=false;">Поле &laquo;Время начала работы&raquo; (может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WORKENDTIME" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_WORKENDTTIME.checked) DDBPN.checked=false;">Поле &laquo;Время окончания работы&raquo; (может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WAITTIME" <?if ($F_WAITTIME=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Перерывы&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WORKTIME" <?if ($F_WORKTIME=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Время работы&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PROCESSMIDDLETIME" <?if ($F_PROCESSMIDDLETIME=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Среднее время обслуживания&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WAITMIDDLETIME" <?if ($F_WAITMIDDLETIME=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Среднее время ожидания&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PROCESSEDALL" <?if ($F_PROCESSEDALL=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Поступило всего&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_NOTPROCESSED" <?if ($F_NOTPROCESSED=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Не обслужено&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PROCESSED" <?if ($F_PROCESSED=="on") print "CHECKED ";?>ONCLICK="">Поле &laquo;Обслужено&raquo;</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Введите данные исполнителя (составителя отчёта):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">Фамилия, инициалы</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>Должность</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: print "инженер-системотехник"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>Контактный телефон</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: print "(8017)2367544"; endif;?>"></TD></TR>
<?
    elseif (($rep==5)||($rep==6)||($rep==7)):
?>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Введите данные исполнителя (составителя отчёта):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">Фамилия, инициалы</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; else: if ($rep==5) print "Иванов В.В."; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>Должность</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: if ($rep==4): print "инженер-системотехник"; elseif ($rep==5): print "инженер-программист"; endif; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>Контактный телефон</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: if ($rep==4): print "(8017)2367544"; elseif ($rep==5): print "(8017)2853813"; endif; endif;?>"></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Выберите прочие параметры для формирования отчёта:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" BGCOLOR="#FFFFFF"><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="LEFT"><INPUT TYPE="CHECKBOX" NAME="RECALC" <?if ($RECALC=="on") print "CHECKED";?>>Провести полный пересчёт данных таблицы за указанный период</TD></TR>
<?
    elseif (($rep==4)||($rep==8)):
?>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Введите данные исполнителя (составителя отчёта):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">Фамилия, инициалы</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; else: if ($rep==8) print "Иванов В.В."; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>Должность</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: if ($rep==4): print "инженер-системотехник"; elseif ($rep==8): print "инженер-программист"; endif; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>Контактный телефон</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: if ($rep==4): print "(8017)2367544"; elseif ($rep==8): print "(8017)2853813"; endif; endif;?>"></TD></TR>
<?
    elseif (($rep==9)||($rep==10)):
?>
          <TR><TD VALIGN="MIDDLE" ALIGN="CENTER" COLSPAN="2"><B>Отсутствуют дополнительные параметры для формирования выбранного отчёта</B></TD></TR>
<?
    endif;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD ALIGN="CENTER" COLSPAN="4"><INPUT TYPE="SUBMIT" VALUE="Далее >>>"></TD></TR>
        </TBODY>
      </TABLE>
    </FORM>