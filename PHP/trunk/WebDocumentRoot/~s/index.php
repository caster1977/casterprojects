<!-- ������� ������� -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>������� �������</TITLE>
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
$months[1]="������";
$months[2]="�������";
$months[3]="����";
$months[4]="������";
$months[5]="���";
$months[6]="����";
$months[7]="����";
$months[8]="������";
$months[9]="��������";
$months[10]="�������";
$months[11]="������";
$months[12]="�������";
$reportcount=12;
$reportnames[1]="���������� ������ ������������ (��� �����)";
$reportnames[2]="���������� ������ ������������ (������ �����)";
$reportnames[3]="���������� ������ ������������ �� ������ (���������)";
$reportnames[4]="���������� ������ ������������ �� ���� (���������)";
$reportnames[5]="���������� �� ������� ��� �� ������";
$reportnames[6]="�������� �� ����� �������� (��������� ������� - 009, 099, 9909111)";
$reportnames[7]="�������� �� ����� �������� (�������������� - 075, 088, 091-097)";
$reportnames[8]="���������� Content Provider �� ���� (�������������)";
$reportnames[9]="�������� � ���������� �����������";
$reportnames[10]="�������� �� ������";
$reportnames[11]="���������� ������ ������������ �� ������ (��� �����) ��������";
$reportnames[12]="���������� ��������� ������������ (��� �����)";
$reporthints["01"]="������ ����� ���������� �� ���������� � ����� ���������� �������� ��������� (�� ��������� ������).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["02"]="������ ����� ���������� �� ���������� � ����� ���������� �������� ��������� (�� ��������� ������).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["03"]="������ ����� ���������� � ����� ���������� �������� ��������� ������ ����� <NOBR>1-��</NOBR> ����� �� ��������� �����. ���������� ��������������� ���������� ��� (��������� �.�.).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["04"]="������ ����� ���������� � ����� ���������� �������� ��������� �� ���������� (�� ��������� ������).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������ �����: <I>30.00</I> ������� ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>�������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["05"]="������ ����� ������������ �������� ��������� ��������� � ���� ����������� ����� <B>*.htm</B> �� ����� ����������� ����� <B>irinamgts@mail.ru</B> ����������� ������ ���������� (���� �.�.), � ����� ���������� � ����� ���������� � ��������������� ���������� ��� (���������� �.�.) <NOBR>1-��</NOBR> ����� ������� ������ �� ���������.<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������ �����: <I>30.00</I> ������� ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>�������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["06"]="������ ����� ���������� �� ���������� � ����� ���������� �������� ��������� (�� ��������� ������).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["07"]="������ ����� ���������� �� ���������� � ����� ���������� �������� ��������� (�� ��������� ������).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["08"]="������ ����� ���������� ��������� �������� ��������� �� ������� ���� � 21:00.<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������ �����: <I>30.00</I> ������� ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>�������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["09"]="������ ����� ���������� ��������� �������� ��������� �� ��������� ���� � 08:15.<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������ �����: <I>30.00</I> ������� ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>�������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["10"]="������ ����� ���������� �� ���������� � ����� ���������� �������� ��������� �� ��������� ������. ���������� ��������������� ���������� ��� (��������� �.�.).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["11"]="������ ����� ���������� ������ ����������� �������� ��������� �� ��������� ������. ���������� ��������������� ���������� ��� (��������� �.�.).<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������� �����, ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>���������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$reporthints["12"]="������ ����� ������������ ��� ����������� ������� (�������� �.�.)<HR><B>��� ������ ������ ��������� ��������� ��������� ��������:</B><BR>������ �����: <I>30.00</I> ������� ������, ������, �����: <I>5.00</I><BR>���������� ��������: <I>�������</I><BR>������ ����������: <I>&b&b�������� &p �� &P</I>";
$f["01"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&vSifra='+vSifra.value);\">������� �����</BUTTON>";
$f["02"]=$f["01"];
$f["03"]=$f["01"];
$f["04"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday');\">������� �����</BUTTON>";
$f["05"]=$f["04"];
$f["06"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&v009='+v009.checked+'&v099='+v099.checked+'&v9909111='+v9909111.checked);\">������� �����</BUTTON>";
$f["07"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&v075='+v075.checked+'&v088='+v088.checked+'&v091='+v091.checked+'&v092='+v092.checked+'&v093='+v093.checked+'&v094='+v094.checked+'&v095='+v095.checked+'&v096='+v096.checked+'&v097='+v097.checked);\">������� �����</BUTTON>";
$f["08"]=$f["04"];
$f["09"]="<HR><BUTTON type=\"Button\" onclick=\"javascript:location=('report$rep.php?syear=$syear&smonth=$smonth&sday=$sday&fyear=$fyear&fmonth=$fmonth&fday=$fday&vCollapsed='+vCollapsed.checked);\">������� �����</BUTTON>";
$f["10"]=$f["09"];
$f["11"]=$f["04"];
$f["12"]=$f["04"];
?>
    <TABLE WIDTH=100%>
      <TBODY>
        <TR>
          <TH class="la">�������� �����:</TH>
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
          <TH class="la" COLSPAN=2><HR>�������� ��������� ����:<HR></TH>
        </TR>
        <TR>
          <TH class="la">�����:</TH>
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
          <TH class="la">�����:</TH>
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
          <TH class="la">���:</TH>
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
          <TH class="la" COLSPAN=2><HR>�������� �������� ����:<HR>
          </TH>
        </TR>
        <TR>
          <TH class="la">�����:</TH>
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
          <TH class="la">�����:</TH>
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
          <TH class="la">���:</TH>
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
          <TH COLSPAN=2><HR><BUTTON type="Button" onclick="javascript:location=('badday.php?vdate=<?print "$sday/$smonth/$syear";?>');">������� �����</BUTTON></TH>
        </TR>
<?
else:
  if (checkdate($fmonth,$fday,$fyear)<>1):
?>
        <TR>
          <TH COLSPAN=2><HR><BUTTON type="Button" onclick="javascript:location=('badday.php?vdate=<?print "$fday/$fmonth/$fyear";?>');">������� �����</BUTTON></TH>
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
          <TH CLASS="la" COLSPAN=2>�������� ������ �����:</TH>
        </TR>
        <TR>
          <TD CLASS="la" COLSPAN=2><INPUT TYPE="text" NAME="vSifra" VALUE="%" SIZE="3" MAXLENGTH="3">&nbsp;&nbsp;(<B>%</B> - ��� ����)</TD>
        </TR>
        <TR>
          <TH COLSPAN=2><HR></TH>
        </TR>
<?
endif;
if ($rep=="06"):
?>
        <TR>
          <TH CLASS="la" COLSPAN=2>�������� ������ ��� �������� ������:</TH>
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
          <TH CLASS="la" COLSPAN=2>�������� ������ ��� �������� ������:</TH>
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
          <TD CLASS="la" COLSPAN=2><INPUT TYPE="checkbox" NAME="vCollapsed">&laquo;��������&raquo; �����</TD>
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