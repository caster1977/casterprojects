<!-- ����� "���������� �� ������� ���" (��� ���� �.�.) -->
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
$title="���������� �� ������� ��� �� ";
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
    <STYLE>
      * {font-family: Verdana, Arial, Helvetica, sans-serif;}
      BODY {font-size: 8pt; background-color: white; margin: 10px; color: #000000;}
      P {font-size: 8pt; text-indent: 20px; margin-top: 2px; margin-bottom: 2px; text-align: justify; font-weight: normal; color: #000000; background: transparent;}
      A {font-size: inherit; text-align: left; font-weight: bold; background: transparent; text-decoration:none;}
      A:link {color: #000000; font-weight: bold;}
      A:hover {color: #000000; text-decoration:underline; font-weight: bold;}
      A:active {color: #000000; font-weight: bold;}
      A:visited {color: #000000; font-weight: bold;}
      H1 {font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;}
      CAPTION {font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;}
      TABLE {caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent;}
      TBODY {vertical-align: top;}
      TD {font-weight: normal; padding: 0px 5px;}
      TH {font-weight: bold; padding: 0px 5px;}
      TH.la {font-weight: bold; padding: 0px 5px; text-align: left;}
      TH.ra {font-weight: bold; padding: 0px 5px; text-align: right;}
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
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
  </HEAD>
  <BODY>
<?
// *** >>> �������� ����� ��� ������
// *** ������������ SQL-������� �� ������ ������� (����) ***
$table=MYSQL_QUERY("SELECT '' as z, date, ceiling(sum(du_call)/count(du_call)) as svob, ceiling(sum(du_wa)/count(du_wa)) as svozh, sum(input) as input, sum(no_serv) as no_serv, sum(in_serv) as in_serv FROM t_day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
$summa1=mysql_result($table, 0, "input"); // '��������� �����'
// *** ������������ SQL-������� �� ������ ������� (��� �����) ***
$table=MYSQL_QUERY("SELECT '' as z, ddi, sum(countCT) as quantity, sum(durat) as duration, (sum(durat))/(sum(countCT)) as sv FROM day WHERE (((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) and ((ddi='1111')or(ddi='2222')or(ddi='9909911')or(ddi='9900911'))) GROUP BY z;");
$summa2=mysql_result($table, 0, "quantity"); // '���������� �������'
// *** <<< �������� ����� ��� ������
// *** ������������ SQL-������� �� ������ ������� (��� �����) ***
$table=MYSQL_QUERY("SELECT ddi, sum(countCT) as quantity, sum(durat) as duration, (sum(durat))/(sum(countCT)) as sv FROM day WHERE ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) and ddi<>'098' GROUP BY ddi ORDER BY $sort;");
$num_rows = MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
$i=0; // ���������� ��� �������� ������� ������� ������ � �������
if ($num_rows==0):
?>
    <H1>�� �������� ������ ������� ������� �� �������!<H1>
<?
else:
?>
    <H1><?print $title;?></H1>
    <TABLE CLASS="border" WIDTH=100%>
      <TBODY>
        <TR>
          <TH><A HREF="report05.php?sort=ddi&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>������</A></TH>
          <TH>������������ ������</A></TH>
          <TH><A HREF="report05.php?sort=quantity&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">���������<BR>�������</A></TH>
          <TH><A HREF="report05.php?sort=duration&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">������������<BR>�������<BR>(� ���.)</A></TH>
          <TH><A HREF="report05.php?sort=sv&syear=<?print $syear;?>&smonth=<?print $smonth;?>&sday=<?print $sday;?>&fyear=<?print $fyear;?>&fmonth=<?print $fmonth;?>&fday=<?print $fday;?>">�������<BR>�����<BR>������<BR>(� ���.)</A></TH>
        </TR>
<?
  while ($i < $num_rows):
    $field1=mysql_result($table, $i, "ddi"); // '������� ������'
    $field2=mysql_result($table, $i, "quantity"); // '���������� �������'
    $field3=mysql_result($table, $i, "duration"); // '������������ �������'
    $field4=mysql_result($table, $i, "sv"); // '������� ����� ������'
    // *** >>> �������� ����� ��� ������
    if ($field1=="009") $field2=$summa1-$summa2;
    // *** <<< �������� ����� ��� ������
    if ($field1=="1111") $field1="099";
    if ($field1=="2222") $field1="9909111";
    if ($field1=="001798") $field1="098";
?>
        <TR>
          <TD><NOBR><?print $field1;?></NOBR></TD>
          <TD class="la">
<?
    switch ($field1):
      case "088": 
?>
            <NOBR>����</NOBR>
<?
      break;
      case "009":
?>
            <NOBR>������� �������</NOBR>
<?
      break;
      case "090":
?>
            <NOBR>������������������</NOBR>

<?
      break;
      case "078":
?>
            <NOBR>��������������� �����</NOBR>

<?
      break;
      case "091":
?>
            <NOBR>���������</NOBR>
<?
      break;
      case "092":
?>
            <NOBR>������ �����</NOBR>
<?
      break;
      case "093":
?>
            <NOBR>����� � �����������</NOBR>
<?
      break;
      case "094":
?>
            <NOBR>��������</NOBR>
<?
      break;
      case "095":
?>
            <NOBR>������</NOBR>
<?
      break;
      case "096":
?>
            <NOBR>������</NOBR>
<?
      break;
      case "097":
?>
            <NOBR>�������</NOBR>
<?
      break;
      case "098":
?>
            <NOBR>Content provider</NOBR>
<?
      break;
      case "099":
?>
            <NOBR>���������� �������</NOBR>
<?
      break;
      case "9909111":
?>
            <NOBR>��������, ���������� �������</NOBR>
<?
      break;
      case "9909911":
?>
            <NOBR>��������, ���������� �������</NOBR>
<?
      break;
      case "075":
?>
            <NOBR>������ �������-������������� ���������</NOBR>
<?
      break;
      case "9900911":
?>
            <NOBR>��������, ������� �������</NOBR>
<?
      break;
      case "99088":
?>
            <NOBR>��������, �����</NOBR>
<?
      break;
      case "99091":
?>
            <NOBR>��������, ���������</NOBR>
<?
      break;
      case "99092":
?>
            <NOBR>��������, ������ �����</NOBR>
<?
      break;
      case "99093":
?>
            <NOBR>��������, ����� � �����������</NOBR>
<?
      break;
      case "99094":
?>
            <NOBR>��������, ��������</NOBR>
<?
      break;
      case "99095":
?>
            <NOBR>��������, ������</NOBR>
<?
      break;
      case "99096":
?>
            <NOBR>��������, ������</NOBR>
<?
      break;
      case "99097":
?>
            <NOBR>��������, �������</NOBR>
<?
      break;
      case "99075":
?>
            <NOBR>��������, ������</NOBR>
<?
      break;
      case "097":
?>
            <NOBR>�������</NOBR>
<?
      break;
    endswitch;
?>
          </TD>
          <TD class="ra"><?print $field2;?></TD>
          <TD class="ra"><?print $field3;?></TD>
          <TD class="ra"><?print $field4;?></TD>
        </TR>
<?
    $i++;
  endwhile;
?>
      </TBODY>
    </TABLE>
<?
endif;
?>
  </BODY>
</HTML>