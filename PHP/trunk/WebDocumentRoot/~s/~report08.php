<!-- ����� "���������� Content Provider �� ���� (�������� � �������� ��������)" -->
<?
// *** ����������� � ������� MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** ���� ����� ���������� �� ����� - ������ �� ��������� ***
if ($sort=="") $sort="ani";
// *** ������������ ������ ������ ***
$title="���������� Content Provider �� ";
if (($sday==$fday)&&($smonth==$fmonth)&&($syear==$fyear)):
  $title .=$sday;
  $title .=" ";
  switch ($smonth):
    case "01": $title .="������ "; break;
    case "02": $title .="������� "; break;
    case "03": $title .="����� "; break;
    case "04": $title .="������ "; break;
    case "05": $title .="��� "; break;
    case "06": $title .="���� "; break;
    case "07": $title .="���� "; break;
    case "08": $title .="������� "; break;
    case "09": $title .="�������� "; break;
    case "10": $title .="������� "; break;
    case "11": $title .="������ "; break;
    case "12": $title .="������� "; break;
  endswitch;
  $title .="$syear ����";
else:
  $title .="������ � $sday/$smonth/$syear �� $fday/$fmonth/$fyear";
endif;
?>
<!-- ��� ������ ��������� ��������� ��������� ��������: �����: 30.00; ������, ������, �����: 5.00; ���������� �������; ������ ����������: &b&b�������� &p �� &P -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?print $title;?></TITLE>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
  </HEAD>
  <BODY>
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report08.php?&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�����<BR>��������</A></TH>
          <TH>���<BR>������</TH>
          <TH>����<BR>������</TH>
          <TH>�����<BR>������</TH>
          <TH><A HREF="report08.php?sort=dur&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">������������<BR>������</A></TH>
        </TR>
<?
$iyear=$syear; // ��������� ���������� ��� �������� ���
$iday=$sday; $iday++; $iday--; // ��������� ���������� ��� �������� ���
$imonth=$smonth; $imonth++; $imonth--; // ��������� ���������� ��� �������� ���
$i2day=$fday; $i2day++; $i2day--;
$i2month=$fmonth; $i2month++; $i2month--;
do {
  $ird="ird_$iyear";
  if ($imonth<10) $ird .="0";
  $ird .="$imonth";
  if ($iday<10) $ird .="0";
  $ird .="$iday";
  //  $table=MYSQL_QUERY("SELECT ani, datum, vrijeme, SEC_TO_TIME(dur) as dur FROM statistika.$ird WHERE (dur>1) AND ((ddi='098') OR (ddi='001798')) ORDER BY $sort;");
  $table=MYSQL_QUERY("SELECT s.ani, c.ddi,s.datum, s.vrijeme, SEC_TO_TIME(s.dur) as dur FROM statistika.$ird s ,test.contentp c WHERE (s.dur>1) AND ((s.ddi='098') OR (s.ddi='001798')) AND c.abroj=s.ani ORDER BY $sort;"); //Edit by Skavin
  $num_rows = MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
  $i=0; // ���������� ��� �������� ������� ������� ������ � �������
  if ($num_rows>0):
    while ($i < $num_rows):
      $field1=mysql_result($table, $i, "s.ani"); // '����� ��������'
      $field2=mysql_result($table, $i, "s.datum"); // '���� ������'
      $field3=mysql_result($table, $i, "s.vrijeme"); // '����� ������'
      $field4=mysql_result($table, $i, "dur"); // '������������ ������'
      $field5=mysql_result($table, $i, "c.ddi"); // '����� ������' //Add by Skavin
      // print "<TR><TD><NOBR>$field1</NOBR></TD><TD>098</TD><TD><NOBR>$field2</NOBR></TD><TD><NOBR>$field3</NOBR></TD><TD>$field4</TD></TR>\n";
      print "        <TR>
          <TD><NOBR>$field1</NOBR></TD>
          <TD>$field5</TD>
          <TD><NOBR>$field2</NOBR></TD>
          <TD><NOBR>$field3</NOBR></TD>
          <TD>$field4</TD>
        </TR>\n"; // Edit by Skavin
      $i++;
    endwhile;
  endif;
  do {
    $iday++;
    if ($iday==32):
      $iday=1;
      $imonth++;
    endif;
    if ($imonth==13):
      $imonth=1; 
      $iyear++;
    endif;
  } while (checkdate($imonth,$iday,$iyear)<>1);
  if (($iday<=$i2day)||(($imonth!=$i2month)||($iyear!=$fyear))) print "<TR><TD COLSPAN=5></TD></TR>";
  if (mktime($imonth,$iday,$iyear)>mktime($i2month,$i2day,$fyear)) break;
} while (($iday<=$i2day)||(($imonth!=$i2month)||($iyear!=$fyear)));
?>
        <TR>
          <TH COLSPAN=5 CLASS="la">�����������:</TH>
        </TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>