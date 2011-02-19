<?
        $ip=getenv('REMOTE_ADDR');
        if ($ip=="10.1.1.15"):
          if ($makerstate==""): $makerstate="инженер-системотехник"; endif;
          if ($makerphone==""): $makerphone="(8017)2947544"; endif;
        elseif ($ip=="10.1.1.222"):
          if ($maker==""): $maker="Иванов В.В."; endif;
          if ($makerstate==""): $makerstate="инженер-программист 2 категории"; endif;
          if ($makerphone==""): $makerphone="(8017)2853813"; endif;
        elseif ($ip=="10.1.1.16"):
          if ($maker==""): $maker="Захаренко А.А."; endif;
          if ($makerstate==""): $makerstate="ведущий инженер"; endif;
          if ($makerphone==""): $makerphone="(8017)2945222"; endif;
        elseif ($ip=="10.1.1.19"):
          if ($maker==""): $maker="Скавинский Е.В."; endif;
          if ($makerstate==""): $makerstate="инженер-администратор телекоммуникационных систем"; endif;
          if ($makerphone==""): $makerphone="(8017)2945222"; endif;
        elseif ($ip=="10.1.1.246"):
          if ($makerstate==""): $makerstate="инcтруктор по производственно-техническим процессам"; endif;
          if ($makerphone==""): $makerphone="(8017)2942040"; endif;
        elseif ($ip=="10.1.1.247"):
          if ($maker==""): $maker="Гринёк Л.И."; endif;
          if ($makerstate==""): $makerstate="заместитель начальника СИЦ"; endif;
          if ($makerphone==""): $makerphone="(8017)2945081"; endif;
        elseif ($ip=="10.1.1.245"):
          if ($maker==""): $maker="Степанова М.Н."; endif;
          if ($makerstate==""): $makerstate="начальник СИЦ"; endif;
          if ($makerphone==""): $makerphone="(8017)2260852"; endif;
        endif;
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Работа с базами данных справочно-информационного цеха филиала &laquo;МГТС&raquo; РУП &laquo;Белтелеком&raquo; (шаг 2/3)</TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT="Dynamic" NAME="Document-state">
    <META CONTENT="text/html; charset=Windows-1251" HTTP-EQUIV="Content-Type">
    <LINK REL="home" HREF="<?echo $base_url;?>">
    <LINK REL="first" HREF="<?echo $base_url;?>">
    <LINK REL="previous" HREF="<?echo $base_url;?>?step=1<?if ($rep!="") echo "&amp;rep=$rep";?>">
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
  <BODY BGCOLOR="gainsboro">
<?
        if (($rep==3)||($rep==6)||($rep==7)||($rep==13)): //||($rep==14)
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
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
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="1">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;"  ONMOUSEOVER="window.status='Для возврата к шагу выбора действия нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
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
            <TD STYLE="padding: 3px 5px;">Извините, программа формирования данного отчёта ещё не дописана!<BR>Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к окну выбора отчётов.</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="red"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
  </BODY>
</HTML>
<?
          die("");
        endif;
        if (($rep==11)&&(!(($ip=="10.1.1.19")||($ip=="10.1.1.222")||($ip=="10.1.1.246")||($ip=="10.1.1.247")))):
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
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
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="1">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;"  ONMOUSEOVER="window.status='Для возврата к шагу выбора действия нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
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
            <TD STYLE="padding: 3px 5px;">Извините, с данного ПК запрещён доступ к функциям снятия оплаты за звонки на службы СИЦ!<BR>Обратитесь к системному администратору!<BR><BR>Нажмите кнопку <B>&laquo;Назад&raquo;</B> для возврата к предыдущему шагу формирования отчёта.</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="red"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
  </BODY>
</HTML>
<?
          die("");
        endif;
?>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" BORDER="0" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13" ROWSPAN="3"></TD>
            <TD WIDTH="13" ROWSPAN="3"></TD>
            <TD HEIGHT="15" COLSPAN="2"></TD>
            <TD WIDTH="13" ROWSPAN="3"></TD>
            <TD WIDTH="13" ROWSPAN="3"></TD>
          </TR>
          <TR>
            <TD  COLSPAN="2" STYLE="font-family: Times New Roman; font-weight: bold; font-size: 12pt;">Работа с базами данных справочно-информационного филиала &laquo;МГТС&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="3"></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD HEIGHT="15" COLSPAN="6"></TD>
          </TR>
          <TR>
            <TD COLSPAN="6">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="1">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="SUBMIT" VALUE="<<< Назад" STYLE="border-color: black; border-width: 2;"  ONMOUSEOVER="window.status='Для возврата к шагу выбора действия нажмите кнопку &laquo;Назад&raquo;';" ONMOUSEOUT="window.status='';">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="6"></TD>
          </TR>
        </TFOOT>
        <TBODY VALIGN="TOP">
          <TR>
            <TD WIDTH="13" ROWSPAN="4"></TD>
            <TD WIDTH="13" ROWSPAN="4" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="4" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="4"></TD>
          </TR>
          <TR>
            <TD ALIGN="LEFT" WIDTH="50%" STYLE="padding: 3px 5px;"><B>Действие:</B></TD>
            <TD ALIGN="JUSTIFY" WIDTH="50%" BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><?echo $reports[$rep]["Наименование"]; ?></TD>
          </TR>
          <TR>
            <TD ALIGN="LEFT" BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><B>Комментарии:</B></TD>
            <TD ALIGN="JUSTIFY" STYLE="padding: 3px 5px;"><?if (!($reports[$rep]["Комментарии"]=="")) echo $reports[$rep]["Комментарии"]; else echo "<I><ABBR TITLE=\"Комментарии к данному отчёту отсутствуют\">нет</ABBR></I>";?></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
    <FORM METHOD="GET" ACTION="" STYLE="margin: 15px 15px 0px 15px; padding-bottom: 15px;">
      <CENTER> <!-- Данный тэг необходим для выравнивания таблицы по центру в браузере MOZILLA -->
      <TABLE BGCOLOR="WHITE" WIDTH="640" BORDER="0" ALIGN="CENTER" STYLE="border-color: black; border-width: 3;"> <!-- В данной строке выравнивание таблицы по центру - ALIGN="CENTER" корректно обрабатывается IE и OPERA - в MOZILLA не работает! -->
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
            <TD HEIGHT="15" COLSPAN="2"></TD>
            <TD WIDTH="13"></TD>
            <TD WIDTH="13"></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE">
          <TR>
            <TD HEIGHT="15" COLSPAN="6"></TD>
          </TR>
          <TR>
            <TD COLSPAN="6">
              <INPUT TYPE="HIDDEN" NAME="step" VALUE="3">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?echo $rep;?>">
              <INPUT TYPE="SUBMIT" VALUE="Далее >>>" STYLE="border-color: black; border-width: 2;" ONMOUSEOVER="window.status='Выставьте необходимые для формирования отчёта параметры и нажмите кнопку &laquo;Далее&raquo; для перехода к следующему шагу';" ONMOUSEOUT="window.status='';">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="6"></TD>
          </TR>
        </TFOOT>
<?
        switch ($rep):
          case 1: $a=11; $b=$a+71; break;
          case 2: $a=11; $b=$a+50; break;
          case 3: $a=11; $b=$a+55; break;
          case 4: $a=10;  $b=$a+33; break; //27
          case 5: $a=6; $b=$a+33; break;
          case 6: $a=6; $b=$a+33; break;
          case 7: $a=6; $b=$a+33; break;
          case 8: $a=5; $b=$a+6; break;
          case 9: $a=6; $b=$a+6; if (($ip!="10.1.1.222")&&($ip!="10.1.1.250")) $b=$b-6; break;
          case 10: $a=6; $b=$a+6; if (($ip!="10.1.1.222")&&($ip!="10.1.1.250")) $b=$b-6; break;
          case 11: $a=7; $b=$a+8; break;
          case 12: $a=6; $b=$a+33; break;
          case 13: break;
          case 14: $a=7; $b=$a+62; break;
          case 15: $a=11; $b=$a+27; break;
        endswitch;
?>
        <TBODY VALIGN="MIDDLE">
          <TR>
            <TD WIDTH="13" ROWSPAN="<?echo $b;?>"></TD>
            <TD WIDTH="13" ROWSPAN="<?echo $a;?>" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="<?echo $a;?>" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="<?echo $b;?>"></TD>
          </TR>
          <TR>
            <TD ALIGN="CENTER" COLSPAN="2" BGCOLOR="#339999"><B>Выберите временной промежуток выбранного действия:</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
<?
        if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==11)||($rep==14)||($rep==15)):
?>
          <TR<?if ($rep==4):?> BGCOLOR="#EEEEEE"<?endif;?>>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="yesterday"<?if ($time=="yesterday"):?> CHECKED<?endif;?>></TD>
                    <TD><B>вчерашний день</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><?if ($ldd<10) echo "0"; echo "$ldd $months2[$ldm] $ldy года";?></TD>
          </TR>
<?
        endif;
        if (($rep==4)||($rep==11)||($rep==14)):
?>
          <TR<?if ($rep!=4):?> BGCOLOR="#EEEEEE"<?endif;?>>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="today"<?if ($time=="today"):?> CHECKED<?endif;?>></TD>
                    <TD><B>сегодняшний день</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><?if ($d<10) echo "0"; echo "$d $months2[$m] $y года";?></TD>
          </TR>
<?
        endif;
        if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==15)):
?>
          <TR BGCOLOR="#EEEEEE">
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="lastweek"<?if ($time=="lastweek"):?> CHECKED<?endif;?>></TD>
                    <TD><B>прошедшая неделя</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><?if ($lwbd<10) echo "0"; echo "$lwbd $months2[$lwbm] $lwby года - "; if ($lwed<10) echo "0"; echo "$lwed $months2[$lwem] $lwey года";?></TD>
          </TR>
<?
        endif;
        if (($rep==1)||($rep==2)||($rep==3)||($rep==6)||($rep==7)||($rep==9)||($rep==10)||($rep==12)||($rep==15)):
?>
          <TR>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="lastmonth"<?if ($time=="lastmonth"):?> CHECKED<?endif;?>></TD>
                    <TD><B>прошедший месяц</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><?echo "$months[$lmm] $lmy года";?></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="anothermonth" <?if ($time=="anothermonth"):?> CHECKED<?endif;?>></TD>
                    <TD><B>указанный месяц:</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <SELECT NAME="amm">
<?
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$amm):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="amy">
<?
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$amy):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
        endif;
        if ($rep==5):
?>
          <TR>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="lastquart"<?if ($time=="lastquart"):?> CHECKED<?endif;?>></TD>
                    <TD><B>прошедший квартал</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><?echo "$months[$lqbm] - $months[$lqem] $lqy года";?></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD WIDTH="50%" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="anotherquart" STYLE='height:15px;'<?if ($time=="anotherquart"):?> CHECKED<?endif;?>></TD>
                    <TD><B>другой квартал</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="aqq">
<?
          for ($i=1;$i<=count($quartals);$i++):
?>
                <OPTION <?if ($i==$aqq):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $quartals[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="aqy">
<?
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aqy):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
        endif;
        if (($rep==8)||($rep==11)||($rep==14)):
?>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="anotherday"<?if ($time=="anotherday"):?> CHECKED<?endif;?>></TD>
                    <TD><B>указанная дата:</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="add">
<?
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$add):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="adm">
<?
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$adm):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="ady">
<?
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$ady):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
        endif;
        if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==15)):
?>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="time" VALUE="another"<?if ($time=="another"):?> CHECKED<?endif;?>></TD>
                    <TD><B>другой период</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="abd">
<?
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$abd):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="abm">
<?
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$abm):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="aby">
<?
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aby):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="aed">
<?
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$aed):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="aem">
<?
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$aem):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="aey">
<?
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aey):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
        endif;
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
<?
       if ($rep==1):
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD WIDTH="13" ROWSPAN="11" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="11" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#339999"><B>Выберите, по какой из телефонных сетей необходимо сформировать отчёт:</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="common"<?if ($net_type=="common") echo " CHECKED";?>></TD>
                    <TD><B>по всем операторам</B> (суммарная)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="MGTS"<?if ($net_type=="MGTS") echo " CHECKED";?>></TD>
                    <TD><B>МГТС</B> (город и пригород - <I>80172xxxxxx</I>, <I>80175xxxxxx</I>)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="MCS"<?if ($net_type=="MCS") echo " CHECKED";?>></TD>
                    <TD><B>МЦС</B> (<I>80291xxxxxx</I>, <I>80293xxxxxx</I>, <I>80296xxxxxx</I>)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="MTS"<?if ($net_type=="MTS") echo " CHECKED";?>></TD>
                    <TD><B>МТС</B> (<I>80292xxxxxx</I>, <I>80295xxxxxx</I>, <I>80297xxxxxx</I>, <I>80298xxxxxx</I>)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="BeST"<?if ($net_type=="BeST") echo " CHECKED";?>></TD>
                    <TD><B>БеСТ</B> (<I>80259xxxxxx</I>)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="BelSel"<?if ($net_type=="BelSel") echo " CHECKED";?>></TD>
                    <TD><B>БелСел</B> (<I>80294xxxxxx</I>)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="net_type" VALUE="other"<?if ($net_type=="other") echo " CHECKED";?>></TD>
                    <TD><B>прочие</B> (<I>звонки, не вошедшие в предыдущие группы</I>)</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD WIDTH="13" ROWSPAN="24" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="24" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#339999"><B>Выберите услуги СИЦ, по которым необходимо сформировать отчёт:</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>

          <TR>
            <TD STYLE="padding: 3px 5px;" ALIGN="CENTER"><B>Голосовые услуги</B></TD>
            <TD STYLE="padding: 3px 5px;" ALIGN="CENTER" BGCOLOR="#EEEEEE"><B>Автоинформатор</B></TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD HEIGHT="6" COLSPAN="2"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C009" <?if ($C009=="on"): echo "CHECKED "; endif;?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>009</B></TD>
                    <TD><?echo $services["009"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C075" <?if ($C075=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>075</B></TD>
                    <TD><?echo $services["075"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C090" <?if ($C090=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>090</B></TD>
                    <TD><?echo $services["090"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C088" <?if ($C088=="on"): print "CHECKED "; endif;?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>088</B></TD>
                    <TD><?echo $services["088"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C093" <?if ($C093=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>093</B></TD>
                    <TD><?echo $services["093"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C091" <?if ($C091=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>091</B></TD>
                    <TD><?echo $services["091"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C099" <?if ($C099=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>099</B></TD>
                    <TD><?echo $services["099"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C092" <?if ($C092=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>092</B></TD>
                    <TD><?echo $services["092"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C098" <?if ($C098=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>098</B></TD>
                    <TD><?echo $services["098"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C094" <?if ($C094=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>094</B></TD>
                    <TD><?echo $services["094"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99090" <?if ($C99090=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>99090</B></TD>
                    <TD><?echo $services["99090"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C095" <?if ($C095=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>095</B></TD>
                    <TD><?echo $services["095"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99093" <?if ($C99093=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>99093</B></TD>
                    <TD><?echo $services["99093"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C096" <?if ($C096=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>096</B></TD>
                    <TD><?echo $services["096"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C9900911" <?if ($C9900911=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>9900911</B></TD>
                    <TD><?echo $services["9900911"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C097" <?if ($C097=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>097</B></TD>
                    <TD><?echo $services["097"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C9909111" <?if ($C9909111=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>9909111</B></TD>
                    <TD><?echo $services["9909111"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99075" <?if ($C99075=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99075</B></TD>
                    <TD><?echo $services["99075"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C9909911" <?if ($C9909911=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C098.checked && C099.checked && C99090.checked && C99093.checked && C9900911.checked && C9909111.checked && C9909911.checked);"></TD>
                    <TD WIDTH="65px"><B>9909911</B></TD>
                    <TD><?echo $services["9909911"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99088" <?if ($C99088=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99088</B></TD>
                    <TD><?echo $services["99088"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD WIDTH="65px"><B></B></TD>
                    <TD ALIGN="JUSTIFY"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99091" <?if ($C99091=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99091</B></TD>
                    <TD><?echo $services["99091"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD WIDTH="65px"><B></B></TD>
                    <TD ALIGN="JUSTIFY"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99092" <?if ($C99092=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99092</B></TD>
                    <TD><?echo $services["99092"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD WIDTH="65px"><B></B></TD>
                    <TD ALIGN="JUSTIFY"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99094" <?if ($C99094=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99094</B></TD>
                    <TD><?echo $services["99094"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD WIDTH="65px"><B></B></TD>
                    <TD ALIGN="JUSTIFY"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99095" <?if ($C99095=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99095</B></TD>
                    <TD><?echo $services["99095"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD WIDTH="65px"><B></B></TD>
                    <TD ALIGN="JUSTIFY"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99096" <?if ($C99096=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99096</B></TD>
                    <TD><?echo $services["99096"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD WIDTH="65px"><B></B></TD>
                    <TD ALIGN="JUSTIFY"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="C99097" <?if ($C99097=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);"></TD>
                    <TD WIDTH="65px"><B>99097</B></TD>
                    <TD><?echo $services["99097"]?></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD HEIGHT="6" COLSPAN="2"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="CHECK_ALL_VOICE" <?if ($CHECK_ALL_VOICE=="on") print "CHECKED ";?>ONCLICK="C009.checked=this.checked; C090.checked=this.checked; C093.checked=this.checked; C098.checked=this.checked; C099.checked=this.checked; C99090.checked=this.checked; C99093.checked=this.checked; C9900911.checked=this.checked; C9909111.checked=this.checked; C9909911.checked=this.checked;"></TD>
                    <TD COLSPAN="2">выбрать все голосовые услуги</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="CHECK_ALL_AUTO" <?if ($CHECK_ALL_AUTO=="on") print "CHECKED ";?>ONCLICK="C075.checked=this.checked; C088.checked=this.checked; C091.checked=this.checked; C092.checked=this.checked; C094.checked=this.checked; C095.checked=this.checked; C096.checked=this.checked; C097.checked=this.checked; C99075.checked=this.checked; C99088.checked=this.checked; C99091.checked=this.checked; C99092.checked=this.checked; C99094.checked=this.checked; C99095.checked=this.checked; C99096.checked=this.checked; C99097.checked=this.checked;"></TD>
                    <TD COLSPAN="2">выбрать все услуги на базе автоинформатора</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          <!--TR>
            <TD HEIGHT="6" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" COLSPAN="2">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD COLSPAN="2"><B>*</B> - <I>для мобильных сетей отчёт по данным услугам не формируется</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR-->
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
<?
       endif;
       if ($rep==3):
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD WIDTH="13" ROWSPAN="21" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="21" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#339999"><B>Выберите параметры отчёта по работе телефонистов и отображаемые поля формы:</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="DDBD" <?if ($DDBD=="on"): echo "CHECKED "; endif;?>ONCLICK="F_DATE.checked=!DDBD.checked;"></TD>
                    <TD>Не разделять по датам</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="DDBPN" <?if ($DDBPN=="on") echo "CHECKED ";?>ONCLICK="F_FIO.checked=!DDBPN.checked; F_PRIVATENUMBER.checked=!DDBPN.checked; F_RM.checked=!DDBPN.checked; F_WORKBEGINTIME.checked=!DDBPN.checked; F_WORKENDTIME.checked=!DDBPN.checked;"></TD>
                    <TD>Не разделять по личным номерам</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="SONT"<?if ($SONT=="on") echo " CHECKED";?>></TD>
                    <TD>Отображать только работу ночной смены</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD HEIGHT="6" COLSPAN="2"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_DATE" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_DATE.checked) DDBD.checked=false;"></TD>
                    <TD>Поле &laquo;<B>Дата</B>&raquo; <I>(может выводиться только в случае, если не установлен флажок &laquo;Не разделять по датам&raquo;)</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_FIO" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_FIO.checked) DDBPN.checked=false;"></TD>
                    <TD>Поле &laquo;<B>Ф.И.О.</B>&raquo; <I>(может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_PRIVATENUMBER" <?if ($F_DDBPN!="on") echo "CHECKED ";?>ONCLICK="if (F_PRIVATENUMBER.checked) DDBPN.checked=false;"></TD>
                    <TD>Поле &laquo;<B>Личный номер</B>&raquo; <I>(может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_RM" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_RM.checked) DDBPN.checked=false;"></TD>
                    <TD>Поле &laquo;<B>Номер рабочего места</B>&raquo; <I>(может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_WORKBEGINTIME" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_WORKBEGINTIME.checked) DDBPN.checked=false;"></TD>
                    <TD>Поле &laquo;<B>Время начала работы</B>&raquo; <I>(может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_WORKENDTIME" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_WORKENDTIME.checked) DDBPN.checked=false;"></TD>
                    <TD>Поле &laquo;<B>Время окончания работы</B>&raquo; <I>(может выводиться только в случае, если не установлен флажок &laquo;Не разделять по личным номерам&raquo;)</I></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_WAITTIME"<?if ($F_WAITTIME=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Перерывы</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_WORKTIME"<?if ($F_WORKTIME=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Время работы</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_PROCESSMIDDLETIME"<?if ($F_PROCESSMIDDLETIME=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Среднее время обслуживания</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_WAITMIDDLETIME"<?if ($F_WAITMIDDLETIME=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Среднее время ожидания</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_PROCESSEDALL"<?if ($F_PROCESSEDALL=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Поступило всего</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_NOTPROCESSED"<?if ($F_NOTPROCESSED=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Не обслужено</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="F_PROCESSED"<?if ($F_PROCESSED=="on") print " CHECKED";?>></TD>
                    <TD>Поле &laquo;<B>Обслужено</B>&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
<?
       endif;
       if ($rep==11):
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD WIDTH="13" ROWSPAN="21" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="21" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#339999"><B>Введите данные для формирования списка соединений:</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" BGCOLOR="#339999"></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;"><B>Номер телефона абонента:</B></TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="ani" SIZE="30" VALUE="<?if ($ani!=""): echo "$ani"; endif;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;"><I>Номер услуги СИЦ:</I></TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="ddi" SIZE="30" VALUE="<?if ($ddi!=""): echo "$ddi"; endif;?>"></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;"><I>Номер рабочего места телефониста:</I></TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="rm" SIZE="30" VALUE="<?if ($rm!=""): echo "$rm"; endif;?>"></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
<?
       endif;
       if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==12)||($rep==14)||($rep==15)):
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD WIDTH="13" ROWSPAN="7" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="7" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#339999"><B>Введите данные исполнителя (составителя отчёта):</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;">Фамилия, инициалы</TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): echo "$maker"; endif;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">Должность</TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): echo "$makerstate"; endif;?>"></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;">Контактный телефон</TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): echo "$makerphone"; endif;?>"></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR>
            <TD WIDTH="13" ROWSPAN="18" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
            <TD WIDTH="13" ROWSPAN="18" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#339999"><B>Выберите действие, которое необходимо выполнить:</B></TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="action" VALUE="print"<?if ($action=="print") echo " CHECKED";?>></TD>
                    <TD><B>визуальный просмотр, подготовка к сохранению на диск либо к печати</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD><B><FONT COLOR="red">Внимание!</FONT></B> Для печати необходимо выставить в меню <B>|Файл|Параметры страницы...|</B> следующие параметры страницы:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Отступ слева:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><B><?if ($orientation=="книжная") echo "20.00"; elseif ($orientation=="альбомная") echo "5.00";?></B></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Отступ справа:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><B><FONT COLOR="#EEEEEE">0</FONT>5.00</B></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Отступ сверху:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><B><FONT COLOR="WHITE">0</FONT>5.00</B></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Отступ снизу:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><B><FONT COLOR="#EEEEEE">0</FONT>5.00</B></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Ориентация страницы:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><B><?echo $orientation;?></B></TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Верхний колонтитул:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><I>пусто</I></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Нижний колонтитул:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD WIDTH="50%" STYLE="padding: 3px 5px;"><B><ABBR TITLE="СОВЕТ: Выделите данную строчку курсором мыши и скопируйте в буфер обмена">&amp;b&amp;bСтраница &amp;p из &amp;P</ABBR></B></TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD HEIGHT="6" COLSPAN="2"></TD>
          </TR>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="RADIO" NAME="action" VALUE="email"<?if ($action=="email") echo " CHECKED";?>></TD>
                    <TD><B>отправка по электронной почте</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Введите первого получателя:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD STYLE="padding: 1px;" WIDTH="40px">Куда:</TD>
                    <TD STYLE="padding: 1px;"><INPUT TYPE="TEXT" STYLE="border: black solid 1px;" NAME="EMAIL1Addr" SIZE="37" VALUE="<?if ($EMAIL1Addr!=""): echo "$EMAIL1Addr"; elseif ($rep==1): echo "irai@mgts.by"; elseif ($rep==6): echo "caster@mgts.by"; endif;?>"></TD>
                  </TR>
                  <TR>
                    <TD STYLE="padding: 1px" WIDTH="40px">Кому:</TD>
                    <TD STYLE="padding: 1px"><INPUT TYPE="TEXT" STYLE="border: black solid 1px;" NAME="EMAIL1Name" SIZE="37" VALUE="<?if ($EMAIL1Name!=""): echo "$EMAIL1Name"; elseif ($rep==1): echo "Илюк Ирине Михайловне"; elseif ($rep==6): echo "Владу ДраКуЛе"; endif;?>"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Введите второго получателя:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD STYLE="padding: 1px;" WIDTH="40px">Куда:</TD>
                    <TD STYLE="padding: 1px;"><INPUT TYPE="TEXT" STYLE="border: black solid 1px;" NAME="EMAIL2Addr" SIZE="37" VALUE="<?if ($EMAIL2Addr!="") echo "$EMAIL2Addr";?>"></TD>
                  </TR>
                  <TR>
                    <TD STYLE="padding: 1px" WIDTH="40px">Кому:</TD>
                    <TD STYLE="padding: 1px"><INPUT TYPE="TEXT" STYLE="border: black solid 1px;" NAME="EMAIL2Name" SIZE="37" VALUE="<?if ($EMAIL2Name!="") echo "$EMAIL2Name";?>"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>Введите третьего получателя:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;" BGCOLOR="#EEEEEE">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD STYLE="padding: 1px;" WIDTH="40px">Куда:</TD>
                    <TD STYLE="padding: 1px;"><INPUT TYPE="TEXT" STYLE="border: black solid 1px;" NAME="EMAIL3Addr" SIZE="37" VALUE="<?if ($EMAIL3Addr!="") echo "$EMAIL3Addr";?>"></TD>
                  </TR>
                  <TR>
                    <TD STYLE="padding: 1px" WIDTH="40px">Кому:</TD>
                    <TD STYLE="padding: 1px"><INPUT TYPE="TEXT" STYLE="border: black solid 1px;" NAME="EMAIL3Name" SIZE="37" VALUE="<?if ($EMAIL3Name!="") echo "$EMAIL3Name";?>"></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="15" COLSPAN="2" BGCOLOR="#339999"></TD>
          </TR>
<?
       endif;
       if (((($rep!=9)&&($rep!=10))||($ip=="10.1.1.222")||($ip=="10.1.1.250"))&&($rep!=11)&&($rep!=15)): // &&($rep!=4)
?>
          <TR>
            <TD HEIGHT="15" COLSPAN="4"></TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD WIDTH="13" ROWSPAN="34" BGCOLOR="#339999"></TD>
            <TD HEIGHT="15" COLSPAN="2"></TD>
            <TD WIDTH="13" ROWSPAN="34" BGCOLOR="#339999"></TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD COLSPAN="2" ALIGN="CENTER"><B>Выберите прочие параметры для выбранного действия:</B></TD>
          </TR>
          <TR BGCOLOR="#339999">
            <TD HEIGHT="15" COLSPAN="2"></TD>
          </TR>
<?
         if (($rep!=12)&&($rep!=14)):
?>
          <TR>
            <TD COLSPAN="2" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="RECALC" ONMOUSEOVER="window.status='Поставьте флажок, чтобы удалить все ранее расчитанные данные и повторно провести их полный расчёт';" ONMOUSEOUT="window.status='';"<?if ($RECALC=="on"): echo " CHECKED"; endif;?>></TD>
                    <TD>Провести полный пересчёт данных таблицы за указанный период</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
<?
         endif;
         if ($rep==1):
?>
          <TR>
            <TD COLSPAN="2" BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="HIDECALLSTOPAY" ONMOUSEOVER="window.status='Поставьте флажок, чтобы не выводить колонку &laquo;Звонков к оплате&raquo;';" ONMOUSEOUT="window.status='';"<?if ($HIDECALLSTOPAY=="on"): echo " CHECKED"; endif;?>></TD>
                    <TD>Не выводить колонку &laquo;Звонков к оплате&raquo;</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
<?
         endif;
         if ($rep==2):
?>
          <TR>
            <TD COLSPAN="2" BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="OPENCICLE" ONMOUSEOVER="window.status='Поставьте флажок, чтобы отображать отчёт за период как группу отчётов по дням';" ONMOUSEOUT="window.status='';"<?if (($OPENCICLE=="on")||($ip=="10.1.1.247")): echo " CHECKED"; endif;?>></TD>
                    <TD>Развернуть отчёт за период</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
<?
         endif;
         if ($rep==12):
?>
          <TR>
            <TD COLSPAN="2" BGCOLOR="#FFFFFF" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="FROMSTARTOFYEAR" ONMOUSEOVER="window.status='Поставьте флажок, чтобы отобразить в отчёте данные за все месяцы по-порядку начиная с января указанного года по указанный месяц';" ONMOUSEOUT="window.status='';" CHECKED></TD>
                    <TD>За все месяцы с начала года</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
          </TR>
<?
          endif;
          if ($rep==14):
?>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA1"<?if ($UA1=="on"): echo " CHECKED"; endif;?>></TD>
                    <TD><B>Номер телефона абонента №1</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN1" SIZE="30" VALUE="<?if ($AN1!="") echo $AN1;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A1BD">
<?
          if ($A1BD=="") $A1BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A1BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A1BM">
<?
          if ($A1BM=="") $A1BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A1BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A1BY">
<?
          if ($A1BY=="") $A1BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A1BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A1ED">
<?
          if ($A1ED=="") $A1ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A1ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A1EM">
<?
          if ($A1EM=="") $A1EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A1EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A1EY">
<?
          if ($A1EY=="") $A1EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A1EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA2"<?if ($UA2=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №2</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN2" SIZE="30" VALUE="<?if ($AN2!="") echo $AN2;?>"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A2BD">
<?
          if ($A2BD=="") $A2BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A2BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A2BM">
<?
          if ($A2BM=="") $A2BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A2BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A2BY">
<?
          if ($A2BY=="") $A2BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A2BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A2ED">
<?
          if ($A2ED=="") $A2ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A2ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A2EM">
<?
          if ($A2EM=="") $A2EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A2EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A2EY">
<?
          if ($A2EY=="") $A2EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A2EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA3"<?if ($UA3=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №3</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN3" SIZE="30" VALUE="<?if ($AN3!="") echo $AN3;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A3BD">
<?
          if ($A3BD=="") $A3BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A3BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A3BM">
<?
          if ($A3BM=="") $A3BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A3BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A3BY">
<?
          if ($A3BY=="") $A3BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A3BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A3ED">
<?
          if ($A3ED=="") $A3ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A3ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A3EM">
<?
          if ($A3EM=="") $A3EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A3EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A3EY">
<?
          if ($A3EY=="") $A3EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A3EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA4"<?if ($UA4=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №4</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN4" SIZE="30" VALUE="<?if ($AN4!="") echo $AN4;?>"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A4BD">
<?
          if ($A4BD=="") $A4BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A4BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A4BM">
<?
          if ($A4BM=="") $A4BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A4BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A4BY">
<?
          if ($A4BY=="") $A4BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A4BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A4ED">
<?
          if ($A4ED=="") $A4ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A4ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A4EM">
<?
          if ($A4EM=="") $A4EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A4EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A4EY">
<?
          if ($A4EY=="") $A4EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A4EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA5"<?if ($UA5=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №5</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN5" SIZE="30" VALUE="<?if ($AN5!="") echo $AN5;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A5BD">
<?
          if ($A5BD=="") $A5BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A5BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A5BM">
<?
          if ($A5BM=="") $A5BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A5BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A5BY">
<?
          if ($A5BY=="") $A5BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A5BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A5ED">
<?
          if ($A5ED=="") $A5ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A5ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A5EM">
<?
          if ($A5EM=="") $A5EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A5EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A5EY">
<?
          if ($A5EY=="") $A5EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A5EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA6"<?if ($UA6=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №6</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN6" SIZE="30" VALUE="<?if ($AN6!="") echo $AN6;?>"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A6BD">
<?
          if ($A6BD=="") $A6BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A6BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A6BM">
<?
          if ($A6BM=="") $A6BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A6BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A6BY">
<?
          if ($A6BY=="") $A6BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A6BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A6ED">
<?
          if ($A6ED=="") $A6ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A6ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A6EM">
<?
          if ($A6EM=="") $A6EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A6EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A6EY">
<?
          if ($A6EY=="") $A6EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A6EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA7"<?if ($UA7=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №7</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN7" SIZE="30" VALUE="<?if ($AN7!="") echo $AN7;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A7BD">
<?
          if ($A7BD=="") $A7BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A7BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A7BM">
<?
          if ($A7BM=="") $A7BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A7BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A7BY">
<?
          if ($A7BY=="") $A7BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A7BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A7ED">
<?
          if ($A7ED=="") $A7ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A7ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A7EM">
<?
          if ($A7EM=="") $A7EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A7EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A7EY">
<?
          if ($A7EY=="") $A7EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A7EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA8"<?if ($UA8=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №8</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN8" SIZE="30" VALUE="<?if ($AN8!="") echo $AN8;?>"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A8BD">
<?
          if ($A8BD=="") $A8BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A8BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A8BM">
<?
          if ($A8BM=="") $A8BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A8BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A8BY">
<?
          if ($A8BY=="") $A8BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A8BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A8ED">
<?
          if ($A8ED=="") $A8ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A8ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A8EM">
<?
          if ($A8EM=="") $A8EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A8EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A8EY">
<?
          if ($A8EY=="") $A8EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A8EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA9"<?if ($UA9=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №9</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN9" SIZE="30" VALUE="<?if ($AN9!="") echo $AN9;?>"></TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A9BD">
<?
          if ($A9BD=="") $A9BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A9BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A9BM">
<?
          if ($A9BM=="") $A9BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A9BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A9BY">
<?
          if ($A9BY=="") $A9BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A9BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD STYLE="padding: 3px 5px;">
              <SELECT NAME="A9ED">
<?
          if ($A9ED=="") $A9ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A9ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A9EM">
<?
          if ($A9EM=="") $A9EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A9EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A9EY">
<?
          if ($A9EY=="") $A9EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A9EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"><INPUT TYPE="CHECKBOX" NAME="UA10"<?if ($UA10=="on") echo " CHECKED";?>></TD>
                    <TD><B>Номер телефона абонента №10</B></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;"><INPUT STYLE="border: black solid 1px;" TYPE="TEXT" NAME="AN10" SIZE="30" VALUE="<?if ($AN10!="") echo $AN10;?>"></TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>начальная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A10BD">
<?
          if ($A10BD=="") $A10BD=1;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A10BD):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A10BM">
<?
          if ($A10BM=="") $A10BM=$ldm;
          for ($i=1;$i<=count($months);$i++):
?>
                <OPTION <?if ($i==$A10BM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A10BY">
<?
          if ($A10BY=="") $A10BY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A10BY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <TABLE>
                <TBODY>
                  <TR>
                    <TD WIDTH="20px"></TD>
                    <TD>конечная дата:</TD>
                  </TR>
                </TBODY>
              </TABLE>
            </TD>
            <TD BGCOLOR="#EEEEEE" STYLE="padding: 3px 5px;">
              <SELECT NAME="A10ED">
<?
          if ($A10ED=="") $A10ED=$ldd;
          for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$A10ED):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A10EM">
<?
          if ($A10EM=="") $A10EM=$ldm;
          for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$A10EM):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $months2[$i];?></OPTION>
<?
          endfor;
?>
              </SELECT>
              <SELECT NAME="A10EY">
<?
          if ($A10EY=="") $A10EY=$ldy;
          for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$A10EY):?>SELECTED <?endif;?>VALUE="<?echo $i;?>"><?echo $i;?></OPTION>
<?
          endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
          endif;
?>
          <TR BGCOLOR="#339999">
            <TD HEIGHT="15" COLSPAN="2"></TD>
          </TR>
<?
       endif;
?>
        </TBODY>
      </TABLE>
      </CENTER>
    </FORM>
  </BODY>
</HTML>