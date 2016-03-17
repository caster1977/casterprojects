<H1>Доступ должностей</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Должность</TH>
      <TH>Группа доступа</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%d</TD><TD>%d</TD><TD>%d</TD></TR>', $row['Id'], $row['PositionId'], $row['AccessGroupId'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
