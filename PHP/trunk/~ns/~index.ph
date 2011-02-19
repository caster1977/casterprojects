<?
// если не указан текущий шаг создания отчёта - установить шаг номер 1
if (!(($STEP=="2")||($STEP=="3")||($STEP=="4")||($STEP=="5")||($STEP=="6")||($STEP=="7")||($STEP=="8"))) $STEP="1";
// заполнение массива названий месяцев
$months[]=""; $months[]="января"; $months[]="февраля"; $months[]="марта"; $months[]="апреля";
$months[]="мая"; $months[]="июня"; $months[]="июля"; $months[]="августа"; $months[]="сентября"; 
$months[]="октября"; $months[]="ноября"; $months[]="декабря";
$repnames[1]="Статистика работы услуг СИЦ";
$repnames[2]="Квартальный отчёт по услуге СИЦ &laquo;009&raquo;";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Формирование отчётов (шаг <?print $STEP;?>)</TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT=Dynamic name=Document-state>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
    <STYLE>
      *               {font-family: Verdana, Arial, Helvetica, sans-serif;}
      BODY            {font-size: 8pt; background-color: white; margin: 10px; color: #000000;}
      P               {font-size: 8pt; text-indent: 20px; margin-top: 2px; margin-bottom: 2px; text-align: justify; font-weight: normal; color: #000000; background: transparent;}
      A               {font-size: inherit; text-align: left; font-weight: bold; background: transparent; text-decoration:none;}
      A:link          {color: #000000; font-weight: bold;}
      A:hover         {color: #000000; text-decoration:underline; font-weight: bold;}
      A:active        {color: #000000; font-weight: bold;}
      A:visited       {color: #000000; font-weight: bold;}
      H1              {font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;}
      CAPTION         {font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;}
      TABLE           {caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent;}
      TBODY           {vertical-align: top;}
      TD              {font-weight: normal; padding: 0px 5px;}
      TH              {font-weight: bold; padding: 0px 5px;}
      TH.la           {font-weight: bold; padding: 0px 5px; text-align: left;}
      TH.ra           {font-weight: bold; padding: 0px 5px; text-align: right;}
      TABLE.border, TABLE.border_la {border: 2px solid #000000;}
      TABLE.border TH {text-align: center; border: 2px solid #000000; padding: 2px 5px;}
      TABLE.border TD {text-align: center; padding: 2px 5px; border-width: 1px 2px; border-color: #000000; border-style: solid}
      TABLE.border TH.la {text-align: left; border: 2px solid #000000; padding: 2px 5px;}
      TABLE.border TD.la {text-align: left; padding: 2px 5px; border-width: 1px 2px; border-color: #000000; border-style: solid}
      TABLE.border TH.ra {text-align: right; border: 2px solid #000000; padding: 2px 5px;}
      TABLE.border TD.ra {text-align: right; padding: 2px 5px; border-width: 1px 2px; border-color: #000000; border-style: solid}
      TABLE.border_la TH {text-align: left; border: 2px solid #000000; padding: 2px 5px;}
      TABLE.border_la TD {text-align: left; padding: 2px 5px; border-width: 1px 2px; border-color: #000000; border-style: solid}
    </STYLE>
  </HEAD>
  <BODY>
<?
switch ($STEP):
  case "2":
    // валидация параметров и выход в случае их непредвиденного отсутствия
    if (($rep=="")||($sday=="")||($smonth=="")||($syear=="")||($fday=="")||($fmonth=="")||($fyear=="")):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Внимание! Переданы неверные параметры строки запроса!</B><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для перехода к выбору параметров создаваемого отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><FORM ACTION="index.php" METHOD="POST"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="1"><INPUT TYPE="SUBMIT" VALUE="<<< Назад"></FORM></TD></TD></TR>
      </TBODY>
    </TABLE>
<?
      break;
    endif;
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#339999">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="5">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="5">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD class="la" WIDTH="50%">Отчёт:</TD><TD WIDTH="50%"><B><?print $repnames[$rep]; ?><B></TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">Начальная дата:</TD><TD class="la"><B><?print $sday;?>&nbsp;<?print $months[$smonth];?>&nbsp;<?print $syear;?></B></TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">Конечная дата:</TD><TD class="la"><B><?print $fday;?>&nbsp;<?print $months[$fmonth];?>&nbsp;<?print $fyear;?></B></TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="4"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="4"><FORM ACTION="index.php" METHOD="POST"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="1"><INPUT TYPE="SUBMIT" VALUE="<<< Назад"></FORM></TD></TD></TR>
      </TBODY>
    </TABLE>
    <FORM ACTION="index.php" METHOD="POST">
      <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="3">
      <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
      <INPUT TYPE="HIDDEN" NAME="sday" VALUE="<?print $sday;?>">
      <INPUT TYPE="HIDDEN" NAME="smonth" VALUE="<?print $smonth;?>">
      <INPUT TYPE="HIDDEN" NAME="syear" VALUE="<?print $syear;?>">
      <INPUT TYPE="HIDDEN" NAME="fday" VALUE="<?print $fday;?>">
      <INPUT TYPE="HIDDEN" NAME="fmonth" VALUE="<?print $fmonth;?>">
      <INPUT TYPE="HIDDEN" NAME="fyear" VALUE="<?print $fyear;?>">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
<?
    switch ($rep):
      case "1":
?>
          <TR VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="16">&nbsp;</TD><TD HEIGHT="15" COLSPAN="2"  WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="16">&nbsp;</TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Выберите услуги СИЦ, по которым необходимо сфлрмировать отчёт:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH BGCOLOR=#FFFFFF WIDTH="50%">Голосовые услуги</TH><TH BGCOLOR=#EEEEEE WIDTH="50%">Автоинформатор</TH></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C009" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">009 &#151; Платная справка</TD><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C075" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">075 &#151; Тарифы жилищно-коммунального хозяйства</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C090" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">090 &#151; МинскгорИнфоСервис</TD><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C088" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">088 &#151; Служба точного времени</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C093" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">093 &#151; Отдых и развлечения</TD><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C091" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">091 &#151; Киноафиша</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C099" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">099 &#151; Бесплатная справка</TD><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C092" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">092 &#151; Ночной Минск</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C9900911" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">9900911 &#151; Межгород, платная справка</TD><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C094" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">094 &#151; Гороскоп</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C9909111" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">9909111 &#151; Межгород, бесплатная справка</TD><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C095" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">095 &#151; Прогноз погоды</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C9909911" ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked);">9909911 &#151; Межгород, бесплатная справка</TD><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="C096" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">096 &#151; Сказки для детей</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#FFFFFF></TD><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="C097" ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">097 &#151; Именины</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR=#EEEEEE><INPUT TYPE="CHECKBOX" NAME="CHECK_ALL_VOICE" ONCLICK="C009.checked=this.checked; C090.checked=this.checked; C093.checked=this.checked; C099.checked=this.checked; C9900911.checked=this.checked; C9909111.checked=this.checked; C9909911.checked=this.checked;">выбрать все голосовые услуги</TD><TD BGCOLOR=#FFFFFF><INPUT TYPE="CHECKBOX" NAME="CHECK_ALL_AUTO" ONCLICK="C075.checked=this.checked; C088.checked=this.checked; C091.checked=this.checked; C092.checked=this.checked; C094.checked=this.checked; C095.checked=this.checked; C096.checked=this.checked; C097.checked=this.checked;">выбрать все услуги на базе автоинформатора</TD></TR>
<?
      break;
    endswitch;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="4"><INPUT TYPE="SUBMIT" VALUE="Далее >>>"></TD></TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;
  case "3":
    // валидация параметров и выход в случае их непредвиденного отсутствия
    if (($rep=="")||($sday=="")||($smonth=="")||($syear=="")||($fday=="")||($fmonth=="")||($fyear=="")):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Внимание! Переданы неверные параметры строки запроса!</B><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для перехода к выбору параметров создаваемого отчёта.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><FORM ACTION="index.php" METHOD="POST"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="1"><INPUT TYPE="SUBMIT" VALUE="<<< Назад"></FORM></TD></TD></TR>
      </TBODY>
    </TABLE>
<?
      break;
    elseif (($C009!="on")&&($C075!="on")&&($C088!="on")&&($C090!="on")&&($C091!="on")&&($C092!="on")&&($C093!="on")&&($C094!="on")&&($C095!="on")&&($C096!="on")&&($C097!="on")&&($C9900911!="on")&&($C9909111!="on")&&($C9909911!="on")):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FFFF00">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>Внимание! Вы должны выбрать хотя бы одну из услуг для формирования отчёта!</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><FORM ACTION="index.php" METHOD="POST"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="2"><INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>"><INPUT TYPE="HIDDEN" NAME="sday" VALUE="<?print $sday;?>"><INPUT TYPE="HIDDEN" NAME="smonth" VALUE="<?print $smonth;?>"><INPUT TYPE="HIDDEN" NAME="syear" VALUE="<?print $syear;?>"><INPUT TYPE="HIDDEN" NAME="fday" VALUE="<?print $fday;?>"><INPUT TYPE="HIDDEN" NAME="fmonth" VALUE="<?print $fmonth;?>"><INPUT TYPE="HIDDEN" NAME="fyear" VALUE="<?print $fyear;?>"><INPUT TYPE="SUBMIT" VALUE="<<< Назад"></FORM></TD></TD></TR>
      </TBODY>
    </TABLE>
<?
      break;
    endif;
    switch ($rep):
      case "1":
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#339999">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="8">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="8">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" WIDTH="50%">Отчёт:</TD><TD WIDTH="50%"><B><?print $repnames[$rep]; ?><B></TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">Начальная дата:</TD><TD class="la"><B><?print $sday;?>&nbsp;<?print $months[$smonth];?>&nbsp;<?print $syear;?></B></TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">Конечная дата:</TD><TD class="la"><B><?print $fday;?>&nbsp;<?print $months[$fmonth];?>&nbsp;<?print $fyear;?></B></TD></TR>
<?
        $s="";
        if ($C009=="on"):
          $s .= "009";
        endif;
        if ($C075=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "075";
        endif;
        if ($C088=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "088";
        endif;
        if ($C090=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "090";
        endif;
        if ($C091=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "091";
        endif;
        if ($C092=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "092";
        endif;
        if ($C093=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "093";
        endif;
        if ($C094=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "094";
        endif;
        if ($C095=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "095";
        endif;
        if ($C096=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "096";
        endif;
        if ($C097=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "097";
        endif;
        if ($C099=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "099";
        endif;
        if ($C9900911=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "9900911";
        endif;
        if ($C9909111=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "9909111";
        endif;
        if ($C9909911=="on"):
          if ($s!=""):
            $s .= ", ";
          endif;
          $s .= "9909911";
        endif;
?>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">Услуги:</TD><TD class="la"><B><?print $s;?></B></TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">Комментарии:</TD><TD class="la">Данный отчёт отправляется дежурным инженером за прошедший день, по понедельникам за прошедшую неделю, а так же первого числа каждого месяца за прошедший месяц в виде сохранённого файла <B>*.htm</B> на адрес электронной почты <B>irai@mgts.by</B><!-- и <B>anna@mgts.by</B> --> специалисту отдела маркетинга (Илюк&nbsp;И.М.), а также печатается в одном экземпляре и предоставляется начальнику СИЦ (Степановой&nbsp;М.Н.) каждый понедельник за прошедшую неделю и 1-го числа каждого месяца за прошедший месяц.</TD></TR>
        <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="4"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="4"><FORM ACTION="index.php" METHOD="POST"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="2"><INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>"><INPUT TYPE="HIDDEN" NAME="sday" VALUE="<?print $sday;?>"><INPUT TYPE="HIDDEN" NAME="smonth" VALUE="<?print $smonth;?>"><INPUT TYPE="HIDDEN" NAME="syear" VALUE="<?print $syear;?>"><INPUT TYPE="HIDDEN" NAME="fday" VALUE="<?print $fday;?>"><INPUT TYPE="HIDDEN" NAME="fmonth" VALUE="<?print $fmonth;?>"><INPUT TYPE="HIDDEN" NAME="fyear" VALUE="<?print $fyear;?>"><INPUT TYPE="SUBMIT" VALUE="<<< Назад"></FORM></TD></TD></TR>
      </TBODY>
    </TABLE>
    <FORM ACTION="index.php" METHOD="POST">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="22">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="22">&nbsp;</TD></TR>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"><B>Выберите действие, которое необходимо выполнить:</B></TD></TR>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="ACTION" VALUE="email" STYLE='height:13px;' CHECKED><B>отправка по электронной почте</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT" WIDTH="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите адрес первого получателя:</TD><TD><INPUT TYPE="TEXT" NAME="EMAIL1" SIZE="30" VALUE="irai@mgts.by"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите адрес второго получателя:</TD><TD><INPUT TYPE="TEXT" NAME="EMAIL2" SIZE="30" VALUE=""></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите адрес третьего получателя:</TD><TD><INPUT TYPE="TEXT" NAME="EMAIL3" SIZE="30"></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="ACTION" VALUE="print" STYLE='height:13px;'><B>визуальный просмотр, подготовка к печати</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT"" COLSPAN="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B><FONT COLOR="#FF0000">Внимание!</FONT></B> Для печати необходимо выставить в меню <B>|Файл|Параметры страницы&#133;|</B> следующие параметры страницы:</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ слева:</TD><TD><B>30.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ справа:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ сверху:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Отступ снизу:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ориентация страницы:</TD><TD><B>книжная</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Нижний колонтитул:</TD><TD><B>&b&bСтраница &p из &P</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="ACTION" VALUE="save" STYLE='height:13px;'><B>сохранение в файл на диске</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT" WIDTH="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Введите путь для сохранения файла:</TD><TD><INPUT TYPE="TEXT" NAME="SAVEPATH" SIZE="30" VALUE="C:\"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Выберите формат файла:</TD><TD><SELECT NAME="savefiletype"><OPTION VALUE="htm" CHECKED>htm</OPTION><OPTION VALUE="txt">txt</OPTION><OPTION VALUE="csv">csv</OPTION></SELECT></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="4"><FORM ACTION="index.php" METHOD="GET"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="5"><INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>"><INPUT TYPE="HIDDEN" NAME="sday" VALUE="<?print $sday;?>"><INPUT TYPE="HIDDEN" NAME="smonth" VALUE="<?print $smonth;?>"><INPUT TYPE="HIDDEN" NAME="syear" VALUE="<?print $syear;?>"><INPUT TYPE="HIDDEN" NAME="fday" VALUE="<?print $fday;?>"><INPUT TYPE="HIDDEN" NAME="fmonth" VALUE="<?print $fmonth;?>"><INPUT TYPE="HIDDEN" NAME="fyear" VALUE="<?print $fyear;?>"><INPUT TYPE="HIDDEN" NAME="C009" CHECKED><INPUT TYPE="HIDDEN" NAME="C075" CHECKED><INPUT TYPE="HIDDEN" NAME="C090" CHECKED><INPUT TYPE="HIDDEN" NAME="C088" CHECKED><INPUT TYPE="HIDDEN" NAME="C093" CHECKED><INPUT TYPE="HIDDEN" NAME="C091" CHECKED><INPUT TYPE="HIDDEN" NAME="C099" CHECKED><INPUT TYPE="HIDDEN" NAME="C092" CHECKED><INPUT TYPE="HIDDEN" NAME="C9900911" CHECKED><INPUT TYPE="HIDDEN" NAME="C094" CHECKED><INPUT TYPE="HIDDEN" NAME="C9909111" CHECKED><INPUT TYPE="HIDDEN" NAME="C095" CHECKED><INPUT TYPE="HIDDEN" NAME="C9909911" CHECKED><INPUT TYPE="HIDDEN" NAME="C096" CHECKED><INPUT TYPE="HIDDEN" NAME="C097" CHECKED><INPUT TYPE="SUBMIT" VALUE="Далее >>>"></FORM></TD></TD></TR-->
          <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="5">
          <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
          <INPUT TYPE="HIDDEN" NAME="sday" VALUE="<?print $sday;?>">
          <INPUT TYPE="HIDDEN" NAME="smonth" VALUE="<?print $smonth;?>">
          <INPUT TYPE="HIDDEN" NAME="syear" VALUE="<?print $syear;?>">
          <INPUT TYPE="HIDDEN" NAME="fday" VALUE="<?print $fday;?>">
          <INPUT TYPE="HIDDEN" NAME="fmonth" VALUE="<?print $fmonth;?>">
          <INPUT TYPE="HIDDEN" NAME="fyear" VALUE="<?print $fyear;?>">
          <!--
          <INPUT TYPE="HIDDEN" NAME="C009" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C075" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C090" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C088" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C093" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C091" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C099" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C092" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C9900911" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C094" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C9909111" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C095" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C9909911" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C096" CHECKED>
          <INPUT TYPE="HIDDEN" NAME="C097" CHECKED>
          -->
        </TBODY>
      </TABLE>
    </FORM>
<?
      break;
    endswitch;
  break;
  case "4": break;
  case "5":
    switch ($rep):
      case "1":
        $hostname="10.1.1.2";
        $username="sel";
        $password="";
        $dbName="statistika";
        $MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
        MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase");
?>
    <P>Succesfully connected to database <B>statistika</B> on MySQL-server <B>DBSERVER</B>.</P>
<?      $title="Статистика работы телефонисток за ";
        if (($sday==$fday)&&($smonth==$fmonth)&&($syear==$fyear)):
        $title .="$sday&nbsp;";
        $title .=$months[$smonth];
        $title .="&nbsp;$syear года";
      else:
        $title .="период с $sday $months[$smonth] $syear по $fday $months[$fmonth] $fyear";
      endif;
?>
    <TABLE CLASS="border" BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <CAPTION ALIGN="CENTER"><?print $title;?></CAPTION>
      <TBODY>
        <TR VALIGN="MIDDLE">
          <TH>Телефон<BR>службы</TH>
          <TH>Наименование службы</A></TH>
          <TH>Обслужено<BR>звонков</TH>
          <TH>Длительность<BR>звонков<BR>(в мин.)</TH>
          <TH>Процент<BR>отказов<BR>(в %)</TH>
        </TR>
<?
      if (($sday==$fday)&&($smonth==$fmonth)&&($syear==$fyear)): // случай с одним днём
      // <!-- input type=button style="background-color:blue" value="Click Me" -->
?>
        <TR>
          <TD>
<!--
<A HREF="file://c:/autoexec.">1.csv</A>
<FORM METHOD="POST" ACTION="mailto:vlad_dracula@tut.by">
<INPUT TYPE="SUBMIT" VALUE="Создать отчёт! >>>">
Hello, world!
<INPUT TYPE="FILE" NAME="">
</FORM>
<DIV STYLE="page-break-before:always"></DIV>
<form method="get" name="form" id="form" action="mailto:vlad_dracula@tut.by">
<input type="hidden" name="subject" value="<?print $title;?>">
<textarea name="body">Hello,
world!</textarea>
<input type="submit" value="send">
</form>
-->
          </TD>
          <TD>
          </TD>
          <TD>
          </TD>
          <TD>
          </TD>
          <TD>
          </TD>
        </TR>
<?
      endif;
?>
      </TBODY>
    </TABLE>
<?
     break;
   endswitch;
  break;
  case "6": break;
  case "7": break;
  case "8": break;
  default:
    // начальная установка значений дат начала и окончания расчётного периода для отчёта на вчерашнюю дату
    $d=date("d",mktime(0,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))));
    $m=date("m",mktime(0,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))));
    $y=date("Y",mktime(0,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))));
?>
    <FORM ACTION="index.php" METHOD="POST">
      <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="2">
      <TABLE WIDTH="100%" BORDER="0" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="6">&nbsp;</TD><TD COLSPAN="2"></TD><TD WIDTH="5" ROWSPAN="6">&nbsp;</TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>Выберите наименование и временной промежуток формируемого отчёта:</B></TD></TR>
          <TR HEIGHT="15" VALIGN="MIDDLE"><TD COLSPAN="2"></TD></TR>
          <TR VALIGN="MIDDLE" BGCOLOR=#FFFFFF>
            <TD class="la" WIDTH="50%">Выберите отчёт:</TD>
            <TD WIDTH="50%">
              <SELECT name="rep">
<?
    for ($i=1;$i<=count($repnames);$i++):
?>
                <OPTION value="<?print $i;?>"><?print $repnames[$i];?></OPTION>
<?
    endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR VALIGN="MIDDLE" BGCOLOR=#EEEEEE>
            <TD class="la">Выберите начальную дату:</TD>
            <TD class="la">
              <SELECT name="sday">
<?
    for ($i=1;$i<32;$i++):
//      if ($i<10) $j="0$i";
//      else 
      $j=$i;
?>
                <OPTION <?if ($d=="$i"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $j;?></OPTION>
<?
    endfor;
?>
              </SELECT>
              <SELECT name="smonth">
<?
    for ($i=1;$i<count($months);$i++):
//      if ($i<10) $j="0$i";
//      else 
      $j=$i;
?>
                <OPTION <?if ($m=="$i"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $months[$i];?></OPTION>
<?
    endfor;
?>
              </SELECT>
              <SELECT name="syear">
<?
    for ($i=2002;$i<2007;$i++):
?>
                <OPTION <?if ($y=="$i"):?>SELECTED <?endif;?>value="<?print $i;?>"><?print $i;?></OPTION>
<?
    endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR VALIGN="MIDDLE" BGCOLOR=#FFFFFF>
            <TD class="la">Выберите конечную дату:</TD>
            <TD class="la">
              <SELECT name="fday">
<?
    for ($i=1;$i<32;$i++):
//      if ($i<10) $j="0$i";
//      else 
      $j=$i;
?>
                <OPTION <?if ($d=="$i"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $j;?></OPTION>
<?
    endfor;
?>
              </SELECT>
              <SELECT name="fmonth">
<?
    for ($i=1;$i<=12;$i++):
//      if ($i<10) $j="0$i";
//      else 
      $j=$i;
?>
                <OPTION <?if ($m=="$i"):?>SELECTED <?endif;?>value="<?print $j;?>"><?print $months[$i];?></OPTION>
<?
    endfor;
?>
              </SELECT>
              <SELECT name="fyear">
<?
    for ($i=2002;$i<2007;$i++):
?>
                <OPTION <?if ($y=="$i"):?>SELECTED <?endif;?>value="<?print $i;?>"><?print $i;?></OPTION>
<?
    endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR HEIGHT="15" VALIGN="MIDDLE"><TD COLSPAN="4"></TD></TR>
          <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="4"><INPUT TYPE="SUBMIT" VALUE="Далее >>>"></TD></TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;
endswitch;
?>
  </BODY>
</HTML>