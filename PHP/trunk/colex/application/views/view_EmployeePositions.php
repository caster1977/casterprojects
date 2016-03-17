<H1>Должности работников</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Работник</TH>
      <TH>Должность</TH>
      <TH>Дата вступления в должность</TH>
      <TH>Дата выхода из должности</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%d</TD><TD>%d</TD><TD>%s</TD><TD>%s</TD><TD>%d</TD></TR>',
	  $row['Id'], $row['EmployeeId'], $row['PositionId'], $row['StartDate'], $row['StopDate'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
