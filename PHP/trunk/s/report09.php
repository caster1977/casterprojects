<!-- ����� "�������� � ���������� ����������� �� ����" -->
<?
// *** ����������� � ������� MySQL ***
$hostname="10.1.1.2";
$username="sel";
$password="";
$dbName="MyStat";
$MYSQLCON = MYSQL_CONNECT($hostname,$username,$password) OR DIE("Can't create connection");
MYSQL_SELECT_DB("$dbName") OR DIE("Can't select DataBase"); 
// *** ������������ ������ ������ ***
$title="";
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
    <TITLE>�������� � ���������� ����������� �� ���� �������� �� <?print $title;?></TITLE>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
  </HEAD>
  <BODY>
<?
// *** ������������ SQL-������� �� ������ ������� (��� �����) ***
$table=MYSQL_QUERY("SELECT date, ddi, countT, durat, (durat/countT) as mt, (countCT-countT) as failed, countCT FROM day WHERE ((ddi='075')or(ddi='088')or(ddi='091')or(ddi='092')or(ddi='093')or(ddi='094')or(ddi='095')or(ddi='096')or(ddi='097') or (ddi='99075')or(ddi='99088')or(ddi='99091')or(ddi='99092')or(ddi='99093')or(ddi='99094')or(ddi='99095')or(ddi='99096')or(ddi='99097')) and ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) ORDER BY date;");
$num_rows = MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
$i=0; // ���������� ��� �������� ������� ������� ������ � �������
if ($num_rows==0):
?>
    <H1>�� �������� ������ ������� ������� �� �������!<H1>
<?
else:
?>
    <TABLE CLASS="border" WIDTH=100%>
      <CAPTION>�������� �� ���� �������� ������ Dicta �� <?print $title;?></CAPTION>
      <TBODY>
        <TR>
          <TH>����</TH>
          <TH>������� ������</TH>
          <TH>������� �������</TH>
          <TH>������������ �������</TH>
          <TH>������� ����� ������</TH>
          <TH>��������� �������</TH>
          <TH>����� �������</TH>
        </TR>
<?
  while ($i < $num_rows):
    $field1=mysql_result($table, $i, "date"); // '����'
    $field2=mysql_result($table, $i, "ddi"); // '������� ������'
    $field3=mysql_result($table, $i, "countT"); // '������� �������'
    $field4=mysql_result($table, $i, "durat"); // '������������ �������'
    $field5=mysql_result($table, $i, "mt"); // '������� �����'
    $field6=mysql_result($table, $i, "failed"); // '��������� �������'
    $field7=mysql_result($table, $i, "countCT"); // '��������� ������� �����'
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
    $i++;
  endwhile;
  $table=MYSQL_QUERY("SELECT '' as z, date, ddi, sum(countT) as countT, sum(durat) as durat, (sum(durat)/sum(countT)) as mt, (sum(countCT)-sum(countT)) as failed, sum(countCT) as countCT FROM day WHERE ((ddi='075')or(ddi='088')or(ddi='091')or(ddi='092')or(ddi='093')or(ddi='094')or(ddi='095')or(ddi='096')or(ddi='097') or (ddi='99075')or(ddi='99088')or(ddi='99091')or(ddi='99092')or(ddi='99093')or(ddi='99094')or(ddi='99095')or(ddi='99096')or(ddi='99097')) and ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
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
  $table=MYSQL_QUERY("SELECT date, ddi, countCT, Aon, ((Aon/countCT)*100) as percent FROM day WHERE ((ddi='075')or(ddi='088')or(ddi='091')or(ddi='092')or(ddi='093')or(ddi='094')or(ddi='095')or(ddi='096')or(ddi='097') or (ddi='99075')or(ddi='99088')or(ddi='99091')or(ddi='99092')or(ddi='99093')or(ddi='99094')or(ddi='99095')or(ddi='99096')or(ddi='99097')) and ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) ORDER BY date;");
  $num_rows = MYSQL_NUM_ROWS($table);
  $i=0;
endif;
if ($num_rows==0):
?>
    <H1>�� �������� ������ ������� ������� �� �������!<H1>
<?
else:
?>
    <TABLE CLASS="border" WIDTH=100%>
      <CAPTION>���������� ����������� ������� �� ���� �������� �� <?print $title;?></CAPTION>
      <TBODY>
        <TR>
          <TH>����</TH>
          <TH>������� ������</A></TH>
          <TH>����� �������</A></TH>
          <TH>���������� �������</A></TH>
          <TH>������� �����������</A></TH>
        </TR>
<?
  while ($i < $num_rows):
    $field1=mysql_result($table, $i, "date"); // '����'
    $field2=mysql_result($table, $i, "ddi"); // '������� ������'
    $field3=mysql_result($table, $i, "countCT"); // '����� �������'
    $field4=mysql_result($table, $i, "Aon"); // '���������� �������'
    $field5=mysql_result($table, $i, "percent"); // '������� �����������'
?>
        <TR>
          <TD><NOBR><?print $field1;?></NOBR></TD>
          <TD><?print $field2;?></TD>
          <TD class="ra"><?print $field3;?></TD>
          <TD class="ra"><?print $field4;?></TD>
<?
    if ($field5<90):
?>
          <TD BGCOLOR="orange"><?print $field5;?>%</TD>

<?
    else:
?>
          <TD><?print $field5;?>%</TD>
<?
    endif;
?>
        </TR>
<?
    $i++;
  endwhile;
  $table=MYSQL_QUERY("SELECT '' as z, date, ddi, sum(countCT) as countCT, sum(Aon) as Aon, (sum(Aon)/sum(countCT)*100) as percent FROM day WHERE ((ddi='075')or(ddi='088')or(ddi='091')or(ddi='092')or(ddi='093')or(ddi='094')or(ddi='095')or(ddi='096')or(ddi='097') or (ddi='99075')or(ddi='99088')or(ddi='99091')or(ddi='99092')or(ddi='99093')or(ddi='99094')or(ddi='99095')or(ddi='99096')or(ddi='99097')) and ((date >= '$syear-$smonth-$sday') and (date <= '$fyear-$fmonth-$fday')) GROUP BY z;");
  $field1=mysql_result($table, 0, "countCT"); // '����� �������'
  $field2=mysql_result($table, 0, "Aon"); // '���������� �������'
  $field3=mysql_result($table, 0, "percent"); // '������� �����������'
?>
        <TR>
          <TH>�����</TH>
          <TH></TH>
          <TH CLASS="ra"><?print $field1;?></TH>
          <TH CLASS="ra"><?print $field2;?></TH>
          <TH><?print $field3;?>%</TH>
        </TR>
      </TBODY>
    </TABLE>
<?
endif;
?>
  </BODY>
</HTML>