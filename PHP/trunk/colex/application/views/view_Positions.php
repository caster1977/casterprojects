<H1>Должности</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Наименование</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%s</TD><TD>%d</TD></TR>', $row['Id'], $row['Name'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
