<!-- ����� "���������� ��������� ������������ (��� �����)"-->
<?
// *** ����������� � ������� MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase");
// *** ���� ����� ���������� �� ����� - ������ �� ��������� ***
if ($sort=="") $sort="sifra";
// *** ������������ ������ ������ ***
$title="���������� ��������� ������������ �� ";
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
<!-- ��� ������ ��������� ��������� ��������� ��������: �����, ������, ������, ����� 5.00; ���������� ���������; ������ ����������: &b&b�������� &p �� &P-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?print $title;?></TITLE>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
    <SCRIPT LANGUAGE="JavaScript">
      function calculate(comp1,comp2,comp3)
      {
        comp1.value = Math.round(((comp3.value/comp2.value)/82)*100);
      }
    </SCRIPT>
  </HEAD>
  <BODY>
<?
// *** ������������ SQL-������� �� ������ ������� (��� �����) ***
$table=MYSQL_QUERY("SELECT name,sifra,sum(in_serv) as in_serv FROM t_day WHERE (((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday'))) GROUP BY sifra ORDER BY $sort;");
$num_rows = MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
$i=0; // ���������� ��� �������� ������� ������� ������ � �������
if ($num_rows==0):
?>
    <H1>�� �������� ������ ������� ������� �� �������!<H1>
<?
else:
  while ($i < $num_rows):
?>
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report03.php?sort=name&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>"><NOBR>�.�.�.</NOBR></A></TH>
          <TH><A HREF="report03.php?sort=sifra&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">������ �����</A></TH>
          <TH>����� ������</TH>
          <TH><A HREF="report03.php?sort=in_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">���������</A></TH>
          <TH>% ���������</TH>
        </TR>
<?
    while ($i < $num_rows):
      $field1=mysql_result($table, $i, "name"); // '���'
      $field2=mysql_result($table, $i, "sifra"); // '������ �����'
      $field3=mysql_result($table, $i, "in_serv"); // '���������'
      $i++;
?>
        <TR VALIGN="MIDDLE">
          <TD CLASS="la"><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD><INPUT TYPE="text" NAME="wt<?print $i;?>" onchange="calculate(wp<?print $i;?>,wt<?print $i;?>,ob<?print $i;?>);"></TD>
          <TD><?print $field3;?><INPUT TYPE="hidden" NAME="ob<?print $i;?>" VALUE="<?print $field3;?>"></TD>
          <TD><INPUT TYPE="text" NAME="wp<?print $i;?>" READONLY></TD>
        </TR>
<?
    endwhile;
  endwhile;
  // *** ������������ SQL-������� �� ������ ������� (����) ***
  $table=MYSQL_QUERY("SELECT '' as z,name,sifra,sum(in_serv) as in_serv FROM t_day WHERE (((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday'))) GROUP BY z;");
  $field1=mysql_result($table, 0, "in_serv"); // '���������'
?>
        <TR>
          <TH>�����</TH>
          <TH></TH>
          <TH></TH>
          <TH><?print $field1;?></TH>
          <TH></TH>
        </TR>
      </TBODY>
    </TABLE>
    <BR>
    <BR>
<?
endif;
?>
  </BODY>
</HTML>