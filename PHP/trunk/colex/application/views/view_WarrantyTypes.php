<H1>Типы гарантий</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Наименование</TH>
      <TH>Условия</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%s</TD><TD>%s</TD><TD>%d</TD></TR>', $row['Id'], $row['Name'], $row['Details'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
