<!-- Браузер отчётов -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Браузер отчётов</TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT=Dynamic name=Document-state>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
  </HEAD>
  <BODY>
<?
if ($rep=="") $rep="01";
if ($sday=="") $sday = date("d");
if ($smonth=="") $smonth = date("m");
if ($syear=="") $syear = date("Y");
if ($fday=="") $fday = date("d");
if ($fmonth=="") $fmonth = date("m");
if ($fyear=="") $fyear = date("Y");
$countfromyear=2002;
$yearscount=date("Y")-$countfromyear+1;
$monthscount=12;
/*
for ($i=1;$i<=$monthscount;$i++):
  $months[$i]=date("F", mktime(0,0,0,$i,1,2000));
endfor;
*/
$months[1]="январь";
$months[2]="февраль";
$months[3]="март";
$months[4]="апрель";
$months[5]="май";
$months[6]="июнь";
$months[7]="июль";
$months[8]="август";
$months[9]="сентябрь";
$months[10]="октябрь";
$months[11]="ноябрь";
$months[12]="декабрь";
$reportcount=12;
$reportnames[1]="Статистика работы телефонисток (все смены)";
$reportnames[2]="Статистика работы телефонисток (ночная смена)";
$reportnames[3]="Статистика работы телефонисток по личным (суммарная)";
$reportnames[4]="Статистика работы телефонисток по дням (суммарная)";
$reportnames[5]="Статистика по услугам СИЦ за период";
$reportnames[6]="Входящие по часам подробно (голосовая справка - 009, 099, 9909111)";
$reportnames[7]="Входящие по часам подробно (автоинформатор - 075, 088, 091-097)";
$reportnames[8]="Статистика Content Provider за дату (Гидрометцентр)";
$reportnames[9]="Входящие и статистика определения";
$reportnames[10]="Входящие за период";
$reportnames[11]="Статистика работы телефонисток за период (все смены) итоговая";
$reportnames[12]="Статистика выработки телефонисток (все смены)";
$reporthints["01"]="Данный отчёт печатается по требованию в одном экземпляре дежурным инженером (за требуемый период).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["02"]="Данный отчёт печатается по требованию в одном экземпляре дежурным инженером (за требуемый период).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["03"]="Данный отчёт печатается в одном экземпляре дежурным инженером каждый месяц <NOBR>1-го</NOBR> числа за прошедший месяц. Распечатка предоставляется начальнику СИЦ (Степанова М.Н.).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["04"]="Данный отчёт печатается в одном экземпляре дежурным инженером по требованию (за требуемый период).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступ слева: <I>30.00</I> отступы сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>книжная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["05"]="Данный отчёт отправляется дежурным инженером ежедневно в виде сохранённого файла <B>*.htm</B> на адрес электронной почты <B>irinamgts@mail.ru</B> специалисту отдела маркетинга (Илюк И.М.), а также печатается в одном экземпляре и предоставляется начальнику СИЦ (Степановой М.Н.) <NOBR>1-го</NOBR> числа каждого месяца за прошедший.<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступ слева: <I>30.00</I> отступы сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>книжная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["06"]="Данный отчёт печатается по требованию в одном экземпляре дежурным инженером (за требуемый период).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["07"]="Данный отчёт печатается по требованию в одном экземпляре дежурным инженером (за требуемый период).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["08"]="Данный отчёт печатается ежедневно дежурным инженером за текущий день в 21:00.<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступ слева: <I>30.00</I> отступы сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>книжная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["09"]="Данный отчёт печатается ежедневно дежурным инженером за прошедший день в 08:15.<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступ слева: <I>30.00</I> отступы сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>книжная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["10"]="Данный отчёт печатается по требованию в одном экземпляре дежурным инженером за прошедшую неделю. Распечатка предоставляется начальнику СИЦ (Степанова М.Н.).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["11"]="Данный отчёт печатается каждый понедельник дежурным инженером за прошедшую неделю. Распечатка предоставляется начальнику СИЦ (Степанова М.Н.).<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступы слева, сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>альбомная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$reporthints["12"]="Данный отчёт используется при составлении табелей (Паречина Н.Н.)<HR><B>Для печати отчёта выставьте следующие параметры страницы:</B><BR>отступ слева: <I>30.00</I> отступы сверху, справа, снизу: <I>5.00</I><BR>ориентация страницы: <I>книжная</I><BR>нижний колонтитул: <I>&b&bСтраница &p из &P</I>";
$f["01"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&vSifra='+vSifra.value);\">Создать отчёт</BUTTON>";
$f["02"]=$f["01"];
$f["03"]=$f["01"];
$f["04"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday');\">Создать отчёт</BUTTON>";
$f["05"]=$f["04"];
$f["06"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&v009='+v009.checked+'&v099='+v099.checked+'&v9909111='+v9909111.checked);\">Создать отчёт</BUTTON>";
$f["07"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&v075='+v075.checked+'&v088='+v088.checked+'&v091='+v091.checked+'&v092='+v092.checked+'&v093='+v093.checked+'&v094='+v094.checked+'&v095='+v095.checked+'&v096='+v096.checked+'&v097='+v097.checked);\">Создать отчёт</BUTTON>";
$f["08"]=$f["04"];
$f["09"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&vCollapsed='+vCollapsed.checked);\">Создать отчёт</BUTTON>";
$f["10"]=$f["09"];
$f["11"]=$f["04"];
$f["12"]=$f["04"];
?>
    <TABLE WIDTH=100%>
      <TBODY>
        <TR>
          <TH class="la">Выберите отчёт:</TH>
          <TD>
            <SELECT name="rep" onchange="javascript:location=('index.php?rep='+value+'&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>');">
<?
for ($i=1;$i<=$reportcount;$i++):
  if ($i<10): $j="0$i"; else: $j=$i; endif;
?>
              <OPTION <?if ($rep=="$j"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $reportnames[$i];?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
        <TR>
          <TH class="la" COLSPAN=2><HR>Выберите начальную дату:<HR></TH>
        </TR>
        <TR>
          <TH class="la">Число:</TH>
          <TD>
            <SELECT name="sday" onchange="javascript:location=('index.php?rep=<?print $rep;?>&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday='+value+'&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>');">
<?
for ($i=1;$i<32;$i++):
  if ($i<10) $j="0$i";
  else $j=$i;
?>
              <OPTION <?if ($sday=="$j"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $j;?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
        <TR>
          <TH class="la">Месяц:</TH>
          <TD>
            <SELECT name="smonth" onchange="javascript:location=('index.php?rep=<?print $rep;?>&syear=<?print $syear;?>&smonth='+value+'&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>');">
<?
for ($i=1;$i<=$monthscount;$i++):
  if ($i<10) $j="0$i";
  else $j=$i;
?>
              <OPTION <?if ($smonth=="$j"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $months[$i];?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
        <TR>
          <TH class="la">Год:</TH>
          <TD>
            <SELECT name="syear" onchange="javascript:location=('index.php?rep=<?print $rep;?>&syear='+value+'&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>');">
<?
for ($i=$countfromyear;$i<($countfromyear+$yearscount);$i++):
?>
              <OPTION <?if ($syear=="$i"):?>SELECTED <?endif;?>value="<?print $i;?>"><?print $i;?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
        <TR>
          <TH class="la" COLSPAN=2><HR>Выберите конечную дату:<HR>
          </TH>
        </TR>
        <TR>
          <TH class="la">Число:</TH>
          <TD>
            <SELECT name="fday" onchange="javascript:location=('index.php?rep=<?print $rep;?>&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday='+value);">
<?
for ($i=1;$i<32;$i++):
  if ($i<10) $j="0$i";
  else $j=$i;
?>
              <OPTION <?if ($fday=="$j"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $j;?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
        <TR>
          <TH class="la">Месяц:</TH>
          <TD>
            <SELECT name="fmonth" onchange="javascript:location=('index.php?rep=<?print $rep;?>&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth='+value+'&fday=<?print $fday;?>');">
<?
for ($i=1;$i<=$monthscount;$i++):
  if ($i<10) $j="0$i";
  else $j=$i;
?>
              <OPTION <?if ($fmonth=="$j"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $months[$i];?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
        <TR>
          <TH class="la">Год:</TH>
          <TD>
            <SELECT name="fyear" onchange="javascript:location=('index.php?rep=<?print $rep;?>&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear='+value+'&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>');">
<?
for ($i=$countfromyear;$i<($countfromyear+$yearscount);$i++):
?>
              <OPTION <?if ($fyear=="$i"):?>SELECTED <?endif;?>value="<?print $i;?>"><?print $i;?></OPTION>
<?
endfor;
?>
            </SELECT>
          </TD>
        </TR>
<?
if (checkdate($smonth,$sday,$syear)<>1):
?>
        <TR>
          <TH COLSPAN=2><HR><BUTTON type="Button" onclick="javascript:location=('badday.php?vdate=<?print "$sday/$smonth/$syear";?>');">Создать отчёт</BUTTON></TH>
        </TR>
<?
else:
  if (checkdate($fmonth,$fday,$fyear)<>1):
?>
        <TR>
          <TH COLSPAN=2><HR><BUTTON type="Button" onclick="javascript:location=('badday.php?vdate=<?print "$fday/$fmonth/$fyear";?>');">Создать отчёт</BUTTON></TH>
        </TR>
<?
  else:
?>
        <TR>
          <TH COLSPAN=2><?print $f[$rep];?></TH>
        </TR>
<?
  endif;
endif;
?>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
<?
if (($rep=="01")||($rep=="02")||($rep=="03")):
?>
        <TR>
          <TH CLASS="la" COLSPAN=2>Выберите личный номер:</TH>
        </TR>
        <TR>
          <TD CLASS="la" COLSPAN=2><INPUT TYPE="text" NAME="vSifra" VALUE="%" SIZE="3" MAXLENGTH="3">&nbsp;&nbsp;(<B>%</B> - для всех)</TD>
        </TR>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
<?
endif;
if ($rep=="06"):
?>
        <TR>
          <TH CLASS="la" COLSPAN=2>Выберите услуги для создания отчёта:</TH>
        </TR>
        <TR>
          <TD CLASS="la" COLSPAN=2><INPUT TYPE="checkbox" NAME="v009" CHECKED>009&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v099" CHECKED>099&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v9909111" CHECKED>9909111</TD>
        </TR>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
<?
endif;
if ($rep=="07"):
?>
        <TR>
          <TH CLASS="la" COLSPAN=2>Выберите услуги для создания отчёта:</TH>
        </TR>
        <TR>
          <TD CLASS="la" COLSPAN=2><INPUT TYPE="checkbox" NAME="v075" CHECKED>075&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v088" CHECKED>088&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v091" CHECKED>091&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v092" CHECKED>092&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v093" CHECKED>093&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v094" CHECKED>094&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v095" CHECKED>095&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v096" CHECKED>096&nbsp;&nbsp;<INPUT TYPE="checkbox" NAME="v097" CHECKED>097</TD>
        </TR>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
<?
endif;
if (($rep=="09")||($rep=="10")):
?>
        <TR VALLIGN="MIDDLE">
          <TD CLASS="la" COLSPAN=2><INPUT TYPE="checkbox" NAME="vCollapsed">&laquo;свёрнутый&raquo; отчёт</TD>
        </TR>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
<?
endif;
?>
        <TR>
          <TD COLSPAN=2><?print $reporthints[$rep];?>
          </TD>
        </TR>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>