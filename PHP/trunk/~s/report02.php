<!-- ����� "���������� ������ ������������ (������ �����)" -->
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
$title="���������� ������ ������������ (������ �����) �� ";
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
<!-- ��� ������ ��������� ��������� ��������� ��������: �����, ������, ������, �����: 5.00; ���������� ���������; ������ ����������: &b&b�������� &p �� &P -->
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
$table=MYSQL_QUERY("SELECT name, sifra, rm, date, vripoc, vrizav, work, paused, ceiling(du_call) AS svob, ceiling(du_wa) AS svozh, input, no_serv, in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) and (sifra LIKE '$vSifra') and (((vripoc>='21:45:00') and (vrizav<='23:59:59')) or ((vripoc>='00:00:00') and (vrizav<='07:15:00')) or (vripoc>vrizav)) ORDER BY $sort;");
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
          <TH><A HREF="report02.php?sort=name&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>"><NOBR>�.�.�.</NOBR></A></TH>
          <TH><A HREF="report02.php?sort=sifra&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">������<BR>�����</A></TH>
          <TH><A HREF="report02.php?sort=rm&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�������<BR>�����</A></TH>
          <TH><A HREF="report02.php?sort=date&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">����</A></TH>
          <TH><A HREF="report02.php?sort=vripoc&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�����<BR>������</A></TH>
          <TH><A HREF="report02.php?sort=vrizav&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�����<BR>����-<BR>�����</A></TH>
          <TH><A HREF="report02.php?sort=work&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�����<BR>������</A></TH>
          <TH><A HREF="report02.php?sort=paused&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">����-<BR>����</A></TH>
          <TH><A HREF="report02.php?sort=svob&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�������<BR>�����<BR>�����-<BR>�������</A></TH>
          <TH><A HREF="report02.php?sort=svozh&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�������<BR>�����<BR>���-<BR>�����</A></TH>
          <TH><A HREF="report02.php?sort=input&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�����-<BR>����<BR>�����</A></TH>
          <TH><A HREF="report02.php?sort=no_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">��<BR>�����-<BR>����</A></TH>
          <TH><A HREF="report02.php?sort=in_serv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>&vSifra=<?print $vSifra;?>">�����-<BR>����</A></TH>
        </TR>
<?
    while (($i < $num_rows) & ($j<=32)):
      $field1=mysql_result($table, $i, "name"); // '���'
      $field2=mysql_result($table, $i, "sifra"); // '������ �����'
      $field3=mysql_result($table, $i, "rm"); // '������� �����'
      $field4=mysql_result($table, $i, "date"); // '����'
      $field5=mysql_result($table, $i, "vripoc"); // '����� ������'
      $field6=mysql_result($table, $i, "vrizav"); // '����� ���������'
      $field7=mysql_result($table, $i, "work"); // '����� ������'
      $field8=mysql_result($table, $i, "paused"); // '��������'
      $field9=mysql_result($table, $i, "svob"); // '������� ����� ������������'
      $field10=mysql_result($table, $i, "svozh"); // '������� ����� ��������'
      $field11=mysql_result($table, $i, "input"); // '��������� �����'
      $field12=mysql_result($table, $i, "no_serv"); // '�� ���������'
      $field13=mysql_result($table, $i, "in_serv"); // '���������'
      $i++;
      $j++;
?>
        <TR>
          <TD CLASS="la"><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD><?print $field3;?></TD>
          <TD><NOBR><?print $field4;?></NOBR></TD>
          <TD><?print $field5;?></TD>
          <TD><?print $field6;?></TD>
          <TD><?print $field7;?></TD>
          <TD><?print $field8;?></TD>
          <TD><?print $field9;?></TD>
          <TD><?print $field10;?></TD>
          <TD><?print $field11;?></TD>
          <TD><?print $field12;?></TD>
          <TD><?print $field13;?></TD>
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
  $table=MYSQL_QUERY("SELECT '' as z, name, sifra, rm, date, vripoc, vrizav, SEC_TO_TIME(sum(TIME_TO_SEC(work))) as work, SEC_TO_TIME(sum(TIME_TO_SEC(paused))) as paused, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) and (sifra LIKE '$vSifra') and (((vripoc>='21:45:00') and (vrizav<='23:59:59')) or ((vripoc>='00:00:00') and (vrizav<='07:15:00')) or (vripoc>vrizav)) GROUP BY z;");
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
          <TH></TH>
          <TH></TH>
          <TH></TH>
          <TH></TH>
          <TH></TH>
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