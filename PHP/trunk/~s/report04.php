<!-- ����� "���������� ������ ������������ �� ���� (���������)" -->
<?
// *** ����������� � ������� MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** ���� ����� ���������� �� ����� - ������ �� ��������� ***
if ($sort=="") $sort="date";
// *** ������������ ������ ������ ***
$title="���������� ������ ������������ �� ���� (���������)<BR>�� ";
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
$table=MYSQL_QUERY("SELECT date, SEC_TO_TIME(sum(TIME_TO_SEC(work))) as work, SEC_TO_TIME(sum(TIME_TO_SEC(paused))) as paused, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY date ORDER BY $sort;");
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
          <TH><A HREF="report04.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">����</A></TH>
          <TH><A HREF="report04.php?sort=work&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�����<BR>������</A></TH>
          <TH><A HREF="report04.php?sort=paused&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">����-<BR>����</A></TH>
          <TH><A HREF="report04.php?sort=svob&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>�����<BR>�����-<BR>�������</A></TH>
          <TH><A HREF="report04.php?sort=svozh&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>�����<BR>���-<BR>�����</A></TH>
          <TH><A HREF="report04.php?sort=input&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�����-<BR>����<BR>�����</A></TH>
          <TH><A HREF="report04.php?sort=no_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">��<BR>�����-<BR>����</A></TH>
          <TH><A HREF="report04.php?sort=in_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�����-<BR>����</A></TH>
        </TR>
<?
    while (($i < $num_rows) & ($j<=49)):
      $field1=mysql_result($table, $i, "date"); // '����'
      $field2=mysql_result($table, $i, "work"); // '����� ������'
      $field3=mysql_result($table, $i, "paused"); // '��������'
      $field4=mysql_result($table, $i, "svob"); // '������� ����� ������������'
      $field5=mysql_result($table, $i, "svozh"); // '������� ����� ��������'
      $field6=mysql_result($table, $i, "input"); // '��������� �����'
      $field7=mysql_result($table, $i, "no_serv"); // '�� ���������'
      $field8=mysql_result($table, $i, "in_serv"); // '���������'
      $i++;
      $j++;
?>
        <TR>
          <TD><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD><?print $field3;?></TD>
          <TD><?print $field4;?></TD>
          <TD><?print $field5;?></TD>
          <TD><?print $field6;?></TD>
          <TD><?print $field7;?></TD>
          <TD><?print $field8;?></TD>
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
  // *** ������������ SQL-������� �� ������ ������� (����) ***
  $table=MYSQL_QUERY("SELECT '' as z, date, SEC_TO_TIME(sum(TIME_TO_SEC(work))) as work, SEC_TO_TIME(sum(TIME_TO_SEC(paused))) as paused, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
  $field1=mysql_result($table, 0, "work"); // '����� ������'
  $field2=mysql_result($table, 0, "paused"); // '��������'
  $field3=mysql_result($table, 0, "svob"); // '������� ����� ������������'
  $field4=mysql_result($table, 0, "svozh"); // '������� ����� ��������'
  $field5=mysql_result($table, 0, "input"); // '��������� �����'
  $field6=mysql_result($table, 0, "no_serv"); // '�� ���������'
  $field7=mysql_result($table, 0, "in_serv"); // '���������'
?>
        <TR>
          <TH>�����</TH>
          <TH><?print $field1;?></TH>
          <TH><?print $field2;?></TH>
          <TH><?print $field3;?></TH>
          <TH><?print $field4;?></TH>
          <TH><?print $field5;?></TH>
          <TH><?print $field6;?></TH>
          <TH><?print $field7;?></TH>
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