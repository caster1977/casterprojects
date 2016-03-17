<H1>Модели оборудования</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Наименование</TH>
      <TH>Прототип</TH>
      <TH>Описание</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%s</TD><TD>%d</TD><TD>%s</TD><TD>%d</TD></TR>', $row['Id'], $row['Name'], $row['Prototype'], $row['Description'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
