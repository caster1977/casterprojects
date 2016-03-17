<H1>Партии изделий</h1>
<P>
  <TABLE>
    <!--CAPTION></CAPTION-->
    <TBODY>
    <TR>
      <TH>Идентификатор</TH>
      <TH>Номер</TH>
      <TH>Дата регистрации</TH>
      <TH>Активность</TH>
    </TR>
    <?php
      foreach($data as $row)
      {
        printf('<TR><TD>%d</TD><TD>%s</TD><TD>%s</TD><TD>%d</TD></TR>', $row['Id'], $row['Number'], $row['RegistrationDate'], $row['Active']);
      }      
    ?>
    </TBODY>
  </TABLE>
</P>
