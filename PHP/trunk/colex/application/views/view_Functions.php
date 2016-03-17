<H1>Пользовательские функции</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Наименование</TH>
      <TH>Код</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%s</TD><TD>%d</TD><TD>%d</TD></TR>', $row['Id'], $row['Name'], $row['Code'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
