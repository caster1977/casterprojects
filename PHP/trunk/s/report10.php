<!-- ����� "�������� �� ������" -->
<?
// *** ����������� � ������� MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** ���� ����� ���������� �� ����� - ������ �� ��������� ***
IF ($sort=="") $sort="date";
// *** ������������ ������ ������ ***
$title="�������� (��� ������) �� ";
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
<?
// *** ������������ SQL-������� �� ������ ������� (��� �����) ***
$table=MYSQL_QUERY("SELECT date, ddi, countT, durat, (durat/countT) as mt, (countCT-countT) as failed, countCT FROM day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) ORDER BY $sort;");
$num_rows = MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
$i=0; // ���������� ��� �������� ������� ������� ������ � �������
if ($num_rows==0):
?>
    <H1>�� �������� ������ ������� ������� �� �������!<H1>
<?
else:
  while ($i < $num_rows):
    $j=0; // ���������� ����� �� ������� ��������
?>
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report10.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">����</A></TH>
          <TH><A HREF="report10.php?sort=ddi&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>������</A></TH>
          <TH><A HREF="report10.php?sort=countT&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>�������</A></TH>
          <TH><A HREF="report10.php?sort=durat&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">������������<BR>�������</A></TH>
          <TH><A HREF="report10.php?sort=mt&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>�����<BR>������</A></TH>
          <TH><A HREF="report10.php?sort=failed&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">���������<BR>�������</A></TH>
          <TH><A HREF="report10.php?sort=countCT&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�����<BR>�������</A></TH>
        </TR>
<?  
    while (($i < $num_rows) & ($j<=32)):
      $field1=mysql_result($table, $i, "date"); // '����'
      $field2=mysql_result($table, $i, "ddi"); // '������� ������'
      $field3=mysql_result($table, $i, "countT"); // '������� �������'
      $field4=mysql_result($table, $i, "durat"); // '������������ �������'
      $field5=mysql_result($table, $i, "mt"); // '������� �����'
      $field6=mysql_result($table, $i, "failed"); // '��������� �������'
      $field7=mysql_result($table, $i, "countCT"); // '��������� ������� �����'
      if ($field2=="1111") $field2="099";
      if ($field2=="2222") $field2="9909111";
      $i++;
      $j++;
?>
        <TR>
          <TD><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD class="ra"><?print $field3;?></TD>
          <TD class="ra"><?print $field4;?></TD>
          <TD class="ra"><?print $field5;?></TD>
<?
      if ($field6>200):
?>
          <TD class="ra" BGCOLOR="orange"><?print $field6;?></TD>
<?
      else:
?>
          <TD class="ra"><?print $field6;?></TD>
<?
      endif;
?>
          <TD class="ra"><?print $field7;?></TD>
        </TR>
<?
    endwhile;
    if ($i < $num_rows):
?>
      </TBODY>
    </TABLE>
    <BR>
    <BR>
<?
    endif;
  endwhile;
  $table=MYSQL_QUERY("SELECT '' as z, date, ddi, sum(countT) as countT, sum(durat) as durat, (sum(durat)/sum(countT)) as mt, (sum(countCT)-sum(countT)) as failed, sum(countCT) as countCT FROM day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
  $field1=mysql_result($table, 0, "countT"); // '������� �������'
  $field2=mysql_result($table, 0, "durat"); // '������������ �������'
  $field3=mysql_result($table, 0, "mt"); // '������� �����'
  $field4=mysql_result($table, 0, "failed"); // '��������� �������'
  $field5=mysql_result($table, 0, "countCT"); // '��������� ������� �����'
?>
        <TR>
          <TH>�����</TH>
          <TH></TH>
          <TH CLASS="ra"><?print $field1;?></TH>
          <TH CLASS="ra"><?print $field2;?></TH>
          <TH CLASS="ra"><?print $field3;?></TH>
          <TH CLASS="ra"><?print $field4;?></TH>
          <TH CLASS="ra"><?print $field5;?></TH>
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